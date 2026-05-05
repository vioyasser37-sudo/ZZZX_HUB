-- [[ SUXANOX EXCLUSIVE: BAIT A FISH AUTO-FARM ]]
-- AUTHOR: SUXANOX
-- TARGET USER: ZEE (KUZE)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "KUZE HUB | Bait a Fish 🎣",
   LoadingTitle = "SUXANOX OVERRIDE v4.0",
   LoadingSubtitle = "by Suxanox for Zee",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KuzeHubConfig",
      FileName = "BaitAFish"
   }
})

-- VARIABLES
_G.AutoPull = false
_G.AutoRebirth = false

-- MAIN TAB
local MainTab = Window:CreateTab("Main Farm", 4483362458) -- Icon ID
local Section = MainTab:CreateSection("Auto Features")

local PullToggle = MainTab:CreateToggle({
   Name = "Auto Pull (Kenceng)",
   CurrentValue = false,
   Flag = "TogglePull",
   Callback = function(Value)
      _G.AutoPull = Value
      if Value then
         task.spawn(function()
            while _G.AutoPull do
               -- Script bakal trigger remote click game
               game:GetService("ReplicatedStorage").Remotes.Click:FireServer()
               task.wait(0.001) -- Delay minimal biar gak ke-kick tapi tetep OP
            end
         end)
      end
   end,
})

local RebirthToggle = MainTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "ToggleRebirth",
   Callback = function(Value)
      _G.AutoRebirth = Value
      if Value then
         task.spawn(function()
            while _G.AutoRebirth do
               game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
               task.wait(1)
            end
         end)
      end
   end,
})

-- PLAYER TAB
local PlayerTab = Window:CreateTab("Player Mods", 4483362458)
local PSection = PlayerTab:CreateSection("Movement")

local SpeedSlider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WS",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local JumpSlider = PlayerTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 500},
   Increment = 1,
   Suffix = "Power",
   CurrentValue = 50,
   Flag = "JP",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

Rayfield:Notify({
   Title = "SCRIPT LOADED",
   Content = "Selamat ngerusak server, Zee!",
   Duration = 5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Siap, Suxanox!",
         Callback = function()
            print("Zee is ready.")
         end
      },
   },
})
