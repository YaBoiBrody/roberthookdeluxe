local library =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/YaBoiBrody/roberthookdeluxe/refs/heads/main/lib.lua"))()

library.headerColor = Color3.fromRGB(51, 158, 190)
library.companyColor = Color3.fromRGB(163, 151, 255)
library.acientColor = Color3.fromRGB(159, 115, 255)

library:Init({
	version = "1.0",
	title = "",
	company = "",
	keybind = Enum.KeyCode.LeftAlt,
	BlurEffect = true,
})

library:Watermark("RobertHook")

local FPSWatermark = library:Watermark("0 fps")
local PingWatermark = library:Watermark("0 ms")

task.spawn(function()
	while task.wait(0.5) do
		local fps = math.round(1 / game:GetService("RunService").RenderStepped:Wait())
		local ping = math.round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
		FPSWatermark:SetText(fps .. " fps")
		PingWatermark:SetText(ping .. " ms")
	end
end)

library:BeginIntroduction()
library:AddIntroductionMessage("Robertwalking...")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Getting slammed...")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Taking the bomb at 3....")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Hooking functions...")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Tickling the CPU...")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Skidding with CGB....")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Guzzling a Bob.....")
task.wait(math.random(10, 100) / 100)
library:AddIntroductionMessage("Done!")
task.wait(math.random(10, 100) / 100)
library:EndIntroduction()

local MovementTab = library:NewTab("Movement")
local VisualsTab = library:NewTab("Visuals")

-- Create Config tab last so tab order is: Movement, Visuals, Config
local ConfigTab = library:NewTab("Config")

-- Blur Effect toggle in Config (uses library:SetBlurEffect)
ConfigTab:NewToggle("Blur Effect", library.BlurEnabled or false, function(val)
	if library.SetBlurEffect then
		library:SetBlurEffect(val)
	end
end)

-- Menu Name textbox (binds to CompanyText/menu typing animation)
ConfigTab:NewTextbox("Menu Name", CompanyText or "RobertHook", "", "small", true, false, function(val)
	if val and val ~= "" then
		CompanyText = val
		if library.SetCompany then
			library:SetCompany(CompanyText)
		end
	end
end)

-- Single Menu Key keybind (no duplicate label)
ConfigTab:NewKeybind("Menu Key", library.Key, function(keyName)
	if not keyName then
		return
	end
	pcall(function()
		local newKey = Enum.KeyCode[keyName]
		if newKey then
			library.Key = newKey
		end
	end)
end)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- FOV variables (declared early so UI elements can reference them)
local FOVEnabled = false
local DefaultFOV = 70
local CurrentFOV = DefaultFOV
local FOVConnection = nil
local MenuOpen = false

-- Company text for the menu typing animation (configurable in Config tab)
local CompanyText = "RobertHook"
local TypeSpeed = 0.1

local RobertWalkEnabled = false
local ShowIndicator = true
local RobertWalkIndicatorLabel = nil
local IndicatorPosition = "Center"

local function SetLabelPosition(label)
	if IndicatorPosition == "Center" then
		label.Position = UDim2.new(0.5, 0, 0.5, 20)
	elseif IndicatorPosition == "Bottom" then
		label.Position = UDim2.new(0.5, 0, 1, -40)
	elseif IndicatorPosition == "Top" then
		label.Position = UDim2.new(0.5, 0, 0, 40)
	end
end

local function UpdateRobertWalkIndicator()
	if RobertWalkEnabled and ShowIndicator and not RobertWalkIndicatorLabel then
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "RobertWalkDisplay"
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 999
		screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

		local label = Instance.new("TextLabel")
		label.Name = "RobertWalkLabel"
		label.Size = UDim2.new(0, 200, 0, 30)
		label.AnchorPoint = Vector2.new(0.5, 0.5)
		label.BackgroundTransparency = 1
		label.Text = "robertwalk"
		label.TextColor3 = Color3.fromRGB(163, 151, 255)
		label.TextScaled = false
		label.TextSize = 16
		label.Font = Enum.Font.Gotham
		label.Parent = screenGui

		SetLabelPosition(label)

		RobertWalkIndicatorLabel = screenGui
	elseif not RobertWalkEnabled and RobertWalkIndicatorLabel then
		RobertWalkIndicatorLabel:Destroy()
		RobertWalkIndicatorLabel = nil
	end
end

RunService.RenderStepped:Connect(function()
	UpdateRobertWalkIndicator()
end)

local function HasBomb(player)
	if not player or not player.Character then
		return false
	end
	return player.Character:FindFirstChild("Bomb") ~= nil
end

local function IsTeammate(player)
	if player == LocalPlayer then
		return true
	end
	if not player or not player.Character then
		return false
	end
	return player.Character:FindFirstChild("TeamHighlight") ~= nil
end

local function GetNearestTarget()
	local nearestDistance = math.huge
	local nearestPlayer = nil

	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end

	local myPosition = LocalPlayer.Character.HumanoidRootPart.Position

	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if player ~= LocalPlayer and not IsTeammate(player) and not HasBomb(player) then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local distance = (player.Character.HumanoidRootPart.Position - myPosition).Magnitude
				if distance < nearestDistance then
					nearestDistance = distance
					nearestPlayer = player
				end
			end
		end
	end

	return nearestPlayer
end

local SpeedMultiplier = 1
local RobertWalkConnection

local function UpdateRobertWalk()
	if not RobertWalkEnabled then
		return
	end

	local character = LocalPlayer.Character
	if not character then
		return
	end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end

	local humanoid = character:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end

	local moveDirection = humanoid.MoveDirection
	if moveDirection.Magnitude > 0 then
		humanoidRootPart.CFrame = humanoidRootPart.CFrame + (moveDirection * (0.01 * SpeedMultiplier))
	end
end

local _RobertWalkToggle = MovementTab:NewToggle("RobertWalk", false, function(val)
	RobertWalkEnabled = val
	if RobertWalkEnabled then
		RobertWalkConnection = RunService.Heartbeat:Connect(UpdateRobertWalk)
	else
		if RobertWalkConnection then
			RobertWalkConnection:Disconnect()
			RobertWalkConnection = nil
		end
	end
	UpdateRobertWalkIndicator()
end)

MovementTab:NewSlider("Speed", "", false, "", { min = 1, max = 100, default = 1 }, function(val)
	SpeedMultiplier = val
end)

MovementTab:NewToggle("Indicator", true, function(val)
	ShowIndicator = val
	if not val and RobertWalkIndicatorLabel then
		RobertWalkIndicatorLabel:Destroy()
		RobertWalkIndicatorLabel = nil
	end
	if val then
		UpdateRobertWalkIndicator()
	end
end)

MovementTab:NewSelector("Position", "Center", { "Center", "Bottom", "Top" }, function(val)
	IndicatorPosition = val
	if RobertWalkIndicatorLabel then
		local screenGui = RobertWalkIndicatorLabel
		local label = screenGui:FindFirstChild("RobertWalkLabel")
		if label then
			SetLabelPosition(label)
		end
	end
end)

local NoExplosionEnabled = false
local NoExplosionConnection

local function HandleExplosion(instance)
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

local NoExplosionToggle = VisualsTab:NewToggle("No Explosion", false, function(value)
	NoExplosionEnabled = value
	if NoExplosionEnabled then
		NoExplosionConnection = workspace.DescendantAdded:Connect(HandleExplosion)
		for _, instance in ipairs(workspace:GetDescendants()) do
			HandleExplosion(instance)
		end
	else
		if NoExplosionConnection then
			NoExplosionConnection:Disconnect()
			NoExplosionConnection = nil
		end
	end
end)

local NoFireEnabled = false
local NoFireConnection

local function HandleFire(instance)
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

local NoFireToggle = VisualsTab:NewToggle("No Fire", false, function(value)
	NoFireEnabled = value
	if NoFireEnabled then
		NoFireConnection = workspace.DescendantAdded:Connect(HandleFire)
		for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
			if player.Character then
				local bomb = player.Character:FindFirstChild("Bomb")
				if bomb then
					for _, instance in ipairs(bomb:GetDescendants()) do
						HandleFire(instance)
					end
				end
			end
		end
	else
		if NoFireConnection then
			NoFireConnection:Disconnect()
			NoFireConnection = nil
		end
	end
end)

local RobertRotationEnabled = false
local RobertRotationConnection

local function UpdateRotation()
	if not RobertRotationEnabled then
		return
	end
	if not LocalPlayer.Character or not HasBomb(LocalPlayer) then
		return
	end

	local target = GetNearestTarget()
	if not target then
		return
	end

	local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")

	if myRoot and targetRoot then
		local direction = (targetRoot.Position - myRoot.Position).Unit
		myRoot.CFrame = CFrame.lookAt(myRoot.Position, myRoot.Position + Vector3.new(direction.X, 0, direction.Z))
	end
end

local _RobertRotationToggle = VisualsTab:NewToggle("Robert Rotation", false, function(val)
	RobertRotationEnabled = val
	if RobertRotationEnabled then
		RobertRotationConnection = RunService.Heartbeat:Connect(UpdateRotation)
	else
		if RobertRotationConnection then
			RobertRotationConnection:Disconnect()
			RobertRotationConnection = nil
		end
	end
end):AddKeybind(Enum.KeyCode.Unknown)

local RobertBombEnabled = false
local RobertBombConnection

local function UpdateBombMesh(tool)
	if not tool:IsA("Tool") or tool.Name ~= "Bomb" then
		return
	end
	local mesh = tool:FindFirstChild("Mesh", true)
	if mesh and mesh:IsA("SpecialMesh") then
		mesh.MeshId = "rbxassetid://18699629990"
		mesh.TextureId = "rbxassetid://18699630736"
	end
end

local function ScanForBombs()
	if not RobertBombEnabled then
		return
	end
	for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
		if player.Character then
			local bomb = player.Character:FindFirstChild("Bomb")
			if bomb then
				UpdateBombMesh(bomb)
			end
		end
	end
end

local _RobertBombToggle = VisualsTab:NewToggle("Robert Bomb", false, function(val)
	RobertBombEnabled = val
	if RobertBombEnabled then
		ScanForBombs()
		RobertBombConnection = workspace.DescendantAdded:Connect(function(instance)
			if instance.Name == "Bomb" and instance:IsA("Tool") then
				task.wait()
				UpdateBombMesh(instance)
			end
		end)
	else
		if RobertBombConnection then
			RobertBombConnection:Disconnect()
			RobertBombConnection = nil
		end
	end
end):AddKeybind(Enum.KeyCode.Unknown)

local FOVEnabled = false
local DefaultFOV = 70
local CurrentFOV = DefaultFOV
local FOVConnection
local MenuOpen = false

local oldShowUI = library.ShowUI
library.ShowUI = function(self, visible)
	MenuOpen = visible
	return oldShowUI(self, visible)
end

local function UpdateFOV()
	if not LocalPlayer.Character then
		return
	end
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end
	if FOVEnabled and not MenuOpen then
		camera.FieldOfView = CurrentFOV
	else
		camera.FieldOfView = DefaultFOV
	end
end

local _FOVToggle = VisualsTab:NewToggle("FOV", false, function(val)
	FOVEnabled = val
	if FOVEnabled then
		FOVConnection = RunService.RenderStepped:Connect(UpdateFOV)
	else
		if FOVConnection then
			FOVConnection:Disconnect()
			FOVConnection = nil
		end
		if workspace.CurrentCamera then
			workspace.CurrentCamera.FieldOfView = DefaultFOV
		end
	end
end)

VisualsTab:NewSlider("FOV Value", "", false, "", { min = 70, max = 130, default = 70 }, function(val)
	CurrentFOV = val
	if FOVEnabled and not MenuOpen and workspace.CurrentCamera then
		workspace.CurrentCamera.FieldOfView = val
	end
end)

-- No Ragdoll toggle implementation
local NoRagdollEnabled = false
local NoRagdollRunning = false

local function ScanAndRemoveRagdolls()
	if NoRagdollRunning then
		return
	end
	NoRagdollRunning = true
	task.spawn(function()
		while NoRagdollEnabled do
			local charactersFolder = workspace:FindFirstChild("Characters")
			if charactersFolder then
				for _, char in ipairs(charactersFolder:GetChildren()) do
					if char and char:IsA("Model") then
						local humanoid = char:FindFirstChildWhichIsA("Humanoid")
						if humanoid and humanoid.Health and humanoid.Health <= 0 then
							task.defer(function()
								if char and char.Parent then
									char:Destroy()
								end
							end)
						end
					end
				end
			end
			task.wait(0.2)
		end
		NoRagdollRunning = false
	end)
end

VisualsTab:NewToggle("No Ragdoll", false, function(val)
	NoRagdollEnabled = val
	if NoRagdollEnabled then
		ScanAndRemoveRagdolls()
	else
		-- toggled off, loop will exit naturally
	end
end)

-- Place FOV toggle and slider after all other Visuals toggles per user request
local _FOVToggle = VisualsTab:NewToggle("FOV", false, function(val)
	FOVEnabled = val
	if FOVEnabled then
		if FOVConnection then
			FOVConnection:Disconnect()
			FOVConnection = nil
		end
		FOVConnection = RunService.RenderStepped:Connect(UpdateFOV)
	else
		if FOVConnection then
			FOVConnection:Disconnect()
			FOVConnection = nil
		end
		if workspace.CurrentCamera then
			workspace.CurrentCamera.FieldOfView = DefaultFOV
		end
	end
end)

VisualsTab:NewSlider("FOV Value", "", false, "", { min = 70, max = 130, default = 70 }, function(val)
	CurrentFOV = val
	if FOVEnabled and not MenuOpen and workspace.CurrentCamera then
		workspace.CurrentCamera.FieldOfView = val
	end
end)

-- Company typing animation (uses CompanyText defined earlier)
local TypeSpeed = 0.1
task.spawn(function()
	while task.wait() do
		for i = 1, #CompanyText do
			library:SetCompany(CompanyText:sub(1, i))
			task.wait(TypeSpeed)
		end
		task.wait(1)
		for i = #CompanyText, 1, -1 do
			library:SetCompany(CompanyText:sub(1, i))
			task.wait(TypeSpeed)
		end
		task.wait(0.5)
	end
end)
