local Library =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/YaBoiBrody/roberthookdeluxe/refs/heads/main/newlib.lua"))()

local MenuVersion = "2.0"

local function cloneTheme(theme)
	local copy = {}
	for key, value in pairs(theme) do
		copy[key] = value
	end
	return copy
end

local baseAqua = Library.Themes and Library.Themes["Aqua"] and cloneTheme(Library.Themes["Aqua"])

Library.Themes = {
	["Aqua"] = baseAqua or {
		["Window Background"] = Color3.fromRGB(71, 84, 99),
		["Inline"] = Color3.fromRGB(31, 35, 39),
		["Text"] = Color3.fromRGB(255, 255, 255),
		["Section Background"] = Color3.fromRGB(22, 25, 28),
		["Element"] = Color3.fromRGB(58, 66, 77),
		["Border"] = Color3.fromRGB(48, 56, 63),
		["Outline"] = Color3.fromRGB(20, 25, 30),
		["Dark Liner"] = Color3.fromRGB(38, 45, 53),
		["Risky"] = Color3.fromRGB(255, 50, 50),
		["Accent"] = Color3.fromRGB(104, 214, 255),
	},
	["Mint"] = {
		["Window Background"] = Color3.fromRGB(40, 68, 58),
		["Inline"] = Color3.fromRGB(24, 44, 36),
		["Text"] = Color3.fromRGB(220, 248, 236),
		["Section Background"] = Color3.fromRGB(30, 54, 44),
		["Element"] = Color3.fromRGB(52, 88, 72),
		["Border"] = Color3.fromRGB(64, 94, 80),
		["Outline"] = Color3.fromRGB(18, 28, 24),
		["Dark Liner"] = Color3.fromRGB(44, 70, 58),
		["Risky"] = Color3.fromRGB(255, 120, 120),
		["Accent"] = Color3.fromRGB(132, 228, 176),
	},
	["Nebula"] = {
		["Window Background"] = Color3.fromRGB(30, 24, 42),
		["Inline"] = Color3.fromRGB(18, 12, 30),
		["Text"] = Color3.fromRGB(220, 205, 255),
		["Section Background"] = Color3.fromRGB(24, 18, 34),
		["Element"] = Color3.fromRGB(52, 40, 76),
		["Border"] = Color3.fromRGB(68, 50, 96),
		["Outline"] = Color3.fromRGB(12, 8, 20),
		["Dark Liner"] = Color3.fromRGB(44, 32, 64),
		["Risky"] = Color3.fromRGB(255, 88, 120),
		["Accent"] = Color3.fromRGB(158, 95, 255),
	},
	["Sunset"] = {
		["Window Background"] = Color3.fromRGB(58, 36, 28),
		["Inline"] = Color3.fromRGB(32, 20, 16),
		["Text"] = Color3.fromRGB(255, 232, 210),
		["Section Background"] = Color3.fromRGB(40, 24, 18),
		["Element"] = Color3.fromRGB(76, 44, 34),
		["Border"] = Color3.fromRGB(90, 54, 42),
		["Outline"] = Color3.fromRGB(24, 14, 12),
		["Dark Liner"] = Color3.fromRGB(60, 36, 28),
		["Risky"] = Color3.fromRGB(255, 112, 80),
		["Accent"] = Color3.fromRGB(255, 170, 92),
	},
	["Glacier"] = {
		["Window Background"] = Color3.fromRGB(48, 64, 78),
		["Inline"] = Color3.fromRGB(28, 44, 56),
		["Text"] = Color3.fromRGB(228, 245, 255),
		["Section Background"] = Color3.fromRGB(32, 48, 60),
		["Element"] = Color3.fromRGB(58, 84, 100),
		["Border"] = Color3.fromRGB(68, 96, 112),
		["Outline"] = Color3.fromRGB(20, 28, 36),
		["Dark Liner"] = Color3.fromRGB(44, 64, 78),
		["Risky"] = Color3.fromRGB(214, 85, 85),
		["Accent"] = Color3.fromRGB(146, 212, 255),
	},
	["Voltage"] = {
		["Window Background"] = Color3.fromRGB(28, 30, 36),
		["Inline"] = Color3.fromRGB(14, 16, 24),
		["Text"] = Color3.fromRGB(230, 240, 255),
		["Section Background"] = Color3.fromRGB(20, 22, 28),
		["Element"] = Color3.fromRGB(42, 44, 56),
		["Border"] = Color3.fromRGB(52, 54, 68),
		["Outline"] = Color3.fromRGB(12, 12, 18),
		["Dark Liner"] = Color3.fromRGB(34, 36, 46),
		["Risky"] = Color3.fromRGB(255, 108, 150),
		["Accent"] = Color3.fromRGB(0, 220, 160),
	},
	["Meadow"] = {
		["Window Background"] = Color3.fromRGB(44, 58, 46),
		["Inline"] = Color3.fromRGB(24, 34, 28),
		["Text"] = Color3.fromRGB(222, 240, 220),
		["Section Background"] = Color3.fromRGB(30, 42, 34),
		["Element"] = Color3.fromRGB(56, 78, 60),
		["Border"] = Color3.fromRGB(64, 88, 68),
		["Outline"] = Color3.fromRGB(18, 25, 20),
		["Dark Liner"] = Color3.fromRGB(46, 64, 50),
		["Risky"] = Color3.fromRGB(240, 98, 87),
		["Accent"] = Color3.fromRGB(132, 214, 156),
	},
	["Crimson"] = {
		["Window Background"] = Color3.fromRGB(60, 24, 28),
		["Inline"] = Color3.fromRGB(32, 12, 16),
		["Text"] = Color3.fromRGB(255, 228, 228),
		["Section Background"] = Color3.fromRGB(40, 16, 20),
		["Element"] = Color3.fromRGB(92, 32, 38),
		["Border"] = Color3.fromRGB(110, 42, 48),
		["Outline"] = Color3.fromRGB(20, 8, 10),
		["Dark Liner"] = Color3.fromRGB(72, 26, 32),
		["Risky"] = Color3.fromRGB(255, 102, 118),
		["Accent"] = Color3.fromRGB(214, 64, 78),
	},
	["Aurora"] = {
		["Window Background"] = Color3.fromRGB(30, 36, 54),
		["Inline"] = Color3.fromRGB(18, 22, 38),
		["Text"] = Color3.fromRGB(220, 244, 255),
		["Section Background"] = Color3.fromRGB(24, 28, 42),
		["Element"] = Color3.fromRGB(52, 64, 92),
		["Border"] = Color3.fromRGB(66, 80, 108),
		["Outline"] = Color3.fromRGB(14, 18, 28),
		["Dark Liner"] = Color3.fromRGB(42, 54, 74),
		["Risky"] = Color3.fromRGB(255, 108, 164),
		["Accent"] = Color3.fromRGB(108, 232, 190),
	},
	["Obsidian"] = {
		["Window Background"] = Color3.fromRGB(24, 26, 32),
		["Inline"] = Color3.fromRGB(14, 16, 22),
		["Text"] = Color3.fromRGB(210, 216, 222),
		["Section Background"] = Color3.fromRGB(18, 20, 28),
		["Element"] = Color3.fromRGB(44, 46, 54),
		["Border"] = Color3.fromRGB(58, 60, 70),
		["Outline"] = Color3.fromRGB(12, 12, 18),
		["Dark Liner"] = Color3.fromRGB(34, 36, 42),
		["Risky"] = Color3.fromRGB(255, 96, 96),
		["Accent"] = Color3.fromRGB(132, 168, 255),
	},
	["Nocturne"] = {
		["Window Background"] = Color3.fromRGB(22, 24, 32),
		["Inline"] = Color3.fromRGB(13, 16, 24),
		["Text"] = Color3.fromRGB(214, 218, 255),
		["Section Background"] = Color3.fromRGB(18, 20, 28),
		["Element"] = Color3.fromRGB(36, 40, 56),
		["Border"] = Color3.fromRGB(48, 52, 68),
		["Outline"] = Color3.fromRGB(12, 12, 18),
		["Dark Liner"] = Color3.fromRGB(32, 34, 46),
		["Risky"] = Color3.fromRGB(255, 108, 140),
		["Accent"] = Color3.fromRGB(96, 150, 255),
	},
}

Library.Theme = cloneTheme(Library.Themes["Aqua"])

local ThemeGradientMap = {
	Aqua = {
		Start = Color3.fromRGB(104, 214, 255),
		Middle = Color3.fromRGB(163, 151, 255),
		End = Color3.fromRGB(159, 115, 255),
	},
	Mint = {
		Start = Color3.fromRGB(132, 228, 176),
		Middle = Color3.fromRGB(104, 212, 160),
		End = Color3.fromRGB(92, 188, 148),
	},
	Nebula = {
		Start = Color3.fromRGB(158, 95, 255),
		Middle = Color3.fromRGB(201, 126, 255),
		End = Color3.fromRGB(118, 74, 210),
	},
	Sunset = {
		Start = Color3.fromRGB(255, 170, 92),
		Middle = Color3.fromRGB(255, 112, 80),
		End = Color3.fromRGB(214, 76, 60),
	},
	Glacier = {
		Start = Color3.fromRGB(146, 212, 255),
		Middle = Color3.fromRGB(110, 180, 230),
		End = Color3.fromRGB(84, 150, 204),
	},
	Voltage = {
		Start = Color3.fromRGB(0, 220, 160),
		Middle = Color3.fromRGB(90, 200, 255),
		End = Color3.fromRGB(150, 120, 255),
	},
	Meadow = {
		Start = Color3.fromRGB(132, 214, 156),
		Middle = Color3.fromRGB(102, 186, 128),
		End = Color3.fromRGB(84, 162, 110),
	},
	Crimson = {
		Start = Color3.fromRGB(214, 64, 78),
		Middle = Color3.fromRGB(255, 102, 118),
		End = Color3.fromRGB(255, 132, 132),
	},
	Aurora = {
		Start = Color3.fromRGB(108, 232, 190),
		Middle = Color3.fromRGB(138, 206, 255),
		End = Color3.fromRGB(90, 180, 255),
	},
	Obsidian = {
		Start = Color3.fromRGB(132, 168, 255),
		Middle = Color3.fromRGB(110, 140, 230),
		End = Color3.fromRGB(84, 116, 200),
	},
	Nocturne = {
		Start = Color3.fromRGB(96, 150, 255),
		Middle = Color3.fromRGB(118, 96, 255),
		End = Color3.fromRGB(72, 80, 210),
	},
}

local function normalizeThemeName(flagValue)
	if typeof(flagValue) == "string" and ThemeGradientMap[flagValue] then
		return flagValue
	elseif typeof(flagValue) == "table" then
		if flagValue.Value and ThemeGradientMap[flagValue.Value] then
			return flagValue.Value
		end
		if flagValue.Name and ThemeGradientMap[flagValue.Name] then
			return flagValue.Name
		end
	end
	return nil
end

local function getGradientForTheme(theme)
	return ThemeGradientMap[theme] or ThemeGradientMap.Aqua
end

local CurrentThemeName = "Aqua"
local Window

local function applyTitleGradient(themeName)
	local resolved = normalizeThemeName(themeName) or CurrentThemeName
	CurrentThemeName = resolved
	local gradientInfo = getGradientForTheme(resolved)

	if Window and Window.GradientTitle then
		Window.GradientTitle.Start = gradientInfo.Start
		Window.GradientTitle.Middle = gradientInfo.Middle
		Window.GradientTitle.End = gradientInfo.End
	end

	if Window and Window.Items then
		local titleFrame = Window.Items["Title"]
		local textLabel

		if titleFrame then
			local inst = titleFrame.Instance or titleFrame
			if typeof(inst) == "Instance" then
				textLabel = inst:FindFirstChildWhichIsA("TextLabel")
			end
		end

		if not textLabel then
			local textItem = Window.Items["Text"]
			if textItem then
				local inst = textItem.Instance or textItem
				if typeof(inst) == "Instance" and inst:IsA("TextLabel") then
					textLabel = inst
				end
			end
		end

		if not textLabel then
			for _, entry in pairs(Window.Items) do
				local inst = entry.Instance or entry
				if typeof(inst) == "Instance" and inst:IsA("TextLabel") and inst.Text == Window.Name then
					textLabel = inst
					break
				end
			end
		end

		if textLabel then
			local gradient = textLabel:FindFirstChildWhichIsA("UIGradient")
			if not gradient then
				gradient = Instance.new("UIGradient")
				gradient.Parent = textLabel
				gradient.Rotation = 0
			end
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, gradientInfo.Start),
				ColorSequenceKeypoint.new(0.5, gradientInfo.Middle),
				ColorSequenceKeypoint.new(1, gradientInfo.End),
			})
		end
	end
end


Library.MenuKeybind = tostring(Enum.KeyCode.LeftAlt)

local initialGradient = getGradientForTheme(CurrentThemeName)
Window = Library:Window({
	Name = "roberthook",
	GradientTitle = {
		Enabled = true,
		Start = initialGradient.Start,
		Middle = initialGradient.Middle,
		End = initialGradient.End,
		Speed = 1,
	},
})

applyTitleGradient(CurrentThemeName)

local function getWatermarkText(fps, ping)
	return string.format("roberthook - %d fps - %d ms - private", fps, ping)
end

local initialWatermarkText = getWatermarkText(0, 0)
local previousThemeItemCount = #Library.ThemeItems
local Watermark = Library:Watermark(initialWatermarkText, { "137309004700555", Color3.fromRGB(163, 151, 255) })
local KeybindList = Library:KeybindList()

local watermarkLabel

for index = previousThemeItemCount + 1, #Library.ThemeItems do
	local item = Library.ThemeItems[index]
	if item and item.Item and item.Item:IsA("TextLabel") and item.Item.Text == initialWatermarkText then
		watermarkLabel = item.Item
		break
	end
end

local function setWatermarkText(text)
	if watermarkLabel and watermarkLabel.Parent then
		watermarkLabel.Text = text
		return
	end

	local holder = Library.Holder and Library.Holder.Instance
	if not holder then
		return
	end

	for _, descendant in ipairs(holder:GetDescendants()) do
		if descendant:IsA("TextLabel") and descendant.Text:find("roberthook") then
			watermarkLabel = descendant
			watermarkLabel.Text = text
			break
		end
	end
end

setWatermarkText(initialWatermarkText)

Watermark:SetVisibility(true)
KeybindList:SetVisibility(true)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Stats = game:GetService("Stats")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

local STAFF_GROUP_ID = 5783673
local STAFF_ROLES = {
	Beloved = true,
	Staff = true,
	Developer = true,
	["Main Developer"] = true,
}

local notifiedStaffPlayers = {}

local function checkAndNotifyStaff(player)
	if not player or notifiedStaffPlayers[player] then
		return
	end

	local ok, role = pcall(player.GetRoleInGroup, player, STAFF_GROUP_ID)
	if not ok or not role or role == "" then
		return
	end

	if STAFF_ROLES[role] then
		notifiedStaffPlayers[player] = role
		Library:Notification(
			string.format("WARNING Potential staff has joined the game: %s (%s)", player.Name, role),
			5,
			Color3.fromRGB(255, 0, 0)
		)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(checkAndNotifyStaff, player)
end

Players.PlayerAdded:Connect(function(player)
	checkAndNotifyStaff(player)
end)

Players.PlayerRemoving:Connect(function(player)
	notifiedStaffPlayers[player] = nil
end)

task.spawn(function()
	while true do
		task.wait(10)
		for _, player in ipairs(Players:GetPlayers()) do
			task.spawn(checkAndNotifyStaff, player)
		end
	end
end)

local DesyncState = getgenv().__roberthook_desyncState
if not DesyncState then
	DesyncState = { Enabled = false }
	getgenv().__roberthook_desyncState = DesyncState
end

local function isUpdateCFrameRemote(obj)
	if typeof(obj) ~= "Instance" or obj.Name ~= "UpdateCFrame" then
		return false
	end
	local parent = obj.Parent
	if not parent or parent.Name ~= "CharacterReplicator" then
		return false
	end
	parent = parent.Parent
	if not parent or parent.Name ~= "Remotes" then
		return false
	end
	return parent.Parent == ReplicatedStorage
end

if not getgenv().__roberthook_namecallhook then
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
		if DesyncState.Enabled and typeof(self) == "Instance" then
			local method = getnamecallmethod()
			if (method == "FireServer" or method == "InvokeServer") and isUpdateCFrameRemote(self) then
				if hasBomb(LocalPlayer) then
					return oldNamecall(self, ...)
				end
				return
			end
		end
		return oldNamecall(self, ...)
	end)
	getgenv().__roberthook_oldNamecall = oldNamecall
	getgenv().__roberthook_namecallhook = true
end

local CustomExplosionEnabled = false
local ExplosionOptions = {
	["Demoman Kaboom"] = "rbxassetid://17698665337",
	["Cod Zombies"] = "rbxassetid://130219836212781",
	["allah akbar"] = "rbxassetid://128063484534323",
	["Spongebob Laugh"] = "rbxassetid://8904888220",
	["boowomp"] = "rbxassetid://18871561370",
	["Im Spongebob!"] = "rbxassetid://102599899751746",
	["bobby foggy"] = "rbxassetid://106974578385523",
	["bob laugh"] = "rbxassetid://111605929167392",
}
local ExplosionOptionNames = {
	"Demoman Kaboom",
	"Cod Zombies",
	"allah akbar",
	"Spongebob Laugh",
	"boowomp",
	"Im Spongebob!",
	"bobby foggy",
	"bob laugh",
}
local SelectedExplosionId = ExplosionOptions[ExplosionOptionNames[1]]
local DEFAULT_CACHE_SOUND_ID = "rbxassetid://13109132253"

local function cloneArray(list)
	local copy = {}
	if list then
		for index, value in ipairs(list) do
			copy[index] = value
		end
	end
	return copy
end

local function collectSoundDataModules()
	local result = {}
	local seen = {}

	local function consider(instance)
		if instance and instance:IsA("ModuleScript") and instance.Name == "SoundData" and not seen[instance] then
			seen[instance] = true
			result[#result + 1] = instance
		end
	end

	local ok, modules = pcall(getloadedmodules)
	if ok and typeof(modules) == "table" then
		for _, module in ipairs(modules) do
			consider(module)
		end
	end

	local replicatedStorage = game:GetService("ReplicatedStorage")
	if replicatedStorage then
		consider(replicatedStorage:FindFirstChild("SoundData"))
		local assets = replicatedStorage:FindFirstChild("Assets")
		if assets then
			consider(assets:FindFirstChild("SoundData"))
		end
	end

	return result
end

local OriginalExplosionLists = {}

local function patchSoundData(newId)
	for _, module in ipairs(collectSoundDataModules()) do
		local ok, data = pcall(require, module)
		if ok and type(data) == "table" and type(data.Ragdoll) == "table" then
			if not OriginalExplosionLists[module] then
				OriginalExplosionLists[module] = cloneArray(data.Ragdoll.Explode)
			end
			data.Ragdoll.Explode = { newId }
		end
	end
end

local function restoreSoundData()
	for module, original in pairs(OriginalExplosionLists) do
		local ok, data = pcall(require, module)
		if ok and type(data) == "table" and type(data.Ragdoll) == "table" then
			if original and #original > 0 then
				data.Ragdoll.Explode = cloneArray(original)
			else
				data.Ragdoll.Explode = { DEFAULT_CACHE_SOUND_ID }
			end
		end
	end
end

local function getDefaultExplosionId()
	for _, original in pairs(OriginalExplosionLists) do
		if original and original[1] then
			return original[1]
		end
	end
	return DEFAULT_CACHE_SOUND_ID
end

local function retuneExistingExplosionSounds(targetId)
	targetId = targetId or SelectedExplosionId

	local function process(container)
		if not container then
			return
		end
		for _, descendant in ipairs(container:GetDescendants()) do
			if descendant:IsA("Sound") then
				if descendant.Name == "Explosion" or descendant.SoundId == DEFAULT_CACHE_SOUND_ID then
					descendant.SoundId = targetId
				end
			end
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		process(player.Character)
		process(player:FindFirstChild("Backpack"))
	end

	process(Workspace:FindFirstChild("Cache"))
end

local function enableCustomExplosions()
	if CustomExplosionEnabled then
		patchSoundData(SelectedExplosionId)
		retuneExistingExplosionSounds(SelectedExplosionId)
		return
	end

	CustomExplosionEnabled = true
	patchSoundData(SelectedExplosionId)
	retuneExistingExplosionSounds(SelectedExplosionId)
end

local function disableCustomExplosions()
	if not CustomExplosionEnabled then
		return
	end

	CustomExplosionEnabled = false
	restoreSoundData()
	retuneExistingExplosionSounds(getDefaultExplosionId())
end

do
	local oldPlayLocalSound = getgenv().__roberthook_PlayLocalSound
	if not oldPlayLocalSound then
		oldPlayLocalSound = hookfunction(SoundService.PlayLocalSound, function(self, sound, ...)
			if CustomExplosionEnabled and sound and sound:IsA("Sound") then
				if sound.Name == "Explosion" or sound.SoundId == DEFAULT_CACHE_SOUND_ID then
					sound.SoundId = SelectedExplosionId
				end
			end
			return oldPlayLocalSound(self, sound, ...)
		end)
		getgenv().__roberthook_PlayLocalSound = oldPlayLocalSound
	end

	if not getgenv().__roberthook_SoundPlay then
		local dummySound = Instance.new("Sound")
		local oldPlay
		oldPlay = hookfunction(dummySound.Play, function(self, ...)
			if CustomExplosionEnabled and self then
				if self.Name == "Explosion" or self.SoundId == DEFAULT_CACHE_SOUND_ID then
					self.SoundId = SelectedExplosionId
				end
			end
			return oldPlay(self, ...)
		end)
		getgenv().__roberthook_SoundPlay = oldPlay
		dummySound:Destroy()
	end
end

local function syncKeybindState(keybind, flagName, value)
	if keybind then
		keybind.Toggled = value
	end
	local stored = Library.Flags[flagName]
	if typeof(stored) == "table" then
		stored.Toggled = value
	end
end

local function updateServerRegionLabel()
	local ok = pcall(function()
		if not LocalPlayer then
			return
		end
		local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
		if not playerGui then
			return
		end
		local tbd = playerGui:FindFirstChild("TBDUI")
		if not tbd then
			return
		end
		local main = tbd:FindFirstChild("Main")
		if not main then
			return
		end
		local serverRegion = main:FindFirstChild("ServerRegion")
		if not serverRegion then
			return
		end

		local label = nil
		if serverRegion:IsA("TextLabel") then
			label = serverRegion
		else
			for _, descendant in ipairs(serverRegion:GetDescendants()) do
				if descendant:IsA("TextLabel") and descendant.Text:match("Server Region") then
					label = descendant
					break
				end
			end
		end

		if not label then
			return
		end

		pcall(function()
			label.RichText = true
		end)

		local inner = "RobertHook " .. MenuVersion
		local replaced, count = label.Text:gsub("(<font.-<stroke.-%>)(.-)(</stroke></font>)", "%1" .. inner .. "%3")
		if count > 0 then
			label.Text = replaced
			return
		end

		label.Text = label.Text:gsub("%b()", "(" .. inner .. ")", 1)
	end)

	if not ok then
		-- ignore errors
	end
end

task.spawn(function()
	for _ = 1, 20 do
		updateServerRegionLabel()
		task.wait(0.5)
	end
end)

task.spawn(function()
	while task.wait(0.5) do
		local delta = RunService.RenderStepped:Wait()
		local fps = (delta ~= 0) and math.round(1 / delta) or 0
		local pingStat = Stats.Network.ServerStatsItem["Data Ping"]
		local ping = pingStat and math.round(pingStat:GetValue()) or 0
		setWatermarkText(getWatermarkText(fps, ping))
	end
end)

local function hasBomb(player)
	if not player or not player.Character then
		return false
	end
	return player.Character:FindFirstChild("Bomb") ~= nil
end

local function isTeammate(player)
	if player == LocalPlayer then
		return true
	end
	if not player or not player.Character then
		return false
	end
	return player.Character:FindFirstChild("TeamHighlight") ~= nil
end

local MovementPage = Window:Page({ Name = "Movement", Columns = 1 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local UtilityPage = Window:Page({ Name = "Utility", Columns = 1 })
local SettingsPage = Window:Page({ Name = "Settings", Columns = 2 })

local MovementSection = MovementPage:Section({ Name = "Robert Walk", Side = 1 })
local EnvironmentSection = VisualsPage:Section({ Name = "Environment", Side = 1 })
local BombSection = VisualsPage:Section({ Name = "Bomb Tweaks", Side = 1 })
local CameraSection = VisualsPage:Section({ Name = "Camera", Side = 2 })
local AutomationSection = UtilityPage:Section({ Name = "Automation", Side = 1 })
local ThemesSection = SettingsPage:Section({ Name = "Themes", Side = 1 })
local ConfigsSection = SettingsPage:Section({ Name = "Configs", Side = 2 })

local SpeedMultiplier = 1
local RobertWalkEnabled = false
local RobertWalkConnection

local function updateRobertWalk()
	if not RobertWalkEnabled then
		return
	end

	local character = LocalPlayer and LocalPlayer.Character
	if not character then
		return
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoidRootPart or not humanoid then
		return
	end

	if humanoid:GetState() == Enum.HumanoidStateType.Climbing then
		return
	end

	local moveDirection = humanoid.MoveDirection
	if moveDirection.Magnitude > 0 then
		humanoidRootPart.CFrame = humanoidRootPart.CFrame + (moveDirection * (0.001 * SpeedMultiplier))
	end
end

local robertWalkKeybind

local RobertWalkToggle = MovementSection:Toggle({
	Name = "Speed",
	Flag = "RobertWalkEnabled",
	Tooltip = "Adds a micro-displacement every heartbeat to keep you moving faster.",
	Callback = function(value)
		RobertWalkEnabled = value
		if RobertWalkEnabled then
			if RobertWalkConnection then
				RobertWalkConnection:Disconnect()
			end
			RobertWalkConnection = RunService.Heartbeat:Connect(updateRobertWalk)
		elseif RobertWalkConnection then
			RobertWalkConnection:Disconnect()
			RobertWalkConnection = nil
		end
		syncKeybindState(robertWalkKeybind, "RobertWalkKeybind", value)
	end,
})

MovementSection:Slider({
	Name = "Speed Multiplier",
	Flag = "RobertWalkSpeed",
	Min = 1,
	Max = 100,
	Default = 1,
	Decimals = 1,
	Suffix = "x",
	Callback = function(value)local Library =
		loadstring(game:HttpGet("https://raw.githubusercontent.com/YaBoiBrody/roberthookdeluxe/refs/heads/main/newlib.lua"))()
	
	local MenuVersion = "1.2"
	
	local function cloneTheme(theme)
		local copy = {}
		for key, value in pairs(theme) do
			copy[key] = value
		end
		return copy
	end
	
	local baseAqua = Library.Themes and Library.Themes["Aqua"] and cloneTheme(Library.Themes["Aqua"])
	
	Library.Themes = {
		["Aqua"] = baseAqua or {
			["Window Background"] = Color3.fromRGB(71, 84, 99),
			["Inline"] = Color3.fromRGB(31, 35, 39),
			["Text"] = Color3.fromRGB(255, 255, 255),
			["Section Background"] = Color3.fromRGB(22, 25, 28),
			["Element"] = Color3.fromRGB(58, 66, 77),
			["Border"] = Color3.fromRGB(48, 56, 63),
			["Outline"] = Color3.fromRGB(20, 25, 30),
			["Dark Liner"] = Color3.fromRGB(38, 45, 53),
			["Risky"] = Color3.fromRGB(255, 50, 50),
			["Accent"] = Color3.fromRGB(104, 214, 255),
		},
		["Mint"] = {
			["Window Background"] = Color3.fromRGB(40, 68, 58),
			["Inline"] = Color3.fromRGB(24, 44, 36),
			["Text"] = Color3.fromRGB(220, 248, 236),
			["Section Background"] = Color3.fromRGB(30, 54, 44),
			["Element"] = Color3.fromRGB(52, 88, 72),
			["Border"] = Color3.fromRGB(64, 94, 80),
			["Outline"] = Color3.fromRGB(18, 28, 24),
			["Dark Liner"] = Color3.fromRGB(44, 70, 58),
			["Risky"] = Color3.fromRGB(255, 120, 120),
			["Accent"] = Color3.fromRGB(132, 228, 176),
		},
		["Nebula"] = {
			["Window Background"] = Color3.fromRGB(30, 24, 42),
			["Inline"] = Color3.fromRGB(18, 12, 30),
			["Text"] = Color3.fromRGB(220, 205, 255),
			["Section Background"] = Color3.fromRGB(24, 18, 34),
			["Element"] = Color3.fromRGB(52, 40, 76),
			["Border"] = Color3.fromRGB(68, 50, 96),
			["Outline"] = Color3.fromRGB(12, 8, 20),
			["Dark Liner"] = Color3.fromRGB(44, 32, 64),
			["Risky"] = Color3.fromRGB(255, 88, 120),
			["Accent"] = Color3.fromRGB(158, 95, 255),
		},
		["Sunset"] = {
			["Window Background"] = Color3.fromRGB(58, 36, 28),
			["Inline"] = Color3.fromRGB(32, 20, 16),
			["Text"] = Color3.fromRGB(255, 232, 210),
			["Section Background"] = Color3.fromRGB(40, 24, 18),
			["Element"] = Color3.fromRGB(76, 44, 34),
			["Border"] = Color3.fromRGB(90, 54, 42),
			["Outline"] = Color3.fromRGB(24, 14, 12),
			["Dark Liner"] = Color3.fromRGB(60, 36, 28),
			["Risky"] = Color3.fromRGB(255, 112, 80),
			["Accent"] = Color3.fromRGB(255, 170, 92),
		},
		["Glacier"] = {
			["Window Background"] = Color3.fromRGB(48, 64, 78),
			["Inline"] = Color3.fromRGB(28, 44, 56),
			["Text"] = Color3.fromRGB(228, 245, 255),
			["Section Background"] = Color3.fromRGB(32, 48, 60),
			["Element"] = Color3.fromRGB(58, 84, 100),
			["Border"] = Color3.fromRGB(68, 96, 112),
			["Outline"] = Color3.fromRGB(20, 28, 36),
			["Dark Liner"] = Color3.fromRGB(44, 64, 78),
			["Risky"] = Color3.fromRGB(214, 85, 85),
			["Accent"] = Color3.fromRGB(146, 212, 255),
		},
		["Voltage"] = {
			["Window Background"] = Color3.fromRGB(28, 30, 36),
			["Inline"] = Color3.fromRGB(14, 16, 24),
			["Text"] = Color3.fromRGB(230, 240, 255),
			["Section Background"] = Color3.fromRGB(20, 22, 28),
			["Element"] = Color3.fromRGB(42, 44, 56),
			["Border"] = Color3.fromRGB(52, 54, 68),
			["Outline"] = Color3.fromRGB(12, 12, 18),
			["Dark Liner"] = Color3.fromRGB(34, 36, 46),
			["Risky"] = Color3.fromRGB(255, 108, 150),
			["Accent"] = Color3.fromRGB(0, 220, 160),
		},
		["Meadow"] = {
			["Window Background"] = Color3.fromRGB(44, 58, 46),
			["Inline"] = Color3.fromRGB(24, 34, 28),
			["Text"] = Color3.fromRGB(222, 240, 220),
			["Section Background"] = Color3.fromRGB(30, 42, 34),
			["Element"] = Color3.fromRGB(56, 78, 60),
			["Border"] = Color3.fromRGB(64, 88, 68),
			["Outline"] = Color3.fromRGB(18, 25, 20),
			["Dark Liner"] = Color3.fromRGB(46, 64, 50),
			["Risky"] = Color3.fromRGB(240, 98, 87),
			["Accent"] = Color3.fromRGB(132, 214, 156),
		},
		["Crimson"] = {
			["Window Background"] = Color3.fromRGB(60, 24, 28),
			["Inline"] = Color3.fromRGB(32, 12, 16),
			["Text"] = Color3.fromRGB(255, 228, 228),
			["Section Background"] = Color3.fromRGB(40, 16, 20),
			["Element"] = Color3.fromRGB(92, 32, 38),
			["Border"] = Color3.fromRGB(110, 42, 48),
			["Outline"] = Color3.fromRGB(20, 8, 10),
			["Dark Liner"] = Color3.fromRGB(72, 26, 32),
			["Risky"] = Color3.fromRGB(255, 102, 118),
			["Accent"] = Color3.fromRGB(214, 64, 78),
		},
		["Aurora"] = {
			["Window Background"] = Color3.fromRGB(30, 36, 54),
			["Inline"] = Color3.fromRGB(18, 22, 38),
			["Text"] = Color3.fromRGB(220, 244, 255),
			["Section Background"] = Color3.fromRGB(24, 28, 42),
			["Element"] = Color3.fromRGB(52, 64, 92),
			["Border"] = Color3.fromRGB(66, 80, 108),
			["Outline"] = Color3.fromRGB(14, 18, 28),
			["Dark Liner"] = Color3.fromRGB(42, 54, 74),
			["Risky"] = Color3.fromRGB(255, 108, 164),
			["Accent"] = Color3.fromRGB(108, 232, 190),
		},
		["Obsidian"] = {
			["Window Background"] = Color3.fromRGB(24, 26, 32),
			["Inline"] = Color3.fromRGB(14, 16, 22),
			["Text"] = Color3.fromRGB(210, 216, 222),
			["Section Background"] = Color3.fromRGB(18, 20, 28),
			["Element"] = Color3.fromRGB(44, 46, 54),
			["Border"] = Color3.fromRGB(58, 60, 70),
			["Outline"] = Color3.fromRGB(12, 12, 18),
			["Dark Liner"] = Color3.fromRGB(34, 36, 42),
			["Risky"] = Color3.fromRGB(255, 96, 96),
			["Accent"] = Color3.fromRGB(132, 168, 255),
		},
		["Nocturne"] = {
			["Window Background"] = Color3.fromRGB(22, 24, 32),
			["Inline"] = Color3.fromRGB(13, 16, 24),
			["Text"] = Color3.fromRGB(214, 218, 255),
			["Section Background"] = Color3.fromRGB(18, 20, 28),
			["Element"] = Color3.fromRGB(36, 40, 56),
			["Border"] = Color3.fromRGB(48, 52, 68),
			["Outline"] = Color3.fromRGB(12, 12, 18),
			["Dark Liner"] = Color3.fromRGB(32, 34, 46),
			["Risky"] = Color3.fromRGB(255, 108, 140),
			["Accent"] = Color3.fromRGB(96, 150, 255),
		},
	}
	
	Library.Theme = cloneTheme(Library.Themes["Aqua"])
	
	local ThemeGradientMap = {
		Aqua = {
			Start = Color3.fromRGB(104, 214, 255),
			Middle = Color3.fromRGB(163, 151, 255),
			End = Color3.fromRGB(159, 115, 255),
		},
		Mint = {
			Start = Color3.fromRGB(132, 228, 176),
			Middle = Color3.fromRGB(104, 212, 160),
			End = Color3.fromRGB(92, 188, 148),
		},
		Nebula = {
			Start = Color3.fromRGB(158, 95, 255),
			Middle = Color3.fromRGB(201, 126, 255),
			End = Color3.fromRGB(118, 74, 210),
		},
		Sunset = {
			Start = Color3.fromRGB(255, 170, 92),
			Middle = Color3.fromRGB(255, 112, 80),
			End = Color3.fromRGB(214, 76, 60),
		},
		Glacier = {
			Start = Color3.fromRGB(146, 212, 255),
			Middle = Color3.fromRGB(110, 180, 230),
			End = Color3.fromRGB(84, 150, 204),
		},
		Voltage = {
			Start = Color3.fromRGB(0, 220, 160),
			Middle = Color3.fromRGB(90, 200, 255),
			End = Color3.fromRGB(150, 120, 255),
		},
		Meadow = {
			Start = Color3.fromRGB(132, 214, 156),
			Middle = Color3.fromRGB(102, 186, 128),
			End = Color3.fromRGB(84, 162, 110),
		},
		Crimson = {
			Start = Color3.fromRGB(214, 64, 78),
			Middle = Color3.fromRGB(255, 102, 118),
			End = Color3.fromRGB(255, 132, 132),
		},
		Aurora = {
			Start = Color3.fromRGB(108, 232, 190),
			Middle = Color3.fromRGB(138, 206, 255),
			End = Color3.fromRGB(90, 180, 255),
		},
		Obsidian = {
			Start = Color3.fromRGB(132, 168, 255),
			Middle = Color3.fromRGB(110, 140, 230),
			End = Color3.fromRGB(84, 116, 200),
		},
		Nocturne = {
			Start = Color3.fromRGB(96, 150, 255),
			Middle = Color3.fromRGB(118, 96, 255),
			End = Color3.fromRGB(72, 80, 210),
		},
	}
	
	local function normalizeThemeName(flagValue)
		if typeof(flagValue) == "string" and ThemeGradientMap[flagValue] then
			return flagValue
		elseif typeof(flagValue) == "table" then
			if flagValue.Value and ThemeGradientMap[flagValue.Value] then
				return flagValue.Value
			end
			if flagValue.Name and ThemeGradientMap[flagValue.Name] then
				return flagValue.Name
			end
		end
		return nil
	end
	
	local function getGradientForTheme(theme)
		return ThemeGradientMap[theme] or ThemeGradientMap.Aqua
	end
	
	local CurrentThemeName = "Aqua"
	local Window
	
	local function applyTitleGradient(themeName)
		local resolved = normalizeThemeName(themeName) or CurrentThemeName
		CurrentThemeName = resolved
		local gradientInfo = getGradientForTheme(resolved)
	
		if Window and Window.GradientTitle then
			Window.GradientTitle.Start = gradientInfo.Start
			Window.GradientTitle.Middle = gradientInfo.Middle
			Window.GradientTitle.End = gradientInfo.End
		end
	
		if Window and Window.Items then
			local titleFrame = Window.Items["Title"]
			local textLabel
	
			if titleFrame then
				local inst = titleFrame.Instance or titleFrame
				if typeof(inst) == "Instance" then
					textLabel = inst:FindFirstChildWhichIsA("TextLabel")
				end
			end
	
			if not textLabel then
				local textItem = Window.Items["Text"]
				if textItem then
					local inst = textItem.Instance or textItem
					if typeof(inst) == "Instance" and inst:IsA("TextLabel") then
						textLabel = inst
					end
				end
			end
	
			if not textLabel then
				for _, entry in pairs(Window.Items) do
					local inst = entry.Instance or entry
					if typeof(inst) == "Instance" and inst:IsA("TextLabel") and inst.Text == Window.Name then
						textLabel = inst
						break
					end
				end
			end
	
			if textLabel then
				local gradient = textLabel:FindFirstChildWhichIsA("UIGradient")
				if not gradient then
					gradient = Instance.new("UIGradient")
					gradient.Parent = textLabel
					gradient.Rotation = 0
				end
				gradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, gradientInfo.Start),
					ColorSequenceKeypoint.new(0.5, gradientInfo.Middle),
					ColorSequenceKeypoint.new(1, gradientInfo.End),
				})
			end
		end
	end
	
	
	Library.MenuKeybind = tostring(Enum.KeyCode.LeftAlt)
	
	local initialGradient = getGradientForTheme(CurrentThemeName)
	Window = Library:Window({
		Name = "roberthook",
		GradientTitle = {
			Enabled = true,
			Start = initialGradient.Start,
			Middle = initialGradient.Middle,
			End = initialGradient.End,
			Speed = 1,
		},
	})
	
	applyTitleGradient(CurrentThemeName)
	
	local function getWatermarkText(fps, ping)
		return string.format("roberthook - %d fps - %d ms - private", fps, ping)
	end
	
	local initialWatermarkText = getWatermarkText(0, 0)
	local previousThemeItemCount = #Library.ThemeItems
	local Watermark = Library:Watermark(initialWatermarkText, { "137309004700555", Color3.fromRGB(163, 151, 255) })
	local KeybindList = Library:KeybindList()
	
	local watermarkLabel
	
	for index = previousThemeItemCount + 1, #Library.ThemeItems do
		local item = Library.ThemeItems[index]
		if item and item.Item and item.Item:IsA("TextLabel") and item.Item.Text == initialWatermarkText then
			watermarkLabel = item.Item
			break
		end
	end
	
	local function setWatermarkText(text)
		if watermarkLabel and watermarkLabel.Parent then
			watermarkLabel.Text = text
			return
		end
	
		local holder = Library.Holder and Library.Holder.Instance
		if not holder then
			return
		end
	
		for _, descendant in ipairs(holder:GetDescendants()) do
			if descendant:IsA("TextLabel") and descendant.Text:find("roberthook") then
				watermarkLabel = descendant
				watermarkLabel.Text = text
				break
			end
		end
	end
	
	setWatermarkText(initialWatermarkText)
	
	Watermark:SetVisibility(true)
	KeybindList:SetVisibility(true)
	
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")
	local Stats = game:GetService("Stats")
	local SoundService = game:GetService("SoundService")
	local LocalPlayer = Players.LocalPlayer
	
	local DesyncState = getgenv().__roberthook_desyncState
	if not DesyncState then
		DesyncState = { Enabled = false }
		getgenv().__roberthook_desyncState = DesyncState
	end
	
	local function isUpdateCFrameRemote(obj)
		if typeof(obj) ~= "Instance" or obj.Name ~= "UpdateCFrame" then
			return false
		end
		local parent = obj.Parent
		if not parent or parent.Name ~= "CharacterReplicator" then
			return false
		end
		parent = parent.Parent
		if not parent or parent.Name ~= "Remotes" then
			return false
		end
		return parent.Parent == ReplicatedStorage
	end
	
	if not getgenv().__roberthook_namecallhook then
		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
			if DesyncState.Enabled and typeof(self) == "Instance" then
				local method = getnamecallmethod()
				if (method == "FireServer" or method == "InvokeServer") and isUpdateCFrameRemote(self) then
					return
				end
			end
			return oldNamecall(self, ...)
		end)
		getgenv().__roberthook_oldNamecall = oldNamecall
		getgenv().__roberthook_namecallhook = true
	end
	
	local CustomExplosionEnabled = false
	local ExplosionOptions = {
		["Demoman Kaboom"] = "rbxassetid://17698665337",
		["Cod Zombies"] = "rbxassetid://130219836212781",
		["allah akbar"] = "rbxassetid://128063484534323",
		["Spongebob Laugh"] = "rbxassetid://8904888220",
		["boowomp"] = "rbxassetid://18871561370",
		["Im Spongebob!"] = "rbxassetid://102599899751746",
		["bobby foggy"] = "rbxassetid://106974578385523",
		["bob laugh"] = "rbxassetid://111605929167392",
	}
	local ExplosionOptionNames = {
		"Demoman Kaboom",
		"Cod Zombies",
		"allah akbar",
		"Spongebob Laugh",
		"boowomp",
		"Im Spongebob!",
		"bobby foggy",
		"bob laugh",
	}
	local SelectedExplosionId = ExplosionOptions[ExplosionOptionNames[1]]
	local DEFAULT_CACHE_SOUND_ID = "rbxassetid://13109132253"
	
	local function cloneArray(list)
		local copy = {}
		if list then
			for index, value in ipairs(list) do
				copy[index] = value
			end
		end
		return copy
	end
	
	local function collectSoundDataModules()
		local result = {}
		local seen = {}
	
		local function consider(instance)
			if instance and instance:IsA("ModuleScript") and instance.Name == "SoundData" and not seen[instance] then
				seen[instance] = true
				result[#result + 1] = instance
			end
		end
	
		local ok, modules = pcall(getloadedmodules)
		if ok and typeof(modules) == "table" then
			for _, module in ipairs(modules) do
				consider(module)
			end
		end
	
		local replicatedStorage = game:GetService("ReplicatedStorage")
		if replicatedStorage then
			consider(replicatedStorage:FindFirstChild("SoundData"))
			local assets = replicatedStorage:FindFirstChild("Assets")
			if assets then
				consider(assets:FindFirstChild("SoundData"))
			end
		end
	
		return result
	end
	
	local OriginalExplosionLists = {}
	
	local function patchSoundData(newId)
		for _, module in ipairs(collectSoundDataModules()) do
			local ok, data = pcall(require, module)
			if ok and type(data) == "table" and type(data.Ragdoll) == "table" then
				if not OriginalExplosionLists[module] then
					OriginalExplosionLists[module] = cloneArray(data.Ragdoll.Explode)
				end
				data.Ragdoll.Explode = { newId }
			end
		end
	end
	
	local function restoreSoundData()
		for module, original in pairs(OriginalExplosionLists) do
			local ok, data = pcall(require, module)
			if ok and type(data) == "table" and type(data.Ragdoll) == "table" then
				if original and #original > 0 then
					data.Ragdoll.Explode = cloneArray(original)
				else
					data.Ragdoll.Explode = { DEFAULT_CACHE_SOUND_ID }
				end
			end
		end
	end
	
	local function getDefaultExplosionId()
		for _, original in pairs(OriginalExplosionLists) do
			if original and original[1] then
				return original[1]
			end
		end
		return DEFAULT_CACHE_SOUND_ID
	end
	
	local function retuneExistingExplosionSounds(targetId)
		targetId = targetId or SelectedExplosionId
	
		local function process(container)
			if not container then
				return
			end
			for _, descendant in ipairs(container:GetDescendants()) do
				if descendant:IsA("Sound") then
					if descendant.Name == "Explosion" or descendant.SoundId == DEFAULT_CACHE_SOUND_ID then
						descendant.SoundId = targetId
					end
				end
			end
		end
	
		for _, player in ipairs(Players:GetPlayers()) do
			process(player.Character)
			process(player:FindFirstChild("Backpack"))
		end
	
		process(Workspace:FindFirstChild("Cache"))
	end
	
	local function enableCustomExplosions()
		if CustomExplosionEnabled then
			patchSoundData(SelectedExplosionId)
			retuneExistingExplosionSounds(SelectedExplosionId)
			return
		end
	
		CustomExplosionEnabled = true
		patchSoundData(SelectedExplosionId)
		retuneExistingExplosionSounds(SelectedExplosionId)
	end
	
	local function disableCustomExplosions()
		if not CustomExplosionEnabled then
			return
		end
	
		CustomExplosionEnabled = false
		restoreSoundData()
		retuneExistingExplosionSounds(getDefaultExplosionId())
	end
	
	do
		local oldPlayLocalSound = getgenv().__roberthook_PlayLocalSound
		if not oldPlayLocalSound then
			oldPlayLocalSound = hookfunction(SoundService.PlayLocalSound, function(self, sound, ...)
				if CustomExplosionEnabled and sound and sound:IsA("Sound") then
					if sound.Name == "Explosion" or sound.SoundId == DEFAULT_CACHE_SOUND_ID then
						sound.SoundId = SelectedExplosionId
					end
				end
				return oldPlayLocalSound(self, sound, ...)
			end)
			getgenv().__roberthook_PlayLocalSound = oldPlayLocalSound
		end
	
		if not getgenv().__roberthook_SoundPlay then
			local dummySound = Instance.new("Sound")
			local oldPlay
			oldPlay = hookfunction(dummySound.Play, function(self, ...)
				if CustomExplosionEnabled and self then
					if self.Name == "Explosion" or self.SoundId == DEFAULT_CACHE_SOUND_ID then
						self.SoundId = SelectedExplosionId
					end
				end
				return oldPlay(self, ...)
			end)
			getgenv().__roberthook_SoundPlay = oldPlay
			dummySound:Destroy()
		end
	end
	
	local function syncKeybindState(keybind, flagName, value)
		if keybind then
			keybind.Toggled = value
		end
		local stored = Library.Flags[flagName]
		if typeof(stored) == "table" then
			stored.Toggled = value
		end
	end
	
	local function updateServerRegionLabel()
		local ok = pcall(function()
			if not LocalPlayer then
				return
			end
			local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
			if not playerGui then
				return
			end
			local tbd = playerGui:FindFirstChild("TBDUI")
			if not tbd then
				return
			end
			local main = tbd:FindFirstChild("Main")
			if not main then
				return
			end
			local serverRegion = main:FindFirstChild("ServerRegion")
			if not serverRegion then
				return
			end
	
			local label = nil
			if serverRegion:IsA("TextLabel") then
				label = serverRegion
			else
				for _, descendant in ipairs(serverRegion:GetDescendants()) do
					if descendant:IsA("TextLabel") and descendant.Text:match("Server Region") then
						label = descendant
						break
					end
				end
			end
	
			if not label then
				return
			end
	
			pcall(function()
				label.RichText = true
			end)
	
			local inner = "RobertHook " .. MenuVersion
			local replaced, count = label.Text:gsub("(<font.-<stroke.-%>)(.-)(</stroke></font>)", "%1" .. inner .. "%3")
			if count > 0 then
				label.Text = replaced
				return
			end
	
			label.Text = label.Text:gsub("%b()", "(" .. inner .. ")", 1)
		end)
	
		if not ok then
			-- ignore errors
		end
	end
	
	task.spawn(function()
		for _ = 1, 20 do
			updateServerRegionLabel()
			task.wait(0.5)
		end
	end)
	
	task.spawn(function()
		while task.wait(0.5) do
			local delta = RunService.RenderStepped:Wait()
			local fps = (delta ~= 0) and math.round(1 / delta) or 0
			local pingStat = Stats.Network.ServerStatsItem["Data Ping"]
			local ping = pingStat and math.round(pingStat:GetValue()) or 0
			setWatermarkText(getWatermarkText(fps, ping))
		end
	end)
	
	local function hasBomb(player)
		if not player or not player.Character then
			return false
		end
		return player.Character:FindFirstChild("Bomb") ~= nil
	end
	
	local function isTeammate(player)
		if player == LocalPlayer then
			return true
		end
		if not player or not player.Character then
			return false
		end
		return player.Character:FindFirstChild("TeamHighlight") ~= nil
	end
	
	local MovementPage = Window:Page({ Name = "Movement", Columns = 1 })
	local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
	local UtilityPage = Window:Page({ Name = "Utility", Columns = 1 })
	local SettingsPage = Window:Page({ Name = "Settings", Columns = 2 })
	
	local MovementSection = MovementPage:Section({ Name = "Robert Walk", Side = 1 })
	local EnvironmentSection = VisualsPage:Section({ Name = "Environment", Side = 1 })
	local BombSection = VisualsPage:Section({ Name = "Bomb Tweaks", Side = 1 })
	local CameraSection = VisualsPage:Section({ Name = "Camera", Side = 2 })
	local AutomationSection = UtilityPage:Section({ Name = "Automation", Side = 1 })
	local ThemesSection = SettingsPage:Section({ Name = "Themes", Side = 1 })
	local ConfigsSection = SettingsPage:Section({ Name = "Configs", Side = 2 })
	
	local SpeedMultiplier = 1
	local RobertWalkEnabled = false
	local RobertWalkConnection
	
	local function updateRobertWalk()
		if not RobertWalkEnabled then
			return
		end
	
		local character = LocalPlayer and LocalPlayer.Character
		if not character then
			return
		end
	
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChild("Humanoid")
		if not humanoidRootPart or not humanoid then
			return
		end
	
		local moveDirection = humanoid.MoveDirection
		if moveDirection.Magnitude > 0 then
			humanoidRootPart.CFrame = humanoidRootPart.CFrame + (moveDirection * (0.001 * SpeedMultiplier))
		end
	end
	
	local robertWalkKeybind
	
	local RobertWalkToggle = MovementSection:Toggle({
		Name = "Speed",
		Flag = "RobertWalkEnabled",
		Tooltip = "Adds a micro-displacement every heartbeat to keep you moving faster.",
		Callback = function(value)
			RobertWalkEnabled = value
			if RobertWalkEnabled then
				if RobertWalkConnection then
					RobertWalkConnection:Disconnect()
				end
				RobertWalkConnection = RunService.Heartbeat:Connect(updateRobertWalk)
			elseif RobertWalkConnection then
				RobertWalkConnection:Disconnect()
				RobertWalkConnection = nil
			end
			syncKeybindState(robertWalkKeybind, "RobertWalkKeybind", value)
		end,
	})
	
	MovementSection:Slider({
		Name = "Speed Multiplier",
		Flag = "RobertWalkSpeed",
		Min = 1,
		Max = 100,
		Default = 1,
		Decimals = 1,
		Suffix = "x",
		Callback = function(value)
			SpeedMultiplier = value
		end,
	})
	
	robertWalkKeybind = RobertWalkToggle:Keybind({
		Name = "Speed",
		Flag = "RobertWalkKeybind",
		Default = Enum.KeyCode.C,
		Mode = "Toggle",
		Callback = function(state)
			RobertWalkToggle:Set(state)
		end,
	})
	
	local DesyncToggle
	local DesyncKeybind
	
	DesyncToggle = MovementSection:Toggle({
		Name = "Desyncronize Hitbox",
		Flag = "RobertDesyncHitbox",
		Tooltip = "Desyncronizes your Hitbox to where you were standing when enabled with pure magic",
		Callback = function(value)
			DesyncState.Enabled = value
			syncKeybindState(DesyncKeybind, "RobertDesyncHitboxKeybind", value)
		end,
	})
	
	DesyncKeybind = DesyncToggle:Keybind({
		Name = "Desyncronize Hitbox",
		Flag = "RobertDesyncHitboxKeybind",
		Default = Enum.KeyCode.Z,
		Mode = "Toggle",
		Callback = function(state)
			DesyncToggle:Set(state)
		end,
	})
	
	local NoExplosionEnabled = false
	local NoExplosionConnection
	
	local function handleExplosion(instance)
		if not NoExplosionEnabled then
			return
		end
		if instance:IsA("Explosion") then
			task.defer(function()
				if instance and instance.Parent then
					instance:Destroy()
				end
			end)
		end
	end
	
	EnvironmentSection:Toggle({
		Name = "No Explosion",
		Flag = "RobertNoExplosion",
		Tooltip = "Delete new explosion instances instantly.",
		Callback = function(value)
			NoExplosionEnabled = value
			if NoExplosionEnabled then
				if NoExplosionConnection then
					NoExplosionConnection:Disconnect()
				end
				NoExplosionConnection = Workspace.DescendantAdded:Connect(handleExplosion)
				for _, descendant in ipairs(Workspace:GetDescendants()) do
					handleExplosion(descendant)
				end
			elseif NoExplosionConnection then
				NoExplosionConnection:Disconnect()
				NoExplosionConnection = nil
			end
		end,
	})
	
	local NoFireEnabled = false
	local NoFireConnection
	
	local function handleFire(instance)
		if not NoFireEnabled then
			return
		end
		if instance:IsA("Fire") and instance:FindFirstAncestor("Bomb") then
			task.defer(function()
				if instance and instance.Parent then
					instance:Destroy()
				end
			end)
		end
	end
	
	EnvironmentSection:Toggle({
		Name = "No Fire",
		Flag = "RobertNoFire",
		Tooltip = "Removes fire effects from bombs.",
		Callback = function(value)
			NoFireEnabled = value
			if NoFireEnabled then
				if NoFireConnection then
					NoFireConnection:Disconnect()
				end
				NoFireConnection = Workspace.DescendantAdded:Connect(handleFire)
				for _, player in ipairs(Players:GetPlayers()) do
					local character = player.Character
					if character then
						local bomb = character:FindFirstChild("Bomb")
						if bomb then
							for _, descendant in ipairs(bomb:GetDescendants()) do
								handleFire(descendant)
							end
						end
					end
				end
			elseif NoFireConnection then
				NoFireConnection:Disconnect()
				NoFireConnection = nil
			end
		end,
	})
	
	local RobertBombEnabled = false
	local RobertBombConnection
	
	local function updateBombMesh(tool)
		if not tool:IsA("Tool") or tool.Name ~= "Bomb" then
			return
		end
		local mesh = tool:FindFirstChild("Mesh", true)
		if mesh and mesh:IsA("SpecialMesh") then
			mesh.MeshId = "rbxassetid://18699629990"
			mesh.TextureId = "rbxassetid://18699630736"
		end
	end
	
	local function scanForBombs()
		if not RobertBombEnabled then
			return
		end
		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			if character then
				local bomb = character:FindFirstChild("Bomb")
				if bomb then
					updateBombMesh(bomb)
				end
			end
		end
	end
	
	BombSection:Toggle({
		Name = "Robert Bomb",
		Flag = "RobertBombEnabled",
		Tooltip = "Replaces the bomb with hamilton (his face is on the bottom)",
		Callback = function(value)
			RobertBombEnabled = value
			if RobertBombEnabled then
				scanForBombs()
				if RobertBombConnection then
					RobertBombConnection:Disconnect()
				end
				RobertBombConnection = Workspace.DescendantAdded:Connect(function(instance)
					if instance.Name == "Bomb" and instance:IsA("Tool") then
						task.defer(function()
							updateBombMesh(instance)
						end)
					end
				end)
			elseif RobertBombConnection then
				RobertBombConnection:Disconnect()
				RobertBombConnection = nil
			end
		end,
	})
	
	local RobertRotationEnabled = false
	local RobertRotationConnection
	local rotationKeybind
	
	local function updateRotation()
		if not RobertRotationEnabled then
			return
		end
	
		local character = LocalPlayer and LocalPlayer.Character
		if not character or not hasBomb(LocalPlayer) then
			return
		end
	
		local bombTool = character:FindFirstChild("Bomb")
		local bombHandle = nil
		if bombTool and bombTool:IsA("Tool") then
			bombHandle = bombTool:FindFirstChild("BombHandle") or bombTool:FindFirstChild("Handle")
			if bombHandle and not bombHandle:IsA("BasePart") then
				bombHandle = nil
			end
		end
	
		if not bombHandle then
			bombHandle = character:FindFirstChild("HumanoidRootPart")
			if not bombHandle or not bombHandle:IsA("BasePart") then
				return
			end
		end
	
		local nearestPlayer = nil
		local nearestDistance = math.huge
	
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and not isTeammate(player) and not hasBomb(player) then
				local targetCharacter = player.Character
				local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
				if targetRoot then
					local distance = (targetRoot.Position - bombHandle.Position).Magnitude
					if distance <= 15 and distance < nearestDistance then
						nearestDistance = distance
						nearestPlayer = player
					end
				end
			end
		end
	
		if not nearestPlayer then
			return
		end
	
		local myRoot = character:FindFirstChild("HumanoidRootPart")
		local targetRoot = nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not myRoot or not targetRoot then
			return
		end
	
		local direction = targetRoot.Position - bombHandle.Position
		local horizontal = Vector3.new(direction.X, 0, direction.Z)
		local magnitude = horizontal.Magnitude
		if magnitude <= 0.001 then
			return
		end
	
		local desiredDir = horizontal.Unit
		local desiredYaw = math.atan2(-desiredDir.X, -desiredDir.Z)
		local look = myRoot.CFrame.LookVector
		local currentYaw = math.atan2(-look.X, -look.Z)
		local delta = desiredYaw - currentYaw
	
		while delta > math.pi do
			delta = delta - (math.pi * 2)
		end
		while delta <= -math.pi do
			delta = delta + (math.pi * 2)
		end
	
		local maxStep = math.rad((magnitude < 0.6) and 8 or 20)
		if delta > maxStep then
			delta = maxStep
		elseif delta < -maxStep then
			delta = -maxStep
		end
	
		myRoot.CFrame = CFrame.new(myRoot.Position) * CFrame.Angles(0, currentYaw + delta, 0)
	end
	
	local RobertRotationToggle = BombSection:Toggle({
		Name = "Robert Rotation",
		Flag = "RobertRotationEnabled",
		Tooltip = "Automatically faces your bomb toward the closest target.",
		Callback = function(value)
			RobertRotationEnabled = value
			if RobertRotationEnabled then
				if RobertRotationConnection then
					RobertRotationConnection:Disconnect()
				end
				RobertRotationConnection = RunService.Heartbeat:Connect(updateRotation)
			elseif RobertRotationConnection then
				RobertRotationConnection:Disconnect()
				RobertRotationConnection = nil
			end
			syncKeybindState(rotationKeybind, "RobertRotationKeybind", value)
		end,
	})
	
	rotationKeybind = RobertRotationToggle:Keybind({
		Name = "Robert Rotation",
		Flag = "RobertRotationKeybind",
		Default = Enum.KeyCode.X,
		Mode = "Toggle",
		Callback = function(state)
			RobertRotationToggle:Set(state)
		end,
	})
	
	local DefaultFOV = (Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView) or 70
	DefaultFOV = math.clamp(DefaultFOV, 70, 130)
	local CurrentFOV = DefaultFOV
	local FOVEnabled = false
	local FOVConnection
	
	local function applyFOV()
		if not FOVEnabled then
			return
		end
		local camera = Workspace.CurrentCamera
		if not camera then
			return
		end
		camera.FieldOfView = CurrentFOV
	end
	
	local function setFOVEnabled(state)
		FOVEnabled = state
		if FOVEnabled then
			if FOVConnection then
				FOVConnection:Disconnect()
			end
			FOVConnection = RunService.RenderStepped:Connect(applyFOV)
			applyFOV()
		else
			if FOVConnection then
				FOVConnection:Disconnect()
				FOVConnection = nil
			end
			local camera = Workspace.CurrentCamera
			if camera then
				camera.FieldOfView = DefaultFOV
			end
		end
	end
	
	CameraSection:Toggle({
		Name = "FOV Changer",
		Flag = "RobertFOVEnabled",
		Tooltip = "Allows you to customize your field of view.",
		Callback = function(value)
			setFOVEnabled(value)
		end,
	})
	
	CameraSection:Slider({
		Name = "FOV",
		Flag = "RobertFOVValue",
		Min = 70,
		Max = 130,
		Default = CurrentFOV,
		Decimals = 1,
		Suffix = "°",
		Callback = function(value)
			CurrentFOV = value
			if FOVEnabled then
				applyFOV()
			end
		end,
	})
	
	local AutoReadyEnabled = false
	local autoReadyConnection
	local autoReadyThread
	
	local function tryFireReady()
		pcall(function()
			local remotes = ReplicatedStorage:FindFirstChild("Remotes")
			if not remotes then
				return
			end
			local arena = remotes:FindFirstChild("Arena")
			if not arena then
				return
			end
			local readyRemote = arena:FindFirstChild("Ready")
			if readyRemote then
				readyRemote:FireServer(true)
			end
		end)
	end
	
	local function startAutoReady()
		if autoReadyThread then
			return
		end
		autoReadyThread = true
		task.spawn(function()
			while AutoReadyEnabled do
				local readyButton = nil
				local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
				if playerGui then
					local tbd = playerGui:FindFirstChild("TBDUI")
					local main = tbd and tbd:FindFirstChild("Main")
					local prompts = main and main:FindFirstChild("Prompts")
					local ready = prompts and prompts:FindFirstChild("Ready")
					if ready and ready:IsA("TextButton") then
						readyButton = ready
					end
				end
	
				if readyButton then
					if not autoReadyConnection then
						autoReadyConnection = readyButton:GetPropertyChangedSignal("Visible"):Connect(function()
							if AutoReadyEnabled and readyButton.Visible then
								tryFireReady()
							end
						end)
						if readyButton.Visible then
							tryFireReady()
						end
					end
				elseif autoReadyConnection then
					autoReadyConnection:Disconnect()
					autoReadyConnection = nil
				end
	
				task.wait(0.25)
			end
	
			if autoReadyConnection then
				autoReadyConnection:Disconnect()
				autoReadyConnection = nil
			end
	
			autoReadyThread = nil
		end)
	end
	
	local function stopAutoReady()
		AutoReadyEnabled = false
		if autoReadyConnection then
			autoReadyConnection:Disconnect()
			autoReadyConnection = nil
		end
		autoReadyThread = nil
	end
	
	AutomationSection:Toggle({
		Name = "Auto Ready",
		Flag = "RobertAutoReady",
		Tooltip = "Presses the Ready button automatically when it appears.",
		Callback = function(value)
			AutoReadyEnabled = value
			if AutoReadyEnabled then
				startAutoReady()
			else
				stopAutoReady()
			end
		end,
	})
	
	AutomationSection:Toggle({
		Name = "Custom Explosion",
		Flag = "RobertCustomExplosion",
		Callback = function(value)
			if value then
				enableCustomExplosions()
			else
				disableCustomExplosions()
			end
		end,
	})
	
	AutomationSection:Dropdown({
		Name = "Explosion Sound",
		Flag = "RobertCustomExplosionSound",
		Items = ExplosionOptionNames,
		Default = ExplosionOptionNames[1],
		Callback = function(value)
			local newId = ExplosionOptions[value]
			if newId then
				SelectedExplosionId = newId
				if CustomExplosionEnabled then
					patchSoundData(SelectedExplosionId)
					retuneExistingExplosionSounds(newId)
				end
			end
		end,
	})
	
	for Index, Value in Library.Theme do
		Library.ThemeColorpickers[Index] = ThemesSection:Label(Index, "Left"):Colorpicker({
			Name = Index,
			Flag = "Theme" .. Index,
			Default = Value,
			Callback = function(Color)
				Library.Theme[Index] = Color
				Library:ChangeTheme(Index, Color)
				local flagTheme = normalizeThemeName(Library.Flags["Themes list"])
				if flagTheme then
					CurrentThemeName = flagTheme
				end
				applyTitleGradient(CurrentThemeName)
			end
		})
	end
	
	ThemesSection:Dropdown({
		Name = "Themes list",
		Flag = "Themes list",
		Items = { "Aqua", "Mint", "Nebula", "Sunset", "Glacier", "Voltage", "Meadow", "Crimson", "Aurora", "Obsidian", "Nocturne" },
		Default = "Aqua",
		Callback = function(Value)
			local ThemeData = Library.Themes[Value]
	
			if not ThemeData then
				return
			end
	
			local normalizedSelection = normalizeThemeName(Value) or CurrentThemeName
			CurrentThemeName = normalizedSelection
	
			for Index, Color in ThemeData do
				Library.Theme[Index] = Color
				Library:ChangeTheme(Index, Color)
	
				if Library.ThemeColorpickers[Index] then
					Library.ThemeColorpickers[Index]:Set(Color)
				end
			end
	
			applyTitleGradient(normalizedSelection)
	
			task.wait(0.3)
	
			Library:Thread(function()
				for Index in Library.Theme do
					Library.Theme[Index] = Library.Flags["Theme" .. Index].Color
					Library:ChangeTheme(Index, Library.Flags["Theme" .. Index].Color)
				end
	
				local flagTheme = normalizeThemeName(Library.Flags["Themes list"])
				if flagTheme then
					CurrentThemeName = flagTheme
				end
	
				applyTitleGradient(CurrentThemeName)
			end)
		end
	})
	
	local ThemeName
	local SelectedTheme
	
	local ThemesListbox = ThemesSection:Listbox({
		Name = "Themes List",
		Flag = "Themes List",
		Items = { },
		Multi = false,
		Default = nil,
		Callback = function(Value)
			SelectedTheme = Value
		end
	})
	
	ThemesSection:Textbox({
		Name = "Name",
		Flag = "Theme Name",
		Default = "",
		Placeholder = ". . .",
		Callback = function(Value)
			ThemeName = Value
		end
	})
	
	ThemesSection:Button({
		Name = "Save Theme",
		Callback = function()
			if ThemeName == "" then
				return
			end
	
			if not isfile(Library.Folders.Themes .. "/" .. ThemeName .. ".json") then
				writefile(Library.Folders.Themes .. "/" .. ThemeName .. ".json", Library:GetTheme())
	
				Library:RefreshThemeList(ThemesListbox)
			else
				Library:Notification("Theme '" .. ThemeName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
				return
			end
		end
	}):SubButton({
		Name = "Load Theme",
		Callback = function()
			if SelectedTheme then
				Library:LoadTheme(readfile(Library.Folders.Themes .. "/" .. SelectedTheme))
				local flagTheme = Library.Flags["Themes list"]
				if flagTheme and ThemeGradientMap[flagTheme] then
					CurrentThemeName = flagTheme
				end
				applyTitleGradient(CurrentThemeName)
			end
		end
	})
	
	ThemesSection:Button({
		Name = "Refresh Themes",
		Callback = function()
			Library:RefreshThemeList(ThemesListbox)
		end
	})
	
	Library:RefreshThemeList(ThemesListbox)
	
	local ConfigName
	local SelectedConfig
	
	local ConfigsListbox = ConfigsSection:Listbox({
		Name = "Configs list",
		Flag = "Configs List",
		Items = { },
		Multi = false,
		Default = nil,
		Callback = function(Value)
			SelectedConfig = Value
		end
	})
	
	ConfigsSection:Textbox({
		Name = "Name",
		Flag = "Config Name",
		Default = "",
		Placeholder = ". . .",
		Callback = function(Value)
			ConfigName = Value
		end
	})
	
	ConfigsSection:Button({
		Name = "Load Config",
		Callback = function()
			if SelectedConfig then
				Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. SelectedConfig))
			end
	
			Library:Thread(function()
				task.wait(0.1)
	
				for Index in Library.Theme do
					Library.Theme[Index] = Library.Flags["Theme" .. Index].Color
					Library:ChangeTheme(Index, Library.Flags["Theme" .. Index].Color)
				end
	
				local flagTheme = Library.Flags["Themes list"]
				if flagTheme and ThemeGradientMap[flagTheme] then
					CurrentThemeName = flagTheme
				end
	
				applyTitleGradient(CurrentThemeName)
			end)
		end
	}):SubButton({
		Name = "Save Config",
		Callback = function()
			if SelectedConfig then
				Library:SaveConfig(SelectedConfig)
			end
		end
	})
	
	ConfigsSection:Button({
		Name = "Create Config",
		Callback = function()
			if ConfigName == "" then
				return
			end
	
			if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
				writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())
	
				Library:RefreshConfigsList(ConfigsListbox)
			else
				Library:Notification("Config '" .. ConfigName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
				return
			end
		end
	}):SubButton({
		Name = "Delete Config",
		Callback = function()
			if SelectedConfig then
				Library:DeleteConfig(SelectedConfig)
	
				Library:RefreshConfigsList(ConfigsListbox)
			end
		end
	})
	
	ConfigsSection:Button({
		Name = "Refresh Configs",
		Callback = function()
			Library:RefreshConfigsList(ConfigsListbox)
		end
	})
	
	Library:RefreshConfigsList(ConfigsListbox)
	
	ConfigsSection:Label("Menu Keybind", "Left"):Keybind({
		Name = "Menu Keybind",
		Flag = "Robert Menu Keybind",
		Default = Enum.KeyCode.LeftAlt,
		Mode = "Toggle",
		Callback = function()
			local info = Library.Flags["Robert Menu Keybind"]
			if info and info.Key then
				Library.MenuKeybind = info.Key
			end
		end,
	})
	
	ConfigsSection:Toggle({
		Name = "Watermark",
		Flag = "Robert Watermark",
		Default = true,
		Callback = function(value)
			Watermark:SetVisibility(value)
		end,
	})
	
	ConfigsSection:Toggle({
		Name = "Keybind List",
		Flag = "Robert Keybind List",
		Default = true,
		Callback = function(value)
			KeybindList:SetVisibility(value)
		end,
	})
	
	ConfigsSection:Dropdown({
		Name = "Style",
		Flag = "Robert Tween Style",
		Default = Library.Tween.Style.Name,
		Items = { "Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce" },
		Callback = function(value)
			if Enum.EasingStyle[value] then
				Library.Tween.Style = Enum.EasingStyle[value]
			end
		end,
	})
	
	ConfigsSection:Dropdown({
		Name = "Direction",
		Flag = "Robert Tween Direction",
		Default = Library.Tween.Direction.Name,
		Items = { "In", "Out", "InOut" },
		Callback = function(value)
			if Enum.EasingDirection[value] then
				Library.Tween.Direction = Enum.EasingDirection[value]
			end
		end,
	})
	
	ConfigsSection:Slider({
		Name = "Tweening Time",
		Flag = "Robert Tween Time",
		Min = 0,
		Max = 5,
		Default = Library.Tween.Time or 0.25,
		Decimals = 0.01,
		Suffix = "s",
		Callback = function(value)
			Library.Tween.Time = value
		end,
	})
	
	ConfigsSection:Button({
		Name = "Unload library",
		Callback = function()
			Library:Unload()
		end,
	})
	
	Library:Notification("roberthook " .. MenuVersion .. " loaded", 4, Color3.fromRGB(163, 151, 255))
	
		SpeedMultiplier = value
	end,
})

robertWalkKeybind = RobertWalkToggle:Keybind({
	Name = "Speed",
	Flag = "RobertWalkKeybind",
	Default = Enum.KeyCode.C,
	Mode = "Toggle",
	Callback = function(state)
		RobertWalkToggle:Set(state)
	end,
})

local DesyncToggle
local DesyncKeybind

DesyncToggle = MovementSection:Toggle({
	Name = "Desyncronize Hitbox",
	Flag = "RobertDesyncHitbox",
	Tooltip = "Desyncronizes your Hitbox to where you were standing when enabled with pure magic",
	Callback = function(value)
		DesyncState.Enabled = value
		syncKeybindState(DesyncKeybind, "RobertDesyncHitboxKeybind", value)
	end,
})

DesyncKeybind = DesyncToggle:Keybind({
	Name = "Desyncronize Hitbox",
	Flag = "RobertDesyncHitboxKeybind",
	Default = Enum.KeyCode.Z,
	Mode = "Toggle",
	Callback = function(state)
		DesyncToggle:Set(state)
	end,
})

local NoExplosionEnabled = false
local NoExplosionConnection

local function handleExplosion(instance)
	if not NoExplosionEnabled then
		return
	end
	if instance:IsA("Explosion") then
		task.defer(function()
			if instance and instance.Parent then
				instance:Destroy()
			end
		end)
	end
end

EnvironmentSection:Toggle({
	Name = "No Explosion",
	Flag = "RobertNoExplosion",
	Tooltip = "Delete new explosion instances instantly.",
	Callback = function(value)
		NoExplosionEnabled = value
		if NoExplosionEnabled then
			if NoExplosionConnection then
				NoExplosionConnection:Disconnect()
			end
			NoExplosionConnection = Workspace.DescendantAdded:Connect(handleExplosion)
			for _, descendant in ipairs(Workspace:GetDescendants()) do
				handleExplosion(descendant)
			end
		elseif NoExplosionConnection then
			NoExplosionConnection:Disconnect()
			NoExplosionConnection = nil
		end
	end,
})

local NoFireEnabled = false
local NoFireConnection

local function handleFire(instance)
	if not NoFireEnabled then
		return
	end
	if instance:IsA("Fire") and instance:FindFirstAncestor("Bomb") then
		task.defer(function()
			if instance and instance.Parent then
				instance:Destroy()
			end
		end)
	end
end

EnvironmentSection:Toggle({
	Name = "No Fire",
	Flag = "RobertNoFire",
	Tooltip = "Removes fire effects from bombs.",
	Callback = function(value)
		NoFireEnabled = value
		if NoFireEnabled then
			if NoFireConnection then
				NoFireConnection:Disconnect()
			end
			NoFireConnection = Workspace.DescendantAdded:Connect(handleFire)
			for _, player in ipairs(Players:GetPlayers()) do
				local character = player.Character
				if character then
					local bomb = character:FindFirstChild("Bomb")
					if bomb then
						for _, descendant in ipairs(bomb:GetDescendants()) do
							handleFire(descendant)
						end
					end
				end
			end
		elseif NoFireConnection then
			NoFireConnection:Disconnect()
			NoFireConnection = nil
		end
	end,
})

local RobertBombEnabled = false
local RobertBombConnection

local function updateBombMesh(tool)
	if not tool:IsA("Tool") or tool.Name ~= "Bomb" then
		return
	end
	local mesh = tool:FindFirstChild("Mesh", true)
	if mesh and mesh:IsA("SpecialMesh") then
		mesh.MeshId = "rbxassetid://18699629990"
		mesh.TextureId = "rbxassetid://18699630736"
	end
end

local function scanForBombs()
	if not RobertBombEnabled then
		return
	end
	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		if character then
			local bomb = character:FindFirstChild("Bomb")
			if bomb then
				updateBombMesh(bomb)
			end
		end
	end
end

BombSection:Toggle({
	Name = "Robert Bomb",
	Flag = "RobertBombEnabled",
	Tooltip = "Replaces the bomb with hamilton (his face is on the bottom)",
	Callback = function(value)
		RobertBombEnabled = value
		if RobertBombEnabled then
			scanForBombs()
			if RobertBombConnection then
				RobertBombConnection:Disconnect()
			end
			RobertBombConnection = Workspace.DescendantAdded:Connect(function(instance)
				if instance.Name == "Bomb" and instance:IsA("Tool") then
					task.defer(function()
						updateBombMesh(instance)
					end)
				end
			end)
		elseif RobertBombConnection then
			RobertBombConnection:Disconnect()
			RobertBombConnection = nil
		end
	end,
})

local RobertRotationEnabled = false
local RobertRotationConnection
local rotationKeybind

local function updateRotation()
	if not RobertRotationEnabled then
		return
	end

	local character = LocalPlayer and LocalPlayer.Character
	if not character or not hasBomb(LocalPlayer) then
		return
	end

	local bombTool = character:FindFirstChild("Bomb")
	local bombHandle = nil
	if bombTool and bombTool:IsA("Tool") then
		bombHandle = bombTool:FindFirstChild("BombHandle") or bombTool:FindFirstChild("Handle")
		if bombHandle and not bombHandle:IsA("BasePart") then
			bombHandle = nil
		end
	end

	if not bombHandle then
		bombHandle = character:FindFirstChild("HumanoidRootPart")
		if not bombHandle or not bombHandle:IsA("BasePart") then
			return
		end
	end

	local nearestPlayer = nil
	local nearestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and not isTeammate(player) and not hasBomb(player) then
			local targetCharacter = player.Character
			local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
			if targetRoot then
				local distance = (targetRoot.Position - bombHandle.Position).Magnitude
				if distance <= 15 and distance < nearestDistance then
					nearestDistance = distance
					nearestPlayer = player
				end
			end
		end
	end

	if not nearestPlayer then
		return
	end

	local myRoot = character:FindFirstChild("HumanoidRootPart")
	local targetRoot = nearestPlayer.Character and nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not myRoot or not targetRoot then
		return
	end

	local direction = targetRoot.Position - bombHandle.Position
	local horizontal = Vector3.new(direction.X, 0, direction.Z)
	local magnitude = horizontal.Magnitude
	if magnitude <= 0.001 then
		return
	end

	local desiredDir = horizontal.Unit
	local desiredYaw = math.atan2(-desiredDir.X, -desiredDir.Z)
	local look = myRoot.CFrame.LookVector
	local currentYaw = math.atan2(-look.X, -look.Z)
	local delta = desiredYaw - currentYaw

	while delta > math.pi do
		delta = delta - (math.pi * 2)
	end
	while delta <= -math.pi do
		delta = delta + (math.pi * 2)
	end

	local maxStep = math.rad((magnitude < 0.6) and 8 or 20)
	if delta > maxStep then
		delta = maxStep
	elseif delta < -maxStep then
		delta = -maxStep
	end

	myRoot.CFrame = CFrame.new(myRoot.Position) * CFrame.Angles(0, currentYaw + delta, 0)
end

local RobertRotationToggle = BombSection:Toggle({
	Name = "Robert Rotation",
	Flag = "RobertRotationEnabled",
	Tooltip = "Automatically faces your bomb toward the closest target.",
	Callback = function(value)
		RobertRotationEnabled = value
		if RobertRotationEnabled then
			if RobertRotationConnection then
				RobertRotationConnection:Disconnect()
			end
			RobertRotationConnection = RunService.Heartbeat:Connect(updateRotation)
		elseif RobertRotationConnection then
			RobertRotationConnection:Disconnect()
			RobertRotationConnection = nil
		end
		syncKeybindState(rotationKeybind, "RobertRotationKeybind", value)
	end,
})

rotationKeybind = RobertRotationToggle:Keybind({
	Name = "Robert Rotation",
	Flag = "RobertRotationKeybind",
	Default = Enum.KeyCode.X,
	Mode = "Toggle",
	Callback = function(state)
		RobertRotationToggle:Set(state)
	end,
})

local DefaultFOV = (Workspace.CurrentCamera and Workspace.CurrentCamera.FieldOfView) or 70
DefaultFOV = math.clamp(DefaultFOV, 70, 130)
local CurrentFOV = DefaultFOV
local FOVEnabled = false
local FOVConnection

local function applyFOV()
	if not FOVEnabled then
		return
	end
	local camera = Workspace.CurrentCamera
	if not camera then
		return
	end
	camera.FieldOfView = CurrentFOV
end

local function setFOVEnabled(state)
	FOVEnabled = state
	if FOVEnabled then
		if FOVConnection then
			FOVConnection:Disconnect()
		end
		FOVConnection = RunService.RenderStepped:Connect(applyFOV)
		applyFOV()
	else
		if FOVConnection then
			FOVConnection:Disconnect()
			FOVConnection = nil
		end
		local camera = Workspace.CurrentCamera
		if camera then
			camera.FieldOfView = DefaultFOV
		end
	end
end

CameraSection:Toggle({
	Name = "FOV Changer",
	Flag = "RobertFOVEnabled",
	Tooltip = "Allows you to customize your field of view.",
	Callback = function(value)
		setFOVEnabled(value)
	end,
})

CameraSection:Slider({
	Name = "FOV",
	Flag = "RobertFOVValue",
	Min = 70,
	Max = 130,
	Default = CurrentFOV,
	Decimals = 1,
	Suffix = "°",
	Callback = function(value)
		CurrentFOV = value
		if FOVEnabled then
			applyFOV()
		end
	end,
})

local AutoReadyEnabled = false
local autoReadyConnection
local autoReadyThread

local function tryFireReady()
	pcall(function()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		if not remotes then
			return
		end
		local arena = remotes:FindFirstChild("Arena")
		if not arena then
			return
		end
		local readyRemote = arena:FindFirstChild("Ready")
		if readyRemote then
			readyRemote:FireServer(true)
		end
	end)
end

local function startAutoReady()
	if autoReadyThread then
		return
	end
	autoReadyThread = true
	task.spawn(function()
		while AutoReadyEnabled do
			local readyButton = nil
			local playerGui = LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
			if playerGui then
				local tbd = playerGui:FindFirstChild("TBDUI")
				local main = tbd and tbd:FindFirstChild("Main")
				local prompts = main and main:FindFirstChild("Prompts")
				local ready = prompts and prompts:FindFirstChild("Ready")
				if ready and ready:IsA("TextButton") then
					readyButton = ready
				end
			end

			if readyButton then
				if not autoReadyConnection then
					autoReadyConnection = readyButton:GetPropertyChangedSignal("Visible"):Connect(function()
						if AutoReadyEnabled and readyButton.Visible then
							tryFireReady()
						end
					end)
					if readyButton.Visible then
						tryFireReady()
					end
				end
			elseif autoReadyConnection then
				autoReadyConnection:Disconnect()
				autoReadyConnection = nil
			end

			task.wait(0.25)
		end

		if autoReadyConnection then
			autoReadyConnection:Disconnect()
			autoReadyConnection = nil
		end

		autoReadyThread = nil
	end)
end

local function stopAutoReady()
	AutoReadyEnabled = false
	if autoReadyConnection then
		autoReadyConnection:Disconnect()
		autoReadyConnection = nil
	end
	autoReadyThread = nil
end

AutomationSection:Toggle({
	Name = "Auto Ready",
	Flag = "RobertAutoReady",
	Tooltip = "Presses the Ready button automatically when it appears.",
	Callback = function(value)
		AutoReadyEnabled = value
		if AutoReadyEnabled then
			startAutoReady()
		else
			stopAutoReady()
		end
	end,
})

AutomationSection:Toggle({
	Name = "Custom Explosion",
	Flag = "RobertCustomExplosion",
	Callback = function(value)
		if value then
			enableCustomExplosions()
		else
			disableCustomExplosions()
		end
	end,
})

AutomationSection:Dropdown({
	Name = "Explosion Sound",
	Flag = "RobertCustomExplosionSound",
	Items = ExplosionOptionNames,
	Default = ExplosionOptionNames[1],
	Callback = function(value)
		local newId = ExplosionOptions[value]
		if newId then
			SelectedExplosionId = newId
			if CustomExplosionEnabled then
				patchSoundData(SelectedExplosionId)
				retuneExistingExplosionSounds(newId)
			end
		end
	end,
})

for Index, Value in Library.Theme do
	Library.ThemeColorpickers[Index] = ThemesSection:Label(Index, "Left"):Colorpicker({
		Name = Index,
		Flag = "Theme" .. Index,
		Default = Value,
		Callback = function(Color)
			Library.Theme[Index] = Color
			Library:ChangeTheme(Index, Color)
			local flagTheme = normalizeThemeName(Library.Flags["Themes list"])
			if flagTheme then
				CurrentThemeName = flagTheme
			end
			applyTitleGradient(CurrentThemeName)
		end
	})
end

ThemesSection:Dropdown({
	Name = "Themes list",
	Flag = "Themes list",
	Items = { "Aqua", "Mint", "Nebula", "Sunset", "Glacier", "Voltage", "Meadow", "Crimson", "Aurora", "Obsidian", "Nocturne" },
	Default = "Aqua",
	Callback = function(Value)
		local ThemeData = Library.Themes[Value]

		if not ThemeData then
			return
		end

		local normalizedSelection = normalizeThemeName(Value) or CurrentThemeName
		CurrentThemeName = normalizedSelection

		for Index, Color in ThemeData do
			Library.Theme[Index] = Color
			Library:ChangeTheme(Index, Color)

			if Library.ThemeColorpickers[Index] then
				Library.ThemeColorpickers[Index]:Set(Color)
			end
		end

		applyTitleGradient(normalizedSelection)

		task.wait(0.3)

		Library:Thread(function()
			for Index in Library.Theme do
				Library.Theme[Index] = Library.Flags["Theme" .. Index].Color
				Library:ChangeTheme(Index, Library.Flags["Theme" .. Index].Color)
			end

			local flagTheme = normalizeThemeName(Library.Flags["Themes list"])
			if flagTheme then
				CurrentThemeName = flagTheme
			end

			applyTitleGradient(CurrentThemeName)
		end)
	end
})

local ThemeName
local SelectedTheme

local ThemesListbox = ThemesSection:Listbox({
	Name = "Themes List",
	Flag = "Themes List",
	Items = { },
	Multi = false,
	Default = nil,
	Callback = function(Value)
		SelectedTheme = Value
	end
})

ThemesSection:Textbox({
	Name = "Name",
	Flag = "Theme Name",
	Default = "",
	Placeholder = ". . .",
	Callback = function(Value)
		ThemeName = Value
	end
})

ThemesSection:Button({
	Name = "Save Theme",
	Callback = function()
		if ThemeName == "" then
			return
		end

		if not isfile(Library.Folders.Themes .. "/" .. ThemeName .. ".json") then
			writefile(Library.Folders.Themes .. "/" .. ThemeName .. ".json", Library:GetTheme())

			Library:RefreshThemeList(ThemesListbox)
		else
			Library:Notification("Theme '" .. ThemeName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
			return
		end
	end
}):SubButton({
	Name = "Load Theme",
	Callback = function()
		if SelectedTheme then
			Library:LoadTheme(readfile(Library.Folders.Themes .. "/" .. SelectedTheme))
			local flagTheme = Library.Flags["Themes list"]
			if flagTheme and ThemeGradientMap[flagTheme] then
				CurrentThemeName = flagTheme
			end
			applyTitleGradient(CurrentThemeName)
		end
	end
})

ThemesSection:Button({
	Name = "Refresh Themes",
	Callback = function()
		Library:RefreshThemeList(ThemesListbox)
	end
})

Library:RefreshThemeList(ThemesListbox)

local ConfigName
local SelectedConfig

local ConfigsListbox = ConfigsSection:Listbox({
	Name = "Configs list",
	Flag = "Configs List",
	Items = { },
	Multi = false,
	Default = nil,
	Callback = function(Value)
		SelectedConfig = Value
	end
})

ConfigsSection:Textbox({
	Name = "Name",
	Flag = "Config Name",
	Default = "",
	Placeholder = ". . .",
	Callback = function(Value)
		ConfigName = Value
	end
})

ConfigsSection:Button({
	Name = "Load Config",
	Callback = function()
		if SelectedConfig then
			Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. SelectedConfig))
		end

		Library:Thread(function()
			task.wait(0.1)

			for Index in Library.Theme do
				Library.Theme[Index] = Library.Flags["Theme" .. Index].Color
				Library:ChangeTheme(Index, Library.Flags["Theme" .. Index].Color)
			end

			local flagTheme = Library.Flags["Themes list"]
			if flagTheme and ThemeGradientMap[flagTheme] then
				CurrentThemeName = flagTheme
			end

			applyTitleGradient(CurrentThemeName)
		end)
	end
}):SubButton({
	Name = "Save Config",
	Callback = function()
		if SelectedConfig then
			Library:SaveConfig(SelectedConfig)
		end
	end
})

ConfigsSection:Button({
	Name = "Create Config",
	Callback = function()
		if ConfigName == "" then
			return
		end

		if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
			writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())

			Library:RefreshConfigsList(ConfigsListbox)
		else
			Library:Notification("Config '" .. ConfigName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
			return
		end
	end
}):SubButton({
	Name = "Delete Config",
	Callback = function()
		if SelectedConfig then
			Library:DeleteConfig(SelectedConfig)

			Library:RefreshConfigsList(ConfigsListbox)
		end
	end
})

ConfigsSection:Button({
	Name = "Refresh Configs",
	Callback = function()
		Library:RefreshConfigsList(ConfigsListbox)
	end
})

Library:RefreshConfigsList(ConfigsListbox)

ConfigsSection:Label("Menu Keybind", "Left"):Keybind({
	Name = "Menu Keybind",
	Flag = "Robert Menu Keybind",
	Default = Enum.KeyCode.LeftAlt,
	Mode = "Toggle",
	Callback = function()
		local info = Library.Flags["Robert Menu Keybind"]
		if info and info.Key then
			Library.MenuKeybind = info.Key
		end
	end,
})

ConfigsSection:Toggle({
	Name = "Watermark",
	Flag = "Robert Watermark",
	Default = true,
	Callback = function(value)
		Watermark:SetVisibility(value)
	end,
})

ConfigsSection:Toggle({
	Name = "Keybind List",
	Flag = "Robert Keybind List",
	Default = true,
	Callback = function(value)
		KeybindList:SetVisibility(value)
	end,
})

ConfigsSection:Dropdown({
	Name = "Style",
	Flag = "Robert Tween Style",
	Default = Library.Tween.Style.Name,
	Items = { "Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce" },
	Callback = function(value)
		if Enum.EasingStyle[value] then
			Library.Tween.Style = Enum.EasingStyle[value]
		end
	end,
})

ConfigsSection:Dropdown({
	Name = "Direction",
	Flag = "Robert Tween Direction",
	Default = Library.Tween.Direction.Name,
	Items = { "In", "Out", "InOut" },
	Callback = function(value)
		if Enum.EasingDirection[value] then
			Library.Tween.Direction = Enum.EasingDirection[value]
		end
	end,
})

ConfigsSection:Slider({
	Name = "Tweening Time",
	Flag = "Robert Tween Time",
	Min = 0,
	Max = 5,
	Default = Library.Tween.Time or 0.25,
	Decimals = 0.01,
	Suffix = "s",
	Callback = function(value)
		Library.Tween.Time = value
	end,
})

ConfigsSection:Button({
	Name = "Unload library",
	Callback = function()
		Library:Unload()
	end,
})

Library:Notification("roberthook " .. MenuVersion .. " loaded my nigga", 4, Color3.fromRGB(163, 151, 255))
