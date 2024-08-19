local RunService = game:GetService("RunService")
local ZombieFolder = workspace:WaitForChild("Zombies")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function getSabre()
    local backpackSabre = player.Backpack:FindFirstChild("Sabre")
    if backpackSabre then
        return backpackSabre
    end
    
    local equippedSabre = workspace:FindFirstChild("Players"):FindFirstChild(player.Name):FindFirstChild("Sabre")
    if equippedSabre then
        return equippedSabre
    end

    return nil
end

local function dealDamage(Zombie)
    if Zombie:FindFirstChild("Humanoid") and Zombie:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - Zombie.HumanoidRootPart.Position).Magnitude
        if distance <= 10 then
            local sabre = getSabre()
            if sabre then
                local remoteEvent = sabre:FindFirstChild("Hit")
                if remoteEvent then
                    remoteEvent:FireServer(Zombie)
                end
            end
        end
    end
end

RunService.Stepped:Connect(function()
    for _, Zombie in ipairs(ZombieFolder:GetChildren()) do
        if Zombie:IsA("Model") and Zombie.Name == "Agent" then
            dealDamage(Zombie)
        end
    end
    task.wait(0.1)
end)
