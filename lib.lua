--[[
  Forked UI from bungie#0001
  Edited by Depso

  I edited this a while ago, the code may not meet my standards xD

  This is also no longer speific to Synapse-X
]]

local CloneRef = cloneref or function(a)
	return a
end

--// Service handlers
local Services = setmetatable({}, {
	__index = function(self, Name: string)
		local Service = game:GetService(Name)
		return CloneRef(Service)
	end,
})

-- / Locals
local Player = Services.Players.LocalPlayer
local Mouse = CloneRef(Player:GetMouse())

-- / Services
local UserInputService = Services.UserInputService
local TextService = Services.TextService
local TweenService = Services.TweenService
local RunService = Services.RunService
local CoreGui = RunService:IsStudio() and CloneRef(Player:WaitForChild("PlayerGui")) or Services.CoreGui
local TeleportService = Services.TeleportService
local Workspace = Services.Workspace
local CurrentCam = Workspace.CurrentCamera

local hiddenUI = get_hidden_gui or gethui or function(a)
	return CoreGui
end

-- / Defaults
local OptionStates = {} -- Used for panic
local library = {
	title = "Bozo depso",
	company = "Company",

	RainbowEnabled = true,
	BlurEffect = true,
	BlurSize = 24,
	FieldOfView = CurrentCam.FieldOfView,

	Key = UserInputService.TouchEnabled and Enum.KeyCode.P or Enum.KeyCode.LeftAlt,
	fps = 0,
	Debug = true,

	-- / Elements Config
	transparency = 0,
	backgroundColor = Color3.fromRGB(31, 31, 31),
	headerColor = Color3.fromRGB(255, 255, 255),
	companyColor = Color3.fromRGB(163, 151, 255),
	acientColor = Color3.fromRGB(167, 154, 121),
	darkGray = Color3.fromRGB(27, 27, 27),
	lightGray = Color3.fromRGB(48, 48, 48),

	Font = Enum.Font.Code,

	rainbowColors = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(241, 137, 53)),
		ColorSequenceKeypoint.new(0.33, Color3.fromRGB(241, 53, 106)),
		ColorSequenceKeypoint.new(0.66, Color3.fromRGB(133, 53, 241)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(53, 186, 241)),
	}),
}

local function Warn(...)
	if not library.Debug then
		return
	end
	warn("Depso:", ...)
end

-- / Remove the previous interface
if _G.DepsoGUI then
	pcall(function()
		_G.DepsoGUI:Remove()
	end)
end
_G.DepsoGUI = library

-- / Blur effect
local Blur = Instance.new("BlurEffect", CurrentCam)
Blur.Enabled = true
Blur.Size = 0

-- / Tween table & function
local TweenWrapper = {}

function TweenWrapper:Init()
	self.RealStyles = {
		Default = {
			TweenInfo.new(0.17, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0),
		},
	}
	self.Styles = setmetatable({}, {
		__index = function(_, Key)
			local Value = self.RealStyles[Key]
			if not Value then
				Warn(`No Tween style for {Key}, returning default`)
				return self.RealStyles.Default
			end
			return Value
		end,
	})
end

function TweenWrapper:CreateStyle(name, speed, ...)
	if not name then
		return TweenInfo.new(0)
	end

	local Tweeninfo = TweenInfo.new(speed or 0.17, ...)

	self.RealStyles[name] = Tweeninfo
	return Tweeninfo
end

TweenWrapper:Init()

-- / Dragging
local function EnableDrag(obj, latency)
	if not obj then
		return
	end
	latency = latency or 0.06

	local toggled = nil
	local input = nil
	local start = nil
	local startPos = obj.Position

	local function InputIsAccepted(Input)
		local UserInputType = Input.UserInputType

		if UserInputType == Enum.UserInputType.Touch then
			return true
		end
		if UserInputType == Enum.UserInputType.MouseButton1 then
			return true
		end

		return false
	end

	obj.InputBegan:Connect(function(Input)
		if not InputIsAccepted(Input) then
			return
		end

		toggled = true
		start = Input.Position
		startPos = obj.Position

		Input.Changed:Connect(function()
			if Input.UserInputState == Enum.UserInputState.End then
				toggled = false
			end
		end)
	end)

	obj.InputChanged:Connect(function(Input)
		local MouseMovement = Input.UserInputType == Enum.UserInputType.MouseMovement
		if not MouseMovement and not InputIsAccepted(Input) then
			return
		end

		input = Input
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == input and toggled then
			local Delta = input.Position - start
			local Position =
				UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			TweenService:Create(obj, TweenInfo.new(latency), { Position = Position }):Play()
		end
	end)
end

RunService.RenderStepped:Connect(function(v)
	library.fps = math.round(1 / v)
end)

function library:RoundNumber(int, float)
	return tonumber(string.format("%." .. (int or 0) .. "f", float))
end

function library:GetUsername()
	return Player.Name
end

function library:Panic()
	for Frame, Data in next, OptionStates do
		local Functions = Data[2]
		local State = Data[1]

		Functions:Set(State)
	end
	return self
end

function library:SetKeybind(new)
	library.Key = new
	return self
end

function library:IsGameLoaded()
	return game:IsLoaded()
end

function library:GetUserId()
	return Player.UserId
end

function library:GetPlaceId()
	return game.PlaceId
end

function library:GetJobId()
	return game.JobId
end

function library:Rejoin()
	TeleportService:TeleportToPlaceInstance(library:GetPlaceId(), library:GetJobId(), library:GetUserId())
end

function library:Copy(input)
	local clipBoard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
	if clipBoard then
		clipBoard(input)
	end
end

function library:GetDay(type)
	if type == "word" then -- day in a full word
		return os.date("%A")
	elseif type == "short" then -- day in a shortened word
		return os.date("%a")
	elseif type == "month" then -- day of the month in digits
		return os.date("%d")
	elseif type == "year" then -- day of the year in digits
		return os.date("%j")
	end
end

function library:GetTime(type)
	if type == "24h" then -- time using a 24 hour clock
		return os.date("%H")
	elseif type == "12h" then -- time using a 12 hour clock
		return os.date("%I")
	elseif type == "minute" then -- time in minutes
		return os.date("%M")
	elseif type == "half" then -- what part of the day it is (AM or PM)
		return os.date("%p")
	elseif type == "second" then -- time in seconds
		return os.date("%S")
	elseif type == "full" then -- full time
		return os.date("%X")
	elseif type == "ISO" then -- ISO / UTC ( 1min = 1, 1hour = 100)
		return os.date("%z")
	elseif type == "zone" then -- time zone
		return os.date("%Z")
	end
end

function library:GetMonth(type)
	if type == "word" then -- full month name
		return os.date("%B")
	elseif type == "short" then -- month in shortened word
		return os.date("%b")
	elseif type == "digit" then -- the months digit
		return os.date("%m")
	end
end

function library:GetWeek(type)
	if type == "year_S" then -- the number of the week in the current year (sunday first day)
		return os.date("%U")
	elseif type == "day" then -- the week day
		return os.date("%w")
	elseif type == "year_M" then -- the number of the week in the current year (monday first day)
		return os.date("%W")
	end
end

function library:GetYear(type)
	if type == "digits" then -- the second 2 digits of the year
		return os.date("%y")
	elseif type == "full" then -- the full year
		return os.date("%Y")
	end
end

function library:UnlockFps(new)
	if setfpscap then
		setfpscap(new)
	end
end

TweenWrapper:CreateStyle("Rainbow", 5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)
function library:ApplyRainbow(instance, Wave)
	local Colors = library.rainbowColors
	local RainbowEnabled = library.RainbowEnabled

	if not RainbowEnabled then
		return
	end

	if not Wave then
		instance.BackgroundColor3 = Colors.Keypoints[1].Value
		TweenService:Create(instance, TweenWrapper.Styles["Rainbow"], {
			BackgroundColor3 = Colors.Keypoints[#Colors.Keypoints].Value,
		}):Play()

		return
	end

	local gradient = Instance.new("UIGradient", instance)
	gradient.Offset = Vector2.new(-0.8, 0)
	gradient.Color = Colors

	TweenService:Create(gradient, TweenWrapper.Styles["Rainbow"], {
		Offset = Vector2.new(0.8, 0),
	}):Play()
end

--/ Watermark library
TweenWrapper:CreateStyle("wm", 0.24)
TweenWrapper:CreateStyle("wm_2", 0.04)

function library:Init(Config)
	--/ Apply new config
	for Key, Value in next, Config do
		library[Key] = Value
	end

	local watermark = Instance.new("ScreenGui", CoreGui)
	watermark.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local watermarkPadding = Instance.new("UIPadding")
	watermarkPadding.Parent = watermark
	watermarkPadding.PaddingTop = UDim.new(0, 6)
	watermarkPadding.PaddingLeft = UDim.new(0, 6)

	local watermarkLayout = Instance.new("UIListLayout")
	watermarkLayout.Parent = watermark
	watermarkLayout.FillDirection = Enum.FillDirection.Horizontal
	watermarkLayout.SortOrder = Enum.SortOrder.LayoutOrder
	watermarkLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	watermarkLayout.Padding = UDim.new(0, 4)

	function library:Watermark(text)
		local edge = Instance.new("Frame")
		local edgeCorner = Instance.new("UICorner")
		local background = Instance.new("Frame")
		local barFolder = Instance.new("Folder")
		local bar = Instance.new("Frame")
		local barCorner = Instance.new("UICorner")
		local barLayout = Instance.new("UIListLayout")
		local backgroundGradient = Instance.new("UIGradient")
		local backgroundCorner = Instance.new("UICorner")
		local waterText = Instance.new("TextLabel")
		local waterPadding = Instance.new("UIPadding")
		local backgroundLayout = Instance.new("UIListLayout")

		edge.Parent = watermark
		edge.AnchorPoint = Vector2.new(0.5, 0.5)
		edge.BackgroundColor3 = library.backgroundColor
		edge.Position = UDim2.new(0.5, 0, -0.03, 0)
		edge.Size = UDim2.new(0, 0, 0, 26)
		edge.BackgroundTransparency = 1

		edgeCorner.CornerRadius = UDim.new(0, 2)
		edgeCorner.Parent = edge

		background.Parent = edge
		background.AnchorPoint = Vector2.new(0.5, 0.5)
		background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		background.BackgroundTransparency = 1
		background.ClipsDescendants = true
		background.Position = UDim2.new(0.5, 0, 0.5, 0)
		background.Size = UDim2.new(0, 0, 0, 24)

		barFolder.Parent = background

		bar.Parent = barFolder
		bar.BackgroundColor3 = library.acientColor
		bar.BackgroundTransparency = 0
		bar.Size = UDim2.new(0, 0, 0, 2)

		self:ApplyRainbow(bar, false)

		barCorner.CornerRadius = UDim.new(0, 2)
		barCorner.Parent = bar

		barLayout.Parent = barFolder
		barLayout.SortOrder = Enum.SortOrder.LayoutOrder

		backgroundGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28)),
		})
		backgroundGradient.Rotation = 90
		backgroundGradient.Parent = background

		backgroundCorner.CornerRadius = UDim.new(0, 2)
		backgroundCorner.Parent = background

		waterText.Parent = background
		waterText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		waterText.BackgroundTransparency = 1.000
		waterText.Position = UDim2.new(0, 0, -0.0416666679, 0)
		waterText.Size = UDim2.new(0, 0, 0, 24)
		waterText.Font = library.Font
		waterText.Text = text
		waterText.TextColor3 = Color3.fromRGB(198, 198, 198)
		waterText.TextTransparency = 1
		waterText.TextSize = 14.000
		waterText.RichText = true

		local NewSize = TextService:GetTextSize(
			waterText.Text,
			waterText.TextSize,
			waterText.Font,
			Vector2.new(math.huge, math.huge)
		)
		waterText.Size = UDim2.new(0, NewSize.X + 8, 0, 24)

		waterPadding.Parent = waterText
		waterPadding.PaddingBottom = UDim.new(0, 4)
		waterPadding.PaddingLeft = UDim.new(0, 4)
		waterPadding.PaddingRight = UDim.new(0, 4)
		waterPadding.PaddingTop = UDim.new(0, 4)

		backgroundLayout.Parent = background
		backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
		backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center

		coroutine.wrap(function()
			TweenService:Create(edge, TweenWrapper.Styles["wm"], { BackgroundTransparency = 0 }):Play()
			TweenService:Create(edge, TweenWrapper.Styles["wm"], { Size = UDim2.new(0, NewSize.x + 10, 0, 26) }):Play()
			TweenService:Create(background, TweenWrapper.Styles["wm"], { BackgroundTransparency = 0 }):Play()
			TweenService:Create(background, TweenWrapper.Styles["wm"], { Size = UDim2.new(0, NewSize.x + 8, 0, 24) })
				:Play()
			wait(0.2)
			TweenService:Create(bar, TweenWrapper.Styles["wm"], { Size = UDim2.new(0, NewSize.x + 8, 0, 1) }):Play()
			wait(0.1)
			TweenService:Create(waterText, TweenWrapper.Styles["wm"], { TextTransparency = 0 }):Play()
		end)()

		local WatermarkFunctions = {}

		function WatermarkFunctions:Hide()
			edge.Visible = false
			return self
		end

		function WatermarkFunctions:Show()
			edge.Visible = true
			return self
		end

		function WatermarkFunctions:SetText(new)
			new = new or text
			waterText.Text = new

			local NewSize = TextService:GetTextSize(
				waterText.Text,
				waterText.TextSize,
				waterText.Font,
				Vector2.new(math.huge, math.huge)
			)
			coroutine.wrap(function()
				TweenService:Create(edge, TweenWrapper.Styles["wm_2"], { Size = UDim2.new(0, NewSize.x + 10, 0, 26) })
					:Play()
				TweenService
					:Create(background, TweenWrapper.Styles["wm_2"], { Size = UDim2.new(0, NewSize.x + 8, 0, 24) })
					:Play()
				TweenService:Create(bar, TweenWrapper.Styles["wm_2"], { Size = UDim2.new(0, NewSize.x + 8, 0, 1) })
					:Play()
				TweenService
					:Create(waterText, TweenWrapper.Styles["wm_2"], { Size = UDim2.new(0, NewSize.x + 8, 0, 1) })
					:Play()
			end)()

			return self
		end

		function WatermarkFunctions:Remove()
			watermark:Destroy()
			return self
		end
		return WatermarkFunctions
	end

	-- InitNotifications

	local Notification = {}
	local Notifications = Instance.new("ScreenGui", hiddenUI())
	local notificationsLayout = Instance.new("UIListLayout", Notifications)
	local notificationsPadding = Instance.new("UIPadding", Notifications)

	Notifications.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	notificationsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	notificationsLayout.Padding = UDim.new(0, 4)

	notificationsPadding.PaddingLeft = UDim.new(0, 6)
	notificationsPadding.PaddingTop = UDim.new(0, 18)

	function library:Notify(text, duration, type, callback)
		TweenWrapper:CreateStyle("notification_load", 0.2)

		text = tostring(text)
		duration = duration or 5
		type = type or "notification"
		callback = callback or function() end

		local edge = Instance.new("Frame", Notifications)
		local edgeCorner = Instance.new("UICorner")
		local background = Instance.new("Frame")
		local barFolder = Instance.new("Folder")
		local bar = Instance.new("Frame")
		local barCorner = Instance.new("UICorner")
		local barLayout = Instance.new("UIListLayout")
		local backgroundGradient = Instance.new("UIGradient")
		local backgroundCorner = Instance.new("UICorner")
		local notifText = Instance.new("TextLabel")
		local notifPadding = Instance.new("UIPadding")
		local backgroundLayout = Instance.new("UIListLayout")

		edge.BackgroundColor3 = library.backgroundColor
		edge.BackgroundTransparency = 1.000
		edge.Size = UDim2.new(0, 0, 0, 26)

		edgeCorner.CornerRadius = UDim.new(0, 2)
		edgeCorner.Parent = edge

		background.Parent = edge
		background.AnchorPoint = Vector2.new(0.5, 0.5)
		background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		background.BackgroundTransparency = 1.000
		background.ClipsDescendants = true
		background.Position = UDim2.new(0.5, 0, 0.5, 0)
		background.Size = UDim2.new(0, 0, 0, 24)

		barFolder.Parent = background

		bar.Parent = barFolder
		bar.BackgroundColor3 = library.acientColor
		bar.BackgroundTransparency = 0.200
		bar.Size = UDim2.new(0, 0, 0, 1)

		if type == "alert" then
			bar.BackgroundColor3 = Color3.fromRGB(255, 246, 112)
		elseif type == "error" then
			bar.BackgroundColor3 = Color3.fromRGB(255, 74, 77)
		elseif type == "success" then
			bar.BackgroundColor3 = Color3.fromRGB(131, 255, 103)
		else
			library:ApplyRainbow(bar, false)
		end

		barCorner.CornerRadius = UDim.new(0, 2)
		barCorner.Parent = bar

		barLayout.Parent = barFolder
		barLayout.SortOrder = Enum.SortOrder.LayoutOrder

		backgroundGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28)),
		})
		backgroundGradient.Rotation = 90
		backgroundGradient.Parent = background

		backgroundCorner.CornerRadius = UDim.new(0, 2)
		backgroundCorner.Parent = background

		notifText.Parent = background
		notifText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		notifText.BackgroundTransparency = 1.000
		notifText.Size = UDim2.new(0, 230, 0, 26)
		notifText.Font = library.Font
		notifText.Text = text
		notifText.TextColor3 = Color3.fromRGB(198, 198, 198)
		notifText.TextSize = 14.000
		notifText.TextTransparency = 1.000
		notifText.TextXAlignment = Enum.TextXAlignment.Left
		notifText.RichText = true

		notifPadding.Parent = notifText
		notifPadding.PaddingBottom = UDim.new(0, 4)
		notifPadding.PaddingLeft = UDim.new(0, 4)
		notifPadding.PaddingRight = UDim.new(0, 4)
		notifPadding.PaddingTop = UDim.new(0, 4)

		backgroundLayout.Parent = background
		backgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
		backgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center

		local NewSize = TextService:GetTextSize(
			notifText.Text,
			notifText.TextSize,
			notifText.Font,
			Vector2.new(math.huge, math.huge)
		)
		TweenWrapper:CreateStyle("notification_wait", duration, Enum.EasingStyle.Quad)
		local IsRunning = false
		coroutine.wrap(function()
			IsRunning = true
			TweenService:Create(edge, TweenWrapper.Styles["notification_load"], { BackgroundTransparency = 0 }):Play()
			TweenService:Create(background, TweenWrapper.Styles["notification_load"], { BackgroundTransparency = 0 })
				:Play()
			TweenService:Create(notifText, TweenWrapper.Styles["notification_load"], { TextTransparency = 0 }):Play()
			TweenService
				:Create(edge, TweenWrapper.Styles["notification_load"], { Size = UDim2.new(0, NewSize.X + 10, 0, 26) })
				:Play()
			TweenService
				:Create(
					background,
					TweenWrapper.Styles["notification_load"],
					{ Size = UDim2.new(0, NewSize.X + 8, 0, 24) }
				)
				:Play()
			TweenService
				:Create(
					notifText,
					TweenWrapper.Styles["notification_load"],
					{ Size = UDim2.new(0, NewSize.X + 8, 0, 24) }
				)
				:Play()
			wait()
			local Tween = TweenService:Create(
				bar,
				TweenWrapper.Styles["notification_wait"],
				{ Size = UDim2.new(0, NewSize.X + 8, 0, 1) }
			)
			Tween:Play()
			Tween.Completed:Wait()
			IsRunning = false
			TweenService:Create(edge, TweenWrapper.Styles["notification_load"], { BackgroundTransparency = 1 }):Play()
			TweenService:Create(background, TweenWrapper.Styles["notification_load"], { BackgroundTransparency = 1 })
				:Play()
			TweenService:Create(notifText, TweenWrapper.Styles["notification_load"], { TextTransparency = 1 }):Play()
			TweenService:Create(bar, TweenWrapper.Styles["notification_load"], { BackgroundTransparency = 1 }):Play()
			TweenService:Create(edge, TweenWrapper.Styles["notification_load"], { Size = UDim2.new(0, 0, 0, 26) })
				:Play()
			TweenService:Create(background, TweenWrapper.Styles["notification_load"], { Size = UDim2.new(0, 0, 0, 24) })
				:Play()
			TweenService:Create(notifText, TweenWrapper.Styles["notification_load"], { Size = UDim2.new(0, 0, 0, 24) })
				:Play()
			TweenService:Create(bar, TweenWrapper.Styles["notification_load"], { Size = UDim2.new(0, 0, 0, 1) }):Play()
			wait(0.2)
			edge:Destroy()
		end)()

		TweenWrapper:CreateStyle("notification_reset", 0.4)
		local NotificationFunctions = {}
		function NotificationFunctions:SetText(new)
			new = new or text
			notifText.Text = new

			NewSize = TextService:GetTextSize(
				notifText.Text,
				notifText.TextSize,
				notifText.Font,
				Vector2.new(math.huge, math.huge)
			)
			local NewSize_2 = NewSize
			if IsRunning then
				TweenService
					:Create(
						edge,
						TweenWrapper.Styles["notification_load"],
						{ Size = UDim2.new(0, NewSize.X + 10, 0, 26) }
					)
					:Play()
				TweenService:Create(
					background,
					TweenWrapper.Styles["notification_load"],
					{ Size = UDim2.new(0, NewSize.X + 8, 0, 24) }
				):Play()
				TweenService:Create(
					notifText,
					TweenWrapper.Styles["notification_load"],
					{ Size = UDim2.new(0, NewSize.X + 8, 0, 24) }
				):Play()
				wait()
				TweenService:Create(bar, TweenWrapper.Styles["notification_reset"], { Size = UDim2.new(0, 0, 0, 1) })
					:Play()
				wait(0.4)
				TweenService
					:Create(bar, TweenWrapper.Styles["notification_wait"], { Size = UDim2.new(0, NewSize.X + 8, 0, 1) })
					:Play()
			end

			return self
		end
		return NotificationFunctions
	end

	-- Introduction

	local introduction = Instance.new("ScreenGui", CoreGui)
	local background = Instance.new("Frame")
	local Logo = Instance.new("TextLabel")
	local backgroundGradient_2 = Instance.new("UIGradient")
	local bar = Instance.new("Frame")
	local barCorner = Instance.new("UICorner")
	local messages = Instance.new("Frame")
	local LogExample = Instance.new("TextLabel")
	local backgroundGradient_3 = Instance.new("UIGradient")
	local pageLayout = Instance.new("UIListLayout")

	introduction.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	background.Parent = introduction
	background.BackgroundTransparency = 1
	background.AnchorPoint = Vector2.new(0.5, 0.5)
	background.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	background.ClipsDescendants = true
	background.Position = UDim2.new(0.511773348, 0, 0.5, 0)
	background.Size = UDim2.new(0, 300, 0, 308)

	--/ Style
	local IntroStroke = Instance.new("UIStroke", background)
	IntroStroke.Color = Color3.fromRGB(26, 26, 26)
	IntroStroke.Thickness = 2
	IntroStroke.Transparency = 1

	local backgroundGradient = Instance.new("UIGradient", background)
	backgroundGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28)),
	})
	backgroundGradient.Rotation = 90

	local backgroundCorner = Instance.new("UICorner", background)
	backgroundCorner.CornerRadius = UDim.new(0, 3)

	Logo.Parent = background
	Logo.AnchorPoint = Vector2.new(0.5, 0.5)
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.TextTransparency = 1
	Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
	Logo.Size = UDim2.new(0, 448, 0, 150)
	Logo.Font = Enum.Font.Unknown
	Logo.FontFace.Weight = Enum.FontWeight.Bold
	Logo.Font = Enum.Font.FredokaOne
	Logo.TextColor3 = library.acientColor
	Logo.TextSize = 100.000

	backgroundGradient_2.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(171, 171, 171)),
	})
	backgroundGradient_2.Rotation = 90
	backgroundGradient_2.Parent = Logo

	bar.Parent = background
	bar.BackgroundColor3 = library.acientColor
	bar.BackgroundTransparency = 1
	bar.Size = UDim2.new(1, 0, 0, 2)
	library:ApplyRainbow(bar, true)

	barCorner.CornerRadius = UDim.new(0, 2)
	barCorner.Parent = bar

	messages.Parent = background
	messages.AnchorPoint = Vector2.new(0.5, 0.5)
	messages.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
	messages.BackgroundTransparency = 1
	messages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	messages.BorderSizePixel = 1
	messages.Position = UDim2.new(0.5, 0, 0.5, 0)
	messages.Size = UDim2.new(1, -30, 1, -30)

	local messagesUIPadding = Instance.new("UIPadding", messages)
	messagesUIPadding.PaddingLeft = UDim.new(0, 6)
	messagesUIPadding.PaddingTop = UDim.new(0, 3)

	local messagesUIListLayout = Instance.new("UIListLayout", messages)
	messagesUIListLayout.Parent = messages
	messagesUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	messagesUIListLayout.FillDirection = Enum.FillDirection.Vertical
	messagesUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	messagesUIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	LogExample.Parent = messages
	LogExample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogExample.BackgroundTransparency = 1.000
	LogExample.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogExample.BorderSizePixel = 0
	LogExample.Size = UDim2.new(1, 0, 0, 18)
	LogExample.Visible = false
	LogExample.Font = library.Font
	LogExample.TextColor3 = Color3.fromRGB(255, 255, 255)
	LogExample.TextSize = 18.000
	LogExample.TextTransparency = 1
	LogExample.TextWrapped = true
	LogExample.TextXAlignment = Enum.TextXAlignment.Left
	LogExample.TextYAlignment = Enum.TextYAlignment.Top

	backgroundGradient_3.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(171, 171, 171)),
	})
	backgroundGradient_3.Rotation = 90
	backgroundGradient_3.Parent = LogExample

	pageLayout.Parent = introduction
	pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	pageLayout.VerticalAlignment = Enum.VerticalAlignment.Center

	TweenWrapper:CreateStyle("introduction", 0.175)
	TweenWrapper:CreateStyle("introduction end", 0.5)

	function library:BeginIntroduction()
		Logo.Text = library.company:sub(1, 1):upper()

		--TweenService:Create(edge, TweenWrapper.Styles["introduction"], {BackgroundTransparency = 0}):Play()
		TweenService:Create(background, TweenWrapper.Styles["introduction"], { BackgroundTransparency = 0 }):Play()
		wait(0.2)
		TweenService:Create(IntroStroke, TweenWrapper.Styles["introduction end"], { Transparency = 0.55 }):Play()
		TweenService:Create(bar, TweenWrapper.Styles["introduction"], { BackgroundTransparency = 0.2 }):Play()
		wait(0.3)
		TweenService:Create(Logo, TweenWrapper.Styles["introduction"], { TextTransparency = 0 }):Play()

		wait(2)

		local LogoTween = TweenService:Create(Logo, TweenWrapper.Styles["introduction"], { TextTransparency = 1 })
		TweenService:Create(Logo, TweenInfo.new(1), { TextSize = 0 }):Play()
		LogoTween:Play()
		LogoTween.Completed:Wait()
	end

	function library:AddIntroductionMessage(Message)
		if messages.BackgroundTransparency >= 1 then
			TweenService:Create(messages, TweenInfo.new(0.2), { BackgroundTransparency = 0.55 }):Play()
		end

		local Log = LogExample:Clone()
		local OrginalSize = Log.TextSize
		Log.Parent = messages
		Log.Text = Message
		Log.TextTransparency = 1
		Log.TextSize = OrginalSize * 0.9
		Log.Visible = true
		TweenService:Create(Log, TweenInfo.new(1), { TextTransparency = 0 }):Play()
		TweenService:Create(Log, TweenInfo.new(0.7), { TextSize = OrginalSize }):Play()
		wait(0.1)
		return Log
	end

	function library:EndIntroduction(Message)
		for _, Message in next, messages:GetChildren() do
			pcall(function()
				TweenService:Create(Message, TweenWrapper.Styles["introduction end"], { TextTransparency = 1 }):Play()
			end)
		end
		wait(0.2)

		TweenService:Create(messages, TweenWrapper.Styles["introduction end"], { BackgroundTransparency = 1 }):Play()
		--TweenService:Create(edge, TweenWrapper.Styles["introduction end"], {BackgroundTransparency = 1}):Play()
		TweenService:Create(background, TweenWrapper.Styles["introduction end"], { BackgroundTransparency = 1 }):Play()
		TweenService:Create(bar, TweenWrapper.Styles["introduction end"], { BackgroundTransparency = 1 }):Play()
		TweenService:Create(Logo, TweenWrapper.Styles["introduction end"], { TextTransparency = 1 }):Play()
		TweenService:Create(IntroStroke, TweenWrapper.Styles["introduction end"], { Transparency = 1 }):Play()
	end

	----/// UI INIT
	local screen = Instance.new("ScreenGui", hiddenUI())
	screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local background = Instance.new("Frame", screen)
	background.Visible = false
	background.BorderSizePixel = 0
	background.AnchorPoint = Vector2.new(0.5, 0.5)
	background.BackgroundTransparency = library.transparency
	background.BackgroundColor3 = library.backgroundColor
	background.Position = UDim2.new(0.5, 0, 0.5, 0)
	--background.Size = UDim2.fromScale(0.5, 0.5)
	background.Size = UDim2.fromOffset(594, 406)
	background.ClipsDescendants = true
	EnableDrag(background, 0.1)

	local SizeConstraint = Instance.new("UISizeConstraint")
	SizeConstraint.Parent = background
	SizeConstraint.MaxSize = Vector2.new(594, 406)
	SizeConstraint.MinSize = Vector2.new(450, 300)

	--/ Style
	local BGStroke = Instance.new("UIStroke", background)
	BGStroke.Color = Color3.fromRGB(26, 26, 26)
	BGStroke.Thickness = 2
	BGStroke.Transparency = 0.55

	local BGGradient = Instance.new("UIGradient", background)
	BGGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(230, 230, 230)),
	})
	BGGradient.Rotation = 90

	--/ Tabs
	local tabButtons = Instance.new("Frame", background)
	tabButtons.BackgroundTransparency = 1
	tabButtons.ClipsDescendants = true
	tabButtons.Position = UDim2.new(0, 10, 0, 35)
	tabButtons.Size = UDim2.new(0, 152, 0, 330)

	local tabButtonLayout = Instance.new("UIListLayout", tabButtons)
	tabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	tabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local tabButtonPadding = Instance.new("UIPadding", tabButtons)
	tabButtonPadding.PaddingBottom = UDim.new(0, 4)
	tabButtonPadding.PaddingLeft = UDim.new(0, 4)
	tabButtonPadding.PaddingRight = UDim.new(0, 4)
	tabButtonPadding.PaddingTop = UDim.new(0, 4)

	local tabButtonCorner_2 = Instance.new("UICorner", tabButtons)
	tabButtonCorner_2.CornerRadius = UDim.new(0, 2)

	--/ Header
	local container = Instance.new("Frame", background)
	container.AnchorPoint = Vector2.new(1, 0)
	container.BackgroundTransparency = 1
	container.Position = UDim2.new(1, -10, 0, 35)
	container.Size = UDim2.new(0, 414, 0, 360)

	local header = Instance.new("Frame", background)
	header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	header.BackgroundTransparency = 1.000
	header.BorderColor3 = Color3.fromRGB(0, 0, 0)
	header.BorderSizePixel = 0
	header.Size = UDim2.new(1, 0, 0, 32)

	local company = Instance.new("TextLabel", header)
	company.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	company.BackgroundTransparency = 1.000
	company.LayoutOrder = 1
	company.AutomaticSize = Enum.AutomaticSize.X
	company.Size = UDim2.new(0, 0, 1, 0)
	company.Font = library.Font
	company.TextColor3 = library.companyColor
	company.TextSize = 16.000
	company.TextTransparency = 0.300
	company.RichText = true
	company.TextXAlignment = Enum.TextXAlignment.Left

	function library:SetCompany(text)
		library.company = text
		company.Text = text or ""
		return self
	end
	library:SetCompany(library.company)

	local headerLabel = Instance.new("TextLabel", header)
	headerLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	headerLabel.BackgroundTransparency = 1.000
	headerLabel.LayoutOrder = 2
	headerLabel.Size = UDim2.new(1, 0, 1, 0)
	headerLabel.Font = library.Font
	headerLabel.Text = ""
	headerLabel.RichText = true
	headerLabel.TextColor3 = Color3.fromRGB(198, 198, 198)
	headerLabel.TextSize = 16.000
	headerLabel.TextXAlignment = Enum.TextXAlignment.Left

	function library:SetTitle(text)
		headerLabel.Text = text or ""
		return self
	end

	local UIListLayout = Instance.new("UIListLayout", header)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 5)

	local UIPadding = Instance.new("UIPadding", header)
	UIPadding.PaddingLeft = UDim.new(0, 10)

	--/ Bars
	local barFolder = Instance.new("Folder", background)

	local bar = Instance.new("Frame", barFolder)
	bar.BackgroundColor3 = library.acientColor
	bar.BackgroundTransparency = 0.200
	bar.Size = UDim2.new(1, 0, 0, 2)
	bar.BorderSizePixel = 0
	library:ApplyRainbow(bar, true)

	local barCorner = Instance.new("UICorner", bar)
	barCorner.CornerRadius = UDim.new(0, 2)

	local barLayout = Instance.new("UIListLayout", barFolder)
	barLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	barLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local tabButtonsOutline = Instance.new("UIStroke", tabButtons)
	tabButtonsOutline.Thickness = 1
	tabButtonsOutline.Color = library.lightGray

	local tabButtonsGradient = Instance.new("UIGradient", tabButtons)
	tabButtonsGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28)),
	})
	tabButtonsGradient.Rotation = 90

	local containerCorner = Instance.new("UICorner")
	containerCorner.CornerRadius = UDim.new(0, 2)
	containerCorner.Parent = container

	local tabButtonsOutline = Instance.new("UIStroke", container)
	tabButtonsOutline.Thickness = 1
	tabButtonsOutline.Color = library.lightGray

	local panic = Instance.new("TextButton", background)
	panic.Text = "Panic"
	panic.AnchorPoint = Vector2.new(0, 1)
	panic.BackgroundTransparency = library.transparency
	panic.BackgroundColor3 = library.darkGray
	panic.Position = UDim2.new(0, 10, 1, -10)
	panic.Size = UDim2.new(0, 152, 0, 24)
	panic.Font = library.Font
	panic.TextColor3 = Color3.fromRGB(190, 190, 190)
	panic.TextSize = 14.000
	panic.Activated:Connect(function()
		library:Panic()
	end)

	local buttonCorner = Instance.new("UICorner", panic)
	buttonCorner.CornerRadius = UDim.new(0, 2)

	local panicOutline = Instance.new("UIStroke", panic)
	panicOutline.Thickness = 1
	panicOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	panicOutline.Color = library.lightGray

	--delay(1, function()
	--	library:Notify("Keybind set to ".. library.Key.Name, 20, "success")
	--end)

	UserInputService.InputBegan:Connect(function(input) -- Toggle UI
		if input.KeyCode ~= library.Key then
			return
		end

		local Visible = not background.Visible
		library:ShowUI(Visible)
	end)

	function library:ShowUI(Visible: boolean)
		local FieldOfView = library.FieldOfView
		local BlurSize = library.BlurSize
		local BlurEffect = library.BlurEffect

		local Tweeninfo = TweenInfo.new(Visible and 0.5 or 0.3)

		background.Visible = Visible

		if BlurEffect then
			TweenService:Create(Blur, Tweeninfo, {
				Size = Visible and BlurSize or 0,
			}):Play()
			TweenService:Create(CurrentCam, Tweeninfo, {
				FieldOfView = Visible and FieldOfView - 12 or FieldOfView,
			}):Play()
		end

		return self
	end

	local TabLibrary = {
		IsFirst = true,
		CurrentTab = "",
	}
	TweenWrapper:CreateStyle("tab_text_colour", 0.16)
	function library:NewTab(title)
		title = title or "tab"

		local tabButton = Instance.new("TextButton")
		local page = Instance.new("ScrollingFrame")
		local pageLayout = Instance.new("UIListLayout")
		local pagePadding = Instance.new("UIPadding")

		tabButton.Parent = tabButtons
		tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		tabButton.BackgroundTransparency = 1.000
		tabButton.ClipsDescendants = true
		tabButton.Position = UDim2.new(-0.0281690136, 0, 0, 0)
		tabButton.Size = UDim2.new(0, 150, 0, 22)
		tabButton.AutoButtonColor = false
		tabButton.Font = library.Font
		tabButton.Text = title
		tabButton.TextColor3 = Color3.fromRGB(170, 170, 170)
		tabButton.TextSize = 15.000
		tabButton.RichText = true

		page.Parent = container
		page.Active = true
		page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		page.BackgroundTransparency = 1.000
		page.BorderSizePixel = 0
		page.Size = UDim2.new(0, 412, 0, 358)
		page.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		page.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		page.ScrollBarThickness = 1
		page.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		page.ScrollBarImageColor3 = library.acientColor
		page.Visible = false
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y

		pageLayout.Parent = page
		pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		pageLayout.Padding = UDim.new(0, 4)

		pagePadding.Parent = page
		pagePadding.PaddingBottom = UDim.new(0, 6)
		pagePadding.PaddingLeft = UDim.new(0, 6)
		pagePadding.PaddingRight = UDim.new(0, 6)
		pagePadding.PaddingTop = UDim.new(0, 6)

		if self.IsFirst or title == "Movement" then -- Show Movement tab by default
			page.Visible = true
			tabButton.TextColor3 = library.acientColor
			self.CurrentTab = title
			self.IsFirst = false -- Set IsFirst to false after showing the Movement tab
		end

		tabButton.MouseButton1Click:Connect(function()
			self.CurrentTab = title
			for i, v in pairs(container:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			page.Visible = true

			for i, v in pairs(tabButtons:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService
						:Create(
							v,
							TweenWrapper.Styles["tab_text_colour"],
							{ TextColor3 = Color3.fromRGB(170, 170, 170) }
						)
						:Play()
				end
			end
			TweenService:Create(tabButton, TweenWrapper.Styles["tab_text_colour"], { TextColor3 = library.acientColor })
				:Play()
		end)

		self.IsFirst = false

		TweenWrapper:CreateStyle("hover", 0.16)
		local Components = {}
		function Components:NewLabel(text, alignment)
			text = text or "label"
			alignment = alignment or "left"

			local label = Instance.new("TextLabel")
			local labelPadding = Instance.new("UIPadding")

			label.Parent = page
			label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			label.BackgroundTransparency = 1.000
			label.Position = UDim2.new(0.00499999989, 0, 0, 0)
			label.Size = UDim2.new(0, 396, 0, 24)
			label.Font = library.Font
			label.Text = text
			label.TextColor3 = Color3.fromRGB(190, 190, 190)
			label.TextSize = 14.000
			label.TextWrapped = true
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.RichText = true

			labelPadding.Parent = page
			labelPadding.PaddingBottom = UDim.new(0, 6)
			labelPadding.PaddingLeft = UDim.new(0, 12)
			labelPadding.PaddingRight = UDim.new(0, 6)
			labelPadding.PaddingTop = UDim.new(0, 6)

			if alignment:lower():find("le") then
				label.TextXAlignment = Enum.TextXAlignment.Left
			elseif alignment:lower():find("cent") then
				label.TextXAlignment = Enum.TextXAlignment.Center
			elseif alignment:lower():find("ri") then
				label.TextXAlignment = Enum.TextXAlignment.Right
			end

			local LabelFunctions = {}
			function LabelFunctions:SetText(text)
				text = text or "new label text"
				label.Text = text
				return self
			end

			function LabelFunctions:Remove()
				label:Destroy()
				return self
			end

			function LabelFunctions:Hide()
				label.Visible = false

				return self
			end

			function LabelFunctions:Show()
				label.Visible = true

				return self
			end

			function LabelFunctions:Align(new)
				new = new or "le"
				if new:lower():find("le") then
					label.TextXAlignment = Enum.TextXAlignment.Left
				elseif new:lower():find("cent") then
					label.TextXAlignment = Enum.TextXAlignment.Center
				elseif new:lower():find("ri") then
					label.TextXAlignment = Enum.TextXAlignment.Right
				end
			end
			return LabelFunctions
		end

		function Components:NewButton(text, callback)
			text = text or "Button"
			callback = callback or function() end

			local ButtonFunctions = {}
			local button = Instance.new("TextButton")
			local buttonCorner = Instance.new("UICorner", button)
			local buttonStroke = Instance.new("UIStroke", button)

			local Color = library.darkGray
			local Hover = Color3.fromRGB(40, 40, 40)

			button.Text = text
			button.Parent = page
			button.BackgroundColor3 = Color
			button.BackgroundTransparency = library.transparency
			button.Size = UDim2.new(0, 396, 0, 24)
			button.AutoButtonColor = false
			button.Font = library.Font
			button.TextColor3 = Color3.fromRGB(190, 190, 190)
			button.TextSize = 14

			buttonStroke.Thickness = 1
			buttonStroke.Color = library.lightGray
			buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			buttonCorner.CornerRadius = UDim.new(0, 2)

			button.MouseEnter:Connect(function()
				TweenService:Create(button, TweenWrapper.Styles["hover"], { BackgroundColor3 = Hover }):Play()
			end)
			button.MouseLeave:Connect(function()
				TweenService:Create(button, TweenWrapper.Styles["hover"], { BackgroundColor3 = Color }):Play()
			end)

			button.MouseButton1Down:Connect(function()
				TweenService
					:Create(button, TweenWrapper.Styles["hover"], { TextColor3 = Color3.fromRGB(169, 107, 255) })
					:Play()
			end)
			button.MouseButton1Up:Connect(function()
				TweenService
					:Create(button, TweenWrapper.Styles["hover"], { TextColor3 = Color3.fromRGB(125, 125, 125) })
					:Play()
			end)

			button.MouseButton1Click:Connect(function()
				callback()
			end)

			function ButtonFunctions:Fire()
				callback()
			end

			function ButtonFunctions:Hide()
				button.Visible = false
				return self
			end

			function ButtonFunctions:Show()
				button.Visible = true
				return self
			end

			function ButtonFunctions:SetText(text)
				text = text or ""
				button.Text = text

				return self
			end

			function ButtonFunctions:Remove()
				button:Destroy()
				return self
			end

			function ButtonFunctions:SetFunction(new)
				new = new or function() end
				callback = new
				return self
			end
			return ButtonFunctions
		end

		function Components:NewSection(text)
			text = text or "section"

			local sectionFrame = Instance.new("Frame", page)
			local sectionLayout = Instance.new("UIListLayout")
			local sectionLabel = Instance.new("TextLabel")
			local sectionPadding = Instance.new("UIPadding", sectionFrame)

			local UICorner = Instance.new("UICorner", sectionFrame)
			UICorner.CornerRadius = UDim.new(0, 3)

			sectionFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
			sectionFrame.BackgroundTransparency = 0.500
			sectionFrame.BorderSizePixel = 0
			sectionFrame.ClipsDescendants = true
			sectionFrame.Size = UDim2.new(0, 396, 0, 19)

			sectionPadding.PaddingBottom = UDim.new(0, 6)
			sectionPadding.PaddingLeft = UDim.new(0, 3)
			sectionPadding.PaddingRight = UDim.new(0, 3)
			sectionPadding.PaddingTop = UDim.new(0, 6)

			sectionLayout.Parent = sectionFrame
			sectionLayout.FillDirection = Enum.FillDirection.Horizontal
			sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sectionLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			sectionLayout.Padding = UDim.new(0, 4)

			sectionLabel.Parent = sectionFrame
			sectionLabel.BackgroundColor3 = library.headerColor
			sectionLabel.BackgroundTransparency = 1.000
			sectionLabel.ClipsDescendants = true
			sectionLabel.Position = UDim2.new(0.0252525248, 0, 0.020833334, 0)
			sectionLabel.Size = UDim2.new(1, 0, 1, 0)
			sectionLabel.Font = library.Font
			sectionLabel.LineHeight = 1
			sectionLabel.Text = text
			sectionLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			sectionLabel.TextSize = 14.000
			sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
			sectionLabel.RichText = true

			local NewSectionSize = TextService:GetTextSize(
				sectionLabel.Text,
				sectionLabel.TextSize,
				sectionLabel.Font,
				Vector2.new(math.huge, math.huge)
			)
			sectionLabel.Size = UDim2.new(0, NewSectionSize.X, 0, 18)

			local SectionFunctions = {}
			function SectionFunctions:SetText(new)
				new = new or text
				sectionLabel.Text = new

				local NewSectionSize = TextService:GetTextSize(
					sectionLabel.Text,
					sectionLabel.TextSize,
					sectionLabel.Font,
					Vector2.new(math.huge, math.huge)
				)
				sectionLabel.Size = UDim2.new(0, NewSectionSize.X, 0, 18)

				return self
			end
			function SectionFunctions:Hide()
				sectionFrame.Visible = false
				return self
			end
			function SectionFunctions:Show()
				sectionFrame.Visible = true
				return self
			end
			function SectionFunctions:Remove()
				sectionFrame:Destroy()
				return self
			end
			--
			return SectionFunctions
		end

		function Components:NewToggle(text, default, callback, loop, ignorepanic)
			text = text or "toggle"
			default = default or false
			callback = callback or function() end

			local toggleButton = Instance.new("TextButton", page)
			local toggleLayout = Instance.new("UIListLayout")

			local toggle = Instance.new("Frame")
			local toggleCorner = Instance.new("UICorner")
			local toggleDesign = Instance.new("Frame")
			local toggleDesignCorner = Instance.new("UICorner")
			local toggleStroke = Instance.new("UIStroke", toggle)
			local toggleLabel = Instance.new("TextLabel")
			local toggleLabelPadding = Instance.new("UIPadding")
			local Extras = Instance.new("Folder")
			local ExtrasLayout = Instance.new("UIListLayout")

			toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggleButton.BackgroundTransparency = 1.000
			toggleButton.ClipsDescendants = false
			toggleButton.Size = UDim2.new(0, 396, 0, 22)
			toggleButton.Font = library.Font
			toggleButton.Text = ""
			toggleButton.TextColor3 = Color3.fromRGB(190, 190, 190)
			toggleButton.TextSize = 14.000
			toggleButton.TextXAlignment = Enum.TextXAlignment.Left

			toggleLayout.Parent = toggleButton
			toggleLayout.FillDirection = Enum.FillDirection.Horizontal
			toggleLayout.SortOrder = Enum.SortOrder.LayoutOrder
			toggleLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			toggle.Parent = toggleButton
			toggle.BackgroundColor3 = library.darkGray
			toggle.BackgroundTransparency = library.transparency
			toggle.Size = UDim2.new(0, 18, 0, 18)

			toggleStroke.Thickness = 1
			toggleStroke.Color = library.lightGray

			toggleCorner.CornerRadius = UDim.new(0, 2)
			toggleCorner.Parent = toggle

			toggleDesign.Parent = toggle
			toggleDesign.AnchorPoint = Vector2.new(0.5, 0.5)
			toggleDesign.BackgroundColor3 = library.acientColor
			toggleDesign.BackgroundTransparency = 1.000
			toggleDesign.Position = UDim2.new(0.5, 0, 0.5, 0)

			toggleDesignCorner.CornerRadius = UDim.new(0, 2)
			toggleDesignCorner.Parent = toggleDesign

			toggleLabel.Parent = toggleButton
			toggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggleLabel.BackgroundTransparency = 1.000
			toggleLabel.Position = UDim2.new(0.0454545468, 0, 0, 0)
			toggleLabel.Size = UDim2.new(0, 377, 0, 22)
			toggleLabel.Font = library.Font
			toggleLabel.LineHeight = 1.150
			toggleLabel.Text = text
			toggleLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			toggleLabel.TextSize = 14.000
			toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			toggleLabel.RichText = true

			toggleLabelPadding.Parent = toggleLabel
			toggleLabelPadding.PaddingLeft = UDim.new(0, 6)

			Extras.Parent = toggleButton

			ExtrasLayout.Parent = Extras
			ExtrasLayout.FillDirection = Enum.FillDirection.Horizontal
			ExtrasLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			ExtrasLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ExtrasLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			ExtrasLayout.Padding = UDim.new(0, 2)

			local NewToggleLabelSize = TextService:GetTextSize(
				toggleLabel.Text,
				toggleLabel.TextSize,
				toggleLabel.Font,
				Vector2.new(math.huge, math.huge)
			)
			toggleLabel.Size = UDim2.new(0, NewToggleLabelSize.X + 6, 0, 22)

			toggleButton.MouseEnter:Connect(function()
				TweenService
					:Create(toggleLabel, TweenWrapper.Styles["hover"], { TextColor3 = Color3.fromRGB(210, 210, 210) })
					:Play()
			end)
			toggleButton.MouseLeave:Connect(function()
				TweenService
					:Create(toggleLabel, TweenWrapper.Styles["hover"], { TextColor3 = Color3.fromRGB(190, 190, 190) })
					:Play()
			end)

			TweenWrapper:CreateStyle("toggle_form", 0.13)
			local On = default
			if default then
				On = true
			else
				On = false
			end

			if loop ~= nil then
				RunService.RenderStepped:Connect(function()
					if On == true then
						callback(On)
					end
				end)
			end

			toggleButton.MouseButton1Click:Connect(function()
				On = not On
				local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
				local Transparency = On and 0 or 1
				TweenService:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { Size = SizeOn }):Play()
				TweenService
					:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { BackgroundTransparency = Transparency })
					:Play()
				callback(On)
			end)

			local ToggleFunctions = {}

			if not ignorepanic then
				OptionStates[toggleButton] = { false, ToggleFunctions }
			end

			function ToggleFunctions:SetText(new)
				new = new or text
				toggleLabel.Text = new
				return self
			end

			function ToggleFunctions:Hide()
				toggleButton.Visible = false
				return self
			end

			function ToggleFunctions:Show()
				toggleButton.Visible = true
				return self
			end

			function ToggleFunctions:Change()
				On = not On
				local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
				local Transparency = On and 0 or 1
				TweenService:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { Size = SizeOn }):Play()
				TweenService
					:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { BackgroundTransparency = Transparency })
					:Play()
				callback(On)
				return self
			end

			function ToggleFunctions:Remove()
				toggleButton:Destroy()
				return self
			end

			function ToggleFunctions:Set(state)
				On = state
				local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
				local Transparency = On and 0 or 1
				TweenService:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { Size = SizeOn }):Play()
				TweenService
					:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { BackgroundTransparency = Transparency })
					:Play()
				callback(On)
				return ToggleFunctions
			end

			function ToggleFunctions:GetValue()
				return On
			end

			local callback_t
			function ToggleFunctions:SetFunction(new)
				new = new or function() end
				callback = new
				callback_t = new
				return ToggleFunctions
			end

			function ToggleFunctions:AddKeybind(default_t)
				callback_t = callback
				if default_t == Enum.KeyCode.Backspace then
					default_t = nil
				end

				local keybind = Instance.new("TextButton")
				local keybindOutline = Instance.new("UIStroke")
				local keybindCorner = Instance.new("UICorner")
				local keybindBackground = Instance.new("Frame")
				local keybindBackCorner = Instance.new("UICorner")
				local keybindButtonLabel = Instance.new("TextLabel")
				local keybindLabelStraint = Instance.new("UISizeConstraint")
				local keybindBackgroundStraint = Instance.new("UISizeConstraint")
				local keybindStraint = Instance.new("UISizeConstraint")

				keybindOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				keybindOutline.Thickness = 1
				keybindOutline.Parent = keybind
				keybindOutline.Color = library.lightGray

				keybindCorner.CornerRadius = UDim.new(0, 2)
				keybindCorner.Parent = keybind

				keybind.Parent = Extras
				keybind.BackgroundTransparency = library.transparency
				keybind.BackgroundColor3 = library.darkGray
				keybind.Position = UDim2.new(0.780303001, 0, 0, 0)
				keybind.Size = UDim2.new(0, 87, 0, 22)
				keybind.AutoButtonColor = false
				keybind.Font = library.Font
				keybind.Text = ""
				keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
				keybind.TextSize = 14.000
				keybind.Active = false

				keybindBackground.Parent = keybind
				keybindBackground.AnchorPoint = Vector2.new(0.5, 0.5)
				keybindBackground.BackgroundTransparency = 1 --library.transparency
				keybindBackground.BackgroundColor3 = library.darkGray
				keybindBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
				keybindBackground.Size = UDim2.new(0, 85, 0, 20)

				keybindBackCorner.CornerRadius = UDim.new(0, 2)
				keybindBackCorner.Parent = keybindBackground

				keybindButtonLabel.Parent = keybindBackground
				keybindButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				keybindButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				keybindButtonLabel.BackgroundTransparency = 1.000
				keybindButtonLabel.ClipsDescendants = true
				keybindButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				keybindButtonLabel.Size = UDim2.new(0, 85, 0, 20)
				keybindButtonLabel.Font = library.Font
				keybindButtonLabel.Text = ". . ."
				keybindButtonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
				keybindButtonLabel.TextSize = 14.000
				keybindButtonLabel.RichText = true

				keybindLabelStraint.Parent = keybindButtonLabel
				keybindLabelStraint.MinSize = Vector2.new(28, 20)

				keybindBackgroundStraint.Parent = keybindBackground
				keybindBackgroundStraint.MinSize = Vector2.new(28, 20)

				keybindStraint.Parent = keybind
				keybindStraint.MinSize = Vector2.new(30, 22)

				local Shortcuts = {
					Return = "enter",
				}

				local _initialKeyText = "None"
				if default_t then
					local _name = Shortcuts[default_t.Name] or default_t.Name
					if _name == "Unknown" then
						_name = "None"
					end
					_initialKeyText = _name
				end
				keybindButtonLabel.Text = _initialKeyText
				TweenWrapper:CreateStyle("keybind", 0.08)

				local NewKeybindSize = TextService:GetTextSize(
					keybindButtonLabel.Text,
					keybindButtonLabel.TextSize,
					keybindButtonLabel.Font,
					Vector2.new(math.huge, math.huge)
				)
				keybindButtonLabel.Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)
				keybindBackground.Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)
				keybind.Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22)

				local function ResizeKeybind()
					NewKeybindSize = TextService:GetTextSize(
						keybindButtonLabel.Text,
						keybindButtonLabel.TextSize,
						keybindButtonLabel.Font,
						Vector2.new(math.huge, math.huge)
					)
					TweenService:Create(
						keybindButtonLabel,
						TweenWrapper.Styles["keybind"],
						{ Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20) }
					):Play()
					TweenService:Create(
						keybindBackground,
						TweenWrapper.Styles["keybind"],
						{ Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20) }
					):Play()
					TweenService:Create(
						keybind,
						TweenWrapper.Styles["keybind"],
						{ Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22) }
					):Play()
				end
				keybindButtonLabel:GetPropertyChangedSignal("Text"):Connect(ResizeKeybind)
				ResizeKeybind()

				local ChosenKey = default_t and default_t.Name

				keybind.MouseButton1Click:Connect(function()
					keybindButtonLabel.Text = ". . ."
					local InputWait = UserInputService.InputBegan:wait()
					if not UserInputService.WindowFocused then
						return
					end

					if InputWait == Enum.KeyCode.Backspace then
						default_t = nil
						ChosenKey = nil
						keybindButtonLabel.Text = "None"
						return
					end

					if InputWait.KeyCode.Name ~= "Unknown" then
						local Result = Shortcuts[InputWait.KeyCode.Name] or InputWait.KeyCode.Name
						keybindButtonLabel.Text = Result
						ChosenKey = InputWait.KeyCode.Name
					end
				end)

				--local ChatTextBox = Player.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
				if UserInputService.WindowFocused then
					UserInputService.InputBegan:Connect(function(c, p)
						if not p and default_t and ChosenKey then
							if c.KeyCode.Name == ChosenKey then --  and not ChatTextBox:IsFocused()
								On = not On
								local SizeOn = On and UDim2.new(0, 12, 0, 12) or UDim2.new(0, 0, 0, 0)
								local Transparency = On and 0 or 1
								TweenService:Create(toggleDesign, TweenWrapper.Styles["toggle_form"], { Size = SizeOn })
									:Play()
								TweenService:Create(
									toggleDesign,
									TweenWrapper.Styles["toggle_form"],
									{ BackgroundTransparency = Transparency }
								):Play()
								callback_t(On)
								return
							end
						end
					end)
				end

				local ExtraKeybindFunctions = {}
				function ExtraKeybindFunctions:SetKey(new)
					new = new or ChosenKey.Name
					ChosenKey = new.Name
					keybindButtonLabel.Text = new.Name
					return self
				end

				function ExtraKeybindFunctions:Fire()
					callback_t(ChosenKey)
					return self
				end

				function ExtraKeybindFunctions:SetFunction(new)
					new = new or function() end
					callback_t = new
					return self
				end

				function ExtraKeybindFunctions:Hide()
					keybind.Visible = false
					return self
				end

				function ExtraKeybindFunctions:Show()
					keybind.Visible = true
					return self
				end
				return ExtraKeybindFunctions and ToggleFunctions
			end

			if default then
				toggleDesign.Size = UDim2.new(0, 12, 0, 12)
				toggleDesign.BackgroundTransparency = 0
				callback(true)
			end
			return ToggleFunctions
		end

		function Components:NewKeybind(text, default, callback)
			text = text or "keybind"
			default = default or Enum.KeyCode.P
			callback = callback or function() end

			local keybindFrame = Instance.new("Frame")
			local keybindButton = Instance.new("TextButton")
			local keybindLayout = Instance.new("UIListLayout")
			local keybindLabel = Instance.new("TextLabel")
			local keybindPadding = Instance.new("UIPadding")
			local keybindFolder = Instance.new("Folder")
			local keybindFolderLayout = Instance.new("UIListLayout")
			local keybind = Instance.new("TextButton")
			local keybindCorner = Instance.new("UICorner")
			local keybindBackground = Instance.new("Frame")
			local keybindGradient = Instance.new("UIGradient")
			local keybindBackCorner = Instance.new("UICorner")
			local keybindButtonLabel = Instance.new("TextLabel")
			local keybindLabelStraint = Instance.new("UISizeConstraint")
			local keybindBackgroundStraint = Instance.new("UISizeConstraint")
			local keybindStraint = Instance.new("UISizeConstraint")

			keybindFrame.Parent = page
			keybindFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindFrame.BackgroundTransparency = 1.000
			keybindFrame.ClipsDescendants = true
			keybindFrame.Size = UDim2.new(0, 396, 0, 24)

			keybindButton.Parent = keybindFrame
			keybindButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindButton.BackgroundTransparency = 1.000
			keybindButton.Size = UDim2.new(0, 396, 0, 24)
			keybindButton.AutoButtonColor = false
			keybindButton.Font = library.Font
			keybindButton.Text = ""
			keybindButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			keybindButton.TextSize = 14.000

			keybindLayout.Parent = keybindButton
			keybindLayout.FillDirection = Enum.FillDirection.Horizontal
			keybindLayout.SortOrder = Enum.SortOrder.LayoutOrder
			keybindLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			keybindLayout.Padding = UDim.new(0, 4)

			keybindLabel.Parent = keybindButton
			keybindLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindLabel.BackgroundTransparency = 1.000
			keybindLabel.Size = UDim2.new(0, 396, 0, 24)
			keybindLabel.Font = library.Font
			keybindLabel.Text = text
			keybindLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			keybindLabel.TextSize = 14.000
			keybindLabel.TextWrapped = true
			keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
			keybindLabel.RichText = true

			keybindPadding.Parent = keybindLabel
			keybindPadding.PaddingBottom = UDim.new(0, 6)
			keybindPadding.PaddingLeft = UDim.new(0, 2)
			keybindPadding.PaddingRight = UDim.new(0, 6)
			keybindPadding.PaddingTop = UDim.new(0, 6)

			keybindFolder.Parent = keybindFrame

			keybindFolderLayout.Parent = keybindFolder
			keybindFolderLayout.FillDirection = Enum.FillDirection.Horizontal
			keybindFolderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			keybindFolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
			keybindFolderLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			keybindFolderLayout.Padding = UDim.new(0, 4)

			keybind.Parent = keybindFolder
			keybind.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			keybind.Position = UDim2.new(0.780303001, 0, 0, 0)
			keybind.Size = UDim2.new(0, 87, 0, 22)
			keybind.AutoButtonColor = false
			keybind.Font = library.Font
			keybind.Text = ""
			keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
			keybind.TextSize = 14.000
			keybind.Active = false

			keybindCorner.CornerRadius = UDim.new(0, 2)
			keybindCorner.Parent = keybind

			keybindBackground.Parent = keybind
			keybindBackground.AnchorPoint = Vector2.new(0.5, 0.5)
			keybindBackground.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindBackground.Position = UDim2.new(0.5, 0, 0.5, 0)
			keybindBackground.Size = UDim2.new(0, 85, 0, 20)

			keybindGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 34, 34)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(28, 28, 28)),
			})
			keybindGradient.Rotation = 90
			keybindGradient.Parent = keybindBackground

			keybindBackCorner.CornerRadius = UDim.new(0, 2)
			keybindBackCorner.Parent = keybindBackground

			keybindButtonLabel.Parent = keybindBackground
			keybindButtonLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			keybindButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			keybindButtonLabel.BackgroundTransparency = 1.000
			keybindButtonLabel.ClipsDescendants = true
			keybindButtonLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			keybindButtonLabel.Size = UDim2.new(0, 85, 0, 20)
			keybindButtonLabel.Font = library.Font
			keybindButtonLabel.Text = ". . ."
			keybindButtonLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			keybindButtonLabel.TextSize = 14.000
			keybindButtonLabel.RichText = true

			keybindLabelStraint.Parent = keybindButtonLabel
			keybindLabelStraint.MinSize = Vector2.new(28, 20)

			keybindBackgroundStraint.Parent = keybindBackground
			keybindBackgroundStraint.MinSize = Vector2.new(28, 20)

			keybindStraint.Parent = keybind
			keybindStraint.MinSize = Vector2.new(30, 22)

			local Shortcuts = {
				Return = "enter",
				Unknown = "None",
				Backspace = "None",
			}

			local _keyName = Shortcuts[default.Name] or default.Name
			if _keyName == "Unknown" then
				_keyName = "None"
			end
			keybindButtonLabel.Text = _keyName
			TweenWrapper:CreateStyle("keybind", 0.08)

			local NewKeybindSize = TextService:GetTextSize(
				keybindButtonLabel.Text,
				keybindButtonLabel.TextSize,
				keybindButtonLabel.Font,
				Vector2.new(math.huge, math.huge)
			)
			keybindButtonLabel.Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)
			keybindBackground.Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20)
			keybind.Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22)

			local function ResizeKeybind()
				NewKeybindSize = TextService:GetTextSize(
					keybindButtonLabel.Text,
					keybindButtonLabel.TextSize,
					keybindButtonLabel.Font,
					Vector2.new(math.huge, math.huge)
				)
				TweenService:Create(
					keybindButtonLabel,
					TweenWrapper.Styles["keybind"],
					{ Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20) }
				):Play()
				TweenService:Create(
					keybindBackground,
					TweenWrapper.Styles["keybind"],
					{ Size = UDim2.new(0, NewKeybindSize.X + 6, 0, 20) }
				):Play()
				TweenService
					:Create(
						keybind,
						TweenWrapper.Styles["keybind"],
						{ Size = UDim2.new(0, NewKeybindSize.X + 8, 0, 22) }
					)
					:Play()
			end
			keybindButtonLabel:GetPropertyChangedSignal("Text"):Connect(ResizeKeybind)
			ResizeKeybind()

			local ChosenKey = default
			keybindButton.MouseButton1Click:Connect(function()
				keybindButtonLabel.Text = "..."
				local InputWait = UserInputService.InputBegan:wait()
				if UserInputService.WindowFocused and InputWait.KeyCode.Name ~= "Unknown" then
					local Result = Shortcuts[InputWait.KeyCode.Name] or InputWait.KeyCode.Name
					keybindButtonLabel.Text = Result
					ChosenKey = InputWait.KeyCode.Name
				end
			end)

			keybind.MouseButton1Click:Connect(function()
				keybindButtonLabel.Text = ". . ."
				local InputWait = UserInputService.InputBegan:wait()
				if UserInputService.WindowFocused and InputWait.KeyCode.Name ~= "Unknown" then
					local Result = Shortcuts[InputWait.KeyCode.Name] or InputWait.KeyCode.Name
					keybindButtonLabel.Text = Result
					ChosenKey = InputWait.KeyCode.Name
				end
			end)

			--local ChatTextBox = Player.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar
			if UserInputService.WindowFocused then
				UserInputService.InputBegan:Connect(function(c, GameProcessed)
					if GameProcessed then
						return
					end
					if c.KeyCode.Name == ChosenKey then -- and not ChatTextBox:IsFocused()
						callback(ChosenKey)
						return
					end
				end)
			end

			local KeybindFunctions = {}
			function KeybindFunctions:Fire()
				callback(ChosenKey)
				return KeybindFunctions
			end

			function KeybindFunctions:SetFunction(new)
				new = new or function() end
				callback = new
				return self
			end

			function KeybindFunctions:SetKey(new)
				new = new or ChosenKey.Name
				ChosenKey = new.Name
				keybindButtonLabel.Text = new.Name
				return self
			end

			function KeybindFunctions:SetText(new)
				new = new or keybindLabel.Text
				keybindLabel.Text = new
				return self
			end

			function KeybindFunctions:Hide()
				keybindFrame.Visible = false
				return self
			end

			function KeybindFunctions:Show()
				keybindFrame.Visible = true
				return self
			end
			return KeybindFunctions
		end

		function Components:NewTextbox(text, default, placeHolder, type, autoexec, autoclear, callback)
			text = text or "text box"
			default = default or ""
			placeHolder = placeHolder or ""
			type = type or "small" -- small, medium, large
			autoexec = autoexec or true
			autoclear = autoclear or false
			callback = callback or function() end

			local textboxFrame = Instance.new("Frame")
			local textboxLabel = Instance.new("TextLabel")
			local textboxPadding = Instance.new("UIPadding")
			local textbox = Instance.new("Frame")
			local textBoxValues = Instance.new("TextBox")
			local textBoxValuesPadding = Instance.new("UIPadding")

			textboxFrame.Parent = page
			textboxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			textboxFrame.BackgroundTransparency = 1.000
			textboxFrame.BorderSizePixel = 0
			textboxFrame.Position = UDim2.new(0.00499999989, 0, 0.268786132, 0)

			textBoxValues.MultiLine = true
			if type == "small" then
				textBoxValues.MultiLine = false
				textboxFrame.Size = UDim2.new(0, 393, 0, 46)
			elseif type == "medium" then
				textboxFrame.Size = UDim2.new(0, 393, 0, 60)
			elseif type == "large" then
				textboxFrame.Size = UDim2.new(0, 393, 0, 118)
			end

			textboxLabel.Parent = textboxFrame
			textboxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			textboxLabel.BackgroundTransparency = 1.000
			textboxLabel.Size = UDim2.new(1, 0, 0, 24)
			textboxLabel.Font = library.Font
			textboxLabel.Text = text
			textboxLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			textboxLabel.TextSize = 14.000
			textboxLabel.TextWrapped = true
			textboxLabel.TextXAlignment = Enum.TextXAlignment.Left

			textboxPadding.Parent = textboxLabel
			textboxPadding.PaddingBottom = UDim.new(0, 6)
			textboxPadding.PaddingRight = UDim.new(0, 6)
			textboxPadding.PaddingTop = UDim.new(0, 6)

			textbox.Parent = textboxFrame
			textbox.BackgroundColor3 = library.darkGray
			textbox.BackgroundTransparency = library.transparency
			textbox.BorderSizePixel = 0
			textbox.Position = UDim2.new(0, 0, 0, 24)
			textbox.Size = UDim2.new(1, 0, 1, -24)

			local textboxOutline = Instance.new("UIStroke", textbox)
			textboxOutline.Thickness = 1
			textboxOutline.Color = library.lightGray

			local UICorner = Instance.new("UICorner", textbox)
			UICorner.CornerRadius = UDim.new(0, 2)

			textBoxValues.Parent = textbox
			textBoxValues.BackgroundTransparency = 1
			textBoxValues.BorderSizePixel = 0
			textBoxValues.ClipsDescendants = true
			textBoxValues.Size = UDim2.new(1, 0, 1, 0)
			textBoxValues.Font = library.Font
			textBoxValues.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
			textBoxValues.PlaceholderText = placeHolder
			textBoxValues.Text = default
			textBoxValues.TextColor3 = Color3.fromRGB(190, 190, 190)
			textBoxValues.TextSize = 14.000
			textBoxValues.TextWrapped = true
			textBoxValues.TextXAlignment = Enum.TextXAlignment.Left
			textBoxValues.TextYAlignment = Enum.TextYAlignment.Top

			textBoxValuesPadding.Parent = textBoxValues
			textBoxValuesPadding.PaddingBottom = UDim.new(0, 4)
			textBoxValuesPadding.PaddingLeft = UDim.new(0, 4)
			textBoxValuesPadding.PaddingRight = UDim.new(0, 4)
			textBoxValuesPadding.PaddingTop = UDim.new(0, 4)

			TweenWrapper:CreateStyle("TextBox", 0.07)

			textBoxValues.FocusLost:Connect(function(enterPressed)
				if autoexec or enterPressed then
					callback(textBoxValues.Text)
				end
			end)

			local TextboxFunctions = {}
			function TextboxFunctions:Input(new)
				new = new or textBoxValues.Text
				textBoxValues = new
				return self
			end

			function TextboxFunctions:Fire()
				callback(textBoxValues.Text)
				return self
			end

			function TextboxFunctions:SetFunction(new)
				new = new or callback
				callback = new
				return self
			end

			function TextboxFunctions:SetText(new)
				new = new or textboxLabel.Text
				textboxLabel.Text = new
				return self
			end

			function TextboxFunctions:Hide()
				textboxFrame.Visible = false
				return self
			end

			function TextboxFunctions:Show()
				textboxFrame.Visible = true
				return self
			end

			function TextboxFunctions:Remove()
				textboxFrame:Destroy()
				return self
			end

			function TextboxFunctions:SetPlaceHolder(new)
				new = new or textBoxValues.PlaceholderText
				textBoxValues.PlaceholderText = new
				return self
			end
			return TextboxFunctions
		end
		--
		function Components:NewSelector(text, default, list, callback)
			text = text or "selector"
			default = default or ". . ."
			list = list or {}
			callback = callback or function() end

			local selectorFrame = Instance.new("Frame")
			local selectorLabel = Instance.new("TextLabel")
			local selectorLabelPadding = Instance.new("UIPadding")
			local selectorFrameLayout = Instance.new("UIListLayout")
			local selector = Instance.new("TextButton")
			local selectorCorner = Instance.new("UICorner")
			local selectorLayout = Instance.new("UIListLayout")
			local selectorPadding = Instance.new("UIPadding")
			local selectorTwo = Instance.new("Frame")
			local selectorText = Instance.new("TextLabel")
			local textBoxValuesPadding = Instance.new("UIPadding")
			local Frame = Instance.new("Frame")
			local selectorTwoLayout = Instance.new("UIListLayout")
			local selectorTwoCorner = Instance.new("UICorner")
			local selectorPadding_2 = Instance.new("UIPadding")
			local selectorContainer = Instance.new("Frame")
			local selectorTwoLayout_2 = Instance.new("UIListLayout")

			selectorFrame.Parent = page
			selectorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selectorFrame.BackgroundTransparency = 1.000
			selectorFrame.ClipsDescendants = true
			selectorFrame.Position = UDim2.new(0.00499999989, 0, 0.0895953774, 0)
			selectorFrame.Size = UDim2.new(0, 394, 0, 48)

			selectorLabel.Parent = selectorFrame
			selectorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selectorLabel.BackgroundTransparency = 1.000
			selectorLabel.Size = UDim2.new(0, 396, 0, 24)
			selectorLabel.Font = library.Font
			selectorLabel.Text = text
			selectorLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			selectorLabel.TextSize = 14.000
			selectorLabel.TextWrapped = true
			selectorLabel.TextXAlignment = Enum.TextXAlignment.Left
			selectorLabel.RichText = true

			selectorLabelPadding.Parent = selectorLabel
			selectorLabelPadding.PaddingBottom = UDim.new(0, 6)
			selectorLabelPadding.PaddingLeft = UDim.new(0, 2)
			selectorLabelPadding.PaddingRight = UDim.new(0, 6)
			selectorLabelPadding.PaddingTop = UDim.new(0, 6)

			selectorFrameLayout.Parent = selectorFrame
			selectorFrameLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			selectorFrameLayout.SortOrder = Enum.SortOrder.LayoutOrder

			selector.Parent = selectorFrame
			selector.BackgroundColor3 = library.darkGray
			selector.BackgroundTransparency = library.transparency
			selector.ClipsDescendants = true
			selector.Position = UDim2.new(0, 0, 0.0926640928, 0)
			selector.Size = UDim2.new(1, 0, 0, 23)
			selector.AutoButtonColor = false
			selector.Font = library.Font
			selector.Text = ""
			selector.TextColor3 = Color3.fromRGB(0, 0, 0)
			selector.TextSize = 14.000

			selectorCorner.CornerRadius = UDim.new(0, 2)
			selectorCorner.Parent = selector

			selectorLayout.Parent = selector
			selectorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			selectorLayout.SortOrder = Enum.SortOrder.LayoutOrder

			selectorPadding.Parent = selector
			selectorPadding.PaddingTop = UDim.new(0, 1)

			selectorTwo.Parent = selector
			selectorTwo.BackgroundColor3 = library.darkGray
			selectorTwo.BackgroundTransparency = library.transparency
			selectorTwo.ClipsDescendants = true
			selectorTwo.Position = UDim2.new(0.00252525252, 0, 0, 0)
			selectorTwo.Size = UDim2.new(1, -2, 1, -1)

			selectorText.Parent = selectorTwo
			selectorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selectorText.BackgroundTransparency = 1.000
			selectorText.Size = UDim2.new(0, 394, 0, 20)
			selectorText.Font = library.Font
			selectorText.LineHeight = 1.150
			selectorText.TextColor3 = Color3.fromRGB(160, 160, 160)
			selectorText.TextSize = 14.000
			selectorText.TextXAlignment = Enum.TextXAlignment.Left
			selectorText.Text = default

			local Toggle = Instance.new("TextButton", selectorText)
			Toggle.AnchorPoint = Vector2.new(1, 0.5)
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 1.000
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(1, 0, 0.5, 0)
			Toggle.Rotation = 90
			Toggle.Size = UDim2.new(0, 20, 1, 5)
			Toggle.Font = library.Font
			Toggle.Text = ">"
			Toggle.TextColor3 = Color3.fromRGB(160, 160, 160)
			Toggle.TextSize = 14.000

			textBoxValuesPadding.Parent = selectorText
			textBoxValuesPadding.PaddingBottom = UDim.new(0, 6)
			textBoxValuesPadding.PaddingLeft = UDim.new(0, 6)
			textBoxValuesPadding.PaddingRight = UDim.new(0, 6)
			textBoxValuesPadding.PaddingTop = UDim.new(0, 6)

			Frame.Parent = selectorText
			Frame.AnchorPoint = Vector2.new(0.5, 1)
			Frame.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			Frame.BorderSizePixel = 0
			Frame.Position = UDim2.new(0.5, 0, 1, 7)
			Frame.Size = UDim2.new(1, -6, 0, 1)

			selectorTwoLayout.Parent = selectorTwo
			selectorTwoLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			selectorTwoLayout.SortOrder = Enum.SortOrder.LayoutOrder

			selectorTwoCorner.CornerRadius = UDim.new(0, 2)
			selectorTwoCorner.Parent = selectorTwo

			selectorPadding_2.Parent = selectorTwo
			selectorPadding_2.PaddingTop = UDim.new(0, 1)

			selectorContainer.Parent = selectorTwo
			selectorContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			selectorContainer.BackgroundTransparency = 1.000
			selectorContainer.Size = UDim2.new(1, 0, 0, 20)

			selectorTwoLayout_2.Parent = selectorContainer
			selectorTwoLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
			selectorTwoLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

			TweenWrapper:CreateStyle("selector", 0.08)

			local Amount = #list
			local Val = (Amount * 20)
			local Size = 0

			local function checkSizes()
				Amount = #list
				Val = (Amount * 20) + 20
			end

			for i, v in next, list do
				local optionButton = Instance.new("TextButton")

				optionButton.Name = "optionButton"
				optionButton.Parent = selectorContainer
				optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				optionButton.BackgroundTransparency = 1.000
				optionButton.Size = UDim2.new(0, 394, 0, 20)
				optionButton.AutoButtonColor = false
				optionButton.Font = library.Font
				optionButton.Text = v
				optionButton.TextColor3 = Color3.fromRGB(160, 160, 160)
				optionButton.TextSize = 14.000
				if optionButton.Text == default then
					optionButton.TextColor3 = library.acientColor
					callback(selectorText.Text)
				end

				optionButton.MouseButton1Click:Connect(function()
					for z, x in next, selectorContainer:GetChildren() do
						if x:IsA("TextButton") then
							TweenService
								:Create(
									x,
									TweenWrapper.Styles["selector"],
									{ TextColor3 = Color3.fromRGB(160, 160, 160) }
								)
								:Play()
						end
					end
					TweenService
						:Create(optionButton, TweenWrapper.Styles["selector"], { TextColor3 = library.acientColor })
						:Play()
					selectorText.Text = optionButton.Text
					callback(optionButton.Text)
				end)

				Size = Val + 2

				checkSizes()
			end

			local SelectorFunctions = {}
			local AddAmount = 0

			local IsOpen = false
			local function HandleToggle()
				local Speed = 0.2
				IsOpen = not IsOpen

				TweenService:Create(selector, TweenInfo.new(Speed), {
					Size = UDim2.new(1, 0, 0, IsOpen and Size or 23),
				}):Play()
				TweenService:Create(selectorFrame, TweenInfo.new(Speed), {
					Size = UDim2.new(0, 394, 0, IsOpen and Size + 24 or 48),
				}):Play()
				TweenService:Create(Toggle, TweenInfo.new(Speed), {
					Rotation = IsOpen and -90 or 90,
				}):Play()
			end

			selector.Activated:Connect(HandleToggle)
			Toggle.Activated:Connect(HandleToggle)

			function SelectorFunctions:AddOption(new, callback_f)
				new = new or "option"
				list[new] = new

				local optionButton = Instance.new("TextButton")

				AddAmount = AddAmount + 20

				optionButton.Name = "optionButton"
				optionButton.Parent = selectorContainer
				optionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				optionButton.BackgroundTransparency = 1.000
				optionButton.Size = UDim2.new(0, 394, 0, 20)
				optionButton.AutoButtonColor = false
				optionButton.Font = library.Font
				optionButton.Text = new
				optionButton.TextColor3 = Color3.fromRGB(140, 140, 140)
				optionButton.TextSize = 14.000
				if optionButton.Text == default then
					optionButton.TextColor3 = library.acientColor
					callback(selectorText.Text)
				end

				optionButton.MouseButton1Click:Connect(function()
					for z, x in next, selectorContainer:GetChildren() do
						if x:IsA("TextButton") then
							TweenService
								:Create(
									x,
									TweenWrapper.Styles["selector"],
									{ TextColor3 = Color3.fromRGB(140, 140, 140) }
								)
								:Play()
						end
					end
					TweenService
						:Create(optionButton, TweenWrapper.Styles["selector"], { TextColor3 = library.acientColor })
						:Play()
					selectorText.Text = optionButton.Text
					callback(optionButton.Text)
				end)

				checkSizes()
				Size = (Val + AddAmount) + 2

				checkSizes()
				return self
			end

			local RemoveAmount = 0
			function SelectorFunctions:RemoveOption(option)
				list[option] = nil

				RemoveAmount = RemoveAmount + 20
				AddAmount = AddAmount - 20

				for i, v in next, selectorContainer:GetDescendants() do
					if v:IsA("TextButton") then
						if v.Text == option then
							v:Destroy()
							Size = (Val - RemoveAmount) + 2
						end
					end
				end

				if selectorText.Text == option then
					selectorText.Text = ". . ."
				end

				checkSizes()
				return self
			end

			function SelectorFunctions:SetFunction(new)
				new = new or callback
				callback = new
				return self
			end

			function SelectorFunctions:Text(new)
				new = new or selectorLabel.Text
				selectorLabel.Text = new
				return self
			end

			function SelectorFunctions:Hide()
				selectorFrame.Visible = false
				return self
			end

			function SelectorFunctions:Show()
				selectorFrame.Visible = true
				return self
			end

			function SelectorFunctions:Remove()
				selectorFrame:Destroy()
				return self
			end
			return SelectorFunctions
		end

		function Components:NewSlider(text, suffix, compare, compareSign, values, callback)
			text = text or "slider"
			suffix = suffix or ""
			compare = compare or false
			compareSign = compareSign or "/"
			values = values
				or {
					min = values.min or 0,
					max = values.max or 100,
					default = values.default or 0,
				}
			callback = callback or function() end

			values.max = values.max + 1

			local sliderFrame = Instance.new("Frame")
			local sliderFolder = Instance.new("Folder")
			local textboxFolderLayout = Instance.new("UIListLayout")
			local sliderButton = Instance.new("TextButton")
			local sliderButtonCorner = Instance.new("UICorner")
			local sliderBackground = Instance.new("Frame")
			local sliderButtonCorner_2 = Instance.new("UICorner")
			local sliderBackgroundLayout = Instance.new("UIListLayout")
			local sliderIndicator = Instance.new("Frame")
			local sliderIndicatorStraint = Instance.new("UISizeConstraint")
			local sliderIndicatorGradient = Instance.new("UIGradient")
			local sliderIndicatorCorner = Instance.new("UICorner")
			local sliderBackgroundPadding = Instance.new("UIPadding")
			local sliderButtonLayout = Instance.new("UIListLayout")
			local sliderLabel = Instance.new("TextLabel")
			local sliderPadding = Instance.new("UIPadding")
			local sliderValue = Instance.new("TextLabel")

			sliderFrame.Parent = page
			sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			sliderFrame.BackgroundTransparency = 1.000
			sliderFrame.ClipsDescendants = true
			sliderFrame.Position = UDim2.new(0.00499999989, 0, 0.667630076, 0)
			sliderFrame.Size = UDim2.new(0, 394, 0, 40)

			sliderFolder.Parent = sliderFrame

			textboxFolderLayout.Parent = sliderFolder
			textboxFolderLayout.FillDirection = Enum.FillDirection.Horizontal
			textboxFolderLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			textboxFolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
			textboxFolderLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
			textboxFolderLayout.Padding = UDim.new(0, 4)

			sliderButton.Parent = sliderFolder
			sliderButton.BackgroundColor3 = library.darkGray
			sliderButton.BackgroundTransparency = library.transparency
			sliderButton.Position = UDim2.new(0.348484844, 0, 0.600000024, 0)
			sliderButton.Size = UDim2.new(0, 394, 0, 16)
			sliderButton.AutoButtonColor = false
			sliderButton.Font = library.Font
			sliderButton.Text = ""
			sliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			sliderButton.TextSize = 14.000

			sliderButtonCorner.CornerRadius = UDim.new(0, 2)
			sliderButtonCorner.Parent = sliderButton

			sliderBackground.Parent = sliderButton
			sliderBackground.BackgroundColor3 = library.darkGray
			sliderBackground.BackgroundTransparency = library.transparency
			sliderBackground.Size = UDim2.new(0, 392, 0, 14)
			sliderBackground.Position = UDim2.new(0, 2, 0, 0)
			sliderBackground.ClipsDescendants = true

			sliderButtonCorner_2.CornerRadius = UDim.new(0, 2)
			sliderButtonCorner_2.Parent = sliderBackground

			sliderBackgroundLayout.Parent = sliderBackground
			sliderBackgroundLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sliderBackgroundLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			sliderIndicator.Parent = sliderBackground
			sliderIndicator.BorderSizePixel = 0
			sliderIndicator.Position = UDim2.new(0, 0, -0.1, 0)
			sliderIndicator.Size = UDim2.new(0, 0, 0, 12)
			sliderIndicator.BackgroundColor3 = library.acientColor

			sliderIndicatorStraint.Parent = sliderIndicator
			sliderIndicatorStraint.MaxSize = Vector2.new(392, 12)

			sliderIndicatorGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(181, 181, 181)),
			})
			sliderIndicatorGradient.Rotation = 90
			sliderIndicatorGradient.Parent = sliderIndicator

			sliderIndicatorCorner.CornerRadius = UDim.new(0, 2)
			sliderIndicatorCorner.Parent = sliderIndicator

			sliderBackgroundPadding.Parent = sliderBackground
			sliderBackgroundPadding.PaddingBottom = UDim.new(0, 2)
			sliderBackgroundPadding.PaddingLeft = UDim.new(0, 1)
			sliderBackgroundPadding.PaddingRight = UDim.new(0, 1)
			sliderBackgroundPadding.PaddingTop = UDim.new(0, 2)

			sliderButtonLayout.Parent = sliderButton
			sliderButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			sliderButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sliderButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center

			sliderLabel.Parent = sliderFrame
			sliderLabel.BackgroundTransparency = 1.000
			sliderLabel.Size = UDim2.new(0, 396, 0, 24)
			sliderLabel.Font = library.Font
			sliderLabel.Text = text
			sliderLabel.TextColor3 = Color3.fromRGB(190, 190, 190)
			sliderLabel.TextSize = 14.000
			sliderLabel.TextWrapped = true
			sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			sliderLabel.RichText = true

			sliderPadding.Parent = sliderLabel
			sliderPadding.PaddingBottom = UDim.new(0, 6)
			sliderPadding.PaddingLeft = UDim.new(0, 2)
			sliderPadding.PaddingRight = UDim.new(0, 6)
			sliderPadding.PaddingTop = UDim.new(0, 6)

			sliderValue.Parent = sliderLabel
			sliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sliderValue.BackgroundTransparency = 1.000
			sliderValue.Position = UDim2.new(0.577319562, 0, 0, 0)
			sliderValue.Size = UDim2.new(0, 169, 0, 15)
			sliderValue.Font = library.Font
			sliderValue.Text = values.default or ""
			sliderValue.TextColor3 = Color3.fromRGB(140, 140, 140)
			sliderValue.TextSize = 14.000
			sliderValue.TextXAlignment = Enum.TextXAlignment.Right

			local calc1 = values.max - values.min
			local calc2 = values.default - values.min
			local calc3 = calc2 / calc1
			local calc4 = calc3 * sliderBackground.AbsoluteSize.X
			sliderIndicator.Size = UDim2.new(0, calc4, 0, 12)
			sliderValue.Text = values.default

			TweenWrapper:CreateStyle("slider_drag", 0.05, Enum.EasingStyle.Linear)

			local ValueNum = values.default
			local slideText = compare and ValueNum .. compareSign .. tostring(values.max - 1) .. suffix
				or ValueNum .. suffix
			sliderValue.Text = slideText
			local function UpdateSlider()
				TweenService:Create(sliderIndicator, TweenWrapper.Styles["slider_drag"], {
					Size = UDim2.new(
						0,
						math.clamp(Mouse.X - sliderIndicator.AbsolutePosition.X, 0, sliderBackground.AbsoluteSize.X),
						0,
						12
					),
				}):Play()

				ValueNum = math.floor(
					(
						((tonumber(values.max) - tonumber(values.min)) / sliderBackground.AbsoluteSize.X)
						* sliderIndicator.AbsoluteSize.X
					) + tonumber(values.min)
				) or 0.00

				local slideText = compare and ValueNum .. compareSign .. tostring(values.max - 1) .. suffix
					or ValueNum .. suffix

				sliderValue.Text = slideText

				pcall(function()
					callback(ValueNum)
				end)

				sliderValue.Text = slideText

				moveconnection = Mouse.Move:Connect(function()
					ValueNum = math.floor(
						(
							((tonumber(values.max) - tonumber(values.min)) / sliderBackground.AbsoluteSize.X)
							* sliderIndicator.AbsoluteSize.X
						) + tonumber(values.min)
					)

					slideText = compare and ValueNum .. compareSign .. tostring(values.max - 1) .. suffix
						or ValueNum .. suffix
					sliderValue.Text = slideText

					pcall(function()
						callback(ValueNum)
					end)

					TweenService:Create(sliderIndicator, TweenWrapper.Styles["slider_drag"], {
						Size = UDim2.new(
							0,
							math.clamp(Mouse.X - sliderIndicator.AbsolutePosition.X, 0, sliderBackground.AbsoluteSize.X),
							0,
							12
						),
					}):Play()
					if not UserInputService.WindowFocused then
						moveconnection:Disconnect()
					end
				end)

				releaseconnection = UserInputService.InputEnded:Connect(function(Mouse_2)
					if Mouse_2.UserInputType == Enum.UserInputType.MouseButton1 then
						ValueNum = math.floor(
							(
								((tonumber(values.max) - tonumber(values.min)) / sliderBackground.AbsoluteSize.X)
								* sliderIndicator.AbsoluteSize.X
							) + tonumber(values.min)
						)

						slideText = compare and ValueNum .. compareSign .. tostring(values.max - 1) .. suffix
							or ValueNum .. suffix
						sliderValue.Text = slideText

						pcall(function()
							callback(ValueNum)
						end)

						TweenService:Create(sliderIndicator, TweenWrapper.Styles["slider_drag"], {
							Size = UDim2.new(
								0,
								math.clamp(
									Mouse.X - sliderIndicator.AbsolutePosition.X,
									0,
									sliderBackground.AbsoluteSize.X
								),
								0,
								12
							),
						}):Play()
						moveconnection:Disconnect()
						releaseconnection:Disconnect()
					end
				end)
			end

			sliderButton.MouseButton1Down:Connect(function()
				UpdateSlider()
			end)

			local SliderFunctions = {}
			OptionStates[sliderButton] = { values.default, SliderFunctions }

			function SliderFunctions:Set(new, NoCallBack)
				local ncalc1 = new - values.min
				local ncalc2 = ncalc1 / calc1
				local ncalc3 = ncalc2 * sliderBackground.AbsoluteSize.X
				local nCalculation = ncalc3
				sliderIndicator.Size = UDim2.new(0, nCalculation, 0, 12)
				slideText = compare and new .. compareSign .. tostring(values.max - 1) .. suffix or new .. suffix
				sliderValue.Text = slideText
				if not NoCallBack then
					callback(new)
				end
				return self
			end
			SliderFunctions:Set(values.default, true)

			function SliderFunctions:Max(new)
				new = new or values.max
				values.max = new + 1
				slideText = compare and ValueNum .. compareSign .. tostring(values.max - 1) .. suffix
					or ValueNum .. suffix
				return self
			end

			function SliderFunctions:Min(new)
				new = new or values.min
				values.min = new
				slideText = compare and new .. compareSign .. tostring(values.max - 1) .. suffix or ValueNum .. suffix
				TweenService:Create(sliderIndicator, TweenWrapper.Styles["slider_drag"], {
					Size = UDim2.new(
						0,
						math.clamp(Mouse.X - sliderIndicator.AbsolutePosition.X, 0, sliderBackground.AbsoluteSize.X),
						0,
						12
					),
				}):Play()
				return self
			end

			function SliderFunctions:SetFunction(new)
				new = new or callback
				callback = new
				return self
			end

			function SliderFunctions:GetValue()
				return ValueNum
			end

			function SliderFunctions:SetText(new)
				new = new or sliderLabel.Text
				sliderLabel.Text = new
				return self
			end

			function SliderFunctions:Hide()
				sliderFrame.Visible = false
				return self
			end

			function SliderFunctions:Show()
				sliderFrame.Visible = true
				return self
			end

			function SliderFunctions:Remove()
				sliderFrame:Destroy()
				return self
			end
			return SliderFunctions
		end

		function Components:NewSeperator()
			local sectionFrame = Instance.new("Frame")
			local sectionLayout = Instance.new("UIListLayout")
			local rightBar = Instance.new("Frame")

			sectionFrame.Name = "sectionFrame"
			sectionFrame.Parent = page
			sectionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			sectionFrame.BackgroundTransparency = 1.000
			sectionFrame.ClipsDescendants = true
			sectionFrame.Position = UDim2.new(0.00499999989, 0, 0.361271679, 0)
			sectionFrame.Size = UDim2.new(0, 396, 0, 12)

			sectionLayout.Name = "sectionLayout"
			sectionLayout.Parent = sectionFrame
			sectionLayout.FillDirection = Enum.FillDirection.Horizontal
			sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			sectionLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			sectionLayout.Padding = UDim.new(0, 4)

			rightBar.Name = "rightBar"
			rightBar.Parent = sectionFrame
			rightBar.BackgroundColor3 = library.darkGray
			rightBar.BackgroundTransparency = library.transparency
			rightBar.BorderSizePixel = 0
			rightBar.Position = UDim2.new(0.308080822, 0, 0.479166657, 0)
			rightBar.Size = UDim2.new(0, 403, 0, 1)

			local SeperatorFunctions = {}
			function SeperatorFunctions:Hide()
				sectionFrame.Visible = false
				return SeperatorFunctions
			end

			function SeperatorFunctions:Show()
				sectionFrame.Visible = true
				return SeperatorFunctions
			end

			function SeperatorFunctions:Remove()
				sectionFrame:Destroy()
				return SeperatorFunctions
			end
			return SeperatorFunctions
		end

		function Components:Open()
			TabLibrary.CurrentTab = title
			for i, v in next, container:GetChildren() do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end
			page.Visible = true

			for i, v in next, tabButtons:GetChildren() do
				if v:IsA("TextButton") then
					TweenService
						:Create(
							v,
							TweenWrapper.Styles["tab_text_colour"],
							{ TextColor3 = Color3.fromRGB(170, 170, 170) }
						)
						:Play()
				end
			end
			TweenService:Create(tabButton, TweenWrapper.Styles["tab_text_colour"], { TextColor3 = library.acientColor })
				:Play()

			return Components
		end

		function Components:Remove()
			tabButton:Destroy()
			page:Destroy()

			return Components
		end

		function Components:Hide()
			tabButton.Visible = false
			page.Visible = false

			return Components
		end

		function Components:Show()
			tabButton.Visible = true

			return Components
		end

		function Components:Text(text)
			text = text or "new text"
			tabButton.Text = text

			return Components
		end
		return Components
	end

	function library:Remove()
		screen:Destroy()
		library:Panic()

		return self
	end

	return library
end

return library

--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local R={"\122\082\080\119";"\113\090\057\068\102\049\057\051\102\117\071\087\102\072\105\081","\072\101\065\048\106\075\057\112\069\070\098\083\113\084\074\070","\085\112\105\047\088\116\098\112\085\102\061\061","\085\086\114\106\089\083\088\118\076\122\100\105","\107\082\085\115\072\076\061\061";"\055\054\112\081\121\102\061\061","\057\049\065\098\074\071\061\061","\118\085\048\070","\108\082\121\089\054\089\090\065\057\051\065\082\108\065\086\088";"\043\072\084\099";"\079\089\120\051\121\087\061\061","\107\089\057\048\110\117\057\051\098\072\098\102\102\101\121\050\057\076\061\061","\112\101\115\047\118\104\111\050\099\065\066\087\090\087\061\061","","\106\084\055\087\121\084\098\116";"\079\089\120\119\057\079\054\105\106\068\065\081\047\068\107\061","\090\116\099\112\054\066\072\111\086\051\080\119";"\106\068\120\104\106\082\086\048\047\117\069\061";"\121\051\090\050\057\102\061\061","\049\071\061\061";"\082\065\066\082\052\109\049\072\057\049\116\105\050\102\068\071\085\118\108\088\118\102\061\061";"\080\071\061\061","\111\119\115\051";"\110\079\085\053\102\084\075\074\057\068\048\107\102\117\072\075\054\087\061\061","\050\122\120\065\080\085\076\070\118\097\121\061","\068\066\101\088\109\051\051\050\072\065\070\061","\107\068\074\105\073\102\061\061";"\052\101\074\049";"\047\056\075\061";"\084\069\117\087\051\067\088\072";"\121\106\120\086\071\076\110\061","\121\079\065\098\069\084\054\049\054\043\070\104\121\043\085\116";"\080\113\099\050\047\087\061\061","\081\120\115\078\103\077\085\050\112\076\066\102";"\121\101\120\080\121\101\065\050","\106\050\057\049\073\084\090\075\113\050\057\102\106\079\048\105","\118\119\101\121\048\105\082\043\107\075\116\048\069\049\108\067\088\098\054\068\080\107\097\043";"\047\084\065\050\113\076\061\061";"\084\078\097\081\049\122\087\119\119\055\120\086\055\077\114\104","\053\055\122\080\089\107\057\119\052\087\061\061","\072\068\065\119\069\068\072\115\118\075\054\090\106\068\072\049\106\068\072\070\118\102\061\061";"\065\112\088\054\118\087\061\061";"\108\073\079\047\066\102\061\061";"\047\066\115\067\112\120\114\122\048\071\061\061";"\069\101\072\050\047\084\072\050\121\079\054\105\121\117\074\090","\073\117\118\089\067\084\048\116\057\072\048\048\107\084\054\101\108\076\061\061","\111\065\103\079\065\087\061\061";"\104\107\117\113\072\087\061\061";"\106\068\065\081\047\068\107\061","\086\043\101\119\052\073\073\047\114\057\067\050\050\121\055\043\050\051\110\110\105\087\061\061","\113\104\090\089\054\079\048\053\108\101\119\117\110\117\107\115\106\102\061\061";"\084\112\090\102\074\090\114\119\066\081\077\053";"\054\101\072\050\107\101\072\115\106\117\090\049\057\102\061\061";"\102\101\120\080\047\117\072\049\106\076\061\061";"\051\089\098\084","\106\068\120\080\106\084\089\081\057\079\118\061";"\057\117\074\112\047\043\118\061";"\066\102\061\061";"\079\089\120\100";"\057\051\077\108\065\105\088\073";"\118\088\099\075\055\071\110\061";"\107\076\061\061";"\106\089\054\074\057\053\098\101\053\065\105\119\098\072\057\090";"\122\104\055\089\110\075\073\101\050\122\049\068\078\103\081\073\098\082\109\082";"\054\068\072\104\106\082\086\112\073\102\061\061","\112\105\047\101\119\085\118\051";"\067\071\061\061";"\069\117\086\077\110\107\054\077\072\043\057\088\054\050\077\055";"\110\084\120\089\053\049\105\110\084\053\054\121\054\049\106\054\098\102\061\061","\057\117\084\087\105\078\101\110","\106\101\120\115\113\043\098\087\121\084\098\090","\106\068\065\104\113\087\061\061","\047\056\118\061","\106\068\055\122\110\049\098\105\072\053\106\080\102\079\105\110\067\068\069\061";"\069\043\054\115\113\084\055\051";"\075\081\097\088\049\076\061\061","\110\105\080\097\066\043\110\079\052\109\056\089","\078\070\109\106\088\067\122\073\110\119\055\102\102\073\114\110\071\065\121\061";"\117\078\070\076\111\077\106\052\077\101\085\087\075\053\079\066\049\115\101\117\076\113\077\117","\108\084\055\104\106\068\065\080\121\101\107\061","\118\056\067\072\079\071\083\122\108\084\121\105\056\076\061\061","\069\117\065\080\057\068\120\119";"\049\101\110\071\106\076\061\061","\104\074\116\120\097\119\107\082\078\122\110\113\071\071\061\061";"\049\107\066\100\119\098\068\069","\114\116\108\085\052\102\061\061","\098\068\086\050\054\053\065\080\107\117\106\051\054\070\089\098\102\071\061\061";"\114\116\057\119\079\081\053\113\102\055\107\061","\102\101\120\111\047\043\118\104";"\108\048\107\085\052\056\114\085","\103\049\076\049\112\089\070\061";"\052\050\077\057\122\102\061\061","\097\114\051\053\084\105\121\061","\054\072\072\077\047\104\098\051\102\117\086\097\069\084\055\049\108\071\061\061","\080\111\074\068\074\067\050\065\108\080\072\047\110\065\118\100\111\089\071\103\097\102\061\061","\106\055\082\122\047\098\106\053\107\120\122\110\120\073\068\065\081\088\098\084\082\098\118\120\080\085\101\109\055\076\061\061","\069\117\072\119\047\043\057\090","\057\101\089\105\106\068\098\083","\079\089\120\100\079\089\120\100\079\089\120\100\079\087\061\061","\069\082\105\086\106\072\048\112\107\072\106\055\054\101\120\077";"\121\101\105\105\069\071\061\061","\053\087\102\072\117\122\084\115\057\106\048\120\107\102\105\048\052\106\080\049";"\057\049\081\076\047\102\061\061";"\057\101\065\119\057\102\061\061";"\069\116\108\047\073\100\110\067";"\106\113\107\067","\120\099\089\114\107\056\057\052\069\051\043\104\121\116\084\087";"\111\083\079\054\103\087\114\077\101\110\071\069\056\043\047\065\054\073\074\105\106\082\069\043\078\111\068\122\107\057\104\057\080\113\111\043";"\098\114\071\047\070\047\088\110","\074\100\076\073\053\071\090\057\048\084\043\104\051\076\061\061";"\054\097\088\110\087\106\105\098","\079\089\120\100\079\089\120\100\079\087\061\061","\066\084\073\065";"\070\097\074\098\097\081\043\068","\074\101\103\048\043\122\077\061","\097\074\086\082\074\047\074\075","\079\089\120\111\057\084\077\061","\079\089\109\061","\087\056\122\099\057\051\088\081\103\109\054\089\050\071\061\061","\055\086\104\087\120\109\043\120\098\103\111\061","\115\073\055\120\049\078\049\112\089\097\084\116\069\071\061\061";"\052\071\061\061","\075\056\072\119\121\076\061\061";"\103\052\043\118";"\100\099\116\084","\054\117\090\080\057\075\057\048\069\051\098\050\102\101\105\048\047\068\054\114\057\070\098\111\121\079\098\104";"\106\104\071\043\121\079\054\079\121\107\071\077\121\101\055\102","\079\089\120\100\079\089\120\100\079\089\120\100";"\072\053\105\098\108\076\061\061";"\047\103\069\078";"\054\108\079\097","\047\068\072\080","\101\122\054\067\066\110\077\051\056\122\119\056\120\105\122\056\089\101\110\061","\088\075\074\111","\102\119\067\074\043\087\061\061","\079\089\120\048\047\117\054\090\073\076\061\061","\081\065\055\089";"\072\107\054\048\047\053\118\061";"\054\049\102\089\113\084\120\090\108\070\057\112\054\075\105\110\110\056\070\061","\067\081\071\090\057\122\083\048\067\071\061\061";"\056\089\080\077\106\067\109\075";"\090\050\112\107\078\107\122\067\066\090\098\103\109\082\075\110\047\087\067\070\065\066\099\051\049\116\065\103\076\087\061\061","\113\107\106\118\047\101\090\107\110\065\098\057\069\089\048\075\113\068\121\061","\054\107\077\074\107\051\106\104\047\043\072\050\107\117\105\049";"\069\068\098\105\047\068\087\061";"\102\122\106\080\120\054\043\055\103\074\065\051\078\120\106\106\075\071\061\061","\057\043\098\089\121\071\061\061";"\109\099\105\118\069\102\061\061";"\117\119\111\087\076\075\056\114\086\084\076\085\072\052\110\061";"\048\082\081\054";"\079\089\120\100\079\089\120\100","\079\089\120\100\079\089\109\061","\054\114\103\088\067\088\090\067";"\068\115\108\112\106\053\113\047\114\047\087\061";"\079\089\120\100\079\089\120\100\079\089\109\061";"\089\053\103\106\105\053\109\061","\071\053\072\115\108\102\098\083\078\110\087\099";"\078\082\112\113","\122\081\082\051\079\076\061\061","\079\089\120\100\079\087\061\061";"\066\071\071\112";"\078\098\052\106\065\082\111\101\043\105\114\083\052\117\116\082\110\097\113\043\107\114\101\121\100\107\101\072\106\102\061\061","\106\047\047\049\105\087\061\061","\053\084\077\043\069\090\086\105\069\075\086\104\054\070\086\117\072\084\075\061","\066\074\113\051","\072\078\116\073\083\084\047\107\098\080\074\121\081\102\061\061","\073\098\113\053\050\102\061\061","\104\049\079\077\105\090\116\087\097\047\115\106\047\053\088\109\049\120\083\082\065\070\103\101\104\111\043\080\102\082\071\053\122\069\084\068\076\065\084\105\085\107\088\116\103\067\101\066\052\088\069\043\121\111\112\113\107\090\050\107\107\050\080\050\081\109\049\106\049\100\076\067\057\098\115\076\079\071\087\073\072\051\074\071\118\076\061\061";"\112\048\101\079\119\116\043\084","\057\098\079\077\048\118\107\087\079\107\121\061";"\121\073\081\053";"\106\043\054\053\072\082\105\110\047\101\054\114\072\079\085\053\069\079\083\061";"\118\113\076\074";"\054\084\055\089\047\102\061\061";"\054\116\116\113\099\076\061\061";"\048\122\055\117\081\076\061\061","\122\104\110\047\067\114\077\061","\099\084\052\088\119\113\087\061","\070\118\057\085\069\102\051\101","\119\049\114\118\103\049\102\083\121\118\051\120\114\087\061\061";"\086\050\085\106\050\116\049\118\057\047\078\080\073\049\087\048","\084\053\105\067\107\050\083\043\106\101\120\090\108\117\048\101";"\057\079\086\115\047\043\118\061"}local function A(A)return R[A+(886880-862236)]end for A,U in ipairs({{-688244+688245;566633-566449};{453359+-453358,-937585+937662};{586251-586173,-203743+203927}})do while U[-963566+963567]<U[-619614+619616]do R[U[512419+-512418]],R[U[627521-627519]],U[-306303-(-306304)],U[883772+-883770]=R[U[149022-149020]],R[U[-192996+192997]],U[-316534-(-316535)]+(914265+-914264),U[-986167+986169]-(227252-227251)end end do local A=table.insert local U=math.floor local m={I=341845-341815,["\052"]=351006+-350948;X=-151263-(-151274);["\049"]=-395275+395310,O=682805-682782;m=545660-545600,A=-101651+101656,R=225747-225740;["\047"]=-295497+295524;q=-417664-(-417690);j=-705596-(-705625);s=681170+-681120,f=-248171+248187;["\054"]=-102506-(-102523),G=-651338+651370;["\051"]=-471059+471098;B=748956-748914;u=211755-211717,U=-426347-(-426348),l=-462787+462805;J=528523+-528474;c=-855454+855516,D=62479-62473;F=-418318+418354;h=-161245-(-161296);H=-1019357+1019378,a=-109941+109951;b=-805576+805589;M=-866350+866406,["\056"]=-580232+580235,y=-255927-(-255951),E=495042-495014,Q=-203877-(-203911);["\048"]=284332+-284291,["\050"]=515646+-515594;P=-90867-(-90913);r=-350529+350544,p=-147868-(-147915);x=-998832+998893,["\043"]=230766+-230711;z=-370155-(-370157);Z=628373-628336,K=-459571+459575,w=793126-793081,v=199672-199664;n=275691+-275679;W=-104698-(-104746);e=-562245+562299,o=-769321-(-769365),V=-190636+190645,i=-916700-(-916733);t=-220977-(-221020),k=57503-57483;g=-277951-(-278014);["\055"]=930036+-929979;L=29990+-29990;Y=-130163-(-130216),C=-183325-(-183339);S=-835026-(-835066),N=520395-520336,d=-141652+141683;T=1012123+-1012101;["\053"]=-530533+530552;["\057"]=463608+-463583}local q=R local J=string.sub local L=string.len local h=string.char local i=type local j=table.concat for R=588853-588852,#q,404410+-404409 do local Z=q[R]if i(Z)=="\115\116\114\105\110\103"then local i=L(Z)local o={}local T=50177+-50176 local G=150146-150146 local B=746763-746763 while T<=i do local R=J(Z,T,T)local q=m[R]if q then G=G+q*(315214-315150)^((-42717+42720)-B)B=B+(-432106-(-432107))if B==-850606-(-850610)then B=-237076+237076 local R=U(G/(495125-429589))local m=U((G%(658385-592849))/(847843-847587))local q=G%(-397775-(-398031))A(o,h(R,m,q))G=790494+-790494 end elseif R=="\061"then A(o,h(U(G/(-782853+848389))))if T>=i or J(Z,T+(-945260+945261),T+(-723534+723535))~="\061"then A(o,h(U((G%(-360371-(-425907)))/(814311+-814055))))end break end T=T+(27279-27278)end q[R]=j(o)end end end return(function(R,m,q,J,L,h,i,Z,Q,e,B,S,p,o,T,a,V,G,j,N,U)p,e,o,a,T,V,Q,U,N,Z,G,S,B,j=function(R,A)local m=G(A)local q=function(...)return U(R,{...},A,m)end return q end,function(R,A)local m=G(A)local q=function(q,J,L)return U(R,{q,J,L},A,m)end return q end,function()T=(-496195+496196)+T Z[T]=465662+-465661 return T end,function(R,A)local m=G(A)local q=function(q)return U(R,{q},A,m)end return q end,-820680-(-820680),function(R)Z[R]=Z[R]-(704145-704144)if Z[R]==-797714+797714 then Z[R],j[R]=nil,nil end end,function(R,A)local m=G(A)local q=function(q,J,L,h,i)return U(R,{q;J;L;h;i},A,m)end return q end,function(U,q,J,L)local E,Jk,t,f,u,d,ok,Z,w,hk,Lk,Rk,Uk,I,k,z,qk,mk,v,g,K,F,y,Y,l,r,D,G,c,s,Vk,Ak,B,n,C,X,ik,Tk,H,b,O,P,Bk,M,W,Gk,x,Zk,i,jk,T while U do if U<9159764-822849 then if U<2984005-(-850674)then if U<1565698-(-417737)then if U<1565654-425080 then if U<-627850+1531793 then if U<-818941+1212087 then if U<-875284-(-1015424)then G=813029+-812976 T=j[J[-84099+84101]]Z=T*G T=31282976505772-952007 i=Z+T Z=178973+35184371909859 U=i%Z j[J[276426+-276424]]=U Z=j[J[732119+-732116]]T=396481-396480 i=Z~=T U=146048+4044975 else B=nil d=nil w=nil U=14263624-(-7561)end else if U<367883-(-451491)then Ak=y Rk=-531305+531306 Uk=-459704+459705 v=O mk=Uk Uk=-210259-(-210259)qk=mk<Uk U=-928453+4011475 Uk=Rk-mk else i={}U=true j[J[-891635+891636]]=U U=R[A(-710929-(-686399))]end end else if U<1594123-551273 then if U<95924+876254 then Z=A(-728198-(-703631))U=R[Z]T=j[J[787542-787534]]G=-808047+808047 Z=U(T,G)U=-961502+15234435 else T=A(18930+-43424)i=j[J[-354243-(-354247)]]U=not i d=-729384+13040243226848 j[J[-354838-(-354842)]]=U Z=R[T]w=A(480303-504783)G=j[J[223767+-223765]]B=j[J[982264+-982261]]l=B(w,d)U=11724761-780425 T=G[l]i=Z[T]T=.01 Z=i(T)end else D=o()v=A(-356598+332059)Uk=A(377691-402263)M=nil Y=A(-111050+86556)v=x[v]mk=20107464414251-(-774248)v=v(x)v=true k=nil j[D]=v H=nil d=nil g=nil y=nil l=nil O=R[Y]u=j[T]Rk=j[B]r=nil Ak=Rk(Uk,mk)E=nil Y=u[Ak]v=O[Y]Uk=A(677448-701921)G=nil x=nil Y=Q(-608784+14091961,{f;T;B;D;P})O=v(Y)F=nil Y=A(33842+-58336)t=nil f=V(f)O=R[Y]mk=10716585856577-(-1017149)u=j[T]U=R[A(-921777+897154)]Rk=j[B]Ak=Rk(Uk,mk)Y=u[Ak]v=O[Y]w=nil u=a(4171910-885749,{T,B})c=nil Y=243997+-243996.5 i={}B=V(B)T=V(T)D=V(D)P=V(P)X=nil O=v(Y,u)end end else if U<-178008+1599843 then if U<1866686-570553 then if U<441348-(-809790)then l=-236847+3656050942933 d=A(-526717+502132)U=j[J[-678391-(-678396)]]Z=j[J[511359+-511357]]B=A(-120464-(-95919))T=j[J[-603500-(-603503)]]G=T(B,l)i=Z[G]G=A(317158-341635)T=R[G]B=j[J[814927-814925]]k=33073900000583-350494 l=j[J[-413282-(-413285)]]w=l(d,k)G=B[w]Z=T[G]l=319053-319053 G=-179730-(-179730)B=-670714+670714 T=Z(G,B,l)U[i]=T U=-196029+1190317 else f=A(393200-417717)U=3799347-78715 r=R[f]f=A(1031240+-1055791)E=r[f]n=E end else if U<2054930-660824 then U=E M=A(107302+-131886)f=j[T]P=j[B]x=3137696754280-681139 g=P(M,x)r=f[g]k=K E=k==r U=E and-440944+9277677 or 5667479-532973 else U=2722683-(-954065)K=A(508607-533158)n=R[K]i=n end end else if U<2368739-627642 then if U<-876713+2613393 then T=A(-97913-(-73302))G=1172425-(-974118)Z=T^G i=11655415-279859 U=i-Z i=A(978275+-1002832)Z=U U=i/Z i={U}U=R[A(-104379+79876)]else v=nil U=99583+11412528 end else T=j[J[-344574+344577]]G=-31027+31028 Z=T~=G U=Z and-236435+10404325 or-644218+4835241 end end end else if U<284825+2697108 then if U<3272806-794751 then if U<2652355-508128 then if U<-281852+2361749 then T=G U=j[J[-969112-(-969113)]]n=1022763+-1022508 k=101889+-101889 d=U(k,n)Z[T]=d T=nil U=10321364-(-139931)else B=A(-396952+372404)i=A(-399752-(-375242))U=R[i]k=A(-846048-(-821443))Z=j[J[-908572+908576]]G=R[B]n=Q(10321464-(-441037),{})d=R[k]k={d(n)}d=580921-580919 w={m(k)}l=w[d]B=G(l)G=A(-1011728-(-987118))T=Z(B,G)Z={T()}i=U(m(Z))T=j[J[-89571-(-89576)]]Z=i i=T U=T and 5427885-865600 or 10460398-774232 end else if U<2677901-401609 then U=R[A(605555+-630120)]i={}else M=138407-138407 g=#f P=g==M U=P and 9004208-199561 or 15716159-159676 end end else if U<1767878-(-991097)then if U<-85603+2771223 then B=672692+-672691 T=j[J[875393+-875392]]l=807738+-807736 G=T(B,l)T=-162754-(-162755)Z=G==T U=Z and 8695622-721880 or-409826+13997561 i=Z else U=a(320356+3652273,{B})z={U()}U=R[A(946143-970658)]i={m(z)}end else x=o()t=1008067+-1008065 c=170395-170394 y=A(-428819-(-404271))W=A(-617228-(-592700))j[x]=s i=R[W]X=307936+-307836 W=A(-302935-(-278451))U=i[W]W=-253789-(-253790)Y=-612515+622515 i=U(W,X)W=o()H=-18808-(-19063)X=153276+-153276 j[W]=i U=j[d]i=U(X,H)X=o()j[X]=i U=j[d]F=j[W]H=118844-118843 O=248711-248711 i=U(H,F)H=o()j[H]=i i=j[d]F=i(c,t)t=A(291746-316245)i=531618+-531617 U=F==i i=A(-351246+326636)F=o()j[F]=U b=R[y]v=j[d]D={v(O,Y)}y=b(m(D))b=A(-872223-(-847724))C=y..b U=A(1020142+-1044745)U=P[U]c=t..C t=A(-585364+560759)U=U(P,i,c)c=o()j[c]=U C=S(2042080-(-458777),{d;x,K;G;T;g,F;c;W,H;X;n})i=R[t]t={i(C)}U={m(t)}t=U U=j[F]U=U and 145735+6400797 or-858460+9226459 end end else if U<3409872-64328 then if U<118858+2974812 then if U<2372388-(-684440)then j[T]=C D=j[H]O=-56049-(-56050)v=D+O y=t[v]b=E+y y=629579+-629323 U=b%y v=j[X]y=r+v v=565586+-565330 b=y%v E=U r=b U=686852+12703987 else Jk=not qk Uk=Uk+mk Rk=Uk<=Ak Rk=Jk and Rk Jk=Uk>=Ak Jk=qk and Jk Rk=Jk or Rk Jk=-971128+15057744 U=Rk and Jk Rk=-1031746+2769475 U=U or Rk end else U=S(8901494-373556,{J[-436267-(-436268)];J[635650+-635648]})k=A(-126543+101970)T=o()Z=U B=A(-1025127+1000633)U=a(3631028-(-270746),{J[754353+-754352],J[622142-622140];T})n=986685+15937889210048 j[T]=U i=R[B]l=j[J[333306-333305]]U=Q(47894+14362517,{J[860057+-860056];J[-265158-(-265160)]})G=U w=j[J[-170386+170388]]d=w(k,n)B=l[d]U=i[B]B=A(-163629+139135)i=U(Z)i=R[B]l=j[J[429663-429662]]n=136871+16509660350304 k=A(518630-543135)w=j[J[-221385+221387]]d=w(k,n)Z=nil B=l[d]U=i[B]B=j[T]n=410108+1767082819898 i=U(B)T=V(T)B=A(-696457-(-671963))k=A(-144083+119489)i=R[B]l=j[J[274243-274242]]w=j[J[786098+-786096]]d=w(k,n)B=l[d]U=i[B]i=U(G)i={}U=R[A(1010385+-1034882)]G=nil end else if U<559487+3155830 then if U<505398+3071132 then Z=j[J[-337360-(-337361)]]i=#Z Z=-1013743-(-1013743)U=i==Z U=U and 638772-546784 or 12091617-(-427955)else n=o()j[n]=i U=j[d]K=-962349+962352 E=-126986-(-127051)P=a(693893+1005641,{})i=U(K,E)K=o()j[K]=i U=-330893-(-330893)E=U U=-419199-(-419199)r=U f=A(333498+-358103)i=R[f]f={i(P)}U={m(f)}i=869274+-869272 f=U U=f[i]P=U i=A(-187976+163466)U=R[i]I=A(84003+-108551)g=j[G]z=R[I]I=z(P)z=A(-95514-(-70904))s=g(I,z)g={s()}i=U(m(g))g=o()j[g]=i i=-690756-(-690757)s=j[K]z=s s=974943+-974942 I=s U=15252634-671044 s=-859672-(-859672)M=I<s s=i-I end else i=n U=K U=n and 2956294-(-720454)or 484561+910945 end end end end else if U<5007600-(-908671)then if U<517891+3917309 then if U<-474546+4598895 then if U<3219104-(-714671)then if U<-884463+4752623 then B=A(745911+-770427)l=845660+1023095184000 U=j[J[-80769+80774]]Z=j[J[1039079-1039077]]T=j[J[9787-9784]]d=A(-1028197-(-1003577))G=T(B,l)i=Z[G]G=A(866127+-890604)T=R[G]k=142262+20268516653352 B=j[J[-222015-(-222017)]]l=j[J[-84107-(-84110)]]w=l(d,k)G=B[w]Z=T[G]G=-450929-(-450930)B=224390-224389 l=-617881+617882 T=Z(G,B,l)U[i]=T U=-27290-(-1021578)else Z=A(1024091+-1048585)i=R[Z]l=A(-1050027-(-1025492))T=j[J[787266+-787265]]w=-584090+8230162528402 G=j[J[-873987-(-873989)]]B=G(l,w)Z=T[B]U=i[Z]Z=N(926062+7748463,{J[-507210+507213]})i=U(Z)i={}U=R[A(-874141+849675)]end else if U<-1043025+5013312 then n=V(n)B=V(B)T=V(T)r=nil K=V(K)T=nil P=nil B=o()f=nil E=nil l=V(l)g=V(g)w=nil k=nil f={}d=V(d)d=A(688198+-712726)w=A(317951+-342479)k=A(771720+-796237)E={}g=-261122+261378 j[B]=T G=V(G)P=-947738+947739 G=nil T=o()j[T]=G l=R[w]w=A(-50809-(-26300))G=l[w]l=o()j[l]=G w=R[d]d=A(-386077-(-361593))G=w[d]d=R[k]k=A(-530585+506116)w=d[k]n=A(839230+-863721)k=R[n]n=A(-660370-(-635905))d=k[n]r=o()k=-337383+337383 M=g n=o()j[n]=k g=-652279+652280 k=954404+-954402 U=919951+9379333 x=g K=o()j[K]=k k={}j[r]=E g=1044214+-1044214 E=-843389-(-843389)W=x<g g=P-x else U=10042349-442744 end end else if U<4732036-381921 then if U<32992+4182220 then T=j[J[840657+-840654]]G=834560+-834354 Z=T*G T=467540-467283 i=Z%T U=760563+984912 j[J[-851909-(-851912)]]=i else M=A(-841700+817207)U=R[M]M=A(-481934+457397)R[M]=U U=7877533-(-106912)end else U=j[J[71537-71530]]U=U and 962583-15286 or 423354+13849579 end end else if U<4856428-(-501958)then if U<4844514-(-245382)then if U<-312486+5142523 then G=j[J[984315+-984309]]T=G==Z i=T U=9932941-246775 else Z={h(-245492+245493,m(q))}n={m(Z)}i=A(-79384+54833)U=R[i]K=939183+-939180 k=n[K]n={U(k)}T=n[-452653-(-452655)]B=n[46953-46949]l=n[147074+-147069]U=A(-1034918+1010286)i=n[-400411-(-400412)]G=n[509957+-509954]d=n[-690217-(-690224)]R[U]=i w=n[631560+-631554]n=A(-845333-(-820866))U=A(172565+-197072)R[U]=T U=A(-527189+502599)R[U]=G U=A(980649+-1005247)R[U]=B i={}U=A(561347+-585946)R[U]=l U=A(-479294-(-454699))R[U]=w k=A(-744333-(-719866))U=A(-27803+3181)R[U]=d U=e(948809+12738567,{})R[k]=U U=R[A(420358-444926)]k=R[n]n=k()end else x=15200589693932-452678 g=A(-851709+827127)M=-859043+33626560125133 r=j[T]f=j[B]P=f(g,M)E=r[P]M=A(-691619-(-666977))f=j[T]P=j[B]g=P(M,x)r=f[g]F=12964505308379-(-19130)g=A(-990233+965747)P=R[g]H=A(-702260+677694)M=j[T]x=j[B]D=-543132+8590577228092 X=x(H,F)U=12544669-1032558 g=M[X]c=5331282948010-(-973320)f=P[g]M=j[T]F=20024+9111342269018 x=j[B]H=A(-783398+758866)X=x(H,F)g=M[X]P=f(g)f=o()j[f]=P y=A(1046266+-1070824)P=j[f]M=j[T]F=25327+239892241792 x=j[B]H=A(906323-930898)X=x(H,F)g=M[X]x=j[T]X=j[B]F=A(-599141-(-574654))H=X(F,c)M=x[H]P[g]=M P=j[f]H=A(-230266+205623)F=811117+33811765255443 M=j[T]x=j[B]X=x(H,F)g=M[X]M=false P[g]=M P=j[f]H=A(302526-327143)M=j[T]F=-1008742+6710518608026 x=j[B]X=x(H,F)H=A(788119-812619)g=M[X]M=true F=-447181+22545407032271 P[g]=M P=j[f]M=j[T]x=j[B]c=290+26869511630782 X=x(H,F)g=M[X]M=d P[g]=M M=A(658011+-682497)F=A(708033+-732589)g=R[M]x=j[T]v=411363+8324308437057 X=j[B]H=X(F,c)F=A(892454-917089)M=x[H]c=647527+31184147355474 P=g[M]x=j[T]X=j[B]H=X(F,c)Ak=13261478074921-524810 F=A(-472758+448225)M=x[H]g=P(M)P=o()j[P]=g g=j[P]x=j[T]X=j[B]c=-93397+26952254201307 H=X(F,c)M=x[H]H=A(635766-660378)X=R[H]F=j[T]c=j[B]t=c(y,v)H=F[t]c=317719-317718 x=X[H]H=-75408-(-75409)v=529797955857-(-802789)y=A(391944+-416482)t=-394419+394419 F=719899-719899 X=x(H,F,c,t)F=A(365528-390068)c=-911717+10843734031646 g[M]=X g=j[P]x=j[T]X=j[B]H=X(F,c)M=x[H]H=A(-694691-(-670079))X=R[H]F=j[T]c=j[B]t=c(y,v)H=F[t]x=X[H]c=-488635+488635 H=-732817+732817 F=820347+-820347 t=-182090+182090 X=x(H,F,c,t)F=A(118811-143282)v=13752570649198-770410 c=31452423233541-452303 y=A(587665-612302)g[M]=X g=j[P]x=j[T]X=j[B]H=X(F,c)M=x[H]H=A(-196464-(-171987))X=R[H]F=j[T]c=j[B]t=c(y,v)H=F[t]x=X[H]H=427546-427545 c=136963+-136962 F=-845318+845319 X=x(H,F,c)c=7939840550061-939580 g[M]=X g=j[P]x=j[T]v=26091816079423-(-941878)X=j[B]F=A(-515743-(-491279))H=X(F,c)M=x[H]x=-922996+922996 g[M]=x F=A(-771094-(-746598))g=j[P]c=-135347+30526977361978 x=j[T]X=j[B]y=A(968325-992951)H=X(F,c)c=9851173288640-(-38699)M=x[H]x=190632-190631 g[M]=x g=j[P]F=A(-770267+745806)x=j[T]X=j[B]H=X(F,c)M=x[H]x=j[f]c=A(1008925+-1033514)g[M]=x t=-669212+9957949524025 x=A(-119933-(-95447))M=R[x]Uk=A(179148+-203692)X=j[T]H=j[B]F=H(c,t)c=A(215824-240312)x=X[F]g=M[x]X=j[T]H=j[B]t=-976864+17675636901894 F=H(c,t)x=X[F]M=g(x)x=j[T]F=A(53120+-77603)c=2184279591689-(-915696)X=j[B]H=X(F,c)g=x[H]H=A(-449397-(-424785))X=R[H]F=j[T]c=j[B]t=c(y,v)qk=14397280233471-134607 y=A(826484+-851097)H=F[t]F=-901273+901273 x=X[H]c=448471+-448470 H=81493-81492 t=-65593-(-65593)X=x(H,F,c,t)F=A(-1009214+984673)M[g]=X x=j[T]X=j[B]c=514185+12654699642491 H=X(F,c)g=x[H]H=A(588438+-613050)X=R[H]F=j[T]v=33295134401361-(-284991)c=j[B]t=c(y,v)H=F[t]x=X[H]c=-443888-(-443888)H=552722+-552722 t=-13300+13300 F=7879-7879 X=x(H,F,c,t)M[g]=X F=A(171781-196369)x=j[T]X=j[B]c=4414773524048-273993 H=X(F,c)F=A(-821561-(-797059))g=x[H]u=92103+888257354198 c=-231886+34980429203823 x=27512-27511 M[g]=x x=j[T]X=j[B]H=X(F,c)g=x[H]F=A(-383099-(-358570))x=930854-930854 M[g]=x x=j[T]X=j[B]c=-455252+1135803004004 H=X(F,c)g=x[H]x=-828682-(-828682)c=662299+30736926629069 M[g]=x x=j[T]v=2933752009197-(-930665)X=j[B]F=A(-684456-(-659827))H=X(F,c)g=x[H]H=A(-268352-(-243740))y=A(-276471-(-251852))X=R[H]F=j[T]c=j[B]t=c(y,v)y=15898258409397-142026 H=F[t]x=X[H]F=661459+-661459 t=-177198-(-177198)c=-825321+825321 H=654048-654048 X=x(H,F,c,t)c=577830+34762361237013 F=A(1004094+-1028570)M[g]=X x=j[T]X=j[B]H=X(F,c)Y=A(428671+-453161)t=A(419895-444511)g=x[H]c=-876329+10753145303736 F=A(-46924-(-22288))x=57098+-57096 M[g]=x x=j[T]X=j[B]H=X(F,c)g=x[H]x=j[f]X=A(-357812+333326)M[g]=x x=R[X]H=j[T]F=j[B]c=F(t,y)X=H[c]t=A(983983+-1008458)g=x[X]H=j[T]y=1031526+8689330967144 F=j[B]c=F(t,y)X=H[c]x=g(X)t=-141148+10993036835675 X=j[T]c=A(324878+-349441)H=j[B]F=H(c,t)g=X[F]X=r x[g]=X X=j[T]c=A(-854464+829855)H=j[B]t=790923+21229541397778 F=H(c,t)g=X[F]X=480071-480061 Rk=A(292001-316520)t=7316726580883-620868 x[g]=X c=A(-175696-(-151099))X=j[T]H=j[B]F=H(c,t)mk=14108263475738-(-618383)g=X[F]X=true x[g]=X X=j[T]t=17703555337115-1026920 c=A(274293-298874)H=j[B]F=H(c,t)g=X[F]X=j[f]F=A(-518744+494249)v=A(314157+-338761)x[g]=X H=R[F]c=j[T]t=j[B]y=t(v,D)F=c[y]v=-532667+34186238140138 X=H[F]y=A(795990-820517)F=j[T]c=j[B]t=c(y,v)v=A(252793-277372)H=F[t]g=X[H]D=-576521+13703330784502 F=A(-444792-(-420306))H=R[F]c=j[T]t=j[B]y=t(v,D)F=c[y]D=31417+358458656237 X=H[F]c=j[T]t=j[B]v=A(132842-157356)y=t(v,D)F=c[y]H=X(F)y=A(-24108-452)v=7326174447551-96876 F=j[T]c=j[B]t=c(y,v)X=F[t]F=E H[X]=F v=24547064305744-961450 y=A(140054-164628)F=j[T]c=j[B]t=c(y,v)X=F[t]y=A(283370-307946)t=R[y]v=j[T]D=j[B]O=D(Y,u)y=v[O]O=A(578382-602953)c=t[y]y=j[T]Y=3594225808517-781820 v=j[B]D=v(O,Y)t=y[D]v=3115261129396-11530 F=c[t]H[X]=F u=585688+29267165660516 Y=416155+12966434029050 F=j[T]c=j[B]y=A(603048+-627526)t=c(y,v)X=F[t]v=376190+8828096680592 y=A(-78184+53614)F=-380050-(-380120)H[X]=F F=j[T]c=j[B]t=c(y,v)X=F[t]v=34121202571037-317709 F=false H[X]=F y=A(-694-23893)F=j[T]c=j[B]O=A(517623-542248)t=c(y,v)X=F[t]t=A(-708410-(-683798))c=R[t]y=j[T]v=j[B]D=v(O,Y)t=y[D]y=659912-659912 v=471030+-471029 F=c[t]D=-1038726-(-1038726)t=938051-938050 c=F(t,y,v,D)v=18786046387472-475877 H[X]=c F=j[T]c=j[B]y=A(-760232-(-735598))t=c(y,v)X=F[t]F=j[f]c=A(-245310+220816)D=A(607741-632215)H[X]=F F=R[c]t=j[T]y=j[B]O=16612465965304-(-107839)v=y(D,O)O=A(-48412-(-23866))c=t[v]X=F[c]D=380623+15150714571968 F=X()v=A(-14967+-9586)c=j[T]t=j[B]y=t(v,D)F=c[y]X=H[F]F=A(117963-142464)F=H[F]F=F(H)Y=-1045927+9693491889992 y=j[T]v=j[B]D=v(O,Y)t=y[D]c=X[t]Y=A(137307-161935)t=119934+-119914 F=c+t v=j[T]D=j[B]O=D(Y,u)y=v[O]t=X[y]y=124035-124025 c=t+y D=A(-415794+391266)v=R[D]O=j[T]Y=j[B]u=Y(Rk,Ak)D=O[u]y=v[D]u=j[T]Rk=j[B]Ak=Rk(Uk,mk)Y=u[Ak]O=g[Y]D=O/c v=y(D)y=-3408-(-3410)t=v+y Ak=A(653037+-677652)O=A(323402+-347930)mk=A(56332+-80836)D=R[O]Uk=29063223823883-710958 Y=j[T]u=j[B]Rk=u(Ak,Uk)O=Y[Rk]v=D[O]Rk=j[T]Ak=j[B]Uk=Ak(mk,qk)u=Rk[Uk]Y=g[u]O=Y/F D=v(O)v=283506+-283504 y=D+v O=-70766-(-70767)D=t v=314700-314699 Y=O O=-100412+100412 u=Y<O O=v-Y end else if U<4797295-(-921082)then if U<-590455+6013946 then P=j[T]X=26322154319973-295044 g=j[B]x=A(894914-919516)M=g(x,X)f=P[M]r=G[f]U=421363+947859 K=r else k=K U=8324946-531694 I=A(-74431+49940)z=R[I]I=A(65890-90437)s=z[I]z=s(Z,k)s=j[J[1005527+-1005521]]I=s()g=z+I P=g+w I=800958-800957 g=-82064+82320 k=nil f=P%g g=G[T]w=f z=w+I s=B[z]P=g..s G[T]=P end else z=E==r s=z U=8812712-468781 end end end else if U<-847858+8258154 then if U<-1004294+7653977 then if U<670703+5550285 then if U<16004+6124479 then i=A(-698299-(-673806))Z=A(468956-493493)U=R[i]i=R[Z]Z=A(-719638+695101)R[Z]=U Z=A(369301+-393794)R[Z]=i U=-23859+9623464 Z=j[J[-80688-(-80689)]]T=Z()else U=R[A(384152+-408672)]i={}end else if U<-749699+7291435 then i=A(266167+-290734)U=R[i]Z=A(-282761+258236)i=U(Z)i={}U=R[A(754318-778790)]else C=j[T]U=C and 506807+9620278 or 12640746-655773 i=C end end else if U<7234331-466743 then if U<-448260+7162260 then M=-271958+271964 U=j[d]I=-92104+92105 z=U(I,M)M=A(-637738+613245)U=A(967837-992330)R[U]=z I=R[M]M=-458826-(-458828)U=I>M U=U and 7988338-472903 or 3669789-(-660433)else d=-877767+878022 U={}j[J[866861-866859]]=U k=A(-956181-(-931690))i=j[J[178921+-178918]]B=i l=-806180+35184372895012 i=T%l j[J[1025048+-1025044]]=i w=T%d d=-869224-(-869226)l=w+d j[J[-752424-(-752429)]]=l d=R[k]k=A(803565+-828183)w=d[k]U=8206132-412880 d=w(Z)w=A(128509+-153061)G[T]=w n=d K=197316-197315 E=K k=789153+-789152 w=-207505-(-207519)K=-943787-(-943787)r=E<K K=k-E end else r=j[T]g=A(68151-92742)M=3025040760713-809481 f=j[B]P=f(g,M)E=r[P]n=G[E]k=n U=14976154-501613 end end else if U<8153845-334885 then if U<6958008-(-722708)then if U<143462+7337928 then M=825159-825159 U=235233+15321250 g=#f P=g==M else I=A(-247119+222571)U=R[I]x=A(319764-344301)M=R[x]I=U(M)U=A(-743077+718584)R[U]=I U=8784999-800554 end else K=K+E f=not r k=K<=n k=f and k f=K>=n f=r and f k=f or k f=344191+5115251 U=k and f k=1249406-1027691 U=U or k end else if U<8148503-9472 then if U<8199733-222256 then U=i and 1624835-(-459821)or 4407318-32871 else U=-561783+11814875 end else U=j[J[507629+-507625]]U=U and 121610-(-1021917)or-876758+4740261 end end end end end else if U<12226439-358691 then if U<11021271-864428 then if U<581895+8397091 then if U<-488846+9148157 then if U<8535314-176746 then if U<8562517-218986 then l=o()T=o()Z=q G=A(-552273+527782)U=true j[T]=U i=R[G]G=A(626369+-650837)U=i[G]k=e(1085991-184431,{l})B=o()G=o()j[G]=U U=Q(6543700-5116,{})j[B]=U d=A(-481166-(-456561))U=false j[l]=U w=R[d]d=w(k)i=d U=d and 472260+11340462 or-14329+12620034 else j[T]=s U=j[T]U=U and 11068280-660540 or 15288523-(-969233)end else if U<7968060-(-487882)then b=j[T]U=b and 422274+10425940 or 741535+2279596 C=b else U=-282876+9474099 end end else if U<9162250-327712 then if U<8094913-(-640591)then U=9853154-(-956711)else g=o()M=e(-319455+3836459,{g;n;K,l})k=nil X={}G=nil F=A(-135062-(-110448))P={}x=o()j[g]=P t=A(567935-592485)l=V(l)P=o()w=nil y=nil j[P]=M M={}W=A(-313496-(-288975))j[x]=M M=R[W]c=j[x]l=A(762166+-786628)E=nil H={[F]=c;[t]=y}W=M(X,H)j[T]=W M=e(9836555-(-31175),{x,g;r,n,K,P})r=V(r)j[B]=M G=R[l]l=A(-205339-(-180826))K=V(K)n=V(n)g=V(g)l=G[l]d=nil x=V(x)K=A(213793+-238319)f=nil E=153890+22333030649725 P=V(P)d=j[T]k=j[B]n=k(K,E)w=d[n]l=l(G,w)g=-740180+31110854919147 r=27517479705199-436322 w=A(-790775-(-766313))G=R[w]E=A(919410-943979)w=A(-116017-(-91504))k=j[T]n=j[B]K=n(E,r)d=k[K]E=A(-955121+930520)w=G[w]w=w(G,d)k=j[T]P=A(-844276-(-819787))f=908021+30163435428840 n=j[B]r=387816+16133867778672 K=n(E,r)d=k[K]G=l[d]n=j[T]d=A(162488+-187052)r=A(958648+-983197)d=G[d]K=j[B]E=K(r,f)k=n[E]d=d(G,k)k=nil E=j[T]r=j[B]f=r(P,g)K=E[f]n=G[K]U=n and 8768458-(-691099)or-588484+14826859 end else U=R[A(482715+-507194)]i={}end end else if U<9170273-(-431925)then if U<10145046-680750 then if U<9659564-223930 then U=true U=U and 10314555-(-384047)or-633070+15431342 else g=13507328671216-337247 E=j[T]r=j[B]P=A(-475529+450967)f=r(P,g)K=E[f]n=G[K]M=-382854+22325729198114 r=j[T]f=j[B]K=A(-280819+256195)g=A(270978+-295608)P=f(g,M)E=r[P]K=n[K]K=K(n,E)U=K and 1019515+5956893 or 14284975-(-189566)end else if U<-767206+10340254 then U=13737555-(-533630)else U=true U=U and-392863+6372618 or-299456+2509460 end end else if U<-558339+10484944 then if U<202225+9618534 then j[J[-419358-(-419363)]]=i Z=nil U=592754+3781693 else Z=q[638788-638787]T=q[659772-659770]U=j[J[76784-76783]]G=U U=G[T]U=U and 273565+9274993 or 7713192-973996 end else D=785422+-785421 v=t[D]b=U D=false y=v==D U=y and 913969+14322093 or 12673879-(-213632)C=y end end end else if U<742401+10034344 then if U<10258614-(-215935)then if U<10970098-615544 then if U<630063+9623386 then E=958527+-958514 T=j[J[620483-620480]]G=774678+-774646 Z=T%G B=j[J[689789-689785]]n=794672+-794670 d=j[J[943725-943723]]P=j[J[-28272-(-28275)]]f=P-Z P=894009-893977 r=f/P K=E-r k=n^K w=d/k l=B(w)E=-303454-(-303710)B=4295432901-465605 G=l%B l=352399-352397 B=l^Z T=G/B k=212850+-212849 B=j[J[-284387+284391]]d=T%k k=33595+4294933701 w=d*k l=B(w)B=j[J[-271310+271314]]w=B(T)G=l+w l=226047-160511 d=-979531+1045067 B=G%l w=G-B l=w/d G=nil d=367830+-367574 n=-105913-(-106169)w=B%d U=12053130-(-466442)k=B-w d=k/n Z=nil n=930075-929819 k=l%n K=l-k n=K/E l=nil B=nil K={w;d,k;n}T=nil w=nil d=nil n=nil j[J[-331382+331383]]=K k=nil else X=not W g=g+x P=g<=M P=X and P X=g>=M X=W and X P=X or P X=15227484-(-269979)U=P and X P=-774526+8224899 U=U or P end else if U<-233635+10693393 then U=12630+3955799 else d=not w G=G+l T=G<=B T=d and T d=G>=B d=w and d T=d or T d=1761358-(-302451)U=T and d T=15494622-(-34266)U=U or T end end else if U<5466+10729608 then if U<-998591+11706779 then Z=A(36477+-60971)w=14351310642847-(-293755)i=R[Z]T=j[J[-732767+732768]]G=j[J[280522-280520]]l=A(348128-372591)B=G(l,w)Z=T[B]U=i[Z]Z=A(-435228-(-410742))i=U()i=R[Z]T=j[J[524671+-524670]]l=A(-598388-(-573928))w=26301719727769-(-319806)G=j[J[385659-385657]]B=G(l,w)Z=T[B]U=i[Z]w=24824850186472-(-797759)T=j[J[413944+-413943]]G=j[J[614241-614239]]l=A(192258+-216885)B=G(l,w)Z=T[B]G=A(529044-553539)T=R[G]i=U(Z,T)U=8243561-(-947662)else U=true U=U and-892237+13605733 or 219516+2500584 end else G=5230266-717698 i=9237699-548937 T=A(1003205+-1027766)Z=T^G U=i-Z i=A(-38797+14176)Z=U U=i/Z i={U}U=R[A(-329353+304767)]end end else if U<-653843+11855514 then if U<10872593-(-59058)then if U<11305128-460057 then U=true U=U and 762839+11463676 or-92017+16270422 else U=-345072+3366203 y=-741135+741136 b=t[y]C=b end else w=17421421632066-(-591214)l=A(-1062535-(-1037894))i=j[J[365924+-365923]]T=j[J[749449+-749447]]G=j[J[-282892-(-282895)]]B=G(l,w)Z=T[B]U=i[Z]U=U and-319756+8631703 or 6753194-587016 end else if U<11060527-(-613462)then if U<-500890+11756691 then U=true U=U and 6594285-(-59489)or 93154+16542384 else Rk=not u O=O+Y v=O<=D v=Rk and v Rk=O>=D Rk=u and Rk v=Rk or v Rk=-325340+988625 U=v and Rk v=1523253-477186 U=U or v end else U=-701729+13307434 w=j[l]i=w end end end end else if U<15030340-758258 then if U<14233856-841612 then if U<641977+12015734 then if U<11681757-(-797323)then if U<976692+11089117 then U=12913163-(-477676)j[T]=i else U=j[J[118812+-118811]]i=U()U=-887472+11697337 end else if U<12369451-(-168358)then U=R[A(-804147-(-779593))]G=A(-1031227-(-1006710))T=R[G]G=A(-779522+755053)Z=T[G]G=j[J[6704-6703]]T={Z(G)}i={m(T)}else k=A(110461+-134978)d=A(784854+-809382)r=A(-541787-(-517270))w=i i=R[d]d=A(-216193+191709)U=i[d]d=o()j[d]=U i=R[k]k=A(106031-130562)U=i[k]K=U k=U E=R[r]n=E U=E and 460095+818496 or 3712544-(-8088)end end else if U<12641839-(-378105)then if U<936290+11817381 then U=747037+10506055 else i=C U=b U=-70954+12055927 end else W=V(W)x=V(x)U=587135+13994455 X=V(X)F=V(F)t=nil c=V(c)H=V(H)end end else if U<-116105+14130802 then if U<13168030-(-423396)then if U<12886042-(-678766)then U=324560+10619776 else T=j[J[508546+-508544]]G=j[J[-138228-(-138231)]]Z=T==G U=-117209+8090951 i=Z end else T=A(-1022090-(-997491))i=A(-918731+894099)U=R[i]Z=R[T]i=U(Z)G=A(601365+-625960)U=A(-752657-(-728019))Z=A(895560-920198)R[U]=i T=A(931107-955697)U=R[Z]Z=R[T]i={}T=R[G]U[Z]=T T=A(233921-258559)G=A(-927226-(-902604))Z=R[T]T=R[G]G=A(-889609-(-865142))U=Z[T]Z=A(-573279+548767)Z=U[Z]T=R[G]Z=Z(U,T)T=A(721697+-746204)G=A(28598-53196)Z=A(406400+-431038)U=R[Z]Z=R[T]T=R[G]U[Z]=T U=R[A(249004+-273610)]end else if U<-619207+14882237 then if U<-267414+14430769 then Gk=A(-270794-(-246202))Rk=Uk Lk=A(502419-526905)hk=R[Lk]Zk=A(746918-771429)ik=j[T]ok=-114110+9660819394384 jk=j[B]Tk=jk(Zk,ok)Lk=ik[Tk]Zk=A(6159-30752)Jk=hk[Lk]ok=-513646+31996976582817 ik=j[T]jk=j[B]Tk=jk(Zk,ok)Lk=ik[Tk]hk=Jk(Lk)Tk=A(-929196-(-904613))Lk=j[T]Bk=-256429+20413963964110 Zk=13975269262287-(-546204)ik=j[B]jk=ik(Tk,Zk)Jk=Lk[jk]jk=A(192789+-217401)ik=R[jk]Tk=j[T]Zk=j[B]ok=Zk(Gk,Bk)jk=Tk[ok]Lk=ik[jk]Tk=1021244+-1021244 jk=-742497+742497 ik=Lk(jk,F,Tk,c)hk[Jk]=ik Zk=12710862797927-566601 Tk=A(204908-229504)Lk=j[T]ik=j[B]jk=ik(Tk,Zk)Bk=397483+22664601409679 Jk=Lk[jk]jk=A(-1001616+977004)ik=R[jk]Gk=A(-869665-(-845065))Tk=j[T]Vk=13926181594394-(-1029178)Zk=j[B]ok=Zk(Gk,Bk)jk=Tk[ok]Bk=-240221+240222 Lk=ik[jk]jk=-820384+820384 ok=428804-428803 Zk=Rk-ok Tk=Zk*F Zk=-516585+516585 Gk=v-Bk ok=Gk*c ik=Lk(jk,Tk,Zk,ok)hk[Jk]=ik Lk=j[T]ik=j[B]Rk=nil Zk=179795+31407000238798 Tk=A(685909-710379)jk=ik(Tk,Zk)Tk=A(384986-409510)U=2720204-(-362818)Jk=Lk[jk]Lk=-338585-(-338586)hk[Jk]=Lk Zk=-250019+33940404686431 Lk=j[T]ik=j[B]jk=ik(Tk,Zk)Jk=Lk[jk]Bk=A(143331-167854)Lk=E hk[Jk]=Lk Zk=-426010+29981328193187 Tk=A(478534+-503093)Lk=j[T]ik=j[B]jk=ik(Tk,Zk)Tk=A(-897866-(-873290))Jk=Lk[jk]jk=R[Tk]Zk=j[T]ok=j[B]Gk=ok(Bk,Vk)Tk=Zk[Gk]Gk=A(-904899+880260)ik=jk[Tk]Bk=7346609547469-531312 Tk=j[T]Zk=j[B]ok=Zk(Gk,Bk)jk=Tk[ok]Lk=ik[jk]hk[Jk]=Lk Tk=A(-44953-(-20373))Lk=j[T]Zk=28983193092740-(-176692)ik=j[B]jk=ik(Tk,Zk)Bk=1124994680836-(-834055)Jk=Lk[jk]Tk=A(41093+-65733)Lk=-903048-(-903118)hk[Jk]=Lk Lk=j[T]ik=j[B]Zk=27629512731949-(-99604)jk=ik(Tk,Zk)Jk=Lk[jk]Zk=7705067405986-(-297825)Lk=true hk[Jk]=Lk Lk=j[T]ik=j[B]Tk=A(468222+-492704)jk=ik(Tk,Zk)Gk=A(47173-71716)Jk=Lk[jk]jk=A(704934-729411)ik=R[jk]Tk=j[T]Zk=j[B]ok=Zk(Gk,Bk)jk=Tk[ok]Zk=-498964+498964 Tk=-704101-(-704101)Lk=ik[jk]jk=1014491+-1014490 ik=Lk(jk,Tk,Zk)Tk=A(-919942-(-895334))hk[Jk]=ik Zk=16992203110502-(-960130)Lk=j[T]ik=j[B]jk=ik(Tk,Zk)Jk=Lk[jk]Lk=-6321+6321.5 hk[Jk]=Lk Lk=j[T]ik=j[B]Tk=A(-127635-(-103099))Zk=-351286+8593325501399 jk=ik(Tk,Zk)Jk=Lk[jk]Lk=-370014+370017 hk[Jk]=Lk Lk=j[T]ik=j[B]Tk=A(285444-309950)Zk=4719220990595-432622 jk=ik(Tk,Zk)Jk=Lk[jk]Lk=M hk[Jk]=Lk hk=nil else E=U U=k and 436360-(-932862)or 5246206-(-157888)K=k end else U=R[A(713340+-737882)]i={T}end end end else if U<15471975-24002 then if U<180262+14575683 then if U<-796527+15233649 then if U<397364+13915495 then U={}T=389901-389900 Z=U G=j[J[458814-458805]]B=G G=-568617-(-568618)U=1037579+9423716 l=G G=903296-903296 w=l<G G=T-l else i=A(588651-613172)Z={}d=A(-228238+203607)k=148981+5514627892242 U=R[i]B=j[J[786886-786885]]l=j[J[839394-839392]]w=l(d,k)G=B[w]B=p(-275999+5161326,{})r=A(990765-1015287)T={[G]=B}i=U(Z,T)Z=j[J[732065-732064]]K=A(-1027005-(-1002487))k=A(415440+-440017)n=696947+5042765211321 T=j[J[-115535+115537]]B=A(828710+-853218)l=-769242+34485671033748 f=570878+6970126980783 G=T(B,l)U=Z[G]B=A(-360233+335747)E=928464+17753627227515 G=R[B]l=j[J[-185048+185049]]w=j[J[-968598-(-968600)]]d=w(k,n)B=l[d]T=G[B]B=j[J[-748522+748523]]d=A(96420-120901)k=19489898172996-323281 l=j[J[-1035808-(-1035810)]]w=l(d,k)n=936159+19715260947197 G=B[w]k=A(421183-445668)l=j[J[-565865-(-565866)]]w=j[J[-23117-(-23119)]]d=w(k,n)B=l[d]w=A(-1032324+1007829)l=R[w]d=j[J[814587+-814586]]k=j[J[-66855+66857]]n=k(K,E)w=d[n]n=j[J[-990438-(-990439)]]d=false K=j[J[216974+-216972]]E=K(r,f)k=n[E]Z={T,G,B;l;w,d,k}i[U]=Z U=R[A(-785394-(-760787))]i={}end else if U<14557379-79448 then K=nil U=13597313-(-641062)else s=s+I x=not M i=s<=z i=x and i x=s>=z x=M and x i=x or i x=-824880+3596541 U=i and x i=-880011+15896287 U=U or i end end else if U<14173521-(-877437)then if U<-534304+15461446 then i={}U=R[A(135355+-159847)]else z=j[T]U=z and 9637+5786824 or 7733867-(-610064)s=z end else D=-374032+374034 v=t[D]U=-898210+13785721 D=j[c]y=v==D C=y end end else if U<548394+15062513 then if U<14893067-(-654238)then if U<15118086-(-386991)then P=g X=P f[P]=X U=-3098+10302382 P=nil else U=j[J[327385+-327375]]T=j[J[631234-631223]]Z[U]=T U=j[J[331080-331068]]T={U(Z)}U=R[A(601176-625754)]i={m(T)}end else g=-869634-(-869635)M=#f P=G(g,M)g=w(f,P)X=-782016+782017 M=j[r]W=g-X x=d(W)M[g]=x P=nil U=2133499-(-277631)g=nil end else if U<17116080-836111 then if U<1040875+15148549 then i={}U=R[A(354451+-378985)]else U=true U=-763485+3483585 end else U=R[A(-96450+71952)]i={}end end end end end end end U=#L return m(i)end,function(R,A)local m=G(A)local q=function()return U(R,{},A,m)end return q end,{},function(R)for A=-930338-(-930339),#R,-881349+881350 do Z[R[A]]=Z[R[A]]+(839908+-839907)end if q then local U=q(true)local m=L(U)m[A(974427-999041)],m[A(166654-191209)],m[A(768658+-793291)]=R,B,function()return-213307+934650 end return U else return J({},{[A(586522+-611077)]=B;[A(444047-468661)]=R;[A(-998556+973923)]=function()return-646362+1367705 end})end end,function(R,A)local m=G(A)local q=function(q,J,L,h)return U(R,{q,J,L,h},A,m)end return q end,function(R)local A,U=607500+-607499,R[-86249+86250]while U do Z[U],A=Z[U]-(-780221+780222),(-521104-(-521105))+A if 254260+-254260==Z[U]then Z[U],j[U]=nil,nil end U=R[A]end end,{}return(p(661166+7680992,{}))(m(i))end)(getfenv and getfenv()or _ENV,unpack or table[A(298055+-322606)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
