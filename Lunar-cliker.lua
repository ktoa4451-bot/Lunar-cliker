--==================================================
-- LUNAR CLICKER v1.2
-- PART 1/4
-- Compact UI foundation
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local Config = {
    CPS = 15,
    MouseButton = "Left",
    Hotkey = Enum.KeyCode.K,
    Running = false
}

--==================================================
-- COLORS
--==================================================

local Colors = {
    Background = Color3.fromRGB(12, 12, 20),
    Surface = Color3.fromRGB(17, 17, 28),
    Surface2 = Color3.fromRGB(22, 21, 36),

    Purple = Color3.fromRGB(108, 65, 220),
    PurpleLight = Color3.fromRGB(165, 125, 255),

    Text = Color3.fromRGB(235, 232, 245),
    TextSecondary = Color3.fromRGB(145, 141, 165),

    Border = Color3.fromRGB(48, 43, 72),

    Green = Color3.fromRGB(90, 220, 125)
}

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarClicker"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.Size = UDim2.fromOffset(570, 330)

Main.BackgroundColor3 = Colors.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Border
MainStroke.Thickness = 1
MainStroke.Transparency = 0.15
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 72)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Main

--==================================================
-- MOON ICON
-- no emoji / unicode
--==================================================

local MoonHolder = Instance.new("Frame")
MoonHolder.Name = "Moon"
MoonHolder.Size = UDim2.fromOffset(42, 42)
MoonHolder.Position = UDim2.fromOffset(18, 15)
MoonHolder.BackgroundTransparency = 1
MoonHolder.Parent = TopBar

local Moon = Instance.new("Frame")
Moon.Size = UDim2.fromOffset(31, 31)
Moon.Position = UDim2.fromOffset(4, 5)
Moon.BackgroundColor3 = Colors.PurpleLight
Moon.BorderSizePixel = 0
Moon.Parent = MoonHolder

local MoonCorner = Instance.new("UICorner")
MoonCorner.CornerRadius = UDim.new(1, 0)
MoonCorner.Parent = Moon

-- cut-out to create crescent
local MoonCut = Instance.new("Frame")
MoonCut.Size = UDim2.fromOffset(25, 25)
MoonCut.Position = UDim2.fromOffset(13, -4)
MoonCut.BackgroundColor3 = Colors.Background
MoonCut.BorderSizePixel = 0
MoonCut.Parent = Moon

local MoonCutCorner = Instance.new("UICorner")
MoonCutCorner.CornerRadius = UDim.new(1, 0)
MoonCutCorner.Parent = MoonCut

--==================================================
-- TITLE
--==================================================

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.fromOffset(260, 27)
Title.Position = UDim2.fromOffset(68, 12)

Title.BackgroundTransparency = 1
Title.Text = "Lunar Clicker"
Title.TextColor3 = Colors.Text
Title.TextSize = 21
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Name = "Subtitle"
Subtitle.Size = UDim2.fromOffset(220, 20)
Subtitle.Position = UDim2.fromOffset(69, 38)

Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Simple • Fast • Universal"
Subtitle.TextColor3 = Colors.TextSecondary
Subtitle.TextSize = 11
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

Subtitle.Parent = TopBar

--==================================================
-- WINDOW BUTTONS
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(34, 34)
Minimize.Position = UDim2.new(1, -76, 0, 19)

Minimize.BackgroundTransparency = 1
Minimize.Text = ""
Minimize.AutoButtonColor = false

Minimize.Parent = TopBar

-- line icon
local Minus = Instance.new("Frame")
Minus.Size = UDim2.fromOffset(13, 2)
Minus.Position = UDim2.fromOffset(10, 16)
Minus.BackgroundColor3 = Colors.TextSecondary
Minus.BorderSizePixel = 0
Minus.Parent = Minimize

--==================================================

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Size = UDim2.fromOffset(34, 34)
Close.Position = UDim2.new(1, -40, 0, 19)

Close.BackgroundTransparency = 1
Close.Text = ""
Close.AutoButtonColor = false

Close.Parent = TopBar

-- X icon
local X1 = Instance.new("Frame")
X1.Size = UDim2.fromOffset(14, 2)
X1.Position = UDim2.fromOffset(10, 16)
X1.Rotation = 45
X1.BackgroundColor3 = Colors.TextSecondary
X1.BorderSizePixel = 0
X1.Parent = Close

local X2 = Instance.new("Frame")
X2.Size = UDim2.fromOffset(14, 2)
X2.Position = UDim2.fromOffset(10, 16)
X2.Rotation = -45
X2.BackgroundColor3 = Colors.TextSecondary
X2.BorderSizePixel = 0
X2.Parent = Close

--==================================================
-- DIVIDER
--==================================================

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, -36, 0, 1)
Divider.Position = UDim2.fromOffset(18, 72)

Divider.BackgroundColor3 = Colors.Border
Divider.BackgroundTransparency = 0.35
Divider.BorderSizePixel = 0

Divider.Parent = Main

--==================================================
-- GENERAL PANEL CREATOR
--==================================================

local function CreatePanel(name, size, position)

    local Panel = Instance.new("Frame")
    Panel.Name = name

    Panel.Size = size
    Panel.Position = position

    Panel.BackgroundColor3 = Colors.Surface
    Panel.BorderSizePixel = 0

    Panel.Parent = Main

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Panel

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Colors.Border
    Stroke.Thickness = 1
    Stroke.Transparency = 0.3
    Stroke.Parent = Panel

    return Panel
end

--==================================================
-- TEXT CREATOR
--==================================================

local function CreateLabel(
    parent,
    name,
    text,
    size,
    position,
    textSize,
    color
)

    local Label = Instance.new("TextLabel")

    Label.Name = name
    Label.Size = size
    Label.Position = position

    Label.BackgroundTransparency = 1
    Label.Text = text

    Label.TextColor3 = color or Colors.Text
    Label.TextSize = textSize or 14

    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left

    Label.Parent = parent

    return Label
end

--==================================================
-- BUTTON CREATOR
--==================================================

local function CreateButton(
    parent,
    name,
    text,
    size,
    position
)

    local Button = Instance.new("TextButton")

    Button.Name = name
    Button.Size = size
    Button.Position = position

    Button.BackgroundColor3 = Colors.Surface2
    Button.BorderSizePixel = 0

    Button.Text = text
    Button.TextColor3 = Colors.Text
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamMedium

    Button.AutoButtonColor = false

    Button.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    return Button
end

--==================================================
-- MAIN PANELS
--==================================================

local StartPanel = CreatePanel(
    "StartPanel",
    UDim2.fromOffset(260, 60),
    UDim2.fromOffset(18, 91)
)

local StatusPanel = CreatePanel(
    "StatusPanel",
    UDim2.fromOffset(260, 60),
    UDim2.fromOffset(292, 91)
)

local CPSPanel = CreatePanel(
    "CPSPanel",
    UDim2.fromOffset(260, 74),
    UDim2.fromOffset(18, 165)
)

local MousePanel = CreatePanel(
    "MousePanel",
    UDim2.fromOffset(260, 74),
    UDim2.fromOffset(292, 165)
)

local HotkeyPanel = CreatePanel(
    "HotkeyPanel",
    UDim2.fromOffset(260, 58),
    UDim2.fromOffset(18, 253)
)

local TelegramPanel = CreatePanel(
    "TelegramPanel",
    UDim2.fromOffset(260, 58),
    UDim2.fromOffset(292, 253)
)

print("Lunar Clicker v1.2 - Part 1 loaded")

--==================================================
-- LUNAR CLICKER v1.2
-- PART 2/4
-- Controls
--==================================================

--==================================================
-- START / STOP
--==================================================

local StartButton = CreateButton(
    StartPanel,
    "StartButton",
    "START",
    UDim2.new(1, -24, 1, -18),
    UDim2.fromOffset(12, 9)
)

StartButton.BackgroundColor3 = Colors.Purple
StartButton.TextSize = 15
StartButton.Font = Enum.Font.GothamBold

-- маленький индикатор слева
local StartIndicator = Instance.new("Frame")
StartIndicator.Size = UDim2.fromOffset(7, 7)
StartIndicator.Position = UDim2.fromOffset(22, 26)
StartIndicator.BackgroundColor3 = Color3.fromRGB(255,255,255)
StartIndicator.BorderSizePixel = 0
StartIndicator.Parent = StartButton

local StartIndicatorCorner = Instance.new("UICorner")
StartIndicatorCorner.CornerRadius = UDim.new(1, 0)
StartIndicatorCorner.Parent = StartIndicator

--==================================================
-- STATUS
--==================================================

CreateLabel(
    StatusPanel,
    "StatusTitle",
    "STATUS",
    UDim2.fromOffset(100, 20),
    UDim2.fromOffset(18, 9),
    10,
    Colors.TextSecondary
)

local StatusValue = CreateLabel(
    StatusPanel,
    "StatusValue",
    "Stopped",
    UDim2.fromOffset(150, 25),
    UDim2.fromOffset(18, 27),
    15,
    Colors.Text
)

-- status dot
local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(9, 9)
StatusDot.Position = UDim2.new(1, -30, 0, 25)
StatusDot.BackgroundColor3 = Colors.Green
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusPanel

local StatusDotCorner = Instance.new("UICorner")
StatusDotCorner.CornerRadius = UDim.new(1, 0)
StatusDotCorner.Parent = StatusDot

--==================================================
-- CPS
--==================================================

CreateLabel(
    CPSPanel,
    "CPSTitle",
    "CPS",
    UDim2.fromOffset(100, 20),
    UDim2.fromOffset(18, 9),
    10,
    Colors.TextSecondary
)

local CPSValue = Instance.new("TextBox")
CPSValue.Name = "CPSValue"

CPSValue.Size = UDim2.fromOffset(92, 38)
CPSValue.Position = UDim2.new(1, -110, 0, 18)

CPSValue.BackgroundColor3 = Colors.Surface2
CPSValue.BorderSizePixel = 0

CPSValue.Text = tostring(Config.CPS)
CPSValue.TextColor3 = Colors.Text
CPSValue.TextSize = 16
CPSValue.Font = Enum.Font.GothamMedium

CPSValue.ClearTextOnFocus = false
CPSValue.TextXAlignment = Enum.TextXAlignment.Center

CPSValue.Parent = CPSPanel

local CPSCorner = Instance.new("UICorner")
CPSCorner.CornerRadius = UDim.new(0, 8)
CPSCorner.Parent = CPSValue

local CPSStroke = Instance.new("UIStroke")
CPSStroke.Color = Colors.Border
CPSStroke.Thickness = 1
CPSStroke.Transparency = 0.2
CPSStroke.Parent = CPSValue

CPSValue.FocusLost:Connect(function()

    local Value = tonumber(CPSValue.Text)

    if Value then

        Value = math.floor(Value)
        Value = math.clamp(Value, 1, 1000)

        Config.CPS = Value
        CPSValue.Text = tostring(Value)

    else

        CPSValue.Text = tostring(Config.CPS)

    end

end)

--==================================================
-- MOUSE BUTTON
--==================================================

CreateLabel(
    MousePanel,
    "MouseTitle",
    "MOUSE BUTTON",
    UDim2.fromOffset(130, 20),
    UDim2.fromOffset(18, 9),
    10,
    Colors.TextSecondary
)

local LeftButton = CreateButton(
    MousePanel,
    "LeftButton",
    "LEFT",
    UDim2.fromOffset(108, 34),
    UDim2.fromOffset(18, 31)
)

local RightButton = CreateButton(
    MousePanel,
    "RightButton",
    "RIGHT",
    UDim2.fromOffset(108, 34),
    UDim2.fromOffset(134, 31)
)

LeftButton.BackgroundColor3 = Colors.Purple
RightButton.BackgroundColor3 = Colors.Surface2

local function SelectMouseButton(Button)

    Config.MouseButton = Button

    if Button == "Left" then

        TweenService:Create(
            LeftButton,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Colors.Purple
            }
        ):Play()

        TweenService:Create(
            RightButton,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Colors.Surface2
            }
        ):Play()

    else

        TweenService:Create(
            RightButton,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Colors.Purple
            }
        ):Play()

        TweenService:Create(
            LeftButton,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Colors.Surface2
            }
        ):Play()

    end

end

LeftButton.MouseButton1Click:Connect(function()
    SelectMouseButton("Left")
end)

RightButton.MouseButton1Click:Connect(function()
    SelectMouseButton("Right")
end)

--==================================================
-- HOTKEY
--==================================================

CreateLabel(
    HotkeyPanel,
    "HotkeyTitle",
    "HOTKEY",
    UDim2.fromOffset(90, 20),
    UDim2.fromOffset(18, 7),
    10,
    Colors.TextSecondary
)

local HotkeyButton = CreateButton(
    HotkeyPanel,
    "HotkeyButton",
    Config.Hotkey.Name,
    UDim2.fromOffset(145, 34),
    UDim2.new(1, -163, 0, 12)
)

HotkeyButton.TextSize = 14

local WaitingForHotkey = false

HotkeyButton.MouseButton1Click:Connect(function()

    if WaitingForHotkey then
        return
    end

    WaitingForHotkey = true

    HotkeyButton.Text = "PRESS KEY"
    HotkeyButton.TextColor3 = Colors.PurpleLight

end)

--==================================================
-- TELEGRAM
--==================================================

local TelegramButton = CreateButton(
    TelegramPanel,
    "TelegramButton",
    "TELEGRAM",
    UDim2.new(1, -24, 1, -18),
    UDim2.fromOffset(12, 9)
)

TelegramButton.TextSize = 14

--==================================================
-- HOVER EFFECTS
--==================================================

local function AddHover(Button, NormalColor, HoverColor)

    Button.MouseEnter:Connect(function()

        if Button ~= LeftButton
        and Button ~= RightButton
        and Button ~= StartButton then

            TweenService:Create(
                Button,
                TweenInfo.new(0.12),
                {
                    BackgroundColor3 = HoverColor
                }
            ):Play()

        end

    end)

    Button.MouseLeave:Connect(function()

        if Button ~= LeftButton
        and Button ~= RightButton
        and Button ~= StartButton then

            TweenService:Create(
                Button,
                TweenInfo.new(0.12),
                {
                    BackgroundColor3 = NormalColor
                }
            ):Play()

        end

    end)

end

AddHover(
    TelegramButton,
    Colors.Surface2,
    Color3.fromRGB(30, 28, 48)
)

AddHover(
    HotkeyButton,
    Colors.Surface2,
    Color3.fromRGB(30, 28, 48)
)

print("Lunar Clicker v1.2 - Part 2 loaded")

--==================================================
-- LUNAR CLICKER v1.2
-- PART 3/4
-- Core / Hotkey / Start-Stop
--==================================================

--==================================================
-- HOTKEY INPUT
--==================================================

UserInputService.InputBegan:Connect(function(input, processed)

    if not input then
        return
    end

    -- назначение новой клавиши
    if WaitingForHotkey then

        if input.UserInputType == Enum.UserInputType.Keyboard then

            Config.Hotkey = input.KeyCode

            HotkeyButton.Text = input.KeyCode.Name
            HotkeyButton.TextColor3 = Colors.Text

            WaitingForHotkey = false
        end

        return
    end

    if processed then
        return
    end

    if input.UserInputType == Enum.UserInputType.Keyboard then

        if input.KeyCode == Config.Hotkey then

            if Config.Running then
                StopClicker()
            else
                StartClicker()
            end

        end

    end

end)

--==================================================
-- CLICK FUNCTION
--==================================================

local function PerformClick()

    -- Проверяем наличие VirtualInputManager
    if not VirtualInputManager then
        return
    end

    if Config.MouseButton == "Left" then

        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            0,
            true,
            game,
            0
        )

        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            0,
            false,
            game,
            0
        )

    elseif Config.MouseButton == "Right" then

        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            1,
            true,
            game,
            0
        )

        VirtualInputManager:SendMouseButtonEvent(
            0,
            0,
            1,
            false,
            game,
            0
        )

    end

end

--==================================================
-- BUTTON ANIMATION
--==================================================

local function UpdateStartButton()

    if Config.Running then

        StartButton.Text = "STOP"

        TweenService:Create(
            StartButton,
            TweenInfo.new(
                0.18,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundColor3 =
                    Color3.fromRGB(82, 48, 165)
            }
        ):Play()

        StatusValue.Text = "Running"

        StatusDot.BackgroundColor3 =
            Colors.Green

        StartIndicator.BackgroundColor3 =
            Colors.Green

    else

        StartButton.Text = "START"

        TweenService:Create(
            StartButton,
            TweenInfo.new(
                0.18,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundColor3 =
                    Colors.Purple
            }
        ):Play()

        StatusValue.Text = "Stopped"

        StatusDot.BackgroundColor3 =
            Colors.Green

        StartIndicator.BackgroundColor3 =
            Color3.fromRGB(255,255,255)

    end

end

--==================================================
-- START
--==================================================

function StartClicker()

    if Config.Running then
        return
    end

    Config.Running = true

    UpdateStartButton()

    task.spawn(function()

        while Config.Running do

            PerformClick()

            local CurrentCPS =
                math.clamp(
                    tonumber(Config.CPS) or 1,
                    1,
                    1000
                )

            task.wait(
                1 / CurrentCPS
            )

        end

    end)

end

--==================================================
-- STOP
--==================================================

function StopClicker()

    if not Config.Running then
        UpdateStartButton()
        return
    end

    Config.Running = false

    UpdateStartButton()

end

--==================================================
-- START BUTTON
--==================================================

StartButton.MouseButton1Click:Connect(function()

    if Config.Running then
        StopClicker()
    else
        StartClicker()
    end

end)

--==================================================
-- BUTTON PRESS ANIMATION
--==================================================

local function PressAnimation(Button)

    local OriginalSize = Button.Size

    Button.MouseButton1Down:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(
                    OriginalSize.X.Scale,
                    OriginalSize.X.Offset - 2,
                    OriginalSize.Y.Scale,
                    OriginalSize.Y.Offset - 2
                )
            }
        ):Play()

    end)

    Button.MouseButton1Up:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(
                0.08,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size = OriginalSize
            }
        ):Play()

    end)

end

PressAnimation(StartButton)
PressAnimation(LeftButton)
PressAnimation(RightButton)
PressAnimation(HotkeyButton)
PressAnimation(TelegramButton)

print("Lunar Clicker v1.2 - Part 3 loaded")

--==================================================
-- LUNAR CLICKER v1.2
-- PART 4/4
-- Animations / Drag / Minimize / Close
--==================================================

--==================================================
-- TELEGRAM
--==================================================

TelegramButton.MouseButton1Click:Connect(function()

    local Link = "https://t.me/lunarhub_script"

    if setclipboard then
        pcall(function()
            setclipboard(Link)
        end)
    end

    local OldText = TelegramButton.Text
    TelegramButton.Text = "COPIED"

    task.delay(1.2, function()
        if TelegramButton and TelegramButton.Parent then
            TelegramButton.Text = OldText
        end
    end)

end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

    end

end)

TopBar.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement then

        local Delta = input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

    end

end)

--==================================================
-- MINI BUTTON
--==================================================

local Mini = Instance.new("TextButton")

Mini.Name = "LunarMini"
Mini.AnchorPoint = Vector2.new(0.5, 0.5)
Mini.Size = UDim2.fromOffset(54, 54)
Mini.Position = Main.Position

Mini.BackgroundColor3 = Colors.Surface
Mini.BorderSizePixel = 0
Mini.Text = ""
Mini.AutoButtonColor = false
Mini.Visible = false

Mini.Parent = Gui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(1, 0)
MiniCorner.Parent = Mini

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Colors.Purple
MiniStroke.Thickness = 1.5
MiniStroke.Transparency = 0.15
MiniStroke.Parent = Mini

--==================================================
-- MINI MOON
--==================================================

local MiniMoon = Instance.new("Frame")

MiniMoon.Size = UDim2.fromOffset(27, 27)
MiniMoon.Position = UDim2.fromOffset(13, 13)

MiniMoon.BackgroundColor3 = Colors.PurpleLight
MiniMoon.BorderSizePixel = 0

MiniMoon.Parent = Mini

local MiniMoonCorner = Instance.new("UICorner")
MiniMoonCorner.CornerRadius = UDim.new(1, 0)
MiniMoonCorner.Parent = MiniMoon

local MiniCut = Instance.new("Frame")

MiniCut.Size = UDim2.fromOffset(22, 22)
MiniCut.Position = UDim2.fromOffset(11, -4)

MiniCut.BackgroundColor3 = Colors.Surface
MiniCut.BorderSizePixel = 0

MiniCut.Parent = MiniMoon

local MiniCutCorner = Instance.new("UICorner")
MiniCutCorner.CornerRadius = UDim.new(1, 0)
MiniCutCorner.Parent = MiniCut

--==================================================
-- MINIMIZE
--==================================================

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

    if Minimized then
        return
    end

    Minimized = true

    Mini.Position = Main.Position
    Mini.Visible = true
    Mini.Size = UDim2.fromOffset(0, 0)

    Main.Visible = false

    TweenService:Create(
        Mini,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(54, 54)
        }
    ):Play()

end)

--==================================================
-- RESTORE
--==================================================

Mini.MouseButton1Click:Connect(function()

    if not Minimized then
        return
    end

    Minimized = false

    Main.Position = Mini.Position
    Mini.Visible = false
    Main.Visible = true

end)

--==================================================
-- MINI HOVER
--==================================================

Mini.MouseEnter:Connect(function()

    TweenService:Create(
        Mini,
        TweenInfo.new(0.15),
        {
            Size = UDim2.fromOffset(58, 58)
        }
    ):Play()

end)

Mini.MouseLeave:Connect(function()

    TweenService:Create(
        Mini,
        TweenInfo.new(0.15),
        {
            Size = UDim2.fromOffset(54, 54)
        }
    ):Play()

end)

--==================================================
-- CLOSE
--==================================================

local Closed = false

Close.MouseButton1Click:Connect(function()

    if Closed then
        return
    end

    Closed = true
    Config.Running = false

    local Animation = TweenService:Create(
        Main,
        TweenInfo.new(
            0.22,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(0, 0)
        }
    )

    Animation:Play()

    Animation.Completed:Connect(function()

        if Gui then
            Gui:Destroy()
        end

    end)

end)

--==================================================
-- WINDOW BUTTON HOVER
--==================================================

local function WindowHover(Button)

    Button.MouseEnter:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.12),
            {
                BackgroundTransparency = 0.8
            }
        ):Play()

    end)

    Button.MouseLeave:Connect(function()

        TweenService:Create(
            Button,
            TweenInfo.new(0.12),
            {
                BackgroundTransparency = 1
            }
        ):Play()

    end)

end

WindowHover(Minimize)
WindowHover(Close)

--==================================================
-- OPEN ANIMATION
--==================================================

local OriginalSize = Main.Size

Main.Size = UDim2.fromOffset(0, 0)

TweenService:Create(
    Main,
    TweenInfo.new(
        0.4,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {
        Size = OriginalSize
    }
):Play()

--==================================================
-- FINAL
--==================================================

print("================================")
print(" Lunar Clicker v1.2 loaded")
print(" Compact UI")
print(" No emoji icons")
print("================================")
