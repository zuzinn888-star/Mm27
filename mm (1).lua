-- Krev Hub MM2 - Massive Enterprise Edition v10.0
-- Полностью расширенный, защищенный и оптимизированный многомодульный комплекс для Murder Mystery 2
-- Адаптирован под мобильные эксекуторы (Delta, Velocity, Codex, Arceus X)

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Защищенный контейнер GUI для обхода багов мобильных клиентов
local CoreContainer = (function()
    local success, res = pcall(function() return gethui() end)
    if success and res then return res end
    return CoreGui
end)()

pcall(function()
    local old = CoreContainer:FindFirstChild("KrevEnterpriseMM2")
    if old then old:Destroy() end
end)

local Palette = {
    Background = Color3.fromRGB(10, 10, 15),
    Panel = Color3.fromRGB(18, 18, 25),
    Element = Color3.fromRGB(25, 25, 35),
    Text = Color3.fromRGB(240, 240, 255),
    SubText = Color3.fromRGB(130, 130, 150),
    Accent = Color3.fromRGB(255, 0, 110),
    Secondary = Color3.fromRGB(0, 229, 255),
    Success = Color3.fromRGB(0, 255, 128),
    Murderer = Color3.fromRGB(255, 45, 85),
    Sheriff = Color3.fromRGB(0, 150, 255)
}

local Registry = {
    RoleESP = false,
    GunESP = false,
    CoinESP = false,
    FullBright = false,
    XRay = false,
    XRayValue = 0.5,
    Noclip = false,
    Fly = false,
    WalkSpeedEnabled = false,
    WalkSpeedValue = 24,
    JumpPowerEnabled = false,
    JumpPowerValue = 50,
    AutoFarm = false,
    AutoPickupGun = false,
    AvoidMurderer = false,
    KillAura = false,
    KillAll = false,
    AutoShoot = false,
    AntiFling = false,
    TouchFling = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrevEnterpriseMM2"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreContainer end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Система перетаскивания окон
local function MakeDraggable(handle, window)
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Плавающая кнопка
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.fromOffset(52, 52)
ToggleButton.Position = UDim2.new(0, 20, 0.35, 0)
ToggleButton.BackgroundColor3 = Palette.Panel
ToggleButton.Text = "KREV"
ToggleButton.TextColor3 = Palette.Accent
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.TextSize = 12
ToggleButton.Parent = ScreenGui
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", ToggleButton)
tStroke.Color = Palette.Accent
tStroke.Thickness = 2
MakeDraggable(ToggleButton, ToggleButton)

-- Главное окно
local MainWindow = Instance.new("Frame")
MainWindow.Size = UDim2.fromOffset(580, 400)
MainWindow.Position = UDim2.fromScale(0.5, 0.5)
MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
MainWindow.BackgroundColor3 = Palette.Background
MainWindow.Visible = false
MainWindow.Parent = ScreenGui
Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 12)
local wStroke = Instance.new("UIStroke", MainWindow)
wStroke.Color = Palette.Accent
wStroke.Thickness = 1.5

ToggleButton.MouseButton1Click:Connect(function() MainWindow.Visible = not MainWindow.Visible end)

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Palette.Panel
TopBar.Parent = MainWindow
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)
MakeDraggable(TopBar, MainWindow)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.fromOffset(15, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "KREV HUB // MM2 Enterprise Ultimate"
TitleLabel.TextColor3 = Palette.Accent
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.fromOffset(42, 42)
CloseButton.Position = UDim2.new(1, -42, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "×"
CloseButton.TextColor3 = Palette.SubText
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 24
CloseButton.Parent = TopBar
CloseButton.MouseButton1Click:Connect(function() MainWindow.Visible = false end)

-- Боковое меню вкладок
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 145, 1, -42)
Sidebar.Position = UDim2.fromOffset(0, 42)
Sidebar.BackgroundColor3 = Palette.Panel
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 0
Sidebar.Parent = MainWindow
local sbLayout = Instance.new("UIListLayout", Sidebar)
sbLayout.Padding = UDim.new(0, 6)
local sbPadding = Instance.new("UIPadding", Sidebar)
sbPadding.PaddingTop, sbPadding.PaddingLeft, sbPadding.PaddingRight = UDim.new(0, 8), UDim.new(0, 8), UDim.new(0, 8)

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -145, 1, -42)
ContentArea.Position = UDim2.fromOffset(145, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainWindow

local Tabs = {}
local ActiveTab = nil

local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Palette.Element
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. name
    btn.TextColor3 = Palette.SubText
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 1, -16)
    page.Position = UDim2.fromOffset(8, 8)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Palette.Accent
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new()
    page.Visible = false
    page.Parent = ContentArea
    
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 8)
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder

    Tabs[name] = {Button = btn, Page = page}

    btn.MouseButton1Click:Connect(function()
        if ActiveTab == name then return end
        for tName, data in pairs(Tabs) do
            local sel = (tName == name)
            data.Page.Visible = sel
            data.Button.BackgroundTransparency = sel and 0 or 1
            data.Button.TextColor3 = sel and Palette.Text or Palette.SubText
        end
        ActiveTab = name
    end)
    return page
end

local elementIndex = 0
local function AddLabel(page, text)
    elementIndex = elementIndex + 1
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Palette.Accent
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = elementIndex
    lbl.Parent = page
end

local function AddToggle(page, text, default, callback)
    elementIndex = elementIndex + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 38)
    row.BackgroundColor3 = Palette.Element
    row.LayoutOrder = elementIndex
    row.Parent = page
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -55, 1, 0)
    lbl.Position = UDim2.fromOffset(12, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Palette.Text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(40, 20)
    btn.Position = UDim2.new(1, -48, 0.5, -10)
    btn.BackgroundColor3 = default and Palette.Accent or Color3.fromRGB(40, 40, 55)
    btn.Text = ""
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(16, 16)
    knob.Position = UDim2.new(default and 1 or 0, default and -18 or 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = btn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local val = default
    btn.MouseButton1Click:Connect(function()
        val = not val
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = val and Palette.Accent or Color3.fromRGB(40, 40, 55)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(val and 1 or 0, val and -18 or 2, 0.5, -8)}):Play()
        callback(val)
    end)
end

local function AddSlider(page, text, min, max, default, callback)
    elementIndex = elementIndex + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 48)
    row.BackgroundColor3 = Palette.Element
    row.LayoutOrder = elementIndex
    row.Parent = page
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 0, 20)
    lbl.Position = UDim2.fromOffset(12, 4)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Palette.Text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.fromOffset(45, 20)
    valLbl.Position = UDim2.new(1, -50, 0, 4)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Palette.Secondary
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 12
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -24, 0, 6)
    bar.Position = UDim2.new(0, 12, 0, 32)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    bar.Text = ""
    bar.Parent = row
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Palette.Secondary
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function update(input)
        local pct = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max - min) * pct)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        valLbl.Text = tostring(val)
        callback(val)
    end
    bar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(inp)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            update(inp)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- Создание вкладок
local TabMain = CreateTab("Visuals")
AddLabel(TabMain, "ESP Systems")
AddToggle(TabMain, "Role ESP (Murder/Sheriff)", false, function(v) Registry.RoleESP = v end)
AddToggle(TabMain, "Gun Drop ESP", false, function(v) Registry.GunESP = v end)
AddToggle(TabMain, "Coin ESP", false, function(v) Registry.CoinESP = v end)
AddToggle(TabMain, "FullBright Lighting", false, function(v) Registry.FullBright = v end)
AddToggle(TabMain, "X-Ray Environment", false, function(v) Registry.XRay = v end)
AddSlider(TabMain, "X-Ray Intensity", 10, 100, 50, function(v) Registry.XRayValue = v / 100 end)

AddLabel(TabMain, "Player Physics")
AddToggle(TabMain, "Noclip Mode", false, function(v) Registry.Noclip = v end)
AddToggle(TabMain, "Fly Mode (Mobile)", false, function(v) Registry.Fly = v end)
AddToggle(TabMain, "WalkSpeed Boost", false, function(v) Registry.WalkSpeedEnabled = v end)
AddSlider(TabMain, "Speed Value", 16, 120, 24, function(v) Registry.WalkSpeedValue = v end)

local TabSheriff = CreateTab("Sheriff")
AddToggle(TabSheriff, "Auto Pickup Gun Drop", false, function(v) Registry.AutoPickupGun = v end)
AddToggle(TabSheriff, "Auto Shoot Murderer", false, function(v) Registry.AutoShoot = v end)

local TabMurder = CreateTab("Murderer")
AddToggle(TabMurder, "Kill Aura", false, function(v) Registry.KillAura = v end)
AddToggle(TabMurder, "Kill All Players", false, function(v) Registry.KillAll = v end)

local TabFarm = CreateTab("Automation")
AddToggle(TabFarm, "Auto Farm Coins", false, function(v) Registry.AutoFarm = v end)
AddToggle(TabFarm, "Avoid Murderer (Safe)", false, function(v) Registry.AvoidMurderer = v end)
AddToggle(TabFarm, "Anti-Fling Protection", false, function(v) Registry.AntiFling = v end)
AddToggle(TabFarm, "Touch Fling Engine", false, function(v) Registry.TouchFling = v end)

Tabs["Visuals"].Button.MouseButton1Click:Fire()

-- Утилиты анализа ролей MM2
local function GetPlayerRole(player)
    local char = player.Character
    local backpack = player:FindFirstChild("Backpack")
    if char and (char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))) then
        return "Murderer"
    elseif char and (char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))) then
        return "Sheriff"
    end
    return "Innocent"
end

local function GetRoot(player)
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid(player)
    local char = player.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local HighlightsCache = {}
local GunEspCache = {}
local CoinEspCache = {}

-- Мощный обработчик графики и визуальных функций
RunService.RenderStepped:Connect(function()
    -- Role ESP
    if Registry.RoleESP then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local role = GetPlayerRole(p)
                local col = Palette.Success
                if role == "Murderer" then col = Palette.Murderer
                elseif role == "Sheriff" then col = Palette.Sheriff end
                
                local hl = HighlightsCache[p]
                if not hl or not hl.Parent then
                    hl = Instance.new("Highlight")
                    hl.Name = "KrevHighlight"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillTransparency = 0.4
                    hl.Parent = p.Character
                    HighlightsCache[p] = hl
                else
                    hl.FillColor = col
                    hl.OutlineColor = col
                    hl.Parent = p.Character
                end
            end
        end
    else
        for p, hl in pairs(HighlightsCache) do
            if hl then hl:Destroy() end
            HighlightsCache[p] = nil
        end
    end

    -- Gun Drop ESP
    if Registry.GunESP then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                local hl = GunEspCache[obj]
                if not hl or not hl.Parent then
                    hl = Instance.new("Highlight")
                    hl.Name = "KrevGunHL"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillColor = Palette.Sheriff
                    hl.Parent = obj
                    GunEspCache[obj] = hl
                end
            end
        end
    else
        for obj, hl in pairs(GunEspCache) do
            if hl then hl:Destroy() end
            GunEspCache[obj] = nil
        end
    end

    -- Coin ESP
    if Registry.CoinESP then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if (obj.Name == "Coin_Server" or obj.Name == "Coin") and obj:IsA("BasePart") then
                local hl = CoinEspCache[obj]
                if not hl or not hl.Parent then
                    hl = Instance.new("Highlight")
                    hl.Name = "KrevCoinHL"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillColor = Palette.Secondary
                    hl.Parent = obj
                    CoinEspCache[obj] = hl
                end
            end
        end
    else
        for obj, hl in pairs(CoinEspCache) do
            if hl then hl:Destroy() end
            CoinEspCache[obj] = nil
        end
    end

    -- X-Ray Environment
    local localChar = LocalPlayer.Character
    if Registry.XRay then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:IsDescendantOf(localChar) and not part.Parent:FindFirstChildOfClass("Humanoid") then
                part.LocalTransparencyModifier = Registry.XRayValue
            end
        end
    else
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.LocalTransparencyModifier > 0 and not part:IsDescendantOf(localChar) then
                part.LocalTransparencyModifier = 0
            end
        end
    end

    -- FullBright
    if Registry.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = false
    end

    -- Speed / Jump
    local hum = GetHumanoid(LocalPlayer)
    if hum then
        if Registry.WalkSpeedEnabled then
            hum.WalkSpeed = Registry.WalkSpeedValue
        end
    end
end)

-- Физический конвейер (Noclip, Anti-Fling, Touch Fling)
RunService.Stepped:Connect(function()
    local localChar = LocalPlayer.Character
    if not localChar then return end

    if Registry.Noclip or Registry.Fly then
        for _, part in ipairs(localChar:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    if Registry.AntiFling then
        local root = GetRoot(LocalPlayer)
        if root and root.AssemblyLinearVelocity.Magnitude > 160 then
            root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if Registry.TouchFling then
        local root = GetRoot(LocalPlayer)
        if root then
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * 1.5 + Vector3.new(math.random(-60, 60), 300, math.random(-60, 60))
        end
    end
end)

-- Асинхронный управляющий поток для автоматизации и боевых функций
task.spawn(function()
    while task.wait(0.18) do
        local root = GetRoot(LocalPlayer)
        local char = LocalPlayer.Character
        if root and char then
            
            -- Auto Farm Coins
            if Registry.AutoFarm then
                pcall(function()
                    for _, name in ipairs({"CoinContainer", "Normal", "Coins"}) do
                        local cont = Workspace:FindFirstChild(name)
                        if cont then
                            for _, coin in ipairs(cont:GetChildren()) do
                                if coin:IsA("BasePart") and coin.Transparency < 1 then
                                    root.CFrame = coin.CFrame
                                    task.wait(0.2)
                                    break
                                end
                            end
                        end
                    end
                end)
            end

            -- Auto Pickup Gun
            if Registry.AutoPickupGun then
                pcall(function()
                    for _, obj in ipairs(Workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                            root.CFrame = obj.CFrame
                            task.wait(0.15)
                            break
                        end
                    end
                end)
            end

            -- Avoid Murderer
            if Registry.AvoidMurderer then
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and GetPlayerRole(p) == "Murderer" then
                            local mRoot = GetRoot(p)
                            if mRoot and (mRoot.Position - root.Position).Magnitude < 40 then
                                local dir = (root.Position - mRoot.Position).Unit
                                root.CFrame = CFrame.new(root.Position + dir * 35)
                            end
                        end
                    end
                end)
            end

            -- KillAura / KillAll
            if Registry.KillAura or Registry.KillAll then
                pcall(function()
                    local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                    if knife then
                        knife.Parent = char
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer then
                                local tRoot = GetRoot(p)
                                local role = GetPlayerRole(p)
                                local targetable = Registry.KillAll or (Registry.KillAura and role ~= "Murderer")
                                
                                if tRoot and targetable then
                                    if Registry.KillAll and (tRoot.Position - root.Position).Magnitude > 22 then
                                        root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 2)
                                        task.wait(0.06)
                                    end
                                    if (tRoot.Position - root.Position).Magnitude < 25 then
                                        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tRoot.Position)
                                        knife:Activate()
                                    end
                                end
                            end
                        end
                    end
                end)
            end

            -- Auto Shoot Murderer
            if Registry.AutoShoot then
                pcall(function()
                    local gun = char:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
                    if gun then
                        gun.Parent = char
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and GetPlayerRole(p) == "Murderer" then
                                local mRoot = GetRoot(p)
                                if mRoot and (mRoot.Position - root.Position).Magnitude < 140 then
                                    local oldCam = Camera.CFrame
                                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, mRoot.Position + Vector3.new(0, 1, 0))
                                    task.wait(0.04)
                                    gun:Activate()
                                    Camera.CFrame = oldCam
                                end
                            end
                        end
                    end
                end)
            end

        end
    end
end)
