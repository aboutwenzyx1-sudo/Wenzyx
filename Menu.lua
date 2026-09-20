-- ═══════════════════════════════════════════════════════════
-- WENZYXHUB | ALL MENU
-- Speed + Jump + Infinite Jump + NoClip + Fly + Anti-AFK
-- Mobile Friendly + Respawn Handler + Hide/Show + Cleanup
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Prevent duplicate GUI
pcall(function()
    local old = CoreGui:FindFirstChild("WenzyXHub")
    if old then
        old:Destroy()
    end
end)

-- =========================================================
-- SETTINGS
-- =========================================================

local settings = {
    Speed = 16,
    JumpPower = 50,
    SpeedEnabled = false,
    JumpEnabled = false,
    InfiniteJump = false,
    NoClip = false,
    Fly = false,
    AntiAFK = true
}

local MIN_SPEED = 1
local MAX_SPEED = 1000
local MIN_JUMP = 1
local MAX_JUMP = 500

local connections = {}
local function connect(signal, callback)
    local c = signal:Connect(callback)
    table.insert(connections, c)
    return c
end

local function getCharacter()
    return LocalPlayer.Character
end

local function getHumanoid()
    local char = getCharacter()
    if not char then return nil end
    return char:FindFirstChildOfClass("Humanoid")
end

local function getRoot()
    local char = getCharacter()
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart")
end

-- =========================================================
-- GUI
-- =========================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WenzyXHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 340, 0, 430)
Main.Position = UDim2.new(0.5, -170, 0.5, -215)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 170, 255)
MainStroke.Thickness = 2
MainStroke.Parent = Main

-- =========================================================
-- TITLE BAR
-- =========================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 45)
Top.BackgroundTransparency = 1
Top.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -55, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "WENZYXHUB"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 35, 0, 30)
Close.Position = UDim2.new(1, -40, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 80, 80)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.Parent = Top

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = Close

-- =========================================================
-- DRAG SYSTEM - MOUSE + MOBILE
-- =========================================================

local dragging = false
local dragStart
local startPos

connect(Top.InputBegan, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

connect(UserInputService.InputChanged, function(input)
    if not dragging then return end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

connect(UserInputService.InputEnded, function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

-- =========================================================
-- SCROLL
-- =========================================================

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -60)
Scroll.Position = UDim2.new(0, 10, 0, 50)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 0, 620)
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.Parent = Scroll

-- =========================================================
-- HELPERS
-- =========================================================

local function createButton(text)
    local button = Instance.new("TextButton")

    button.Size = UDim2.new(1, -10, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 13
    button.Text = text
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Parent = Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = button

    return button
end

local function updateButton(button, name, enabled)
    button.Text = name .. ": " .. (enabled and "ON" or "OFF")

    if enabled then
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 220)
    else
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    end
end

local function createSlider(title, min, max, default, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 65)
    holder.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    holder.BorderSizePixel = 0
    holder.Parent = Scroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 7)
    corner.Parent = holder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, 3)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -30, 0, 10)
    bar.Position = UDim2.new(0, 15, 0, 40)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    bar.BorderSizePixel = 0
    bar.Parent = holder

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Text = ""
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = bar

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local value = default
    local sliderDragging = false

    local function setValue(v)
        value = math.clamp(math.floor(v), min, max)

        local percent = (value - min) / (max - min)

        label.Text = title .. ": " .. value
        fill.Size = UDim2.new(percent, 0, 1, 0)
        knob.Position = UDim2.new(percent, -9, 0.5, -9)

        callback(value)
    end

    local function updateFromInput(input)
        local x = input.Position.X
        local left = bar.AbsolutePosition.X
        local width = bar.AbsoluteSize.X

        if width <= 0 then return end

        local percent = math.clamp((x - left) / width, 0, 1)
        setValue(min + percent * (max - min))
    end

    connect(knob.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliderDragging = true
        end
    end)

    connect(UserInputService.InputChanged, function(input)
        if not sliderDragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            updateFromInput(input)
        end
    end)

    connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliderDragging = false
        end
    end)

    setValue(default)

    return holder
end

-- =========================================================
-- SPEED
-- =========================================================

createSlider(
    "Speed",
    MIN_SPEED,
    MAX_SPEED,
    settings.Speed,
    function(value)
        settings.Speed = value

        if settings.SpeedEnabled then
            local hum = getHumanoid()

            if hum then
                hum.WalkSpeed = value
            end
        end
    end
)

local SpeedButton = createButton("Speed: OFF")

connect(SpeedButton.MouseButton1Click, function()
    settings.SpeedEnabled = not settings.SpeedEnabled

    updateButton(
        SpeedButton,
        "Speed",
        settings.SpeedEnabled
    )

    local hum = getHumanoid()

    if hum then
        hum.WalkSpeed = settings.SpeedEnabled
            and settings.Speed
            or 16
    end
end)

-- =========================================================
-- JUMP POWER
-- =========================================================

createSlider(
    "Jump Power",
    MIN_JUMP,
    MAX_JUMP,
    settings.JumpPower,
    function(value)
        settings.JumpPower = value

        if settings.JumpEnabled then
            local hum = getHumanoid()

            if hum then
                hum.UseJumpPower = true
                hum.JumpPower = value
            end
        end
    end
)

local JumpButton = createButton("Jump Power: OFF")

connect(JumpButton.MouseButton1Click, function()
    settings.JumpEnabled = not settings.JumpEnabled

    updateButton(
        JumpButton,
        "Jump Power",
        settings.JumpEnabled
    )

    local hum = getHumanoid()

    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = settings.JumpEnabled
            and settings.JumpPower
            or 50
    end
end)

-- =========================================================
-- INFINITE JUMP
-- =========================================================

local InfiniteButton = createButton("Infinite Jump: OFF")

connect(InfiniteButton.MouseButton1Click, function()
    settings.InfiniteJump = not settings.InfiniteJump

    updateButton(
        InfiniteButton,
        "Infinite Jump",
        settings.InfiniteJump
    )
end)

connect(UserInputService.JumpRequest, function()
    if not settings.InfiniteJump then return end

    local hum = getHumanoid()

    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- =========================================================
-- NOCLIP
-- =========================================================

local NoClipButton = createButton("NoClip: OFF")

connect(NoClipButton.MouseButton1Click, function()
    settings.NoClip = not settings.NoClip

    updateButton(
        NoClipButton,
        "NoClip",
        settings.NoClip
    )
end)

connect(RunService.Stepped, function()
    if not settings.NoClip then return end

    local char = getCharacter()

    if char then
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.CanCollide = false
            end
        end
    end
end)

-- =========================================================
-- FLY
-- =========================================================

local flySpeed = 60
local flyConnection

local FlyButton = createButton("Fly: OFF")

local function stopFly()
    settings.Fly = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    local root = getRoot()

    if root then
        root.AssemblyLinearVelocity = Vector3.zero
    end

    updateButton(FlyButton, "Fly", false)
end

local function startFly()
    if flyConnection then
        flyConnection:Disconnect()
    end

    settings.Fly = true

    flyConnection = RunService.RenderStepped:Connect(function()
        local root = getRoot()

        if not root then return end

        local camera = workspace.CurrentCamera
        if not camera then return end

        local direction = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction += camera.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction -= camera.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction -= camera.CFrame.RightVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction += camera.CFrame.RightVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction += Vector3.new(0, 1, 0)
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction -= Vector3.new(0, 1, 0)
        end

        if direction.Magnitude > 0 then
            direction = direction.Unit * flySpeed
        end

        root.AssemblyLinearVelocity = direction
    end)

    updateButton(FlyButton, "Fly", true)
end

connect(FlyButton.MouseButton1Click, function()
    if settings.Fly then
        stopFly()
    else
        startFly()
    end
end)

-- =========================================================
-- ANTI AFK
-- =========================================================

local AntiAFKButton = createButton("Anti-AFK: ON")

connect(AntiAFKButton.MouseButton1Click, function()
    settings.AntiAFK = not settings.AntiAFK

    updateButton(
        AntiAFKButton,
        "Anti-AFK",
        settings.AntiAFK
    )
end)

connect(LocalPlayer.Idled, function()
    if not settings.AntiAFK then return end

    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- =========================================================
-- PRESETS
-- =========================================================

local FastButton = createButton("Preset: FAST")

connect(FastButton.MouseButton1Click, function()
    settings.Speed = 100
    settings.SpeedEnabled = true

    local hum = getHumanoid()

    if hum then
        hum.WalkSpeed = 100
    end

    updateButton(SpeedButton, "Speed", true)
end)

local NormalButton = createButton("Preset: NORMAL")

connect(NormalButton.MouseButton1Click, function()
    settings.Speed = 16
    settings.SpeedEnabled = false

    local hum = getHumanoid()

    if hum then
        hum.WalkSpeed = 16
    end

    updateButton(SpeedButton, "Speed", false)
end)

-- =========================================================
-- HIDE
-- =========================================================

local Hidden = false

local HideButton = createButton("Hide Menu")

connect(HideButton.MouseButton1Click, function()
    Hidden = true
    Main.Visible = false
end)

local ReopenButton = Instance.new("TextButton")
ReopenButton.Size = UDim2.new(0, 120, 0, 40)
ReopenButton.Position = UDim2.new(0, 15, 0.5, -20)
ReopenButton.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ReopenButton.Text = "WENZYX"
ReopenButton.TextColor3 = Color3.fromRGB(0, 200, 255)
ReopenButton.Font = Enum.Font.GothamBold
ReopenButton.TextSize = 14
ReopenButton.Visible = false
ReopenButton.Parent = ScreenGui

local ReopenCorner = Instance.new("UICorner")
ReopenCorner.CornerRadius = UDim.new(0, 8)
ReopenCorner.Parent = ReopenButton

connect(ReopenButton.MouseButton1Click, function()
    Hidden = false
    Main.Visible = true
    ReopenButton.Visible = false
end)

-- =========================================================
-- CLOSE / CLEANUP
-- =========================================================

connect(Close.MouseButton1Click, function()
    settings.Fly = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    for _, c in ipairs(connections) do
        pcall(function()
            c:Disconnect()
        end)
    end

    ScreenGui:Destroy()
end)

-- =========================================================
-- RESPawn HANDLER
-- =========================================================

connect(LocalPlayer.CharacterAdded, function(char)
    task.wait(0.5)

    local hum = char:FindFirstChildOfClass("Humanoid")

    if not hum then
        hum = char:WaitForChild("Humanoid", 5)
    end

    if not hum then return end

    if settings.SpeedEnabled then
        hum.WalkSpeed = settings.Speed
    else
        hum.WalkSpeed = 16
    end

    hum.UseJumpPower = true

    if settings.JumpEnabled then
        hum.JumpPower = settings.JumpPower
    else
        hum.JumpPower = 50
    end
end)

-- =========================================================
-- STARTUP
-- =========================================================

print("[WENZYXHUB] Loaded successfully.")
print("[WENZYXHUB] All safe client-side features ready.")
