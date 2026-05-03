--[[
💀 ONE TAP HUB - LUAU EDITION
🎨 UI STYLE: ORION LIBRARY
⚡ BY: KUZE
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = Library:MakeWindow({
    Name = "💀 ONE TAP HUB",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OneTapHub",
    IntroText = "ONE TAP MODE"
})

-- SERVICES
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- VARIABLES
local Enabled = false
local FOV = 200

-- TAB
local Tab = Window:MakeTab({
    Name = "🎯 AIMBOT",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- SECTION
Tab:AddSection("MAIN SETTINGS")

-- TOGGLE
Tab:AddToggle({
    Name = "ONE TAP ENABLE",
    Default = false,
    Callback = function(Value)
        Enabled = Value
    end
})

-- SLIDER FOV
Tab:AddSlider({
    Name = "FOV RANGE",
    Min = 50,
    Max = 500,
    Default = 200,
    Color = Color3.fromRGB(255,0,0),
    Increment = 10,
    ValueName = " studs",
    Callback = function(Value)
        FOV = Value
    end
})

-- 🎯 FUNCTION
local function GetClosest()
    local Target = nil
    local BestDist = FOV
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("Head") then
            local Hum = v.Character:FindFirstChild("Humanoid")
            if Hum and Hum.Health > 0 then
                local Dist = (Camera.CFrame.Position - v.Character.Head.Position).Magnitude
                if Dist < BestDist then
                    BestDist = Dist
                    Target = v.Character.Head
                end
            end
        end
    end
    return Target
end

-- LOOP
RunService.RenderStepped:Connect(function()
    if Enabled then
        local Target = GetClosest()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position)
        end
    end
end)

print("LOADED BOS! UI NYA ELEGAN KAN? 😎")
