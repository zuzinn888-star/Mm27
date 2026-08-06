-- Krev Hub MM2 Delta Edition (Fixed)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Default State
local state = {
    ws = 16, -- Default WalkSpeed
    jp = 50, -- Default JumpPower
    wsEnabled = false,
    jpEnabled = false,
    noclip = false,
    autoFarm = false,
    autoPickupGun = false,
    avoidMurderer = false,
    autoFlingSheriff = false,
    killAura = false,
    killAll = false,
    killOnlySheriff = false,
    autoShoot = false,
    autoKill = false,
    autoRespawn = false,
    autoEmote = false,
    selectedEmote = "Dance",
    antiFling = false,
    touchFling = false
}

-- Helpers
local function getRoot(char)
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    return root
end

local function getRole(player)
    if not player.Character then return "Innocent" end
    local knife = player.Character:FindFirstChild("Knife")
    local gun = player.Character:FindFirstChild("Gun")
    if knife then
        return "Murderer"
    elseif gun then
        return "Sheriff"
    else
        return "Innocent"
    end
end

local function aimAt(targetPos)
    if not Camera then return end
    Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
end

-- WalkSpeed & JumpPower
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    if state.wsEnabled then
        hum.WalkSpeed = state.ws
    end
    if state.jpEnabled then
        hum.JumpPower = state.jp
    end
end)

-- Noclip
local noclipConn = nil
if state.noclip then
    noclipConn = RunService.Stepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

-- Anti-Fling
RunService.Heartbeat:Connect(function()
    if not state.antiFling then return end
    local root = getRoot(LocalPlayer)
    if not root then return end
    local vel = root.AssemblyLinearVelocity
    if vel.Magnitude > 150 or root.AssemblyAngularVelocity.Magnitude > 50 then
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        root.RotVelocity = Vector3.new(0, 0, 0)
    end
end)

-- Auto Respawn
task.spawn(function()
    while task.wait(3) do
        if state.autoRespawn then
            if not LocalPlayer.Character or not getRoot(LocalPlayer) then
                pcall(function() LocalPlayer:LoadCharacter() end)
            end
        end
    end
end)

-- Auto Emote
task.spawn(function()
    while task.wait(3) do
        if state.autoEmote then
            pcall(function()
                ReplicatedStorage.Remotes.Misc.PlayEmote:FireServer(state.selectedEmote)
            end)
        end
    end
end)

-- Main Action Loop
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    local root = char and getRoot(char)
    if not root then return end
    
    -- Auto Farm (Tween)
    if state.autoFarm then
        pcall(function()
            local containers = {"Normal", "CoinContainer", "Coins"}
            for _, cName in ipairs(containers) do
                local cont = Workspace:FindFirstChild(cName)
                if cont then
                    for _, coin in pairs(cont:GetChildren()) do
                        if coin:IsA("BasePart") and (coin.Name == "Coin_Server" or coin.Name == "Coin") then
                            local tween = TweenService:Create(root, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                            tween:Play()
                            tween.Completed:Wait()
                            task.wait(0.2)
                        end
                    end
                end
            end
        end)
    end
    
    -- Auto Pickup Gun (Tween)
    if state.autoPickupGun then
        pcall(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj.Name == "GunDrop" and obj:IsA("BasePart") then
                    local tween = TweenService:Create(root, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = obj.CFrame})
                    tween:Play()
                    tween.Completed:Wait()
                    task.wait(0.2)
                    break
                end
            end
        end)
    end
    
    -- Avoid Murderer
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
    
    -- Auto Fling Sheriff (CFrame-based)
    if state.autoFlingSheriff then
        pcall(function()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and getRole(p) == "Sheriff" then
                    local sRoot = getRoot(p)
                    if sRoot then
                        root.CFrame = sRoot.CFrame
                        task.wait(0.05)
                        root.Velocity = Vector3.new(0, 500, 0)
                        task.wait(0.15)
                    end
                end
            end
        end)
    end
    
    -- Kill Aura
    if state.killAura then
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
                        local shouldKill = state.killAll or (state.killOnlySheriff and role == "Sheriff")
                        if shouldKill and (tRoot.Position - root.Position).Magnitude < 20 then
                            aimAt(tRoot.Position)
                            task.wait(0.05)
                            knife:Activate()
                            task.wait(0.05)
                        end
                    end
                end
            end
        end)
    end
    
    -- Auto Shoot / Auto Kill (Sheriff)
    if state.autoShoot or state.autoKill then
        pcall(function()
            local gun = char:FindFirstChild("Gun") or (LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChild("Gun"))
            if not gun then return end
            gun.Parent = char
            task.wait(0.1)

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and getRole(p) == "Murderer" then
                    local mRoot = getRoot(p)
                    if mRoot and (mRoot.Position - root.Position).Magnitude < 100 then
                        local oldCF = Camera.CFrame
                        aimAt(mRoot.Position + Vector3.new(0, 1, 0))
                        task.wait(0.05)
                        gun:Activate()
                        task.wait(0.05)
                        Camera.CFrame = oldCF
                    end
                end
            end
        end)
    end
end)

-- Cleanup on death
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if not state.noclip and noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
end)

print("Krev Hub MM2 Delta Edition (Fixed) loaded successfully.")
