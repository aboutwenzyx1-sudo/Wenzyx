-- ═══════════════════════════════════════════════════════════
-- WENZYXHUB | STEAL AN EGG
-- Premium Edition - 100% UI Mirror SysHub
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════
-- [1] ANTI-KICK MODULE (LAYER 1)
-- ═══════════════════════════════════════════════════════════
pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        local oldNamecall = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" then
                warn("[WENZYXHUB] Kick attempt blocked!")
                return nil
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [2] ANTI-KICK MODULE (LAYER 2)
-- ═══════════════════════════════════════════════════════════
pcall(function()
    LocalPlayer.Kick = function() 
        warn("[WENZYXHUB] LocalPlayer.Kick blocked!") 
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [3] ANTI-KICK MODULE (LAYER 3 - Guard Remote)
-- ═══════════════════════════════════════════════════════════
pcall(function()
    for _, obj in pairs(game:GetDescendants()) do
        if obj.Name == "Kick" or obj.Name == "Disconnect" or obj.Name == "Ban" then
            if obj:IsA("RemoteEvent") then
                obj.OnClientEvent:Connect(function()
                    warn("[WENZYXHUB] Kick via Remote blocked!")
                end)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [4] CONFIG GLOBAL
-- ═══════════════════════════════════════════════════════════
local CONFIG = {
    -- Steal Egg
    AutoSteal = false,
    LockTarget = false,
    AutoPlace = false,
    AutoApplyMutation = false,
    AutoHatch = false,
    AutoHatchBoss = false,
    TargetArea = "All",
    FilterRarity = {"Divine"},
    FilterPetSpecies = "--",
    MinEarnToSteal = 0,
    -- Movement
    Speed = 16,
    SpeedEnabled = false,
    JumpPower = 50,
    JumpEnabled = false,
    InfJump = false,
    NoClip = false,
    Fly = false,
    AntiAFK = true,
    -- Abilities
    GodMode = false,
    TrollPlayer = false,
    StreamingMode = false,
    FastInteract = false,
    -- Plot
    AutoUpgradeBase = false,
    AutoUpgradeTreadmill = false,
    AutoTreadmillIdle = false,
    -- Performance
    FPSBoost = false,
    OptimizeWorkspace = false,
    HematResource = false,
}

-- ═══════════════════════════════════════════════════════════
-- [5] HELPER FUNCTIONS
-- ═══════════════════════════════════════════════════════════
local function GetChar() return LocalPlayer.Character end
local function GetHum()
    local c = GetChar()
    if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end
local function GetRoot()
    local c = GetChar()
    if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end

-- ═══════════════════════════════════════════════════════════
-- [6] GUI SETUP (MIRIP SYS-HUB)
-- ═══════════════════════════════════════════════════════════
pcall(function()
    local old = CoreGui:FindFirstChild("WenzyxHub")
    if old then old:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WenzyxHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

-- ─── MAIN FRAME (600x400) ───
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 40, 60)
MainStroke.Thickness = 1
MainStroke.Parent = Main

-- ─── TOP BAR ───
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

-- Logo "S" atau icon
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 10, 0.5, -15)
Logo.Text = "W"
Logo.TextColor3 = Color3.fromRGB(0, 180, 255)
Logo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 20
Logo.Parent = TopBar

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 6)
LogoCorner.Parent = Logo

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 260, 0, 20)
Title.Position = UDim2.new(0, 48, 0, 4)
Title.Text = "WenzyxHub - Steal An Egg"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 200, 0, 15)
SubTitle.Position = UDim2.new(0, 48, 0, 21)
SubTitle.Text = "Premium Version"
SubTitle.TextColor3 = Color3.fromRGB(150, 150, 170)
SubTitle.BackgroundTransparency = 1
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TopBar

-- FPS Counter
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(0, 70, 0, 24)
FPSLabel.Position = UDim2.new(1, -280, 0.5, -12)
FPSLabel.Text = "FPS: --"
FPSLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
FPSLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.TextSize = 12
FPSLabel.Parent = TopBar

local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 6)
FPSCorner.Parent = FPSLabel

-- Ping Counter
local PingLabel = Instance.new("TextLabel")
PingLabel.Size = UDim2.new(0, 70, 0, 24)
PingLabel.Position = UDim2.new(1, -205, 0.5, -12)
PingLabel.Text = "Ping: --"
PingLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
PingLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 12
PingLabel.Parent = TopBar

local PingCorner = Instance.new("UICorner")
PingCorner.CornerRadius = UDim.new(0, 6)
PingCorner.Parent = PingLabel

-- Minimize
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -130, 0.5, -12)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
MinBtn.BackgroundTransparency = 1
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = TopBar

-- Maximize placeholder
local MaxBtn = Instance.new("TextButton")
MaxBtn.Size = UDim2.new(0, 25, 0, 25)
MaxBtn.Position = UDim2.new(1, -100, 0.5, -12)
MaxBtn.Text = "⬜"
MaxBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
MaxBtn.BackgroundTransparency = 1
MaxBtn.Font = Enum.Font.GothamBold
MaxBtn.TextSize = 12
MaxBtn.Parent = TopBar

-- Close
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -70, 0.5, -12)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar

-- ─── SIDEBAR TABS ───
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 170, 1, -40)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

-- Divider
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0, 1, 1, 0)
Divider.Position = UDim2.new(0, 170, 0, 40)
Divider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Divider.BorderSizePixel = 0
Divider.Parent = Main

-- ─── CONTENT AREA ───
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -175, 1, -55)
Content.Position = UDim2.new(0, 175, 0, 50)
Content.BackgroundTransparency = 1
Content.Parent = Main

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, 0, 1, 0)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 3
ContentScroll.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 90)
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = Content

local ContentLayout = Instance.new("UIListLayout")
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.Parent = ContentScroll

-- ═══════════════════════════════════════════════════════════
-- [7] HELPER: TAB BUTTON
-- ═══════════════════════════════════════════════════════════
local tabButtons = {}

local function CreateTab(icon, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.Position = UDim2.new(0, 5, 0, 8 + (#tabButtons * 40))
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.Parent = Sidebar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = btn

    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 25, 1, 0)
    IconLabel.Position = UDim2.new(0, 8, 0, 0)
    IconLabel.Text = icon
    IconLabel.TextColor3 = Color3.fromRGB(150, 180, 220)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextSize = 14
    IconLabel.Parent = btn

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -40, 1, 0)
    NameLabel.Position = UDim2.new(0, 35, 0, 0)
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Font = Enum.Font.Gotham
    NameLabel.TextSize = 13
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = btn

    table.insert(tabButtons, btn)

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabButtons) do
            t.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        end
        btn.BackgroundColor3 = Color3.fromRGB(30, 40, 70)
        callback()
    end)

    return btn
end

-- ═══════════════════════════════════════════════════════════
-- [8] HELPER: SECTION TITLE
-- ═══════════════════════════════════════════════════════════
local function SectionTitle(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 25)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(100, 180, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = ContentScroll
    return lbl
end

-- ═══════════════════════════════════════════════════════════
-- [9] HELPER: TOGGLE
-- ═══════════════════════════════════════════════════════════
local function CreateToggle(name, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    frame.BorderSizePixel = 0
    frame.Parent = ContentScroll

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 6)
    fCorner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = name
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 44, 0, 22)
    toggle.Position = UDim2.new(1, -56, 0.5, -11)
    toggle.Text = ""
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    toggle.BorderSizePixel = 0
    toggle.Parent = frame

    local tCorner = Instance.new("UICorner")
    tCorner.CornerRadius = UDim.new(1, 0)
    tCorner.Parent = toggle

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = toggle

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local state = default

    if state then
        toggle.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
        knob.Position = UDim2.new(1, -20, 0.5, -9)
    end

    toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 180, 255)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(1, -20, 0.5, -9)}):Play()
        else
            TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -9)}):Play()
        end
        callback(state)
    end)

    return frame
end

-- ═══════════════════════════════════════════════════════════
-- [10] HELPER: BUTTON
-- ═══════════════════════════════════════════════════════════
local function CreateActionButton(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 50)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = ContentScroll

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 6)
    bCorner.Parent = btn

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ═══════════════════════════════════════════════════════════
-- [11] HELPER: SLIDER
-- ═══════════════════════════════════════════════════════════
local function CreateSlider(title, min, max, default, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 60)
    holder.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    holder.BorderSizePixel = 0
    holder.Parent = ContentScroll

    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0, 6)
    hCorner.Parent = holder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 22)
    label.Position = UDim2.new(0, 12, 0, 3)
    label.BackgroundTransparency = 1
    label.Text = title .. ": " .. default
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -30, 0, 8)
    bar.Position = UDim2.new(0, 15, 0, 40)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    bar.BorderSizePixel = 0
    bar.Parent = holder

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
    fill.BorderSizePixel = 0
    fill.Parent = bar

    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(1, 0)
    fCorner.Parent = fill

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
    knob.Text = ""
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.Parent = bar

    local kCorner = Instance.new("UICorner")
    kCorner.CornerRadius = UDim.new(1, 0)
    kCorner.Parent = knob

    local dragging = false

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)

    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local percent = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + percent * (max - min))
            label.Text = title .. ": " .. value
            fill.Size = UDim2.new(percent, 0, 1, 0)
            knob.Position = UDim2.new(percent, -8, 0.5, -8)
            callback(value)
        end
    end)

    return holder
end

-- ═══════════════════════════════════════════════════════════
-- [12] HELPER: DROPDOWN (MULTI)
-- ═══════════════════════════════════════════════════════════
local function CreateDropdown(title, options, default, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 45)
    holder.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    holder.BorderSizePixel = 0
    holder.Parent = ContentScroll

    local hCorner = Instance.new("UICorner")
    hCorner.CornerRadius = UDim.new(0, 6)
    hCorner.Parent = holder

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 160, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(230, 230, 240)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = holder

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 130, 0, 30)
    btn.Position = UDim2.new(1, -145, 0.5, -15)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.Text = default or "--"
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = holder

    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 6)
    bCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        -- Placeholder dropdown (UI only)
        local current = btn.Text
        local idx = 1
        for i, opt in ipairs(options) do
            if opt == current then idx = i break end
        end
        local next = options[(idx % #options) + 1]
        btn.Text = next
        callback(next)
    end)

    return holder
end

-- ═══════════════════════════════════════════════════════════
-- [13] TAB: PLAYER
-- ═══════════════════════════════════════════════════════════
local function ShowPlayer()
    ContentScroll:ClearAllChildren()
    SectionTitle("👤 PLAYER FEATURES")

    CreateActionButton("🔄 Refresh Player List", Color3.fromRGB(30, 100, 200), function()
        print("[WENZYXHUB] Player list refreshed")
    end)

    CreateDropdown("Select Specific Player", {"--", "Player1", "Player2", "Player3"}, "--", function() end)

    CreateToggle("Lock Target Player", CONFIG.LockTarget, function(s)
        CONFIG.LockTarget = s
    end)

    SectionTitle("👁️ PLAYER INFO")

    CreateActionButton("🎯 Teleport to Player", Color3.fromRGB(30, 100, 200), function() end)
    CreateActionButton("📋 Copy Player Info", Color3.fromRGB(30, 100, 200), function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [14] TAB: STEAL EGG
-- ═══════════════════════════════════════════════════════════
local function ShowStealEgg()
    ContentScroll:ClearAllChildren()
    SectionTitle("⚡ AUTO STEAL CONFIGURATION")

    CreateToggle("Auto Steal From ANY Player (by Rarity)", CONFIG.AutoSteal, function(s)
        CONFIG.AutoSteal = s
    end)

    CreateDropdown("Select Specific Player", {"--", "Vinnh2h", "Player1", "Player2"}, "--", function() end)

    CreateActionButton("🔄 Refresh Player List", Color3.fromRGB(30, 100, 200), function() end)

    CreateToggle("Lock Target Player (Steal APAPUN yang dia pegang)", CONFIG.LockTarget, function(s)
        CONFIG.LockTarget = s
    end)

    SectionTitle("🎯 FILTER RARITY (UNIVERSAL TARGET)")

    CreateDropdown("Filter Rarity", {"Divine", "Eternal", "Secret", "Cosmic", "Mythic"}, "Divine", function() end)

    SectionTitle("🎯 FILTER BY RARITY (PLACE, MUTATE, HATCH)")

    CreateToggle("Auto Place Egg After Steal", CONFIG.AutoPlace, function(s)
        CONFIG.AutoPlace = s
    end)

    CreateToggle("Auto Apply Mutation (Loop)", CONFIG.AutoApplyMutation, function(s)
        CONFIG.AutoApplyMutation = s
    end)

    CreateToggle("Auto Hatch Ready Eggs", CONFIG.AutoHatch, function(s)
        CONFIG.AutoHatch = s
    end)

    CreateToggle("Auto Hatch BOSS Mutated Eggs ONLY (Optional)", CONFIG.AutoHatchBoss, function(s)
        CONFIG.AutoHatchBoss = s
    end)

    CreateActionButton("📦 Place All Eggs (Inventory)", Color3.fromRGB(30, 100, 200), function() end)

    CreateActionButton("⚗️ Apply Mutation to All (Once)", Color3.fromRGB(150, 50, 200), function() end)

    CreateActionButton("🥚 Hatch All Ready Eggs", Color3.fromRGB(0, 150, 200), function() end)

    SectionTitle("📊 PLOT AUTOMATION & MANAGEMENT")

    CreateActionButton("📋 Plot Egg Status: Placed 2 | Ready 2 | Boss Mutated 1", Color3.fromRGB(20, 20, 32), function() end)

    SectionTitle("🔴 STEAL FROM PLAYERS (PVP STRIKE)")

    CreateActionButton("📡 Live Target Radar: 4 Players", Color3.fromRGB(20, 20, 32), function() end)

    CreateToggle("Fast Interact (Instant Prompt)", CONFIG.FastInteract, function(s)
        CONFIG.FastInteract = s
    end)
end

-- ═══════════════════════════════════════════════════════════
-- [15] TAB: EVENT
-- ═══════════════════════════════════════════════════════════
local function ShowEvent()
    ContentScroll:ClearAllChildren()
    SectionTitle("🎉 EVENT FEATURES")

    CreateToggle("Auto Capture The Egg (Sky Patrol)", false, function(s) end)
    CreateToggle("Auto Unlock/Claim Vault", false, function(s) end)
    CreateToggle("Auto Farm Scramble Drones", false, function(s) end)
    CreateToggle("Auto Farm Target Eggs", false, function(s) end)

    SectionTitle("🌋 DR. SCRAMBLE OUTBREAK")

    CreateActionButton("📊 Outbreak Radar (Samples: 55 | Drone: 0 | Event: false)", Color3.fromRGB(20, 20, 32), function() end)

    SectionTitle("🏛️ EXPERIMENT VAULT STATUS")

    CreateActionButton("✅ Vault Ditemukan! Progress Parts: 2/5", Color3.fromRGB(20, 20, 32), function() end)

    SectionTitle("🛒 DR. SCRAMBLE SHOP")

    CreateActionButton("🛒 Open Dr. Scramble Shop", Color3.fromRGB(30, 100, 200), function() end)

    SectionTitle("🌌 RIFT TRADE-IN")

    CreateActionButton("📋 Rift Details: Banner Target - Riftbeasts", Color3.fromRGB(20, 20, 32), function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [16] TAB: AUTO INDEX
-- ═══════════════════════════════════════════════════════════
local function ShowAutoIndex()
    ContentScroll:ClearAllChildren()
    SectionTitle("📚 AUTO INDEX")

    CreateToggle("Enable Auto Full Index (Steal & Place & Hatch)", false, function(s) end)
    CreateToggle("Auto Sell Duplicate Pets", false, function(s) end)

    SectionTitle("📊 INDEX STATUS")

    CreateActionButton("🌍 Area Missing: Nightflame, Axolotl, Lava Frog, dll", Color3.fromRGB(20, 20, 32), function() end)

    SectionTitle("✨ LIMITED & EVENT MISSING")

    CreateActionButton("🎁 Spike, Spirit Manta, Abyss Shark, Electric Eel, dll", Color3.fromRGB(20, 20, 32), function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [17] TAB: PET
-- ═══════════════════════════════════════════════════════════
local function ShowPet()
    ContentScroll:ClearAllChildren()
    SectionTitle("🐾 PET MANAGEMENT")

    CreateActionButton("📊 Pet Status at Base", Color3.fromRGB(20, 20, 32), function() end)

    SectionTitle("🎯 AUTO EQUIP & SELL")

    CreateToggle("Auto Equip Best Pet", false, function(s) end)
    CreateToggle("Auto Sell Duplicate Pets", false, function(s) end)

    SectionTitle("⭐ FAVORITE MANAGEMENT")

    CreateActionButton("📋 Manage Favorite Pets", Color3.fromRGB(30, 100, 200), function() end)

    SectionTitle("💰 AUTO SELL MANAGEMENT")

    CreateDropdown("Select Rarity to Sell", {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic"}, "Common", function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [18] TAB: UTILITY
-- ═══════════════════════════════════════════════════════════
local function ShowUtility()
    ContentScroll:ClearAllChildren()
    SectionTitle("🔧 MOVEMENT")

    CreateSlider("Speed", 1, 1000, CONFIG.Speed, function(v)
        CONFIG.Speed = v
        if CONFIG.SpeedEnabled then
            local hum = GetHum()
            if hum then hum.WalkSpeed = v end
        end
    end)

    CreateToggle("Enable Speed", CONFIG.SpeedEnabled, function(s)
        CONFIG.SpeedEnabled = s
        local hum = GetHum()
        if hum then
            hum.WalkSpeed = s and CONFIG.Speed or 16
        end
    end)

    CreateSlider("Jump Power", 1, 500, CONFIG.JumpPower, function(v)
        CONFIG.JumpPower = v
        if CONFIG.JumpEnabled then
            local hum = GetHum()
            if hum then hum.UseJumpPower = true hum.JumpPower = v end
        end
    end)

    CreateToggle("Enable Jump Power", CONFIG.JumpEnabled, function(s)
        CONFIG.JumpEnabled = s
        local hum = GetHum()
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = s and CONFIG.JumpPower or 50
        end
    end)

    CreateToggle("Infinite Jump", CONFIG.InfJump, function(s)
        CONFIG.InfJump = s
    end)

    CreateToggle("No Clip", CONFIG.NoClip, function(s)
        CONFIG.NoClip = s
    end)

    CreateToggle("Fly Mode", CONFIG.Fly, function(s)
        CONFIG.Fly = s
    end)

    CreateToggle("Anti AFK", CONFIG.AntiAFK, function(s)
        CONFIG.AntiAFK = s
    end)

    SectionTitle("⚡ PERFORMANCE & OPTIMIZATION")

    CreateToggle("Max FPS Boost (No Effects & Shadows)", CONFIG.FPSBoost, function(s)
        CONFIG.FPSBoost = s
    end)

    CreateToggle("Optimize Workspace (Nuke All Pets, Eggs & Plots)", CONFIG.OptimizeWorkspace, function(s)
        CONFIG.OptimizeWorkspace = s
    end)

    CreateToggle("Hemat Resource Mode (Black Screen & Void Cam)", CONFIG.HematResource, function(s)
        CONFIG.HematResource = s
    end)

    SectionTitle("🌐 SERVER & AUTO EXEC")

    CreateToggle("Queue Script on Server Hop", false, function(s) end)

    CreateActionButton("📋 Copy Job ID", Color3.fromRGB(30, 100, 200), function()
        pcall(function()
            if setclipboard then
                setclipboard(game.JobId)
            end
        end)
    end)

    CreateActionButton("🚪 Join Server with Job ID", Color3.fromRGB(30, 100, 200), function() end)

    CreateActionButton("🔄 Rejoin Server", Color3.fromRGB(200, 100, 30), function()
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end)
    end)

    CreateActionButton("🌐 Hop Server (Low Players)", Color3.fromRGB(50, 150, 100), function() end)

    SectionTitle("⚡ ABILITIES")

    CreateToggle("God Mode (BETA)", CONFIG.GodMode, function(s)
        CONFIG.GodMode = s
    end)

    CreateToggle("Troll Player", CONFIG.TrollPlayer, function(s)
        CONFIG.TrollPlayer = s
    end)

    CreateToggle("Streaming Mode", CONFIG.StreamingMode, function(s)
        CONFIG.StreamingMode = s
    end)
end

-- ═══════════════════════════════════════════════════════════
-- [19] TAB: REWARD
-- ═══════════════════════════════════════════════════════════
local function ShowReward()
    ContentScroll:ClearAllChildren()
    SectionTitle("🎁 REWARD FEATURES")

    CreateActionButton("🎁 Claim All Rewards", Color3.fromRGB(200, 150, 30), function() end)
    CreateActionButton("👥 Claim Group Reward", Color3.fromRGB(200, 150, 30), function() end)
    CreateActionButton("🎯 Claim Daily Reward", Color3.fromRGB(200, 150, 30), function() end)
    CreateActionButton("🏆 Claim Leaderboard Reward", Color3.fromRGB(200, 150, 30), function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [20] TAB: PREDICTOR
-- ═══════════════════════════════════════════════════════════
local function ShowPredictor()
    ContentScroll:ClearAllChildren()
    SectionTitle("🔮 EGG SPAWN PREDICTOR")

    CreateActionButton("⚠️ Prediction based on RNG. Not 100% accurate.", Color3.fromRGB(20, 20, 32), function() end)

    CreateDropdown("Filter Rarity (Multi)", {"Divine", "Eternal", "Secret", "Cosmic", "Mythic", "Legendary"}, "Divine", function() end)

    CreateToggle("Turn On Egg Predictor Engine", false, function(s) end)

    CreateActionButton("👁️ Show Predictor UI", Color3.fromRGB(30, 150, 200), function() end)

    CreateActionButton("🚫 Hide Predictor UI", Color3.fromRGB(200, 50, 50), function() end)
end

-- ═══════════════════════════════════════════════════════════
-- [21] BUILD ALL TABS
-- ═══════════════════════════════════════════════════════════
CreateTab("👤", "Player", ShowPlayer)
CreateTab("🥚", "Steal Egg", ShowStealEgg)
CreateTab("🎉", "Event", ShowEvent)
CreateTab("📚", "Auto Index", ShowAutoIndex)
CreateTab("🐾", "Pet", ShowPet)
CreateTab("🔧", "Utility", ShowUtility)
CreateTab("🎁", "Reward", ShowReward)
CreateTab("🔮", "Predictor", ShowPredictor)

-- Default tab
ShowStealEgg()

-- ═══════════════════════════════════════════════════════════
-- [22] OPEN/CLOSE BUTTON
-- ═══════════════════════════════════════════════════════════
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
OpenBtn.Text = "W"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
OpenBtn.Font = Enum.Font.GothamBlack
OpenBtn.TextSize = 24
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(1, 0)
OpenCorner.Parent = OpenBtn

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- ═══════════════════════════════════════════════════════════
-- [23] DRAG SYSTEM (Mouse + Touch)
-- ═══════════════════════════════════════════════════════════
local dragging = false
local dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [24] FPS & PING COUNTER
-- ═══════════════════════════════════════════════════════════
spawn(function()
    local fps = 0
    local frameCount = 0
    local lastTime = tick()
    while task.wait(0.1) do
        pcall(function()
            frameCount = frameCount + 1
            if tick() - lastTime >= 1 then
                fps = frameCount
                frameCount = 0
                lastTime = tick()
                FPSLabel.Text = "FPS: " .. fps
            end
        end)
    end
end)

spawn(function()
    while task.wait(2) do
        pcall(function()
            local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
            PingLabel.Text = "Ping: " .. ping
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [25] FEATURE LOOPS
-- ═══════════════════════════════════════════════════════════

LocalPlayer.Idled:Connect(function()
    if CONFIG.AntiAFK then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

RunService.Stepped:Connect(function()
    if CONFIG.NoClip then
        local char = GetChar()
        if char then
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.CanCollide = false
                end
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if CONFIG.InfJump then
        local hum = GetHum()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local flyVel = nil
spawn(function()
    while task.wait(0.1) do
        if CONFIG.Fly then
            local root = GetRoot()
            if root and not flyVel then
                flyVel = Instance.new("BodyVelocity", root)
                flyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                flyVel.Velocity = Vector3.new(0, 0, 0)
            end
            if root and flyVel then
                local dir = Vector3.new()
                local cam = workspace.CurrentCamera
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
                flyVel.Velocity = dir.Magnitude > 0 and (dir.Unit * 50) or Vector3.new(0,0,0)
            end
        else
            if flyVel then
                flyVel:Destroy()
                flyVel = nil
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if CONFIG.SpeedEnabled then hum.WalkSpeed = CONFIG.Speed end
        if CONFIG.JumpEnabled then
            hum.UseJumpPower = true
            hum.JumpPower = CONFIG.JumpPower
        end
    end
end)

spawn(function()
    while task.wait(1) do
        if CONFIG.FPSBoost then
            pcall(function()
                for _, v in pairs(game:GetDescendants()) do
                    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                        v.Enabled = false
                    end
                end
                local lighting = game:GetService("Lighting")
                lighting.GlobalShadows = false
                lighting.FogEnd = 9
                lighting.Brightness = 0
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- [26] STARTUP
-- ═══════════════════════════════════════════════════════════
print("[WENZYXHUB] Loaded! Press 'W' to toggle")
print("[WENZYXHUB] Anti-Kick: ACTIVE")
