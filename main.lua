local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local auraRadius = 10
local function autoKill()
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local zombiesFolder = workspace:FindFirstChild("Zombies")
    if zombiesFolder then
        for _, Agent in pairs(zombiesFolder:GetChildren()) do
            if Agent:IsA("Model") and Agent:FindFirstChild("Humanoid") and Agent:FindFirstChild("HumanoidRootPart") then
                local humanoid = Agent.Humanoid
                local agentPosition = Agent.HumanoidRootPart.Position
                local distance = (character.HumanoidRootPart.Position - agentPosition).Magnitude

                if distance <= auraRadius then
                    humanoid:TakeDamage(humanoid.Health)
                    print("Auto-killed " .. Agent.Name)
                end
            end
        end
    end
end
RunService.RenderStepped:Connect(function()
    autoKill()
end)
