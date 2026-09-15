--// Lunar Clicker v1.0
--// Compact Universal Auto Clicker UI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local CPS = 15
local MouseButton = "Left"
local Hotkey = Enum.KeyCode.K
local Running = false
local Minimized = false

local ClickThread

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarClicker"
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

-- Main
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(610, 360)
Main.Position = UDim2.new(0.5, -305, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
Main.BorderSizePixel = 0
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(105, 55, 220)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.25
Stroke.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 78)
Top.BackgroundTransparency = 1
Top.Parent = Main

local Moon = Instance.new("TextLabel")
Moon.Size = UDim2.fromOffset(58, 58)
Moon.Position = UDim2.fromOffset(18, 10)
Moon.BackgroundTransparency = 1
Moon.Text = "☾"
Moon.TextColor3 = Color3.fromRGB(175, 120, 255)
Moon.TextSize = 46
Moon.Font = Enum.Font.GothamBold
Moon.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromOffset(300, 32)
Title.Position = UDim2.fromOffset(76, 12)
Title.BackgroundTransparency = 1
Title.Text = "Lunar Clicker"
Title.TextColor3 = Color3.fromRGB(235, 230, 255)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.fromOffset(300, 24)
SubTitle.Position = UDim2.fromOffset(78, 42)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Auto Clicker"
SubTitle.TextColor3 = Color3.fromRGB(135, 130, 165)
SubTitle.TextSize = 13
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Top

-- Minimize
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.fromOffset(42, 42)
Minimize.Position = UDim2.new(1, -92, 0, 18)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextColor3 = Color3.fromRGB(190, 185, 220)
Minimize.TextSize = 25
Minimize.Font = Enum.Font.Gotham
Minimize.Parent = Top

-- Close
local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(42, 42)
Close.Position = UDim2.new(1, -48, 0, 18)
Close.BackgroundTransparency = 1
Close.Text = "×"
Close.TextColor3 = Color3.fromRGB(190, 185, 220)
Close.TextSize = 27
Close.Font = Enum.Font.Gotham
Close.Parent = Top

--==================================================
-- HELPER
--==================================================

local function CreateCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = object
end

local function CreatePanel(parent, size, position)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(17, 17, 31)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    CreateCorner(frame, 12)

    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(55, 48, 90)
    outline.Thickness = 1
    outline.Transparency = 0.35
    outline.Parent = frame

    return frame
end

local function CreateText(parent, text, size, position)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(210, 205, 235)
    label.TextSize = 15
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

--==================================================
-- START / STATUS
--==================================================

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.fromOffset(275, 60)
StartButton.Position = UDim2.fromOffset(18, 90)
StartButton.BackgroundColor3 = Color3.fromRGB(105, 55, 225)
StartButton.BorderSizePixel = 0
StartButton.Text = "▶   Start"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 18
StartButton.Font = Enum.Font.GothamBold
StartButton.Parent = Main

CreateCorner(StartButton, 12)

local StatusPanel = CreatePanel(
    Main,
    UDim2.fromOffset(275, 60),
    UDim2.fromOffset(310, 90)
)

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.fromOffset(12, 12)
StatusDot.Position = UDim2.fromOffset(20, 24)
StatusDot.BackgroundColor3 = Color3.fromRGB(90, 230, 120)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusPanel

CreateCorner(StatusDot, 50)

local Status = CreateText(
    StatusPanel,
    "Stopped",
    UDim2.fromOffset(210, 35),
    UDim2.fromOffset(42, 13)
)

Status.TextSize = 16

--==================================================
-- CPS
--==================================================

local CPSPanel = CreatePanel(
    Main,
    UDim2.fromOffset(275, 82),
    UDim2.fromOffset(18, 164)
)

CreateText(
    CPSPanel,
    "CPS",
    UDim2.fromOffset(90, 30),
    UDim2.fromOffset(48, 10)
)

local CPSIcon = CreateText(
    CPSPanel,
    "⌁",
    UDim2.fromOffset(30, 30),
    UDim2.fromOffset(15, 10)
)

CPSIcon.TextColor3 = Color3.fromRGB(175, 125, 255)
CPSIcon.TextSize = 25

local CPSBox = Instance.new("TextBox")
CPSBox.Size = UDim2.fromOffset(105, 42)
CPSBox.Position = UDim2.fromOffset(145, 20)
CPSBox.BackgroundColor3 = Color3.fromRGB(23, 22, 42)
CPSBox.BorderSizePixel = 0
CPSBox.Text = tostring(CPS)
CPSBox.TextColor3 = Color3.fromRGB(240, 235, 255)
CPSBox.TextSize = 17
CPSBox.Font = Enum.Font.GothamMedium
CPSBox.ClearTextOnFocus = false
CPSBox.Parent = CPSPanel

CreateCorner(CPSBox, 9)

local CPSStroke = Instance.new("UIStroke")
CPSStroke.Color = Color3.fromRGB(65, 55, 105)
CPSStroke.Parent = CPSBox

CPSBox.FocusLost:Connect(function()
    local value = tonumber(CPSBox.Text)

    if value then
        CPS = math.clamp(math.floor(value), 1, 1000)
        CPSBox.Text = tostring(CPS)
    else
        CPSBox.Text = tostring(CPS)
    end
end)

--==================================================
-- MOUSE BUTTON
--==================================================

local MousePanel = CreatePanel(
    Main,
    UDim2.fromOffset(275, 82),
    UDim2.fromOffset(310, 164)
)

CreateText(
    MousePanel,
    "Mouse Button",
    UDim2.fromOffset(150, 30),
    UDim2.fromOffset(48, 10)
)

local MouseIcon = CreateText(
    MousePanel,
    "🖱",
    UDim2.fromOffset(30, 30),
    UDim2.fromOffset(15, 10)
)

MouseIcon.TextSize = 20

local Left = Instance.new("TextButton")
Left.Size = UDim2.fromOffset(105, 34)
Left.Position = UDim2.fromOffset(15, 43)
Left.BackgroundColor3 = Color3.fromRGB(105, 55, 225)
Left.BorderSizePixel = 0
Left.Text = "Left"
Left.TextColor3 = Color3.fromRGB(255, 255, 255)
Left.TextSize = 14
Left.Font = Enum.Font.GothamMedium
Left.Parent = MousePanel

CreateCorner(Left, 8)

local Right = Instance.new("TextButton")
Right.Size = UDim2.fromOffset(105, 34)
Right.Position = UDim2.fromOffset(130, 43)
Right.BackgroundColor3 = Color3.fromRGB(24, 23, 43)
Right.BorderSizePixel = 0
Right.Text = "Right"
Right.TextColor3 = Color3.fromRGB(180, 175, 205)
Right.TextSize = 14
Right.Font = Enum.Font.GothamMedium
Right.Parent = MousePanel

CreateCorner(Right, 8)

Left.MouseButton1Click:Connect(function()
    MouseButton = "Left"

    Left.BackgroundColor3 = Color3.fromRGB(105, 55, 225)
    Left.TextColor3 = Color3.fromRGB(255, 255, 255)

    Right.BackgroundColor3 = Color3.fromRGB(24, 23, 43)
    Right.TextColor3 = Color3.fromRGB(180, 175, 205)
end)

Right.MouseButton1Click:Connect(function()
    MouseButton = "Right"

    Right.BackgroundColor3 = Color3.fromRGB(105, 55, 225)
    Right.TextColor3 = Color3.fromRGB(255, 255, 255)

    Left.BackgroundColor3 = Color3.fromRGB(24, 23, 43)
    Left.TextColor3 = Color3.fromRGB(180, 175, 205)
end)

--==================================================
-- HOTKEY
--==================================================

local HotkeyPanel = CreatePanel(
    Main,
    UDim2.fromOffset(275, 72),
    UDim2.fromOffset(18, 258)
)

CreateText(
    HotkeyPanel,
    "Hotkey",
    UDim2.fromOffset(100, 30),
    UDim2.fromOffset(48, 8)
)

local HotkeyBox = Instance.new("TextButton")
HotkeyBox.Size = UDim2.fromOffset(175, 35)
HotkeyBox.Position = UDim2.fromOffset(85, 20)
HotkeyBox.BackgroundColor3 = Color3.fromRGB(23, 22, 42)
HotkeyBox.BorderSizePixel = 0
HotkeyBox.Text = "K"
HotkeyBox.TextColor3 = Color3.fromRGB(220, 215, 240)
HotkeyBox.TextSize = 15
HotkeyBox.Font = Enum.Font.GothamMedium
HotkeyBox.Parent = HotkeyPanel

CreateCorner(HotkeyBox, 8)

--==================================================
-- SETTINGS
--==================================================

local Settings = Instance.new("TextButton")
Settings.Size = UDim2.fromOffset(275, 72)
Settings.Position = UDim2.fromOffset(310, 258)
Settings.BackgroundColor3 = Color3.fromRGB(17, 17, 31)
Settings.BorderSizePixel = 0
Settings.Text = "⚙   Settings                         ›"
Settings.TextColor3 = Color3.fromRGB(200, 195, 225)
Settings.TextSize = 15
Settings.Font = Enum.Font.GothamMedium
Settings.TextXAlignment = Enum.TextXAlignment.Left
Settings.Parent = Main

CreateCorner(Settings, 12)

local SettingsPadding = Instance.new("UIPadding")
SettingsPadding.PaddingLeft = UDim.new(0, 18)
SettingsPadding.Parent = Settings

--==================================================
-- CLICK FUNCTION
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

--==================================================
-- CLICK LOOP
--==================================================

local function StartClicker()
    if Running then
        return
    end

    Running = true

    StartButton.Text = "■   Stop"
    StartButton.BackgroundColor3 = Color3.fromRGB(75, 40, 155)

    Status.Text = "Running"
    StatusDot.BackgroundColor3 = Color3.fromRGB(90, 230, 120)

    ClickThread = task.spawn(function()
        while Running do
            DoClick()

            local delayTime = 1 / math.max(CPS, 1)
            task.wait(delayTime)
        end
    end)
end

local function StopClicker()
    Running = false

    StartButton.Text = "▶   Start"
    StartButton.BackgroundColor3 = Color3.fromRGB(105, 55, 225)

    Status.Text = "Stopped"
    StatusDot.BackgroundColor3 = Color3.fromRGB(90, 230, 120)
end

StartButton.MouseButton1Click:Connect(function()
    if Running then
        StopClicker()
    else
        StartClicker()
    end
end)

--==================================================
-- HOTKEY SYSTEM
--==================================================

HotkeyBox.MouseButton1Click:Connect(function()
    HotkeyBox.Text = "Press key..."

    local connection
    connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end

        if input.UserInputType == Enum.UserInputType.Keyboard then
            Hotkey = input.KeyCode
            HotkeyBox.Text = input.KeyCode.Name
            connection:Disconnect()
        end
    end)
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end

    if input.KeyCode == Hotkey then
        if Running then
            StopClicker()
        else
            StartClicker()
        end
    end
end)

--==================================================
-- DRAGGING
--==================================================

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position
    end
end)

Top.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
-- MINIMIZE
--==================================================

local Mini = Instance.new("TextButton")
Mini.Size = UDim2.fromOffset(180, 48)
Mini.Position = Main.Position
Mini.BackgroundColor3 = Color3.fromRGB(15, 14, 28)
Mini.BorderSizePixel = 0
Mini.Text = "☾   Lunar Clicker     +"
Mini.TextColor3 = Color3.fromRGB(215, 205, 240)
Mini.TextSize = 14
Mini.Font = Enum.Font.GothamMedium
Mini.Visible = false
Mini.Parent = Gui

CreateCorner(Mini, 14)

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Color = Color3.fromRGB(105, 55, 220)
MiniStroke.Thickness = 1.5
MiniStroke.Transparency = 0.25
MiniStroke.Parent = Mini

Minimize.MouseButton1Click:Connect(function()
    Minimized = true
    Mini.Position = Main.Position
    Main.Visible = false
    Mini.Visible = true
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
    StopClicker()
    Gui:Destroy()
end)

print("Lunar Clicker v1.0 loaded")
