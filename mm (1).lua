-- Krev Hub MM2 - Delta / Velocity Edition (Fully Fixed & Optimized)
-- Compatible: Delta, Velocity, Codex, Arceus X, Trigon (Mobile)

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = Workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

local guiParent
local success, res = pcall(function() return gethui() end)
if success and res then 
    guiParent = res 
else 
    guiParent = CoreGui 
end

pcall(function()
    local old = guiParent:FindFirstChild("KrevHubMM2")
    if not old then old = LocalPlayer.PlayerGui:FindFirstChild("KrevHubMM2") end
    if old then old:Destroy() end
end)

local Theme = {
    background = Color3.fromRGB(15, 15, 20),
    panel = Color3.fromRGB(25, 25, 30),
    surface = Color3.fromRGB(35, 35, 45),
    text = Color3.fromRGB(255, 255, 255),
    muted = Color3.fromRGB(160, 160, 175),
    accent = Color3.fromRGB(255, 0, 128),
    success = Color3.fromRGB(0, 255, 128),
    danger = Color3.fromRGB(255, 50, 50),
    sheriff = Color3.fromRGB(0, 150, 255),
}

local state = {
    roleEsp = false, xray = false, xrayStr = 0.5, noclip = false, fly = false,
    autoPickupGun = false, gunEsp = false,
    autoShoot = false, autoKill = false,
    killAura = false, killAll = false, killOnlySheriff = false, killPlayerTarget = "None",
    autoFarm = false, antiFling = false, avoidMurderer = false,
    wsEnabled = false, ws = 50, jpEnabled = false, jp = 100,
    touchFling = false, selectedEmote = "ninja"
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrevHubMM2"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = guiParent end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local function makeDraggable(gui, handle)
    handle = handle or gui
    local dragging, dragInput, dragStart, startPos
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
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
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.fromOffset(45, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Theme.panel
ToggleBtn.Text = "K"
ToggleBtn.TextColor3 = Theme.accent
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.TextSize = 24
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
local tbStroke = Instance.new("UIStroke", ToggleBtn)
tbStroke.Color = Theme.accent
tbStroke.Thickness = 2
makeDraggable(ToggleBtn)

local Window = Instance.new("Frame")
Window.Size = UDim2.fromOffset(520, 340)
Window.Position = UDim2.fromScale(0.5, 0.5)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = Theme.background
Window.Visible = false
Window.Parent = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", Window).Color = Theme.accent

ToggleBtn.MouseButton1Click:Connect(function() Window.Visible = not Window.Visible end)

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Theme.panel
Header.Parent = Window
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)
makeDraggable(Window, Header)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = "Krev Hub | MM2 Delta - @krevetkascripts"
Title.TextColor3 = Theme.accent
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(35, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Theme.muted
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = Header
CloseBtn.MouseButton1Click:Connect(function() Window.Visible = false end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.Position = UDim2.fromOffset(0, 35)
Sidebar.BackgroundColor3 = Theme.panel
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 0
Sidebar.Parent = Window
local sLayout = Instance.new("UIListLayout", Sidebar)
sLayout.Padding = UDim.new(0, 5)
local sPad = Instance.new("UIPadding", Sidebar)
sPad.PaddingTop, sPad.PaddingLeft, sPad.PaddingRight = UDim.new(0, 5), UDim.new(0, 5), UDim.new(0, 5)

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -120, 1, -35)
Content.Position = UDim2.fromOffset(120, 35)
Content.BackgroundTransparency = 1
Content.Parent = Window

local tabs = {}
local activeTab = nil
local elementOrder = 0

local function addTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Theme.surface
    btn.BackgroundTransparency = 1
    btn.Text = "  " .. name
    btn.TextColor3 = Theme.muted
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, -16, 1, -16)
    page.Position = UDim2.fromOffset(8, 8)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = Theme.accent
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new()
    page.Visible = false
    page.Parent = Content
    local pLayout = Instance.new("UIListLayout", page)
    pLayout.Padding = UDim.new(0, 6)
    pLayout.SortOrder = Enum.SortOrder.LayoutOrder

    tabs[name] = {btn = btn, page = page}

    btn.MouseButton1Click:Connect(function()
        if activeTab == name then return end
        for tName, tData in pairs(tabs) do
            local isSel = (tName == name)
            tData.page.Visible = isSel
            tData.btn.BackgroundTransparency = isSel and 0 or 1
            tData.btn.TextColor3 = isSel and Theme.text or Theme.muted
        end
        activeTab = name
    end)
    return page
end

local function addLabel(page, text)
    elementOrder = elementOrder + 1
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Theme.accent
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = elementOrder
    lbl.Parent = page
end

local function addToggle(page, text, default, callback)
    elementOrder = elementOrder + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundColor3 = Theme.surface
    row.LayoutOrder = elementOrder
    row.Parent = page
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.Position = UDim2.fromOffset(10, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Theme.text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(36, 18)
    btn.Position = UDim2.new(1, -44, 0.5, -9)
    btn.BackgroundColor3 = default and Theme.accent or Color3.fromRGB(50, 50, 60)
    btn.Text = ""
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(14, 14)
    knob.Position = UDim2.new(default and 1 or 0, default and -16 or 2, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Parent = btn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local val = default
    btn.MouseButton1Click:Connect(function()
        val = not val
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = val and Theme.accent or Color3.fromRGB(50, 50, 60)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(val and 1 or 0, val and -16 or 2, 0.5, -7)}):Play()
        callback(val)
    end)
end

local function addSlider(page, text, min, max, default, callback)
    elementOrder = elementOrder + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 42)
    row.BackgroundColor3 = Theme.surface
    row.LayoutOrder = elementOrder
    row.Parent = page
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 0, 20)
    lbl.Position = UDim2.fromOffset(10, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Theme.text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.fromOffset(30, 20)
    valLbl.Position = UDim2.new(1, -40, 0, 2)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.TextColor3 = Theme.accent
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextSize = 11
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -20, 0, 4)
    bar.Position = UDim2.new(0, 10, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    bar.Text = ""
    bar.Parent = row
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.accent
    fill.Parent = bar
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function update(inp)
        local pct = math.clamp((inp.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(min + (max - min) * pct)
        fill.Size = UDim2.new(pct, 0, 1, 0)
        valLbl.Text = tostring(v)
        callback(v)
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

local function addBtn(page, text, callback)
    elementOrder = elementOrder + 1
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 28)
    btn.BackgroundColor3 = Theme.surface
    btn.Text = text
    btn.TextColor3 = Theme.accent
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.LayoutOrder = elementOrder
    btn.Parent = page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
end

local function addDropdown(page, text, options, callback)
    elementOrder = elementOrder + 1
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 50)
    row.BackgroundColor3 = Theme.surface
    row.LayoutOrder = elementOrder
    row.ClipsDescendants = true
    row.Parent = page
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -16, 0, 20)
    lbl.Position = UDim2.fromOffset(10, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Theme.text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local dBtn = Instance.new("TextButton")
    dBtn.Size = UDim2.new(1, -20, 0, 20)
    dBtn.Position = UDim2.fromOffset(10, 24)
    dBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    dBtn.Text = " " .. options[1]
    dBtn.TextColor3 = Theme.accent
    dBtn.Font = Enum.Font.GothamBold
    dBtn.TextSize = 11
    dBtn.TextXAlignment = Enum.TextXAlignment.Left
    dBtn.Parent = row
    Instance.new("UICorner", dBtn).CornerRadius = UDim.new(0, 4)

    local list = Instance.new("ScrollingFrame")
    list.Size = UDim2.new(1, -20, 0, 70)
    list.Position = UDim2.fromOffset(10, 48)
    list.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    list.BorderSizePixel = 0
    list.ScrollBarThickness = 2
    list.Parent = row
    Instance.new("UIListLayout", list)

    local isOpen = false
    local function refresh(opts)
        for _, v in pairs(list:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        for _, o in pairs(opts) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 20)
            b.BackgroundTransparency = 1
            b.Text = "  " .. o
            b.TextColor3 = Theme.text
            b.Font = Enum.Font.Gotham
            b.TextSize = 11
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Parent = list
            b.MouseButton1Click:Connect(function()
                isOpen = false
                row.Size = UDim2.new(1, 0, 0, 50)
                dBtn.Text = " " .. o
                callback(o)
            end)
        end
    end
    refresh(options)

    dBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        row.Size = isOpen and UDim2.new(1, 0, 0, 125) or UDim2.new(1, 0, 0, 50)
    end)
    return refresh
end

local pMain = addTab("Main")
addLabel(pMain, "Visuals")
addToggle(pMain, "Enable Role ESP", false, function(v) state.roleEsp = v end)
addToggle(pMain, "Gun ESP", false, function(v) state.gunEsp = v end)
addToggle(pMain, "X-Ray", false, function(v) state.xray = v end)
addSlider(pMain, "X-Ray Strength", 10, 100, 50, function(v) state.xrayStr = v / 100 end)

addLabel(pMain, "Movement")
addToggle(pMain, "No Clip", false, function(v) state.noclip = v end)
addToggle(pMain, "Fly (Mobile Fix)", false, function(v) state.fly = v end)
addToggle(pMain, "Walk Speed", false, function(v) state.wsEnabled = v end)
addSlider(pMain, "Speed Value", 16, 150, 50, function(v) state.ws = v end)
addToggle(pMain, "Jump Power", false, function(v) state.jpEnabled = v end)
addSlider(pMain, "Jump Value", 50, 250, 100, function(v) state.jp = v end)

local pSheriff = addTab("Sheriff")
addToggle(pSheriff, "Auto Pickup Gun", false, function(v) state.autoPickupGun = v end)
addToggle(pSheriff, "Auto Shoot", false, function(v) state.autoShoot = v end)

local pMurder = addTab("Murder")
addToggle(pMurder, "Kill Aura", false, function(v) state.killAura = v end)
addToggle(pMurder, "Kill All", false, function(v) state.killAll = v end)
addToggle(pMurder, "Kill Only Sheriff", false, function(v) state.killOnlySheriff = v end)
local pList = {"None"}
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then table.insert(pList, p.Name) end
end
local dRefresh = addDropdown(pMurder, "Kill Specific Player", pList, function(v) state.killPlayerTarget = v end)
addBtn(pMurder, "Refresh Players", function()
    local nl = {"None"}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(nl, p.Name) end
    end
    dRefresh(nl)
end)
addBtn(pMurder, "Teleport & Kill Selected", function()
    pcall(function()
        if state.killPlayerTarget == "None" then return end
        local t = Players:FindFirstChild(state.killPlayerTarget)
        local c = LocalPlayer.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        local k = c and c:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
        if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and r and k then
            k.Parent = c
            task.wait(0.1)
            local targetCF = t.Character.HumanoidRootPart.CFrame
            r.CFrame = targetCF * CFrame.new(0, 0, 3)
            task.wait(0.15)
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetCF.Position)
            task.wait(0.1)
            k:Activate()
        end
    end)
end)

local pFarm = addTab("Auto Farm")
addToggle(pFarm, "Auto Farm Coins", false, function(v) state.autoFarm = v end)
addToggle(pFarm, "Avoid Murderer", false, function(v) state.avoidMurderer = v end)
addToggle(pFarm, "Anti-Fling", false, function(v) state.antiFling = v end)

local pFun = addTab("Troll Fun")
addToggle(pFun, "Safe Touch Fling", false, function(v) state.touchFling = v end)
addDropdown(pFun, "Select Emote", {"ninja", "zen", "zombie", "floss", "sit", "dab", "vampire", "robot"}, function(v) state.selectedEmote = v end)
addBtn(pFun, "Play Emote", function()
    pcall(function()
        ReplicatedStorage.Remotes.Misc.PlayEmote:FireServer(state.selectedEmote)
    end)
end)

tabs["Main"].btn.MouseButton1Click:Fire()

local function getRole(player)
    local char = player.Character
    local bp = player:FindFirstChild("Backpack")
    if char and (char:FindFirstChild("Knife") or (bp and bp:FindFirstChild("Knife"))) then return "Murderer" end
    if char and (char:FindFirstChild("Gun") or (bp and bp:FindFirstChild("Gun"))) then return "Sheriff" end
    return "Innocent"
end

local function getRoot(player)
    local c = player.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function getHum(player)
    local c = player.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

local espCache = {}
local gunEspCache = {}

local function updateRoleEsp()
    if not state.roleEsp then
        for k, v in pairs(espCache) do if v and v.Parent then v:Destroy() end end
        table.clear(espCache)
        return
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local role = getRole(p)
            local color = Theme.success
            if role == "Murderer" then color = Theme.danger elseif role == "Sheriff" then color = Theme.sheriff end
            
            if not espCache[p] then
                local hl = Instance.new("Highlight")
                hl.Name = "KrevESP"
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.FillTransparency = 0.5
                hl.OutlineTransparency = 0
                hl.Parent = p.Character
                espCache[p] = hl
            end
            if espCache[p] then
                espCache[p].FillColor = color
                espCache[p].OutlineColor = color
                espCache[p].Parent = p.Character
            end
        else
            if espCache[p] then espCache[p]:Destroy(); espCache[p] = nil end
        end
    end
end

local function updateGunEsp()
    if not state.gunEsp then
        for k, v in pairs(gunEspCache) do if v and v.Parent then v:Destroy() end end
        table.clear(gunEspCache)
        return
    end
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
            if not gunEspCache[obj] then
                local hl = Instance.new("Highlight")
                hl.Name = "KrevGunESP"
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                hl.FillColor = Theme.sheriff
                hl.OutlineColor = Theme.sheriff
                hl.Parent = obj
                gunEspCache[obj] = hl
            end
        end
    end
    for obj, hl in pairs(gunEspCache) do
        if not obj or not obj.Parent or obj.Name ~= "GunDrop" then
            if hl then hl:Destroy() end
            gunEspCache[obj] = nil
        end
    end
end

RunService.RenderStepped:Connect(function(deltaTime)
    local char = LocalPlayer.Character
    if not char then return end
    
    local hum = getHum(LocalPlayer)
    if hum then
        if state.wsEnabled then
            hum.WalkSpeed = state.ws
        end
        if state.jpEnabled then
            hum.UseJumpPower = true
            hum.JumpPower = state.jp
        end
        
        if state.fly then
            hum.PlatformStand = true
            local root = getRoot(LocalPlayer)
            if root then
                local moveDir = hum.MoveDirection
                local cam = Workspace.CurrentCamera.CFrame
                local moveVector = Vector3.new()
                
                if moveDir.Magnitude > 0 then
                    moveVector = (cam.LookVector * moveDir.Z * -1) + (cam.RightVector * moveDir.X)
                end
                
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector + Vector3.new(0, -1, 0)
                end
                
                local speed = state.wsEnabled and state.ws or 50
                root.Velocity = moveVector * speed
            end
        else
            if hum.PlatformStand and not state.noclip then
                hum.PlatformStand = false
            end
        end
    end

    if state.xray then
        for _, p in pairs(Workspace:GetDescendants()) do
            if p:IsA("BasePart") and not p:IsDescendantOf(char) and not p.Parent:FindFirstChildOfClass("Humanoid") then
                p.LocalTransparencyModifier = state.xrayStr
            end
        end
    else
        for _, p in pairs(Workspace:GetDescendants()) do
            if p:IsA("BasePart") and p.LocalTransparencyModifier > 0 and not p:IsDescendantOf(char) then
                p.LocalTransparencyModifier = 0
            end
        end
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end

    if state.noclip or state.fly then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end

    if state.antiFling then
        local root = getRoot(LocalPlayer)
        if root then
            local vel = root.AssemblyLinearVelocity
            if vel.Magnitude > 150 or root.AssemblyAngularVelocity.Magnitude > 50 then
                root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        pcall(updateRoleEsp)
        pcall(updateGunEsp)
    end
end)

-- Исправленный безопасный Touch Fling без крашей
RunService.Heartbeat:Connect(function()
    if state.touchFling then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            local vel = root.AssemblyLinearVelocity
            root.AssemblyLinearVelocity = vel * 1.5 + Vector3.new(math.random(-50, 50), 250, math.random(-50, 50))
        end
    end
end)

local function getMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and getRole(p) == "Murderer" then return p end
    end
    return nil
end

local function aimAt(targetPos)
    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
end

task.spawn(function()
    while task.wait(0.2) do
        local char = LocalPlayer.Character
        local root = getRoot(LocalPlayer)
        if root then
            
            if state.autoFarm then
                pcall(function()
                    local containers = {"Normal", "CoinContainer", "Coins"}
                    for _, cName in ipairs(containers) do
                        local cont = Workspace:FindFirstChild(cName)
                        if cont then
                            for _, coin in pairs(cont:GetChildren()) do
                                if coin:IsA("BasePart") and (coin.Name == "Coin_Server" or coin.Name == "Coin") and coin.Transparency < 1 then
                                    root.CFrame = coin.CFrame
                                    task.wait(0.25)
                                    break
                                end
                            end
                        end
                    end
                end)
            end

            if state.autoPickupGun then
                pcall(function()
                    local gun = nil
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                            gun = obj
                            break
                        end
                    end
                    if gun then
                        root.CFrame = gun.CFrame
                        task.wait(0.2)
                    end
                end)
            end

            if state.avoidMurderer then
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and getRole(p) == "Murderer" then
                            local mRoot = getRoot(p)
                            if mRoot then
                                local d = (mRoot.Position - root.Position).Magnitude
                                if d < 35 then
                                    local dir = (root.Position - mRoot.Position).Unit
                                    local targetPos = root.Position + dir * 30
                                    root.CFrame = CFrame.new(targetPos)
                                end
                            end
                        end
                    end
                end)
            end

            if state.killAura or state.killAll then
                pcall(function()
                    local knife = char:FindFirstChild("Knife") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Knife"))
                    if not knife then return end
                    knife.Parent = char
                    task.wait(0.1)

                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then
                            local tRoot = getRoot(p)
                            if tRoot then
                                local role = getRole(p)
                                local shouldKill = state.killAll or (state.killOnlySheriff and role == "Sheriff") or (state.killAura and role ~= "Murderer")
                                
                                if shouldKill then
                                    if state.killAll and (tRoot.Position - root.Position).Magnitude > 20 then
                                        root.CFrame = tRoot.CFrame * CFrame.new(0, 0, 3)
                                        task.wait(0.1)
                                    end
                                    
                                    if (tRoot.Position - root.Position).Magnitude < 25 then
                                        aimAt(tRoot.Position)
                                        task.wait(0.05)
                                        knife:Activate()
                                        task.wait(0.05)
                                    end
                                end
                            end
                        end
                    end
                end)
            end

            if state.autoShoot then
                pcall(function()
                    local gun = char:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
                    if not gun then return end
                    gun.Parent = char
                    task.wait(0.1)

                    local murderer = getMurderer()
                    if murderer and murderer.Character then
                        local mRoot = getRoot(murderer)
                        if mRoot and (mRoot.Position - root.Position).Magnitude < 100 then
                            local oldCF = Camera.CFrame
                            aimAt(mRoot.Position + Vector3.new(0, 1, 0))
                            task.wait(0.05)
                            gun:Activate()
                            task.wait(0.05)
                            Camera.CFrame = oldCF
                        end
                    end
                end)
            end
        end
    end
end)
