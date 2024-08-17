local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local auraRadius = 10

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local GibRemote = Remotes:WaitForChild("Gib")

print("Running")

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
                    local args = {
                        [1] = player.Name,
                        [2] = Agent,
                        [3] = "Right Arm",
                        [4] = agentPosition,
                        [5] = Agent.HumanoidRootPart.CFrame.LookVector
                    }
                    GibRemote:FireServer(unpack(args))

                    print("Running")
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(autoKill)
