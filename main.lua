local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local auraRadius = 10
local function autoKill()
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local zombiesFolder = workspace:FindFirstChild("zombies")
    if zombiesFolder then
        for _, agent in pairs(zombiesFolder:GetChildren()) do
            if agent:IsA("Model") and agent:FindFirstChild("Humanoid") and agent:FindFirstChild("HumanoidRootPart") then
                local humanoid = agent.Humanoid
                local agentPosition = agent.HumanoidRootPart.Position
                local distance = (character.HumanoidRootPart.Position - agentPosition).Magnitude

                if distance <= auraRadius then
                    humanoid:TakeDamage(humanoid.Health)
                    print("Auto-killed " .. agent.Name)
                end
            end
        end
    end
end
RunService.RenderStepped:Connect(function()
    autoKill()
end)
