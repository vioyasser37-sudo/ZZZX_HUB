local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "RANZMODZ HUB",
   LoadingTitle = "OBSIDIAN RECKONING",
   LoadingSubtitle = "by RanzModz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "RanzModz"
   }
})

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- VARIABLES
local Config = {
    Aimbot = false,
    AimbotKey = Enum.KeyCode.E,
    AimbotPart = "Head",
    FOV = 150,
    Smooth = 0.2,
    
    SilentAim = false,
    
    ESP = false,
    ESP_Color = Color3.new(1, 0, 0),
    
    Speed = false,
    WalkSpeed = 35,
    JumpPower = 100
}

-- FUNCTION GET CLOSEST
local function GetClosest()
    local Target = nil
    local Dist = Config.FOV
    
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild(Config.AimbotPart) then
            local Hum = v.Character:FindFirstChildOfClass("Humanoid")
            if Hum and Hum.Health > 0 then
                local Pos, OnScreen = Workspace.CurrentCamera:WorldToViewportPoint(v.Character[Config.AimbotPart].Position)
                local Mag = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Pos.X, Pos.Y)).Magnitude
                
                if Mag < Dist and OnScreen then
                    Dist = Mag
                    Target = v.Character[Config.AimbotPart]
                end
            end
        end
    end
    return Target
end

-- LOOP
RunService.RenderStepped:Connect(function()
    -- AIMBOT
    if Config.Aimbot and UserInputService:IsKeyDown(Config.AimbotKey) then
        local T = GetClosest()
        if T then
            local Cam = Workspace.CurrentCamera.CFrame
            Workspace.CurrentCamera.CFrame = Cam:Lerp(CFrame.new(Cam.Position, T.Position), Config.Smooth)
        end
    end
    
    -- SPEED
    if Config.Speed and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Hum then
            Hum.WalkSpeed = Config.WalkSpeed
            Hum.JumpPower = Config.JumpPower
        end
    end
end)

-- SILENT AIM (FIXED)
hookmetamethod(Mouse, "__index", function(t, k)
    if k == "Hit" and Config.SilentAim then
        local T = GetClosest()
        if T then return CFrame.new(T.Position) end
    end
    return rawget(t, k)
end)

-- ESP FUNCTION
local function MakeESP(v)
    if v == LocalPlayer or not v.Character then return end
    if v.Character:FindFirstChild("RanzESP") then return end
    
    local Box = Instance.new("BoxHandleAdornment")
    Box.Name = "RanzESP"
    Box.Size = Vector3.new(2,3,1)
    Box.Color3 = Config.ESP_Color
    Box.Transparency = 0.4
    Box.AlwaysOnTop = true
    Box.Parent = v.Character
end

-- LOOP ESP
spawn(function()
    while wait(1) do
        if Config.ESP then
            for _, v in pairs(Players:GetPlayers()) do
                MakeESP(v)
            end
        end
    end
end)

-- PLAYER ADDED EVENT
Players.PlayerAdded:Connect(function(Player)
    Player.CharacterAdded:Connect(function()
        wait(1)
        if Config.ESP then MakeESP(Player) end
    end)
end)

-- TAB COMBAT
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateToggle({
   Name = "Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      Config.Aimbot = Value
   end,
})

CombatTab:CreateKeyPicker({
   Name = "Aimbot Key",
   CurrentValue = Enum.KeyCode.E,
   Flag = "AimbotKey",
   Callback = function(Value)
      Config.AimbotKey = Value
   end,
})

CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Flag = "SilentAim",
   Callback = function(Value)
      Config.SilentAim = Value
   end,
})

-- TAB MOVEMENT
local MoveTab = Window:CreateTab("Movement", 4483362458)

MoveTab:CreateToggle({
   Name = "Speed Boost",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
      Config.Speed = Value
   end,
})

MoveTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 35,
   Flag = "SpeedVal",
   Callback = function(Value)
      Config.WalkSpeed = Value
   end,
})

-- TAB VISUAL
local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateToggle({
   Name = "ESP Box",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      Config.ESP = Value
   end,
})

Rayfield:Notify({
   Title = "RANZMODZ HUB",
   Content = "Script Loaded!",
   Duration = 5,
   Image = 4483362458
})
