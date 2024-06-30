local HorizonLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/babyfayy333/HorizonLibrary/main/Library.lua"))()
local Window = HorizonLibrary:CreateWindow({
    Name = "Jailbreak Script",
    Version = "1.2"
})
local ConsoleTab = Window:CreateConsoleTab({
    Name = "Console",
    Icon = "rbxassetid://14290789640",
    FirstWindow = true
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Jewelery Store",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Bank",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Museum",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Powerplant",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Casino",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Tomb",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Cargo Plane",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Cargo Ship",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Cargo Train",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Donut Shop",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Gas Station",
    RobberyStatus = "Robbery Status - "
})
ConsoleTab:CreateConsoleAlert({
    RobberyLocation = "Airdrop",
    RobberyStatus = "Robbery Status - "
})
local LocationsTab = Window:CreateLocationsTab({
    Name = "Locations",
    Icon = "rbxassetid://14290812747",
    FirstWindow = false
})
LocationsTab:CreateToggle({
    RobberyLocation = "Jewelery Store",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Bank",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Museum",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Powerplant",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Casino",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Tomb",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Cargo Plane",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Cargo Ship",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Cargo Train",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Donut Shop",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Gas Station",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
LocationsTab:CreateToggle({
    RobberyLocation = "Airdrop",
    Value = true,
    Callback = function(Value)
        print(Value)
    end
})
local MiscellaneousTab = Window:CreateMiscellaneousTab({
    Name = "Miscellaneous",
    Icon = "rbxassetid://14290820935",
    FirstWindow = false
})
MiscellaneousTab:CreateSection({
    Name = "Robbery Statuses"
})
MiscellaneousTab:CreateToggle({
    Name = "Notify Store Openings",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateToggle({
    Name = "Chat Store Openings",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateSection({
    Name = "Safes"
})
MiscellaneousTab:CreateSlider({
    Name = "Safe Rarity",
    Max = 5,
    Min = 1,
    Increment = 1,
    DecimalPrecision = 0,
    CurrentValue = 3,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateSlider({
    Name = "Buy Safe Amount",
    Max = 10,
    Min = 1,
    Increment = 1,
    DecimalPrecision = 0,
    CurrentValue = 8,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateButton({
    Name = "Buy Safes",
    Callback = function()
        print("button hehe")
    end
})
MiscellaneousTab:CreateButton({
    Name = "Open All Safes",
    Callback = function()
        print("button hehe")
    end
})
MiscellaneousTab:CreateSection({
    Name = "Character"
})
MiscellaneousTab:CreateToggle({
    Name = "Kill Aura",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateGunsDropdown({
    Name = "Kill Aura Gun",
    Callback = function(Option)
        print(Option)
    end
})
MiscellaneousTab:CreateSection({
    Name = "Vehicle"
})
MiscellaneousTab:CreateToggle({
    Name = "Auto Lock Vehicle",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateToggle({
    Name = "Auto Kick Passengers",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateToggle({
    Name = "Loop Tire Pop",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateSection({
    Name = "Game"
})
MiscellaneousTab:CreateToggle({
    Name = "Render Game",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
MiscellaneousTab:CreateButton({
    Name = "Remove Textures",
    Callback = function()
        print("button hehe")
    end
})
local SettingsTab = Window:CreateSettingsTab({
    Name = "Settings",
    Icon = "rbxassetid://14290827572",
    FirstWindow = false
})
SettingsTab:CreateSection({
    Name = "Teleportation"
})
SettingsTab:CreateToggle({
    Name = "Instant Teleport",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSlider({
    Name = "TP Walkspeed",
    Max = 110,
    Min = 50,
    Increment = 5,
    DecimalPrecision = 0,
    CurrentValue = 70,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSlider({
    Name = "TP Sky Speed",
    Max = 130,
    Min = 60,
    Increment = 5,
    DecimalPrecision = 0,
    CurrentValue = 80,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSection({
    Name = "Robbery"
})
SettingsTab:CreateSlider({
    Name = "Robbery Cooldown",
    Max = 100,
    Min = 10,
    Increment = 5,
    DecimalPrecision = 0,
    CurrentValue = 50,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSlider({
    Name = "Cop Bank Range",
    Max = 150,
    Min = 30,
    Increment = 5,
    DecimalPrecision = 0,
    CurrentValue = 50,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateToggle({
    Name = "Auto Open Museum",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateToggle({
    Name = "Auto Call Cargo Plane",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateToggle({
    Name = "Auto Lure Players",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateToggle({
    Name = "Longer Sell Cooldowns",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSection({
    Name = "Webhooks"
})
SettingsTab:CreateInput({
    Name = "Webhook URL",
    PlaceholderText = "Paste URL",
    Callback = function(Text)
        print(Text)
    end
})
SettingsTab:CreateButton({
    Name = "Test Webhook",
    Callback = function()
        print("button hehe")
    end
})
SettingsTab:CreateSlider({
    Name = "Update Delay",
    Max = 10,
    Min = 1,
    Increment = 1,
    DecimalPrecision = 0,
    CurrentValue = 5,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateSection({
    Name = "Game"
})
SettingsTab:CreateSlider({
    Name = "Set FPS Cap",
    Max = 360,
    Min = 20,
    Increment = 5,
    DecimalPrecision = 0,
    CurrentValue = 60,
    Callback = function(Value)
        print(Value)
    end
})
SettingsTab:CreateToggle({
    Name = "Set Rendering",
    Value = false,
    Callback = function(Value)
        print(Value)
    end
})
local UserTab = Window:CreateUserTab({
    Name = "User",
    Icon = "rbxassetid://14290844857",
    FirstWindow = false
})
UserTab:SetExecutionText({
    Text = "9999"
})
UserTab:SetMoneyText({
    Text = "9999"
})
UserTab:SetTimeText({
    Text = "99:99"
})

UserTab:CreateCredit({
    Text = "im a credit"
})
