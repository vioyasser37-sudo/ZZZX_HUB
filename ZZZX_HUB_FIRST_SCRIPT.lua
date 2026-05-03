--[[ SCRIPT KICK A LUCKY BLOCK 
     WITH UI MENU 🎨
     SUPPORT DELTA EXECUTOR ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ⚙️ VARIABLES
local Enabled = true
local Power = 100000
local Connection = nil

-- 🎨 MAKE UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local PowerText = Instance.new("TextLabel")
local IncreaseBtn = Instance.new("TextButton")
local DecreaseBtn = Instance.new("TextButton")
local Credit = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MAIN FRAME
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- BISA DI-GESER

-- TITLE
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ KICK BLOCK HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- TOGGLE BUTTON
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.Position = UDim2.new(0.05, 0, 0.25, 0)
ToggleButton.Size = UDim2.new(0.9, 0, 0, 35)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "STATUS: ON ✅"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14

-- POWER TEXT
PowerText.Name = "PowerText"
PowerText.Parent = MainFrame
PowerText.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
PowerText.Position = UDim2.new(0.05, 0, 0.55, 0)
PowerText.Size = UDim2.new(0.6, 0, 0, 35)
PowerText.Font = Enum.Font.GothamBold
PowerText.Text = "POWER: "..Power
PowerText.TextColor3 = Color3.fromRGB(255, 255, 255)
PowerText.TextSize = 14

-- PLUS BUTTON
IncreaseBtn.Name = "IncreaseBtn"
IncreaseBtn.Parent = MainFrame
IncreaseBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
IncreaseBtn.Position = UDim2.new(0.68, 0, 0.55, 0)
IncreaseBtn.Size = UDim2.new(0.13, 0, 0, 35)
IncreaseBtn.Font = Enum.Font.GothamBold
IncreaseBtn.Text = "+"
IncreaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
IncreaseBtn.TextSize = 16

-- MINUS BUTTON
DecreaseBtn.Name = "DecreaseBtn"
DecreaseBtn.Parent = MainFrame
DecreaseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
DecreaseBtn.Position = UDim2.new(0.83, 0, 0.55, 0)
DecreaseBtn.Size = UDim2.new(0.13, 0, 0, 35)
DecreaseBtn.Font = Enum.Font.GothamBold
DecreaseBtn.Text = "-"
DecreaseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DecreaseBtn.TextSize = 16

-- CREDIT
Credit.Name = "Credit"
Credit.Parent = MainFrame
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0.05, 0, 0.85, 0)
Credit.Size = UDim2.new(0.9, 0, 0, 20)
Credit.Font = Enum.Font.Gotham
Credit.Text = "Script by: "..Player.Name
Credit.TextColor3 = Color3.fromRGB(200, 200, 200)
Credit.TextSize = 11

-- 🚀 FUNCTION KICK
local function KickBlocks()
    if not Enabled then return end
    for _, Model in pairs(workspace:GetDescendants()) do
        if Model:IsA("Part") and Model.CanCollide == true and Model.Name ~= "Terrain" and Model.Parent.Name ~= "Debris" then
            local Jarak = (HumanoidRootPart.Position - Model.Position).Magnitude
            if Jarak < 20 then
                if Model:FindFirstChild("BodyVelocity") then
                    Model.BodyVelocity:Destroy()
                end
                local BV = Instance.new("BodyVelocity")
                BV.Velocity = Vector3.new(math.random(-Power,Power), Power/1.5, math.random(-Power,Power))
                BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                BV.Parent = Model
            end
        end
    end
end

-- 🔘 BUTTON EVENT
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        ToggleButton.Text = "STATUS: ON ✅"
        Connection = RunService.Heartbeat:Connect(KickBlocks)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToggleButton.Text = "STATUS: OFF ❌"
        if Connection then
            Connection:Disconnect()
        end
    end
end)

IncreaseBtn.MouseButton1Click:Connect(function()
    Power = Power + 20000
    PowerText.Text = "POWER: "..Power
end)

DecreaseBtn.MouseButton1Click:Connect(function()
    Power = Power - 20000
    if Power < 10000 then Power = 10000 end
    PowerText.Text.Text = "POWER: "..Power
end)

-- START LOOP
Connection = RunService.Heartbeat:Connect(KickBlocks)

print("UI LOADED BOS! 🎨")
