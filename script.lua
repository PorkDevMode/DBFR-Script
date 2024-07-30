local initialized = true -- To stop all operations to prevent leaks when killing the script.


--#region FinalStandRemastered

-- Variables section

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local kiAmount = 400
local stamAmount = 100
local zeniAmount = 20000

local entityAuraEnabled = false
local dragonballfarm = true

-- Gui variables.
getgenv().SecureMode = true
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/PorkDevMode/trump-client/main/Ui.luau'))()

-- Service variables.
local RS = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- Antiban initialized on start

local BanRemote = ReplicatedStorage:FindFirstChild("BanRemote")

local originalFireServer

originalFireServer = hookmetamethod(game, "__namecall", function(self, ...)
local method = getnamecallmethod()
if self == BanRemote and method == "FireServer" then
    return
end
return originalFireServer(self, ...)
end)
print("Antiban Activated")
-- Remotes

local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
local damageRemote = Remotes:FindFirstChild("Damage4")

-- Arrays / Dictonarys

local KiSkills = {}

local path1 = ReplicatedStorage:FindFirstChild("CharacterStuff"):FindFirstChild("PlayerGui"):FindFirstChild("PlaceHolder"):FindFirstChild("SkillFrame"):FindFirstChild("Ki")
local path2 = ReplicatedStorage:FindFirstChild("CharacterStuff"):FindFirstChild("PlayerGui"):FindFirstChild("PlaceHolder"):FindFirstChild("SkillFrame"):FindFirstChild("Physical")

for i, v in pairs(path1:GetChildren()) do
    if #v:GetChildren() > 0 then
        local skillname = v:FindFirstChild("SkillName")
        if skillname then
            table.insert(KiSkills, skillname.Value)
        end
    end
end

for i, v in pairs(path2:GetChildren()) do
    if #v:GetChildren() > 0 then
        local skillname = v:FindFirstChild("SkillName")
        if skillname then
            table.insert(KiSkills, skillname.Value)
        end
    end
end

-- z : 3, g : 4, h : 2, v : 1.

local saiyanForms = {
    "Ultra Ego",
    "Ultra Instinct",
    "Mastered Ultra Instinct",
    "False Super Saiyan",
    "Super Saiyan",
    "Super Saiyan 2",
    "Super Saiyan 3",
    "Mystic",
    "Super Saiyan 4",
    "Super Saiyan Rage",
    "Super Saiyan Blue",
    "Super Saiyan Blue Evolution",
    "Super Saiyan Rose",
    "Super Saiyan Rose Evolution",
    "Legendary Super Saiyan",
    "Beast Form",
    "Super Saiyan 5",
    "Savior From Heaven",
    "Super Villainous Mode"
}

-- Functions

local function getFreaky()
    local args = {
        [1] = "EquipClothing",
        [2] = "http://www.roblox.com/asset/?id=10590477450",
        [3] = "http://www.roblox.com/asset/?id=10590477450"
    }
    
    game:GetService("ReplicatedStorage"):FindFirstChild("Remotes"):FindFirstChild("OutfitChange"):FireServer(unpack(args))
end

local function changeKi(value)
    local char = LocalPlayer.Character

    if char and char:FindFirstChild("Humanoid") then
        if char:FindFirstChild("Humanoid").Health > 0 then
            local data = LocalPlayer:FindFirstChild("Data")

            if data then
                local ki = data:FindFirstChild("Ki")

                if ki and ki.Value ~= kiAmount then
                    ki.Value = value
                end
            end
        end
    end
end

local function changeStamina(value)
    local char = LocalPlayer.Character

    if char and char:FindFirstChild("Humanoid") then
        if char:FindFirstChild("Humanoid").Health > 0 then
            local data = LocalPlayer:FindFirstChild("Data")

            if data then
                local stamina = data:FindFirstChild("Stamina")

                if stamina and stamina.Value ~= stamAmount then
                    stamina.Value = value
                end
            end
        end
    end
end

--[[
local function entityAura()
    local Entitys = workspace:FindFirstChild("Entities")

    if Entitys and LocalPlayer.Character and LocalPlayer.Character.Humanoid.Health > 0 then
        for i, v in pairs(Entitys:GetChildren()) do
            local HRP = v:FindFirstChild("HumanoidRootPart")
            local Hum = v:FindFirstChild("Humanoid")
            local playerCheck = v:FindFirstChild("DB Effect")

            if HRP and Hum and Hum.Health > 0 and not playerCheck then
                local HRPCframe = HRP.Position
                local LocalPlayerCFrame = LocalPlayer.Character.HumanoidRootPart.Position

                local punchingDistance = 15
                local tolerance = 0.5
                local lowerBound = punchingDistance - tolerance
                local upperBound = punchingDistance + tolerance
                local mag = (HRPCframe - LocalPlayerCFrame).Magnitude

                if mag >= lowerBound and mag <= upperBound then
                    local argsgold = {
                        [1] = v,
                        [2] = {
                            ["HitTime"] = 0.5,
                            ["Type"] = "Normal",
                            ["HitEffect"] = game:GetService("ReplicatedStorage"):FindFirstChild("Resources"):FindFirstChild("OtherEffects"):FindFirstChild("NormaIHitEffect2"),
                            ["Velocity"] = Vector3.new(-1.4373252391815186, -3.023573160171509, -3.7137718200683594),
                            ["HurtAnimation"] = game:GetService("ReplicatedStorage"):FindFirstChild("Resources"):FindFirstChild("Animations"):FindFirstChild("HurtAnimations"):FindFirstChild("Hurt1"),
                            ["VictimCFrame"] = CFrame.new(-245.4299774169922, 235.987060546875, -614.739013671875, -0.942154049873352, -0.17236487567424774, -0.2874651253223419, 0.03897470235824585, 0.7954879999160767, -0.6047146320343018, 0.3329066038131714, -0.5809382200241089, -0.742754340171814),
                            ["Sound"] = game:GetService("ReplicatedStorage"):FindFirstChild("Resources"):FindFirstChild("Sounds"):FindFirstChild("Combat"):FindFirstChild("NormalPunching"),
                            ["Damage"] = 1
                        }
                    }

                    damageRemote:InvokeServer(unpack(argsgold))

                    print("Hit")
                end
            end
        end
    end
end
]]
local function changeZeni(value)
    local char = LocalPlayer.Character

    if char and char:FindFirstChild("Humanoid") then
        if char:FindFirstChild("Humanoid").Health > 0 then
            local data = LocalPlayer:FindFirstChild("Data")

            if data then
                local zeni = data:FindFirstChild("Moneys")

                if zeni and zeni.Value ~= zeniAmount then
                    zeni.Value = value
                end
            end
        end
    end
end

local function getDragonBall()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidrootpart = character:FindFirstChild("HumanoidRootPart")

    if character and humanoid and humanoidrootpart and humanoid.Health > 0 then
        local dbfolder = workspace:FindFirstChild("DragonBallLocatioionsa")

        if dbfolder then
            local dbnum = dbfolder:GetChildren()

            if #dbnum > 0 then
                for i, v in pairs(dbnum) do
                    local location = v.Model.MeshPart
                    humanoidrootpart.Position = location.Position
                    fireproximityprompt(v.ProximityPrompt, 1)
                end
            end
        end
    end
end

local function infGtc()
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("TimeCheck")
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        
        if self == remote and method == "InvokeServer" then
            return 0
        end
        
        return oldNamecall(self, ...)
    end)
end

local function htcAutoFarm()
    local minigameFolder = ReplicatedStorage:FindFirstChild("Minigame")
    local hitRemote = minigameFolder:FindFirstChild("Hit")

    local oldNamecall = nil

    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local nameCallMethod = getnamecallmethod()

        if not checkcaller() and self == hitRemote and nameCallMethod == "FireServer" then
            args[1] = true
            return oldNamecall(self, unpack(args))
        end

        return oldNamecall(self, ...)
    end)

    LocalPlayer.Character.Humanoid.MaxHealth = 99999999999999999999999999999999
    LocalPlayer.Character.Humanoid.Health = 99999999999999999999999999999999
end

local function getSkill(skill, slot)
    if LocalPlayer.Character then
        if LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
            local args = {
                [1] = {
                    [1] = skill,
                    [2] = slot
                }
            }
            Remotes:FindFirstChild("KeyAttack"):FireServer(unpack(args))
        end
    end
end

local function teleportPlace(placeId)
    local player = Players.LocalPlayer

    if player then
        TeleportService:Teleport(placeId, player)
    end
end

local function getForm(form, slot)
    if LocalPlayer.Character then
        if LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("Humanoid").Health > 0 then
            Remotes.SaveFormWheel:FireServer(form, slot)
            print("Firing")
        end
    end
end

local function executeIY()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
end

local function executeDEX() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
end

local function mainLoop()
    if initialized then
        changeZeni(zeniAmount)
        changeStamina(stamAmount)
        changeKi(kiAmount)

        if dragonballfarm then
            getDragonBall()
        end
    end
end



connection = RS.Heartbeat:Connect(mainLoop)

print("Functions Loaded")

-- Gui initialization / Values.

-- The main window.
local mainWindow = Rayfield:CreateWindow({
    Name = "Trump Hub",
    LoadingTitle = "Making exploiting great again.",
    LoadingSubtitle = "By porkcheatdev on v3rm",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "Trump", 
       FileName = "Trump-Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "Xg9E3Kzn", 
       RememberJoins = true 
    }
 })

 print("main window created")

-- The tabs.
local localPlayerTab = mainWindow:CreateTab("Local Player Option's", nil)
--local enemyPlayersTab = mainWindow:CreateTab("Enemy Option's", nil)
local formsTab = mainWindow:CreateTab("Unlock Forms", nil)
local skillsTab = mainWindow:CreateTab("Unlock Skills", nil)
local farmTab = mainWindow:CreateTab("Autofarm", nil)
local gtcTab = mainWindow:CreateTab("Gravity Time Chamber", nil)
local htcTab = mainWindow:CreateTab("Hyperbolic Time Chamber", nil)
local utilTab = mainWindow:CreateTab("Utility Tab", nil)

-- Autofarm stuff

farmTab:CreateToggle({
    Name = "Dragon ball farm",
    CurrentValue = dragonballfarm,
    Flag = "DbFarm",

    Callback = function(value)
        dragonballfarm = value
    end
})

-- LocalPlayer stuff

localPlayerTab:CreateButton({
    Name = "Get Freaky",
    Callback = function()
        getFreaky()
    end
})



localPlayerTab:CreateButton({
    Name = "Disable Hub",
    Callback = function()
        initialized = false
        Rayfield:Destroy()
    end
})

localPlayerTab:CreateSlider({
    Name = "Ki",
    Range = {0, 20000},
    Increment = 1,
    CurrentValue = 400,
    Flag = "KiValue",
    Callback = function(v)
        kiAmount = v
    end
})

localPlayerTab:CreateSlider({
    Name = "Stamina",
    Range = {0, 20000},
    Increment = 1,
    CurrentValue = 100,
    Flag = "StaValue",
    Callback = function(v)
        stamAmount = v
    end
})

localPlayerTab:CreateSlider({
    Name = "Zeni",
    Range = {1000, 1000000},
    Increment = 1000,
    CurrentValue = 10000,
    Flag = "ZeniValue",
    Callback = function(v)
        zeniAmount = v
    end
})

-- Form stuff

formsTab:CreateDropdown({
    Name = "Form Slot 1",
    Options = saiyanForms,
    CurrentOption = saiyanForms[1],
    MultipleOptions = false,
    Flag = "Form1",
    Callback = function(Option)
        getForm("Form1", Option[1])
    end
})

formsTab:CreateDropdown({
    Name = "Form Slot 2",
    Options = saiyanForms,
    CurrentOption = saiyanForms[2],
    MultipleOptions = false,
    Flag = "Form2",
    Callback = function(Option)
        getForm("Form2", Option[1])
    end
})

formsTab:CreateDropdown({
    Name = "Form Slot 3",
    Options = saiyanForms,
    CurrentOption = saiyanForms[3],
    MultipleOptions = false,
    Flag = "Form3",
    Callback = function(Option)
        getForm("Form3", Option[1])
    end
})

formsTab:CreateDropdown({
    Name = "Form Slot 4",
    Options = saiyanForms,
    CurrentOption = saiyanForms[4],
    MultipleOptions = false,
    Flag = "Form4",
    Callback = function(Option)
        getForm("Form4", Option[1])
    end
})

formsTab:CreateButton({
    Name = "Jiren Unbound, Works at any power level.",

    Callback = function()
        Remotes.Transform:FireServer("Unbound\xE5\xAB\x8C")
    end
})

-- Skill Stuff

skillsTab:CreateDropdown({
    Name = "Skill Z",
    Options = KiSkills,
    CurrentOption = KiSkills[1],
    MultipleOptions = false,
    Flag = "Skill1",
    Callback = function(Option)
        getSkill(Option[1], 3)
        print(Option[1] .. " " .. 3)
    end
})

skillsTab:CreateDropdown({
    Name = "Skill G",
    Options = KiSkills,
    CurrentOption = KiSkills[2],
    MultipleOptions = false,
    Flag = "Skill2",
    Callback = function(Option)
        getSkill(Option[1], 4)
    end
})

skillsTab:CreateDropdown({
    Name = "Skill H",
    Options = KiSkills,
    CurrentOption = KiSkills[3],
    MultipleOptions = false,
    Flag = "Skill3",
    Callback = function(Option)
        getSkill(Option[1], 2)
    end
})

skillsTab:CreateDropdown({
    Name = "Skill V",
    Options = KiSkills,
    CurrentOption = KiSkills[4],
    MultipleOptions = false,
    Flag = "Skill4",
    Callback = function(Option)
        getSkill(Option[1], 1)
    end
})

-- Gravity Chamber Stuff

gtcTab:CreateButton({
    Name = "No Gtc Cooldown",
    Callback = function()
        infGtc()
    end
})

-- Htc stuff

htcTab:CreateButton({
    Name = "Teleport To HTC",

    Callback = function()
        teleportPlace(4178935231)
    end
})

htcTab:CreateButton({
    Name = "Infinite Time",
    Callback = function()
        game:GetService("Workspace").Timer.Hours.Value = 69696969696969
    end
})

htcTab:CreateButton({
    Name = "Auto Farm (just click it and let it do the work)",

    Callback = function()
        htcAutoFarm()
    end
})

-- Utility stuff (IY, DEX ect)

utilTab:CreateButton({
    Name = "Dark Dex",

    Callback = function()
        executeDEX()
    end
})

utilTab:CreateButton({
    Name = "Infinite Yield",

    Callback = function()
        executeIY()
    end
})


Rayfield:LoadConfiguration()

print("Gui loaded")
--#endregion
