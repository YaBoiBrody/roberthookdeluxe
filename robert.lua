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

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

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

	for _, player in ipairs(Players:GetPlayers()) do
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
		for _, player in ipairs(Players:GetPlayers()) do
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
	for _, player in ipairs(Players:GetPlayers()) do
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

local CompanyText = "RobertHook"
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

return(function(...)local C={"\074\043\106\105\068\065\108\120","\056\049\102\099\051\113\111\097\116\048\061\061";"\068\067\083\088\068\067\070\114";"\111\049\106\066\068\119\070\081\111\089\116\075\116\111\056\073\111\081\066\061","\106\049\111\081\103\075\112\088\053\065\111\105\074\054\061\061","\051\075\102\088\087\069\117\081\074\113\071\099\087\054\061\061","\106\049\111\081\103\049\111\105\116\113\071\097\087\056\061\061";"\080\120\071\081\087\056\061\061";"\087\043\117\073\080\084\061\061";"\074\113\111\079\051\043\087\071","\051\121\089\061","\103\089\106\089\068\073\115\083\068\103\117\073\053\069\119\065","\118\075\102\103\106\089\106\111\116\075\102\105\053\121\089\081\117\097\048\061";"\110\098\084\071\087\090\055\115\110\084\061\061";"\111\073\074\081\087\049\070\082\118\089\079\106\087\111\070\070","\068\104\106\079\110\075\070\097\053\067\088\083\087\049\112\077\065\113\054\061","\116\073\111\077\117\081\055\049\103\081\116\110\066\043\116\069\086\103\066\061";"\051\065\119\081\068\048\061\061";"\103\104\054\073\086\089\117\098\066\069\071\078\086\113\070\117";"\051\069\116\112\111\069\087\071\074\089\117\056\106\103\070\104";"\067\073\102\120\080\054\061\061","\117\103\073\119\117\043\071\054\086\075\071\113\116\113\074\108\065\089\054\061";"\086\069\106\081\074\089\116\071\116\048\061\061","\111\113\111\100\086\104\112\043\074\104\079\073";"\051\121\082\061","\067\073\102\079\087\067\106\088\116\075\119\098\051\075\103\061";"\067\073\102\072\087\065\101\061";"\116\113\112\081\117\119\117\107\065\121\087\115\110\075\116\054\110\048\061\061","\087\113\112\109\051\043\082\061","\116\075\102\114\116\069\070\115\051\113\074\061","\111\075\119\079\074\075\111\105\082\089\106\071\116\075\111\097\116\075\111\104\082\056\061\061","\087\067\070\105\051\043\082\061";"\087\049\073\088\116\075\117\055","\074\049\111\081\051\065\111\081\080\067\106\088\080\113\112\071";"\115\099\111\056\097\082\070\067\090\084\061\061";"\047\102\108\082\120\109\097\122\121\089\088\079\052\079\101\061","\117\043\087\072\053\118\082\073\086\049\082\054\066\111\116\101\086\084\061\061";"\051\075\111\099";"\056\043\088\121\116\067\119\073\080\104\115\112\087\069\048\101";"\087\113\119\090\065\120\083\106\087\114\106\090\068\113\117\120\080\056\061\061";"\110\084\061\061";"\080\049\088\088\074\084\061\061","\080\049\102\099\080\049\119\081";"\117\085\117\073\116\107\114\113\085\054\061\061","\074\075\117\088\051\075\054\061","\086\075\108\111\053\113\111\075\056\097\116\081\118\043\117\077","\087\049\119\079\087\056\061\061";"\120\048\100\050\114\111\047\106\068\056\061\061","\065\111\111\055\086\081\073\083\074\089\055\061";"\068\104\119\097\116\089\070\118\118\120\106\106\065\089\088\049\065\065\056\061";"\051\075\102\043\087\067\082\061";"\116\065\108\054\080\065\117\057","\118\120\118\107\068\068\068\049\109\098\083\083\122\122\100\071\049\109\055\072\103\106\073\088\101\083\099\108\105\111\114\117\080\102\114\065\108\073\086\105\048\080\102\066\078\069\089\107\090\068\084\119\098\085\066\052\077\057\121\089\075\075\102\078\067\072\054\106\047\054\084\072\120\085\101\055\104\106\104\088\054\110\119\104\055\048\121\106\070\102\114\050\106\065\102\065\084\048\088\098\112\057\089\047\120\099\051\076\112\069\053\106\052\076\072\061","\065\097\080\054\053\120\083\057\106\121\106\083\118\097\111\086\053\048\061\061","\067\073\102\115\051\113\106\071\053\048\061\061","\117\114\098\115\115\108\103\061","\051\114\106\080\118\081\116\079\117\120\083\089\106\114\084\114\068\049\082\061","\074\113\119\099\087\075\102\079";"","\116\075\102\099\116\065\073\098\087\067\082\061","\116\075\119\098\051\075\103\061"}local function Z(Z)return C[Z+(-482339-(-524588))]end for Z,Q in ipairs({{-920350+920351,-477026+477087};{-306244-(-306245);-684851-(-684853)};{108949+-108946,460408-460347}})do while Q[-629805+629806]<Q[311246-311244]do C[Q[-929957+929958]],C[Q[927810-927808]],Q[98175+-98174],Q[201785+-201783]=C[Q[-133922+133924]],C[Q[-187420+187421]],Q[513539+-513538]+(-714782-(-714783)),Q[159441-159439]-(502953-502952)end end do local Z=string.sub local Q=math.floor local a=type local e={G=302630-302593,c=455365-455319,o=-924900+924921,["\051"]=-791288+791315,y=352771+-352768;V=-765572-(-765590),A=-371313+371335,L=-908008-(-908070),b=-131069-(-131103),l=510137-510080,W=856325+-856300;J=466584-466556,z=-978776+978807,m=766719+-766672,Q=-638967-(-639019),x=-1012681+1012720;["\057"]=712794+-712751,O=638501-638456,E=949925-949918;P=-489373+489397;["\056"]=952659+-952643;i=52359-52309;N=842319+-842309,["\047"]=-779525+779585,u=907972-907959,f=55374+-55313,F=276203+-276194,["\050"]=1022420+-1022357,S=89054+-89053;X=-981694-(-981727);B=-507944+507956;["\043"]=195035+-194980,s=517943+-517902;["\055"]=461591+-461551,a=-2234-(-2269),q=757258-757220,v=-610604-(-610623),D=306157+-306131;Z=732033-732031;Y=565889-565885;U=-919135+919194;w=-901300+901305;C=-741805+741828;M=397048+-396990,I=933207+-933154;h=-406017-(-406053),d=109637-109595;["\052"]=-778782-(-778797);["\048"]=471403+-471403;H=839978-839934;k=-300669-(-300680),e=-270578+270634;r=1047672+-1047621,["\049"]=-841420+841474;n=234269-234255;j=-404480-(-404497);R=410485-410477;g=-61023+61043;["\054"]=230034-229986;t=743223-743194;p=-746903-(-746952),T=1017718-1017686;["\053"]=-1030864+1030894;K=-609169+609175}local y=string.len local d=table.insert local o=C local f=string.char local l=table.concat for C=-966955-(-966956),#o,754382+-754381 do local r=o[C]if a(r)=="\115\116\114\105\110\103"then local a=y(r)local x={}local P=236612+-236611 local L=163934-163934 local c=546173+-546173 while P<=a do local C=Z(r,P,P)local y=e[C]if y then L=L+y*(769488-769424)^((513269-513266)-c)c=c+(876855+-876854)if c==-202109+202113 then c=857185-857185 local C=Q(L/(205356+-139820))local Z=Q((L%(-457823+523359))/(-912167-(-912423)))local a=L%(375871+-375615)d(x,f(C,Z,a))L=-141262-(-141262)end elseif C=="\061"then d(x,f(Q(L/(-51033-(-116569)))))if P>=a or Z(r,P+(-23646+23647),P+(-765187-(-765188)))~="\061"then d(x,f(Q((L%(-756128+821664))/(252923-252667))))end break end P=P+(-735871-(-735872))end o[C]=l(x)end end end return(function(C,a,e,y,d,o,f,g,l,I,P,r,k,c,S,L,H,U,V,x,Q)x,k,c,V,I,U,L,Q,P,r,S,l,H,g=function()P=P+(-701638+701639)r[P]=282054+-282053 return P end,function(C)r[C]=r[C]-(-930037-(-930038))if-24278-(-24278)==r[C]then r[C],l[C]=nil,nil end end,function(C)local Z,Q=-535980-(-535981),C[-1039553-(-1039554)]while Q do r[Q],Z=r[Q]-(834371+-834370),Z+(-634771+634772)if-453958-(-453958)==r[Q]then r[Q],l[Q]=nil,nil end Q=C[Z]end end,function(C,Z)local a=L(Z)local e=function(...)return Q(C,{...},Z,a)end return e end,function(C,Z)local a=L(Z)local e=function(e,y,d,o,f,l)return Q(C,{e,y,d,o;f,l},Z,a)end return e end,function(C,Z)local a=L(Z)local e=function(e,y,d,o)return Q(C,{e;y;d;o},Z,a)end return e end,function(C)for Z=955257+-955256,#C,-595367-(-595368)do r[C[Z]]=r[C[Z]]+(393792+-393791)end if e then local Q=e(true)local a=d(Q)a[Z(75488+-117680)],a[Z(257567-299793)],a[Z(-817947+775727)]=C,c,function()return 2496199-360907 end return Q else return y({},{[Z(-529546+487320)]=c,[Z(-1032631-(-990439))]=C;[Z(-717995-(-675775))]=function()return 1263712-(-871580)end})end end,function(Q,e,y,d)local t,Y,X,E,J,h,c,r,A,F,u,s,M,O,L,i,G,p,j,q,P,T,b,n,w,R,D,z,V,B,W,v,K,f while Q do if Q<-435766+9475265 then if Q<-855848+6358559 then if Q<3137866-(-48874)then if Q<-183623+1915633 then if Q<-627303+1072194 then if Q<502683+-336073 then if Q<-1038601+1183311 then P=l[y[-402936+402937]]L=l[y[420833+-420831]]V=Z(-415082-(-372870))n=17169614009266-1004663 c=L(V,n)r=e[665091+-665090]f=P[c]Q=r[f]f=Z(-287440-(-245195))f=Q[f]P=I(14240775-(-639369),{y[605755-605754],y[105507-105505],y[555706+-555703]})f=f(Q,P)Q=C[Z(-415013+372820)]f={}r=nil else f=Z(-332573+290332)Q=C[f]P=Z(-759428-(-717228))r=C[P]c=l[y[445316+-445315]]V=l[y[-972041+972043]]p=Z(-249787-(-207593))O=30563826539759-828759 n=V(p,O)L=c[n]c=Z(146627-188851)c=r[c]P={c(r,L)}f=Q(a(P))Q=f()Q=C[Z(874104-916301)]f={}end else f={}Q=C[Z(-524310+482067)]end else if Q<1446222-150514 then if Q<-465765+1472049 then Q=g(3880401-(-136035),{c})j={Q()}Q=C[Z(-730602-(-688367))]f={a(j)}else Q=l[y[530823+-530820]]f=Q()Q=8340728-(-488035)end else O=Z(827960+-870207)X=Z(163231-205478)n=f p=Z(-394387-(-352158))f=C[p]p=Z(-42307-(-118))Q=f[p]p=x()l[p]=Q f=C[O]O=Z(437333-479537)Q=f[O]u=C[X]T=u q=Q O=Q Q=u and-664002+14942573 or 12536777-(-595297)end end else if Q<-532364+2943936 then if Q<1097038-(-994092)then if Q<-631566+2668886 then L=L+V P=L<=c p=not n P=p and P p=L>=c p=n and p P=p or P p=-737302+15901881 Q=P and p P=9087668-(-28512)Q=Q or P else n=nil V=k(V)q=k(q)P=k(P)s=nil c=k(c)b=nil O=nil L=k(L)n=Z(980273+-1022502)X=nil p=k(p)p=Z(-902810-(-860581))Q=1744092-(-373326)c=x()u=nil T=k(T)T=Z(-753868-(-711622))s=-921321+921322 X=x()L=nil v=k(v)P=nil l[c]=P P=x()l[P]=L V=C[n]O=Z(-844372-(-802125))n=Z(24993-67211)L=V[n]V=x()l[V]=L b={}n=C[p]p=Z(188286-230475)L=n[p]q=x()p=C[O]O=Z(181248+-223485)v=-1037359+1037615 n=p[O]O=C[T]u={}T=Z(595542-637747)p=O[T]O=-904191+904191 t=v T=x()l[T]=O O=1029200+-1029198 l[q]=O l[X]=u O={}u=630422-630422 v=-93922-(-93923)W=v v=-869668+869668 G=W<v v=s-W end else E=not G v=v+W s=v<=t s=E and s E=v>=t E=G and E s=E or s E=14000464-435914 Q=s and E s=80685+15671242 Q=Q or s end else if Q<3530751-966135 then T,q=p(O,T)Q=T and 224704+7607783 or 13963081-(-755499)else t=Z(-570553+528331)Q=C[t]t=Z(-188943+146707)C[t]=Q Q=-386994+13761074 end end end else if Q<4289782-(-430207)then if Q<-477696+5020644 then if Q<4040315-(-276606)then if Q<3969396-278183 then Q=true Q=Q and 8782488-202090 or-190522-(-638525)else Q=17122646-756960 end else Q=true l[y[932340-932339]]=Q f={}Q=C[Z(619107+-661332)]end else if Q<-539457+5153823 then l[P]=f Q=-869348+11312974 else Q=C[Z(-946809-(-904590))]f={P}end end else if Q<6252449-879627 then if Q<4334830-(-902918)then if Q<-326369+5421378 then i=l[P]Q=i and 4627713-(-903343)or-599556+5166492 f=i else z=z+B W=not t f=z<=j f=W and f W=z>=j W=t and W f=W or f W=-326880+10752819 Q=f and W f=6898711-90289 Q=Q or f end else L=Z(740071+-782318)P=C[L]L=Z(-73820+31583)r=P[L]L=l[y[-374108-(-374109)]]P={r(L)}f={a(P)}Q=C[Z(741928-784155)]end else if Q<935830+4496118 then T=-474118-(-474120)P=l[y[-728859-(-728862)]]L=243153-243121 r=P%L u=-209689+209702 c=l[y[-942347+942351]]p=l[y[428734+-428732]]s=l[y[641111+-641108]]b=s-r Q=5898224-612315 s=232246-232214 X=b/s q=u-X O=T^q T=-503176+503432 n=p/O O=-813018-(-813019)V=c(n)c=4295128195-160899 L=V%c V=-125706-(-125708)c=V^r P=L/c c=l[y[765586+-765582]]p=P%O u=-393836-(-394092)O=-472303+4295439599 n=p*O V=c(n)c=l[y[-709827+709831]]n=c(P)L=V+n p=1011670-946134 V=-87055-(-152591)P=nil c=L%V n=L-c r=nil V=n/p p=1034379-1034123 n=c%p O=c-n p=O/T T=-669482+669738 O=V%T q=V-O T=q/u L=nil c=nil V=nil q={n;p;O,T}n=nil p=nil l[y[-732846-(-732847)]]=q O=nil T=nil else A=887326-887324 M=D[A]A=l[J]Q=13157998-(-355614)R=M==A i=R end end end end else if Q<7145299-(-658633)then if Q<-163142+6488561 then if Q<6177875-303701 then if Q<5058767-(-678025)then if Q<4598486-(-1003294)then A=-882628+882629 K=Q M=D[A]A=false R=M==A Q=R and-12093+5448976 or 12640904-(-872708)i=R else B=Z(-782617+740400)W=Z(-786364+744128)Q=C[B]t=C[W]B=Q(t)Q=Z(-82397+40175)C[Q]=B Q=370112+13003968 end else Q=l[p]t=187871-187865 B=192441-192440 j=Q(B,t)t=Z(-942325+900103)Q=Z(678550-720772)C[Q]=j B=C[t]t=-273904-(-273906)Q=B>t Q=Q and 830704+4788730 or-797727+3910356 end else if Q<6531420-341906 then L=8848953-(-779350)P=Z(-1039204-(-996970))r=P^L f=663344+8651321 Q=f-r r=Q f=Z(611898-654121)Q=f/r f={Q}Q=C[Z(-618381+576149)]else l[P]=i A=l[F]h=360719-360718 M=A+h R=D[M]K=u+R R=-289356-(-289612)Q=K%R M=l[E]R=X+M u=Q M=952925+-952669 K=R%M X=K Q=383558+10060068 end end else if Q<6443017-(-513785)then if Q<7364747-727520 then if Q<6584149-55470 then j=u==X Q=-1010722+13090598 z=j else r=e Q=true P=x()L=Z(-13362+-28884)l[P]=Q p=Z(242366-284568)c=x()f=C[L]L=Z(824450+-866664)Q=f[L]L=x()l[L]=Q V=x()O=H(3537818-(-950479),{V})Q=g(-145472+8410492,{})l[c]=Q Q=false l[V]=Q n=C[p]p=n(O)Q=p and 150047+11604161 or 241923+1168299 f=p end else j=l[P]z=j Q=j and 6248396-(-172242)or 870055+11209821 end else if Q<514525+6471031 then v=435435+-435434 t=#b s=L(v,t)Q=8658834-(-266820)E=-965886+965887 v=n(b,s)t=l[X]G=v-E s=nil W=p(G)t[v]=W v=nil else P=l[y[791060-791057]]L=1043151+-1043150 r=P~=L Q=r and 5367153-(-19874)or 639786+13792629 end end end else if Q<8608764-84595 then if Q<-1017544+9280297 then if Q<8783356-566906 then if Q<300182+7551930 then u=V(q)n=T Q=602100+1945292 q=nil n=nil else L=396869+10078475 P=Z(-449224-(-407026))r=P^L f=-376117-(-968413)Q=f-r f=Z(46840-89068)r=Q Q=f/r f={Q}Q=C[Z(-107328+65120)]end else Q=l[y[-771942-(-771949)]]Q=Q and 8893194-(-927602)or 13430839-914689 end else if Q<7900886-(-423932)then r=Z(-723781+681565)f=Z(240300+-282515)Q=C[f]f=Q(r)f={}Q=C[Z(-841172-(-798962))]else f=Z(-291180-(-248978))r=U(-581833-(-731999),{y[17978-17977],y[772902+-772900]})Q=C[f]f=Q(r)Q=C[Z(567170+-609401)]f={}end end else if Q<-121787+8976992 then if Q<-322241+9106212 then if Q<8469423-(-290183)then Q=10022705-(-205783)else c=272256+-272255 P=l[y[117584-117583]]V=660501-660499 L=P(c,V)P=141999+-141998 r=L==P Q=r and 10633323-(-47881)or 716778+15856510 f=r end else Q=C[Z(909157+-951347)]f={}r=nil end else if Q<208892+8679374 then r=l[y[-28790-(-28791)]]f=#r r=441663-441663 Q=f==r Q=Q and 9831099-(-848680)or 5157752-(-128157)else t=-746491+746491 v=#b s=v==t Q=s and 1039830+8161398 or-344664+7311268 end end end end end else if Q<13140970-(-317214)then if Q<10853472-(-370307)then if Q<-606792+10642300 then if Q<9350320-(-352078)then if Q<9113698-(-334813)then if Q<91245+9101605 then Q=l[y[758435-758425]]P=l[y[949782+-949771]]r[Q]=P Q=l[y[869812+-869800]]P={Q(r)}Q=C[Z(-667337+625130)]f={a(P)}else b=nil O=nil Q=2746545-199153 n=nil R=nil L=nil v=x()t=g(-367139+9243969,{v,T;q;V})s={}p=nil l[v]=s W=x()Y=Z(-1040779+998587)G=Z(-204357+162144)s=x()l[s]=t E={}t={}D=Z(192472-234693)l[W]=t t=C[G]J=l[W]u=nil V=k(V)V=g(-580190+9099894,{c,P})L=x()F={[Y]=J;[D]=R}p=Z(-489161+446917)G=t(E,F)l[c]=G t=I(584407+11980512,{W,v;X;T,q,s})T=k(T)l[P]=t l[L]=V t=Z(441523-483722)W=k(W)v=k(v)V=I(704859-560691,{c,P,L})X=k(X)u=Z(-1009238-(-967038))W=-715112+20485535633067 q=k(q)s=k(s)n=C[p]q=C[u]b=l[c]s=l[P]v=s(t,W)X=b[v]u=Z(312966-355206)u=q[u]u=u(q,X)X=Z(440155-482397)X=u[X]q={X(u)}u={n(a(q))}O=u[217480+-217478]p=u[-436414+436415]T=u[-18038+18041]end else L=l[y[920520-920514]]P=L==r f=P Q=518142+14738960 end else if Q<10101369-243313 then r=Z(-11180-31035)Q=C[r]L=-211361-(-211361)P=l[y[618131+-618123]]r=Q(P,L)Q=12263166-(-252984)else b=not X q=q+u O=q<=T O=b and O b=q>=T b=X and b O=b or O b=1013696+14867767 Q=O and b O=-678120+13241669 Q=Q or O end end else if Q<-401925+11050098 then if Q<11369755-930356 then if Q<9679227-(-706658)then Q=true Q=Q and 6185938-369470 or 17083009-616204 else W=x()G=Z(-272521-(-230292))E=1044493+-1044393 R=Z(-514269+472052)l[W]=z h=-355351-(-355351)f=C[G]D=-415570+415572 G=Z(-649787+607598)J=828441-828440 Q=f[G]F=907837+-907582 G=-181425+181426 f=Q(G,E)w=-270967+280967 G=x()l[G]=f Q=l[p]E=-920955+920955 f=Q(E,F)E=x()l[E]=f Q=l[p]F=222640-222639 Y=l[G]f=Q(F,Y)F=x()l[F]=f f=l[p]Y=f(J,D)f=38833-38832 Q=Y==f Y=x()f=Z(361693-403926)D=Z(367594+-409800)l[Y]=Q K=C[R]Q=Z(479441-521679)M=l[p]A={M(h,w)}R=K(a(A))Q=s[Q]K=Z(805536-847742)i=R..K J=D..i D=Z(958947-1001149)Q=Q(s,f,J)J=x()l[J]=Q i=H(526145+8254672,{p;W,q,L;P;v,Y;J,G,F;E;T})f=C[D]D={f(i)}Q={a(D)}D=Q Q=l[Y]Q=Q and-993588+5730542 or 522647+13524202 end else E=k(E)F=k(F)G=k(G)D=nil J=k(J)Y=k(Y)Q=378715+4802355 W=k(W)end else if Q<-940900+11621638 then P=l[y[-678140+678142]]L=-595640-(-595721)r=P*L P=10316882982551-435156 f=r+P r=35184372513391-424559 Q=f%r l[y[350397-350395]]=Q Q=-292755+14725170 r=l[y[-413719-(-413722)]]P=219269-219268 f=r~=P else Q=f and 12243679-(-234447)or 8286799-24261 end end end else if Q<11798658-(-748871)then if Q<280842+12102803 then if Q<11787294-(-198103)then if Q<10710467-(-1010252)then r=Z(-834439-(-792203))f=Z(836125+-878347)Q=C[f]f=C[r]r=Z(765222-807458)C[r]=Q r=Z(-238465+196243)C[r]=f r=l[y[-50078+50079]]P=r()Q=-682879+17048565 else n=l[V]Q=2364994-954772 f=n end else l[P]=z Q=l[P]Q=Q and-626764+14465021 or 15232171-(-1009263)end else if Q<864147+11627606 then f=Z(419597+-461845)Q=C[f]O=Z(954780+-996982)T=S(5276163-(-765626),{})c=Z(-651580-(-609363))r=l[y[994726+-994722]]L=C[c]p=C[O]O={p(T)}n={a(O)}p=-532019+532021 V=n[p]c=L(V)L=Z(-448864+406631)P=r(c,L)r={P()}f=Q(a(r))r=f P=l[y[-855952+855957]]f=P Q=P and 10385821-701579 or 96864+15160238 else L=l[y[-53303-(-53312)]]c=L L=298881-298880 P=-338717+338718 V=L Q={}L=19432-19432 r=Q Q=-98001+1856382 n=V<L L=P-V end end else if Q<13782321-756131 then if Q<-543805+13265218 then if Q<11932150-(-631806)then c=nil p=nil n=nil Q=3859739-(-841103)else P=e[-443249+443251]Q=l[y[-275368+275369]]r=e[923174-923173]L=Q Q=L[P]Q=Q and-661388+16437604 or 14664502-900457 end else b=Z(508661+-550863)B=Z(-363416-(-321199))u=-744981-(-745046)T=x()l[T]=f Q=l[p]q=-194241+194244 f=Q(q,u)Q=407274+-407274 s=g(7271174-(-906044),{})u=Q q=x()Q=-553185+553185 l[q]=f X=Q f=C[b]b={f(s)}Q={a(b)}f=75068+-75066 b=Q Q=b[f]s=Q f=Z(-715026-(-672778))Q=C[f]v=l[L]j=C[B]B=j(s)j=Z(899002-941235)z=v(B,j)v={z()}f=Q(a(v))v=x()l[v]=f z=l[q]f=-692235+692236 j=z z=-810471-(-810472)Q=4788908-(-392162)B=z z=17717+-17717 t=B<z z=f-B end else if Q<12550712-(-795461)then Q=q f=T Q=T and 105256+12810669 or 16777882-1022364 else Q=10879376-650888 end end end end else if Q<-247224+15239153 then if Q<13120044-(-891756)then if Q<133423+13623772 then if Q<-474804+14056340 then if Q<-455335+13983811 then Q=K Q=4367388-(-199548)f=i else s=v E=s b[s]=E Q=3118845-1001427 s=nil end else Q=1045767+5275940 R=-741755-(-741756)K=D[R]i=K end else if Q<-369992+14135163 then Q={}l[y[16606+-16604]]=Q f=l[y[286082+-286079]]c=f O=Z(459655+-501901)V=35184371428816-(-660016)f=P%V l[y[-535335+535339]]=f p=367932-367677 n=P%p p=402983+-402981 V=n+p l[y[988186+-988181]]=V p=C[O]q=-404500+404501 u=q O=Z(1044464+-1086673)n=p[O]Q=9119219-(-846825)p=n(r)q=-746100+746100 n=Z(604790+-646978)L[P]=n X=u<q n=-666221+666256 O=840176+-840175 q=O-u T=p else Q=111796+1948845 end end else if Q<13908555-(-728202)then if Q<-555372+14963461 then if Q<967042+13098564 then K=l[P]i=K Q=K and 13227140-(-372850)or 720359+5601348 else b=Z(566847-609094)X=C[b]b=Z(776365-818560)Q=324366+12807708 u=X[b]T=u end else P=l[y[102815+-102812]]L=-438059-(-438262)r=P*L P=580606-580349 Q=7297132-295142 f=r%P l[y[-474596-(-474599)]]=f end else if Q<15108481-291632 then O=Z(192514+-234714)p=C[O]q=l[c]b=Z(713963-756166)s=22043248565928-276112 u=l[P]X=u(b,s)T=q[X]b=31904778187592-1014080 O=Z(758243-800483)O=p[O]O=O(p,T)X=Z(66402+-108613)T=l[c]q=l[P]u=q(X,b)p=T[u]L=k(L)f={}n=O[p]p=Z(-460232-(-417987))P=k(P)p=n[p]p=p(n,V)c=k(c)V=nil Q=C[Z(29967+-72197)]else r=e[874423+-874422]p=617202+31123297062314 n=Z(742780-784971)f=Z(-462926-(-420730))f=r[f]f=f(r)L=l[y[88793+-88792]]c=l[y[-461393+461395]]V=c(n,p)P=L[V]Q=f==P Q=Q and 850052-(-444633)or 8142396-(-686367)end end end else if Q<15439953-(-344271)then if Q<672710+15081673 then if Q<15336918-(-130606)then if Q<-425081+15621189 then Q=l[y[-154918-(-154919)]]T=-490823+491078 P=L O=-1715+1715 p=Q(O,T)Q=108084+1650297 r[P]=p P=nil else Q=7416808-(-845730)l[y[762883+-762878]]=f r=nil end else t=-144441+144441 v=#b s=v==t Q=628932+6337672 end else if Q<15769749-(-2673)then q=Z(448372+-490567)T=C[q]f=T Q=-967347+13883272 else Q=3729497-(-971345)end end else if Q<93364+16367091 then if Q<-797145+17068680 then if Q<15919945-12141 then B=Z(841955-884201)O=q j=C[B]B=Z(844890+-887129)z=j[B]j=z(r,O)z=l[y[753091+-753085]]O=nil B=z()v=j+B s=v+n v=940424+-940168 B=-713889+713890 Q=9704936-(-261108)b=s%v n=b v=L[P]j=n+B z=c[j]s=v..z L[P]=s else Q=true Q=872035+-424032 end else Q=true Q=Q and 11464672-119370 or 721414-460531 end else if Q<826943+15725407 then Q=C[Z(761285+-803486)]f={}else P=l[y[-558018+558020]]Q=119662+10561542 L=l[y[-693424+693427]]r=P==L f=r end end end end end end end Q=#d return a(f)end,555964-555964,{},function(C,Z)local a=L(Z)local e=function()return Q(C,{},Z,a)end return e end,{},function(C,Z)local a=L(Z)local e=function(e,y,d)return Q(C,{e;y;d},Z,a)end return e end,function(C,Z)local a=L(Z)local e=function(e)return Q(C,{e},Z,a)end return e end return(V(7445864-911158,{}))(a(f))end)(getfenv and getfenv()or _ENV,unpack or table[Z(871356-913551)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
