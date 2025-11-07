local library =
	loadstring(game:HttpGet("https://raw.githubusercontent.com/YaBoiBrody/roberthookdeluxe/refs/heads/main/lib.lua"))()

library.headerColor = Color3.fromRGB(51, 158, 190)
library.companyColor = Color3.fromRGB(163, 151, 255)
library.acientColor = Color3.fromRGB(159, 115, 255)

local MenuVersion = "1.2"

library:Init({
	version = MenuVersion,
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

local CompanyText = "RobertHook"
local TypeSpeed = 0.1

local DefaultFOV = 70
local CurrentFOV = DefaultFOV
local FOVEnabled = false
local FOVConnection = nil
local MenuOpen = false
local MenuFOVEnabled = true 
local _FOVOverrideConnection = nil

local ConfigTab = library:NewTab("Config")

ConfigTab:NewToggle("Blur Effect", (library.BlurEnabled == nil) and true or library.BlurEnabled, function(val)
	if library.SetBlurEffect then
		library:SetBlurEffect(val)
	end

	MenuFOVEnabled = val

	if not val and workspace and workspace.CurrentCamera then
		if FOVEnabled then
			workspace.CurrentCamera.FieldOfView = CurrentFOV
		else
			workspace.CurrentCamera.FieldOfView = DefaultFOV
		end
	end
end)

ConfigTab:NewTextbox("Menu Name", CompanyText, "", "small", true, false, function(val)
	if val and val ~= "" then
		CompanyText = val
		if library.SetCompany then
			library:SetCompany(CompanyText)
		end
	end
end)

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

local function UpdateServerRegionLabel()
	local ok, err = pcall(function()
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
			for _, v in ipairs(serverRegion:GetDescendants()) do
				if v:IsA("TextLabel") and v.Text:match("Server Region") then
					label = v
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

		local newInner = "RobertHook " .. tostring(MenuVersion or "")

		local replaced, count = label.Text:gsub("(<font.-<stroke.-%>)(.-)(</stroke></font>)", "%1" .. newInner .. "%3")
		if count > 0 then
			label.Text = replaced
			return
		end

		local fallback = label.Text:gsub("%b()", "(" .. newInner .. ")", 1)
		label.Text = fallback
	end)
	if not ok then

	end
end

task.spawn(function()
	for i = 1, 20 do
		UpdateServerRegionLabel()
		task.wait(0.5)
	end
end)
local RobertWalkEnabled = false
local ShowIndicator = false
local RobertWalkIndicatorLabel = nil
local IndicatorPosition = "Center"
local IndicatorOutline = false
local IndicatorSize = 1 
local BaseIndicatorTextSize = 16

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
		label.TextSize = BaseIndicatorTextSize + ((IndicatorSize or 1) - 1)
		label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		label.TextStrokeTransparency = (IndicatorOutline and 0) or 1
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
end):AddKeybind(Enum.KeyCode.Unknown)

MovementTab:NewSlider("Speed", "", false, "", { min = 1, max = 100, default = 1 }, function(val)
	SpeedMultiplier = val
end)

MovementTab:NewToggle("Indicator", false, function(val)
	ShowIndicator = val
	if not val and RobertWalkIndicatorLabel then
		RobertWalkIndicatorLabel:Destroy()
		RobertWalkIndicatorLabel = nil
	end
	if val then
		UpdateRobertWalkIndicator()
	end
end)

MovementTab:NewToggle("Indicator Outline", false, function(val)
	IndicatorOutline = val
	if RobertWalkIndicatorLabel then
		local screenGui = RobertWalkIndicatorLabel
		local label = screenGui:FindFirstChild("RobertWalkLabel")
		if label then
			label.TextStrokeTransparency = (IndicatorOutline and 0) or 1
		end
	end
end)

MovementTab:NewSlider("Indicator Size", "", false, "", { min = 1, max = 10, default = 1 }, function(val)
	IndicatorSize = val
	if RobertWalkIndicatorLabel then
		local screenGui = RobertWalkIndicatorLabel
		local label = screenGui:FindFirstChild("RobertWalkLabel")
		if label then
			label.TextSize = BaseIndicatorTextSize + ((IndicatorSize or 1) - 1)
		end
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

local AutoReadyEnabled = false
local _AutoReadyConn = nil
local _AutoReadyPoll = nil
local function TryFireReady()
	pcall(function()
		local remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
		local arena = remotes:WaitForChild("Arena")
		local readyRemote = arena:WaitForChild("Ready")
		readyRemote:FireServer(true)
	end)
end

local function StartAutoReady()
	if _AutoReadyPoll then
		return
	end
	_AutoReadyPoll = task.spawn(function()
		while AutoReadyEnabled do
			local ok, playerGui = pcall(function()
				return LocalPlayer and LocalPlayer:FindFirstChild("PlayerGui")
			end)
			playerGui = ok and playerGui or nil
			if playerGui then
				local tbd = playerGui:FindFirstChild("TBDUI")
				local main = tbd and tbd:FindFirstChild("Main")
				local prompts = main and main:FindFirstChild("Prompts")
				local readyBtn = prompts and prompts:FindFirstChild("Ready")
				if readyBtn and readyBtn:IsA("TextButton") then

					if not _AutoReadyConn then
						_AutoReadyConn = readyBtn:GetPropertyChangedSignal("Visible"):Connect(function()
							if readyBtn.Visible then
								TryFireReady()
							end
						end)

						if readyBtn.Visible then
							TryFireReady()
						end
					end
				else

					if _AutoReadyConn then
						_AutoReadyConn:Disconnect()
						_AutoReadyConn = nil
					end
				end
			end
			task.wait(0.25)
		end

		if _AutoReadyConn then
			_AutoReadyConn:Disconnect()
			_AutoReadyConn = nil
		end
		_AutoReadyPoll = nil
	end)
end

local function StopAutoReady()
	AutoReadyEnabled = false
	if _AutoReadyConn then
		_AutoReadyConn:Disconnect()
		_AutoReadyConn = nil
	end

end

local _AutoReadyToggle = VisualsTab:NewToggle("Auto Ready", false, function(val)
	AutoReadyEnabled = val
	if AutoReadyEnabled then
		StartAutoReady()
	else
		StopAutoReady()
	end
end)

local RobertRotationEnabled = false
local RobertRotationConnection
local RobertRotationDesired = false 

local function EnsureRobertRotationConnection()
	if RobertRotationDesired then
		if not RobertRotationConnection then
			print("[RobertRotation] establishing connection (desired=true)")
			RobertRotationConnection = RunService.Heartbeat:Connect(function()
				local ok, err = pcall(UpdateRotation)
				if not ok then

					print("[RobertRotation] UpdateRotation error:", err)
				end
			end)
			RobertRotationEnabled = true
		end
	else
		if RobertRotationConnection then
			print("[RobertRotation] tearing down connection (desired=false)")
			RobertRotationConnection:Disconnect()
			RobertRotationConnection = nil
		end
		RobertRotationEnabled = false
	end
end

local function UpdateRotation()
	if not RobertRotationEnabled then
		return
	end
	if not LocalPlayer.Character or not HasBomb(LocalPlayer) then
		return
	end

	local bombTool = LocalPlayer.Character:FindFirstChild("Bomb")
	local bombHandlePart = nil
	if bombTool and bombTool:IsA("Tool") then
		local candidate = bombTool:FindFirstChild("BombHandle") or bombTool:FindFirstChild("Handle")
		if candidate and candidate:IsA("BasePart") then
			bombHandlePart = candidate
		end
	end

	if not bombHandlePart then
		bombHandlePart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not bombHandlePart or not bombHandlePart:IsA("BasePart") then
			return
		end
	end

	local nearestDistance = math.huge
	local nearestPlayer = nil
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and not IsTeammate(player) and not HasBomb(player) then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local targetPos = player.Character.HumanoidRootPart.Position
				local dist = (targetPos - bombHandlePart.Position).Magnitude
				if dist <= 15 and dist < nearestDistance then
					nearestDistance = dist
					nearestPlayer = player
				end
			end
		end
	end
	if not nearestPlayer then
		return
	end

	local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local targetRoot = nearestPlayer.Character:FindFirstChild("HumanoidRootPart")
	if myRoot and targetRoot and bombHandlePart then

		local direction = (targetRoot.Position - bombHandlePart.Position)
		local horizontal = Vector3.new(direction.X, 0, direction.Z)
		local hd = horizontal.Magnitude
		if hd > 0.001 then
			local desiredDir = horizontal.Unit

			local desiredYaw = math.atan2(-desiredDir.X, -desiredDir.Z)
			local look = myRoot.CFrame.LookVector
			local currentYaw = math.atan2(-look.X, -look.Z)
			local delta = desiredYaw - currentYaw

			while delta > math.pi do
				delta = delta - 2 * math.pi
			end
			while delta <= -math.pi do
				delta = delta + 2 * math.pi
			end

			local maxDeg = (hd < 0.6) and 8 or 20 
			local maxStep = math.rad(maxDeg)
			if delta > maxStep then
				delta = maxStep
			elseif delta < -maxStep then
				delta = -maxStep
			end
			local newYaw = currentYaw + delta
			myRoot.CFrame = CFrame.new(myRoot.Position) * CFrame.Angles(0, newYaw, 0)
		end
	end
end

local _RobertRotationToggle = VisualsTab:NewToggle("Robert Rotation", false, function(val)

	RobertRotationDesired = val
	print("[RobertRotation] toggle callback, desired ->", tostring(val))
	EnsureRobertRotationConnection()
end):AddKeybind(Enum.KeyCode.Unknown)

if LocalPlayer then
	LocalPlayer.CharacterAdded:Connect(function()

		task.wait(0.2)
		EnsureRobertRotationConnection()
	end)
	LocalPlayer.CharacterRemoving:Connect(function()

		if RobertRotationConnection then
			RobertRotationConnection:Disconnect()
			RobertRotationConnection = nil
		end
		RobertRotationEnabled = false
	end)
end

task.spawn(function()
	while true do
		EnsureRobertRotationConnection()
		task.wait(1)
	end
end)

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
end)

local oldShowUI = library.ShowUI
library.ShowUI = function(self, visible)
	local result = oldShowUI(self, visible)
	MenuOpen = visible

	if workspace and workspace.CurrentCamera then
		if not (library.BlurEnabled and MenuFOVEnabled) then
			if _FOVOverrideConnection then
				_FOVOverrideConnection:Disconnect()
				_FOVOverrideConnection = nil
			end

			if FOVEnabled then
				workspace.CurrentCamera.FieldOfView = CurrentFOV
			else
				workspace.CurrentCamera.FieldOfView = DefaultFOV
			end

			_FOVOverrideConnection = RunService.RenderStepped:Connect(function()
				if workspace and workspace.CurrentCamera then
					if FOVEnabled then
						workspace.CurrentCamera.FieldOfView = CurrentFOV
					else
						workspace.CurrentCamera.FieldOfView = DefaultFOV
					end
				end
			end)
			task.delay(0.25, function()
				if _FOVOverrideConnection then
					_FOVOverrideConnection:Disconnect()
					_FOVOverrideConnection = nil
				end
			end)
		end
	end
	return result
end

local function UpdateFOV()
	if not LocalPlayer.Character then
		return
	end
	local camera = workspace.CurrentCamera
	if not camera then
		return
	end

	if FOVEnabled then
		if (not MenuOpen) or not (library.BlurEnabled and MenuFOVEnabled) then
			camera.FieldOfView = CurrentFOV
		else
			camera.FieldOfView = DefaultFOV
		end
	else
		camera.FieldOfView = DefaultFOV
	end
end

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
		if workspace and workspace.CurrentCamera then
			workspace.CurrentCamera.FieldOfView = DefaultFOV
		end
	end
end)

VisualsTab:NewSlider("FOV Value", "", false, "", { min = 70, max = 130, default = 70 }, function(val)
	CurrentFOV = val
	if FOVEnabled and workspace and workspace.CurrentCamera then

		if (not MenuOpen) or not (library.BlurEnabled and MenuFOVEnabled) then
			workspace.CurrentCamera.FieldOfView = val
		end
	end
end)

task.spawn(function()
	while true do
		local len = #CompanyText

		for i = 1, len do
			library:SetCompany(CompanyText:sub(1, i))
			task.wait(TypeSpeed)
		end
		task.wait(1)

		for i = len, 0, -1 do
			if i == 0 then
				library:SetCompany("")
			else
				library:SetCompany(CompanyText:sub(1, i))
			end
			task.wait(TypeSpeed)
		end
		task.wait(0.5)
	end
end)
