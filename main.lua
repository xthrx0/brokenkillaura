local RunService = game:GetService("RunService")
local ZombieFolder = workspace:WaitForChild("Zombies")
local remoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("DamageRemote")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function dealDamage(Zombie)
    if Zombie:FindFirstChild("Humanoid") and Zombie:FindFirstChild("HumanoidRootPart") then
        local distance = (character.HumanoidRootPart.Position - Zombie.HumanoidRootPart.Position).Magnitude
        if distance <= 10 then
            remoteEvent:FireServer(Zombie)
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
