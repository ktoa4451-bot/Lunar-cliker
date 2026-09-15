--// Lunar Clicker v1.1
--// Compact Auto Clicker
--// Visual reference: compact Lunar Clicker concept

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local CPS = 15
local MouseButton = "Left"
local Hotkey = Enum.KeyCode.K

local Running = false
local Destroyed = false

local PURPLE = Color3.fromRGB(105, 55, 225)
local PURPLE_LIGHT = Color3.fromRGB(175, 125, 255)
local DARK = Color3.fromRGB(12, 12, 22)
local PANEL = Color3.fromRGB(17, 17, 31)
local PANEL_2 = Color3.fromRGB(23, 22, 42)
local TEXT = Color3.fromRGB(225, 220, 240)
local SUBTEXT = Color3.fromRGB(145, 140, 170)

local OPEN_SIZE = UDim2.fromOffset(610, 360)
local CLOSED_SIZE = UDim2.fromOffset(0, 0)

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarClicker"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = OPEN_SIZE
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(78, 48, 150)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.2
MainStroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 78)
Top.BackgroundTransparency = 1
Top.Parent = Main

local Moon = Instance.new("TextLabel")
Moon.Size = UDim2.fromOffset(58, 58)
Moon.Position = UDim2.fromOffset(18, 9)
Moon.BackgroundTransparency = 1
Moon.Text = "☾"
Moon.TextColor3 = PURPLE_LIGHT
Moon.TextSize = 46
Moon.Font = Enum.Font.GothamBold
Moon.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromOffset(300, 30)
Title.Position = UDim2.fromOffset(76, 13)
Title.BackgroundTransparency = 1
Title.Text = "Lunar Clicker"
Title.TextColor3 = TEXT
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.fromOffset(200, 22)
SubTitle.Position = UDim2.fromOffset(78, 42)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Auto Clicker"
SubTitle.TextColor3 = SUBTEXT
SubTitle.TextSize = 13
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Top

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(42, 42)
Minimize.Position = UDim2.new(1, -92, 0, 17)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextColor3 = Color3.fromRGB(185, 180, 210)
Minimize.TextSize = 25
Minimize.Font = Enum.Font.Gotham
Minimize.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(42, 42)
Close.Position = UDim2.new(1, -48, 0, 17)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(185, 180, 210)
Close.TextSize = 27
Close.Font = Enum.Font.Gotham
Close.Parent = Top

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -2, 0, 1)
Divider.Position = UDim2.fromOffset(1, 77)
Divider.BackgroundColor3 = Color3.fromRGB(38, 36, 60)
Divider.BorderSizePixel = 0
Divider.Parent = Main

--==================================================
-- HELPERS
--==================================================

local function Corner(object, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = object
end

local function Panel(size, position)
    local p = Instance.new("Frame")
    p.Size = size
    p.Position = position
    p.BackgroundColor3 = PANEL
    p.BorderSizePixel = 0
    p.Parent = Main

    Corner(p, 12)

    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(48, 45, 78)
    s.Thickness = 1
    s.Transparency = 0.3
    s.Parent = p

    return p
end

local function Label(parent, text, size, position)
    local l = Instance.new("TextLabel")
    l.Size = size
    l.Position = position
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = TEXT
    l.TextSize = 15
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = parent
    return l
end

--==================================================
-- START BUTTON
--==================================================

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.fromOffset(275, 60)
StartButton.Position = UDim2.fromOffset(18, 90)
StartButton.BackgroundColor3 = PURPLE
StartButton.BorderSizePixel = 0
StartButton.Text = "▶   Start"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 18
StartButton.Font = Enum.Font.GothamBold
StartButton.AutoButtonColor = false
StartButton.Parent = Main

Corner(StartButton, 12)

--==================================================
-- STATUS
--==================================================

local StatusPanel = Panel(
    UDim2.fromOffset(275, 60),
    UDim2.fromOffset(310, 90)
)

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(12, 12)
StatusDot.Position = UDim2.fromOffset(20, 24)
StatusDot.BackgroundColor3 = Color3.fromRGB(80, 225, 110)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusPanel

Corner(StatusDot, 50)

local Status = Label(
    StatusPanel,
    "Stopped",
    UDim2.fromOffset(200, 30),
    UDim2.fromOffset(42, 15)
)

Status.TextSize = 16

--==================================================
-- CPS
--==================================================

local CPSPanel = Panel(
    UDim2.fromOffset(275, 82),
    UDim2.fromOffset(18, 164)
)

local CPSIcon = Label(
    CPSPanel,
    "⌁",
    UDim2.fromOffset(30, 35),
    UDim2.fromOffset(15, 9)
)

CPSIcon.TextColor3 = PURPLE_LIGHT
CPSIcon.TextSize = 27

Label(
    CPSPanel,
    "CPS",
    UDim2.fromOffset(80, 28),
    UDim2.fromOffset(48, 11)
)

local CPSBox = Instance.new("TextBox")
CPSBox.Size = UDim2.fromOffset(105, 42)
CPSBox.Position = UDim2.fromOffset(145, 20)
CPSBox.BackgroundColor3 = PANEL_2
CPSBox.BorderSizePixel = 0
CPSBox.Text = tostring(CPS)
CPSBox.TextColor3 = TEXT
CPSBox.TextSize = 17
CPSBox.Font = Enum.Font.GothamMedium
CPSBox.ClearTextOnFocus = false
CPSBox.Parent = CPSPanel

Corner(CPSBox, 9)

local CPSStroke = Instance.new("UIStroke")
CPSStroke.Color = Color3.fromRGB(55, 50, 90)
CPSStroke.Parent = CPSBox

CPSBox.FocusLost:Connect(function()
    local number = tonumber(CPSBox.Text)

    if number then
        CPS = math.clamp(math.floor(number), 1, 1000)
        CPSBox.Text = tostring(CPS)
    else
        CPSBox.Text = tostring(CPS)
    end
end)

--==================================================
-- MOUSE BUTTON
--==================================================

local MousePanel = Panel(
    UDim2.fromOffset(275, 82),
    UDim2.fromOffset(310, 164)
)

local MouseIcon = Label(
    MousePanel,
    "🖱",
    UDim2.fromOffset(30, 30),
    UDim2.fromOffset(15, 10)
)

MouseIcon.TextSize = 19

Label(
    MousePanel,
    "Mouse Button",
    UDim2.fromOffset(150, 28),
    UDim2.fromOffset(48, 11)
)

local Left = Instance.new("TextButton")
Left.Size = UDim2.fromOffset(105, 34)
Left.Position = UDim2.fromOffset(15, 43)
Left.BackgroundColor3 = PURPLE
Left.BorderSizePixel = 0
Left.Text = "Left"
Left.TextColor3 = Color3.fromRGB(255, 255, 255)
Left.TextSize = 14
Left.Font = Enum.Font.GothamMedium
Left.AutoButtonColor = false
Left.Parent = MousePanel

Corner(Left, 8)

local Right = Instance.new("TextButton")
Right.Size = UDim2.fromOffset(105, 34)
Right.Position = UDim2.fromOffset(130, 43)
Right.BackgroundColor3 = PANEL_2
Right.BorderSizePixel = 0
Right.Text = "Right"
Right.TextColor3 = SUBTEXT
Right.TextSize = 14
Right.Font = Enum.Font.GothamMedium
Right.AutoButtonColor = false
Right.Parent = MousePanel

Corner(Right, 8)

Left.MouseButton1Click:Connect(function()
    MouseButton = "Left"

    TweenService:Create(
        Left,
        TweenInfo.new(0.15),
        {BackgroundColor3 = PURPLE}
    ):Play()

    TweenService:Create(
        Right,
        TweenInfo.new(0.15),
        {BackgroundColor3 = PANEL_2}
    ):Play()

    Left.TextColor3 = Color3.fromRGB(255, 255, 255)
    Right.TextColor3 = SUBTEXT
end)

Right.MouseButton1Click:Connect(function()
    MouseButton = "Right"

    TweenService:Create(
        Right,
        TweenInfo.new(0.15),
        {BackgroundColor3 = PURPLE}
    ):Play()

    TweenService:Create(
        Left,
        TweenInfo.new(0.15),
        {BackgroundColor3 = PANEL_2}
    ):Play()

    Right.TextColor3 = Color3.fromRGB(255, 255, 255)
    Left.TextColor3 = SUBTEXT
end)

--==================================================
-- HOTKEY
--==================================================

local HotkeyPanel = Panel(
    UDim2.fromOffset(275, 72),
    UDim2.fromOffset(18, 258)
)

local KeyIcon = Label(
    HotkeyPanel,
    "⌨",
    UDim2.fromOffset(30, 30),
    UDim2.fromOffset(15, 7)
)

KeyIcon.TextColor3 = PURPLE_LIGHT
KeyIcon.TextSize = 21

Label(
    HotkeyPanel,
    "Hotkey",
    UDim2.fromOffset(90, 28),
    UDim2.fromOffset(48, 10)
)

local HotkeyButton = Instance.new("TextButton")
HotkeyButton.Size = UDim2.fromOffset(175, 35)
HotkeyButton.Position = UDim2.fromOffset(85, 19)
HotkeyButton.BackgroundColor3 = PANEL_2
HotkeyButton.BorderSizePixel = 0
HotkeyButton.Text = "K"
HotkeyButton.TextColor3 = TEXT
HotkeyButton.TextSize = 15
HotkeyButton.Font = Enum.Font.GothamMedium
HotkeyButton.Parent = HotkeyPanel

Corner(HotkeyButton, 8)

--==================================================
-- TELEGRAM
--==================================================

local Telegram = Instance.new("TextButton")
Telegram.Size = UDim2.fromOffset(275, 72)
Telegram.Position = UDim2.fromOffset(310, 258)
Telegram.BackgroundColor3 = PANEL
Telegram.BorderSizePixel = 0
Telegram.Text = "✈   Telegram                         ›"
Telegram.TextColor3 = Color3.fromRGB(200, 195, 225)
Telegram.TextSize = 15
Telegram.Font = Enum.Font.GothamMedium
Telegram.TextXAlignment = Enum.TextXAlignment.Left
Telegram.AutoButtonColor = false
Telegram.Parent = Main

Corner(Telegram, 12)

local TelegramPadding = Instance.new("UIPadding")
TelegramPadding.PaddingLeft = UDim.new(0, 18)
TelegramPadding.Parent = Telegram

Telegram.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://t.me/lunarhub_script")
    end
end)

--==================================================
-- AUTO CLICK
--==================================================

local function DoClick()
    if MouseButton == "Left" then

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

    else

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

local function StartClicker()

    if Running then
        return
    end

    Running = true

    StartButton.Text = "■   Stop"
    Status.Text = "Running"

    StatusDot.BackgroundColor3 =
        Color3.fromRGB(80, 225, 110)

    TweenService:Create(
        StartButton,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 =
                Color3.fromRGB(75, 40, 160)
        }
    ):Play()

    task.spawn(function()

        while Running and not Destroyed do

            DoClick()

            task.wait(
                1 / math.max(CPS, 1)
            )

        end

    end)
end

local function StopClicker()

    Running = false

    StartButton.Text = "▶   Start"
    Status.Text = "Stopped"

    StatusDot.BackgroundColor3 =
        Color3.fromRGB(80, 225, 110)

    TweenService:Create(
        StartButton,
        TweenInfo.new(0.15),
        {
            BackgroundColor3 = PURPLE
        }
    ):Play()
end

StartButton.MouseButton1Click:Connect(function()

    if Running then
        StopClicker()
    else
        StartClicker()
    end

end)

--==================================================
-- HOTKEY CHANGE
--==================================================

local WaitingForKey = false

HotkeyButton.MouseButton1Click:Connect(function()

    if WaitingForKey then
        return
    end

    WaitingForKey = true
    HotkeyButton.Text = "Press key..."

end)

UserInputService.InputBegan:Connect(function(input, processed)

    if Destroyed then
        return
    end

    if WaitingForKey then

        if input.UserInputType ==
            Enum.UserInputType.Keyboard then

            Hotkey = input.KeyCode
            HotkeyButton.Text = input.KeyCode.Name
            WaitingForKey = false

            return
        end

    end

    if processed then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.Keyboard then

        if input.KeyCode == Hotkey then

            if Running then
                StopClicker()
            else
                StartClicker()
            end

        end

    end

end)

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1 then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

    end

end)

Top.InputEnded:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1 then

        Dragging = false

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement then

        local delta =
            input.Position - DragStart

        Main.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + delta.Y
        )

    end

end)

--==================================================
-- MINI BUTTON
--==================================================

local Mini = Instance.new("TextButton")
Mini.Name = "Mini"
Mini.AnchorPoint = Vector2.new(0.5, 0.5)
Mini.Position = Main.Position
Mini.Size = UDim2.fromOffset(0, 0)
Mini.BackgroundColor3 = PANEL
Mini.BorderSizePixel = 0
Mini.Text = "☾"
Mini.TextColor3 = PURPLE_LIGHT
Mini.TextSize = 25
Mini.Font = Enum.Font.GothamBold
Mini.Visible = false
Mini.Parent = Gui

Corner(Mini, 50)

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(105, 55, 225)
MiniStroke.Thickness = 1.5
MiniStroke.Parent = Mini

--==================================================
-- MINIMIZE
--==================================================

Minimize.MouseButton1Click:Connect(function()

    if Minimized then
        return
    end

    Minimized = true

    local oldPosition = Main.Position

    Mini.Position = oldPosition
    Mini.Visible = true

    Main.Visible = false

    Mini.Size = UDim2.fromOffset(0, 0)

    TweenService:Create(
        Mini,
        TweenInfo.new(
            0.25,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(58, 58)
        }
    ):Play()

end)

Mini.MouseButton1Click:Connect(function()

    Minimized = false

    Main.Position = Mini.Position

    Mini.Visible = false
    Main.Visible = true

end)

--==================================================
-- CLOSE
--==================================================

Close.MouseButton1Click:Connect(function()

    Destroyed = true
    StopClicker()

    Gui:Destroy()

end)

--==================================================
-- OPEN ANIMATION
--==================================================

Main.Size = UDim2.fromOffset(0, 0)

TweenService:Create(
    Main,
    TweenInfo.new(
        0.35,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ),
    {
        Size = OPEN_SIZE
    }
):Play()

print("Lunar Clicker v1.1 loaded")
