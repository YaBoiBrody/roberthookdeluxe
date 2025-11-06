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

--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...)local l={"\089\105\115\101\104\112\120\090\089\101\054\072\113\078\082\056";"\104\108\048\084\115\052\082\047\050\078\048\043\121\099\061\061";"\050\112\077\082\066\051\085\080\118\048\121\076\066\108\057\097\075\099\061\061","\077\108\047\047\121\067\061\061";"\106\053\082\080\114\101\073\061","\048\111\047\108\087\105\115\084\104\053\082\075\069\101\089\087\104\084\073\061";"\106\108\072\047\117\052\089\122";"\108\077\081\089\119\067\043\122\070\079\061\061";"\117\078\097\099\077\078\089\098";"\069\051\049\077\077\051\117\105\048\105\122\101\075\118\054\088";"\115\101\077\101\048\053\106\115\114\084\122\097\075\067\061\061","\088\057\071\068\085\108\098\110\085\066\090\098\116\106\065\110\114\119\050\055\070\079\057\086\117\076\086\057\112\050\075\052\075\068\100\083\119\070\068\098\073\050\100\072\116\084\069\121\100\107\048\052\085\068\089\055\104\109\106\065\048\115\072\109\068\073\075\078\085\103\067\057\116\083\043\043\067\072\067\118\081\080\100\043\115\081\115\114\111\073\085\088\084\113\069\101\076\105\071\068\075\103\113\050\055\085\109\112\119\083\121\117\122\114\102\061";"\115\070\117\107\075\115\049\081\069\101\122\084\117\084\100\084";"\078\070\047\108\115\115\106\122\104\051\089\057\114\084\089\051\078\113\061\061","\106\078\117\115\089\076\089\078\104\072\079\057\104\078\117\081\087\113\061\061";"\051\072\071\070\077\099\061\061";"\106\051\054\043\114\101\073\061","\051\072\071\120\106\051\104\047\117\052\049\083\114\052\115\061","\066\051\085\047\066\051\054\076","\078\051\110\069\069\112\117\073\113\051\106\098\117\100\085\069\075\115\099\061";"\121\053\049\116\106\052\071\120","\117\052\071\076\117\105\054\110\114\053\121\061","\113\072\085\065\089\078\047\098\113\101\110\107\089\084\120\101\115\115\099\061";"\051\072\071\107\106\078\057\061","\087\083\067\100\106\068\122\110\087\067\061\061","\106\108\049\120\106\113\061\061";"\114\081\073\061";"\121\108\048\084\114\078\048\084\077\051\104\047\077\053\082\100","\114\081\112\061";"\051\072\071\110\114\053\104\100\050\079\061\061","\066\051\106\085\050\105\054\054\077\101\054\055\106\118\106\106\106\113\061\061","\104\118\085\111\115\118\054\057\113\084\110\072\077\076\085\101\113\078\107\061","\069\105\104\084\121\112\117\100\117\079\061\061","\121\053\048\120\114\101\106\100","\048\101\122\076\121\051\100\106\069\072\089\113\089\048\104\120\069\079\061\061","\048\052\049\120\121\052\048\043\073\112\104\100\117\052\048\111\117\052\048\102\073\113\061\061";"\114\052\072\054\089\076\085\106\114\078\106\055\114\100\106\081\089\102\073\061","\104\108\048\084\115\108\048\043\117\053\100\111\106\113\061\061";"\114\052\048\116","\117\052\049\083\114\052\115\061";"\121\052\089\047\114\052\099\061","\114\052\071\047\106\105\089\084\121\053\100\116\106\099\061\061","\077\053\048\065\050\102\082\065\104\111\112\082\104\052\120\068","\104\049\106\053\121\072\104\099\104\100\054\115\117\105\047\089\075\051\121\061","\117\052\071\116\117\078\072\083\106\051\073\061","\077\078\057\061","\088\097\070\081\103\081\071\118\072\067\061\061","\121\101\104\043\066\078\097\070";"\106\101\089\072\077\067\061\061","\077\070\100\084\106\113\061\061","\087\067\061\061","","\069\108\120\077\104\118\067\061";"\121\118\115\072\118\049\100\115\104\070\112\072\050\053\082\098\117\067\061\061";"\107\048\070\109\043\083\053\047\075\075\070\056\088\114\079\061";"\114\078\049\084\066\079\061\061";"\077\108\071\116\077\108\049\084","\114\052\071\101\106\051\073\061","\113\108\071\116\114\053\048\111\117\079\061\061","\047\056\117\082\066\088\103\061"}for N,K in ipairs({{873483+-873482,365945+-365885};{354102+-354101;-237806-(-237841)},{-821003+821039;189037-188977}})do while K[954105+-954104]<K[-640868+640870]do l[K[-216099-(-216100)]],l[K[1020497+-1020495]],K[316636+-316635],K[-657895-(-657897)]=l[K[-111629+111631]],l[K[115812+-115811]],K[169699-169698]+(722570+-722569),K[453543-453541]-(-460412-(-460413))end end local function N(N)return l[N-(-201812-(-259154))]end do local N=string.char local K=table.concat local Y=table.insert local M={T=-293336+293388;["\055"]=-311758+311800;L=653229+-653178,z=-272925-(-272965),e=78121-78066;a=671137+-671080;o=868738+-868703;W=-617065-(-617079),y=953612+-953584;g=-623749-(-623809),["\047"]=952305+-952272;E=119535-119517,f=392811+-392775,d=61523+-61486,D=112791+-112789,c=-712856+712904,["\050"]=-501944-(-501974);Y=718781+-718768;Q=1018423-1018420;["\043"]=652704+-652654,R=429919+-429870,N=-225448+225470;O=-537176+537176;K=-79310+79322;x=896411-896366;["\053"]=-106248-(-106286);M=247216+-247192,["\054"]=203527+-203518;m=-18793-(-18852);["\048"]=-704556-(-704577),n=-196140-(-196181);F=-859524+859563;b=-610975-(-611018);t=1026635+-1026589;["\052"]=24931+-24925;u=944559-944530;B=158384+-158358;q=804039+-804023,w=-136309+136372;["\056"]=-900966+900981;U=-808649-(-808650),["\057"]=612029+-611973;["\049"]=-1033948+1033953,l=180232-180178;A=313582+-313524;v=-1004629+1004648,V=773256-773225;P=674319+-674272,h=-655022+655039;I=400833-400825,G=-871101+871162;k=1042862-1042818,X=384187+-384176,i=-1037480+1037487,S=549773-549739;j=530982+-530957;H=-372259+372312;Z=-873896+873906;p=793050+-793046;r=-748086+748113;C=568326+-568294,J=-525608+525670,s=-499-(-519),["\051"]=-694706+694729}local x=string.len local I=type local H=math.floor local a=l local w=string.sub for l=708094+-708093,#a,721597-721596 do local F=a[l]if I(F)=="\115\116\114\105\110\103"then local I=x(F)local t={}local W=76249-76248 local o=923322-923322 local U=-317859-(-317859)while W<=I do local l=w(F,W,W)local K=M[l]if K then o=o+K*(693487+-693423)^((893166-893163)-U)U=U+(413786+-413785)if U==56984-56980 then U=-1031210-(-1031210)local l=H(o/(-538725-(-604261)))local K=H((o%(-192770-(-258306)))/(241627-241371))local M=o%(-162911-(-163167))Y(t,N(l,K,M))o=-947379+947379 end elseif l=="\061"then Y(t,N(H(o/(987943+-922407))))if W>=I or w(F,W+(-103713+103714),W+(873365+-873364))~="\061"then Y(t,N(H((o%(-603301-(-668837)))/(309286-309030))))end break end W=W+(-34057+34058)end a[l]=K(t)end end end return(function(l,Y,M,x,I,H,a,U,K,t,w,p,F,B,O,f,G,W,A,o,v)O,U,f,G,t,A,F,o,K,w,v,W,B,p=function(l,N)local Y=o(N)local M=function(M)return K(l,{M},N,Y)end return M end,function(l)local N,K=398545-398544,l[384258-384257]while K do F[K],N=F[K]-(463519-463518),(860286-860285)+N if F[K]==-589047+589047 then F[K],w[K]=nil,nil end K=l[N]end end,function(l,N)local Y=o(N)local M=function(M,x,I)return K(l,{M,x;I},N,Y)end return M end,function(l,N)local Y=o(N)local M=function(...)return K(l,{...},N,Y)end return M end,function()W=(798297-798296)+W F[W]=-714556+714557 return W end,function(l)F[l]=F[l]-(509048-509047)if-873794+873794==F[l]then F[l],w[l]=nil,nil end end,{},function(l)for N=-364031-(-364032),#l,-858029-(-858030)do F[l[N]]=(451495+-451494)+F[l[N]]end if M then local K=M(true)local Y=I(K)Y[N(-257575+314922)],Y[N(806612+-749219)],Y[N(-469279+526680)]=l,U,function()return 55856+1814932 end return K else return x({},{[N(641046-583653)]=U;[N(479340-421993)]=l;[N(920145-862744)]=function()return 1156502-(-714286)end})end end,function(K,M,x,I)local C,k,J,D,b,P,q,G,r,V,y,L,m,c,Q,F,T,e,a,d,n,R,E,z,g,o,S,W,i,Z,U,u,h,j while K do if K<26517+9525762 then if K<3948988-(-780048)then if K<3385905-603409 then if K<-295044-(-1001787)then if K<536584-302581 then if K<-590650-(-732286)then if K<-98754+164968 then j=nil J=nil E=nil W=A(W)Q=A(Q)T=nil o=A(o)o=nil z=A(z)r=nil P=A(P)j=t()u=A(u)W=nil P=t()G=A(G)Q=N(558366-501001)U=A(U)U=t()w[U]=W J={}W=t()k=nil E=N(59321+-1948)w[W]=o u=N(276876+-219503)G=l[E]r=N(351072+-293715)E=N(868609-811227)o=G[E]k=-348817-(-348818)G=t()z=431478+-431222 w[G]=o E=l[u]u=N(480632-423234)o=E[u]u=l[r]r=N(-601344-(-658695))E=u[r]i=z K=5603768-(-336825)r=l[Q]Q=N(-539771+597152)u=r[Q]Q=t()r=-1007137-(-1007137)T={}w[Q]=r r=-793977-(-793979)w[P]=r w[j]=J r={}J=905692-905692 z=-459746+459747 d=z z=12332+-12332 S=d<z z=k-d else K=11291847-158582 end else F=nil a={}K=l[N(-369480-(-426851))]end else if K<342991+176470 then if K<481875+-184958 then a=N(-648350+705744)F=N(1008745-951392)K=l[a]a=K(F)a={}K=l[N(564873-507493)]else K=4948112-(-854103)w[x[-119134+119139]]=a F=nil end else y=963328+-963326 m=h[y]y=w[D]g=m==y e=g K=12098138-749836 end end else if K<2155246-38299 then if K<-865605+2379033 then if K<324539+791205 then w[W]=a K=-705823+6148949 else K=12036713-225564 end else z=t()Z=N(-948163+1005510)o=nil r=nil S=N(97366+-40021)J=nil k={}J=-354412+12600415633239 w[z]=k n={}i=v(2346434-(-553708),{z,Q;P,G})h=N(644590-587195)k=t()g=nil T=nil E=nil w[k]=i d=t()i={}w[d]=i i=l[S]D=w[d]C={[Z]=D;[h]=g}S=i(n,C)w[U]=S i=p(10646904-55518,{d,z;j,Q;P;k})w[W]=i k=A(k)G=A(G)d=A(d)j=A(j)z=A(z)G=N(165819-108476)Q=A(Q)u=nil P=A(P)o=l[G]u=w[U]P=N(-437383+494768)G=N(469608-412253)r=w[W]Q=r(P,J)E=u[Q]G=o[G]r=N(970393+-912997)G=G(o,E)o=t()j=N(-487929-(-545308))E=f(660657+4945830,{U,W})w[o]=E E=v(9102313-696997,{U,W;o})K=5564161-(-225395)u=l[r]j=G[j]J={j(G)}j={u(Y(J))}Q=j[653626+-653624]r=j[42333-42332]P=j[-310942+310945]end else if K<-652632+3274065 then o=N(-818808-(-876165))W=l[o]K=l[N(-201978-(-259356))]o=N(605605-548254)F=W[o]o=w[x[-482956-(-482957)]]W={F(o)}a={Y(W)}else K=a and 2756838-(-333402)or 4765031-(-1037184)end end end else if K<2294820-(-916787)then if K<-410318+3550598 then if K<833352+2278130 then if K<-859619+3763001 then F=w[x[-278577-(-278578)]]a=#F F=-696239-(-696239)K=a==F K=K and 8602755-(-321344)or 3217198-740856 else a=N(917811-860449)U=N(-977250-(-1034649))r=N(890546+-833188)K=l[a]F=w[x[725421+-725417]]Q=p(15121894-(-217906),{})o=l[U]u=l[r]r={u(Q)}u=273929+-273927 E={Y(r)}G=E[u]U=o(G)o=N(-167138-(-224540))W=F(U,o)F={W()}a=K(Y(F))F=a W=w[x[725357-725352]]K=W and 199893+2944242 or 306576-4053 a=W end else o=-788155-(-788187)W=w[x[-228453+228456]]Q=-752322+752324 F=W%o J=294444+-294431 U=w[x[857967+-857963]]u=w[x[-323811+323813]]k=w[x[-974501+974504]]T=k-F k=-38888+38920 j=T/k P=J-j r=Q^P K=-8732+2485074 E=u/r G=U(E)U=4295421810-454514 o=G%U J=392136-391880 G=-1016181+1016183 U=G^F W=o/U U=w[x[581701+-581697]]r=-842019+842020 F=nil u=W%r r=-101237+4295068533 E=u*r u=670266-604730 G=U(E)U=w[x[775499-775495]]E=U(W)o=G+E G=1005247-939711 U=o%G E=o-U G=E/u Q=-799489-(-799745)u=-61815-(-62071)E=U%u r=U-E u=r/Q Q=-847998-(-848254)r=G%Q P=G-r U=nil Q=P/J o=nil G=nil W=nil P={E,u;r,Q}E=nil w[x[-1047322+1047323]]=P Q=nil r=nil u=nil end else if K<-378911+3546072 then K=-217544+520067 o=w[x[-476746-(-476752)]]W=o==F a=W else e=w[W]a=e K=e and 10697812-(-329796)or-812398+1681393 end end else if K<3329686-(-469256)then if K<226509+3467208 then if K<2672384-(-923062)then P=P+J r=P<=Q T=not j r=T and r T=P>=Q T=j and T r=T or r T=14033074-(-806934)K=r and T r=-405239+14583334 K=K or r else c=w[W]e=c K=c and 15994059-(-699900)or 3640837-(-109474)end else w[W]=e q=27793-27792 y=w[C]m=y+q g=h[m]c=J+g g=-937037+937293 K=c%g J=K m=w[n]K=660120+4783006 g=j+m m=-605488-(-605744)c=g%m j=c end else if K<4769225-680461 then K=true K=K and 14488371-(-193916)or 10889937-(-754125)else L=608942+-608941 i=-443564+443570 K=w[u]b=K(L,i)K=N(602255-544911)l[K]=b i=N(-7248+64592)L=l[i]i=267018-267016 K=L>i K=K and 858848+11343096 or 986207+13749086 end end end end else if K<6736350-90952 then if K<4851880-(-935622)then if K<6390901-920478 then if K<126676+5307607 then if K<156970+4777450 then K=10944561-(-845404)else o=o+G W=o<=U u=not E W=u and W u=o>=U u=E and u W=u or W u=12712922-(-91952)K=W and u W=-752297+12351327 K=K or W end else n=A(n)Z=A(Z)K=955542+14348767 h=nil S=A(S)C=A(C)d=A(d)D=A(D)end else if K<-375815+6147957 then a=N(-526968+584326)K=l[a]F=O(866790+11539649,{x[-825875+825876],x[136721+-136719]})a=K(F)a={}K=l[N(566565+-509173)]else a={}K=true w[x[363707+-363706]]=K K=l[N(195456+-138056)]end end else if K<6486708-548706 then if K<5786242-(-95157)then if K<-513116+6311643 then P,J=r(Q,P)K=P and 13040192-(-607859)or 9125497-803736 else K=w[x[-801851-(-801858)]]K=K and 967438+12104499 or 15607683-(-616128)end else F=N(514465+-457119)a=N(728937-671593)K=l[a]a=l[F]F=N(692450+-635104)l[F]=K F=N(666643-609299)l[F]=a F=w[x[-813636-(-813637)]]W=F()K=10497587-(-635678)end else if K<5805671-(-181227)then z=z+d k=z<=i n=not S k=n and k n=z>=i n=S and n k=n or k n=12949458-(-55442)K=k and n k=10195763-866409 K=K or k else u=N(-17944+75317)E=a r=N(603064+-545707)a=l[u]u=N(622049-564651)K=a[u]u=t()w[u]=K a=l[r]j=N(138673-81316)r=N(293279+-235905)K=a[r]J=l[j]P=K r=K Q=J K=J and 8145569-826292 or 14378491-(-255191)end end end else if K<8292876-(-195189)then if K<8977159-680909 then if K<7272912-(-195560)then if K<810075+6162028 then K=l[N(328265+-270874)]a={}else T=N(723704+-666347)K=-195612+14829294 j=l[T]T=N(-529392+586778)J=j[T]Q=J end else K=true W=t()F=M w[W]=K o=N(-612505-(-669870))a=l[o]o=N(-43335+100719)K=a[o]o=t()w[o]=K K=p(399924+-113976,{})G=t()r=f(6761488-975666,{G})u=N(568757+-511399)U=t()w[U]=K K=false w[G]=K E=l[u]u=E(r)a=u K=u and 13451521-864208 or 5636905-(-359708)end else if K<8972449-604192 then a={}T=-908903+12895783499228 Q=w[U]j=N(708816+-651444)P=w[W]W=A(W)K=l[N(-451020-(-508407))]o=A(o)J=P(j,T)r=Q[J]u=G[r]r=N(-910623-(-967999))r=u[r]U=A(U)G=nil r=r(u,E)E=nil else F=M[-778614+778615]E=-766523+29994247530698 G=N(107073+-49709)W=w[x[-134512+134513]]o=w[x[597923+-597921]]U=o(G,E)a=W[U]K=F[a]a=N(-242033+299409)W=v(-936586+10014778,{x[-716412+716413];x[227712-227710];x[949763+-949760]})a=K[a]a=a(K,W)F=nil K=l[N(19465-(-37889))]a={}end end else if K<-36342+9053220 then if K<9732354-828869 then if K<-93804+8680396 then P=N(-344391-(-401777))Q=l[P]a=Q K=8717951-(-840985)else G=47318+35184372041514 K={}w[x[-198994-(-198996)]]=K a=w[x[375741-375738]]K=-244310+3684156 U=a a=W%G P=-728619-(-728620)u=396617+-396362 w[x[325555+-325551]]=a E=W%u u=688647+-688645 r=N(324492-267127)G=E+u w[x[-30510-(-30515)]]=G u=l[r]r=N(-443220+500576)E=u[r]u=E(F)r=-726479-(-726480)J=P Q=u P=170311-170311 E=N(276839-219470)o[W]=E E=-13036-(-13107)j=J<P P=r-J end else o=-529259+529344 W=w[x[615612-615610]]F=W*o W=22362986310880-(-555981)a=F+W F=35184372240621-151789 W=257486-257485 K=a%F w[x[351046+-351044]]=K F=w[x[599611+-599608]]K=11682025-371538 a=F~=W end else if K<959242+8359495 then F=M[-53549-(-53550)]a=N(-488754-(-546129))E=N(-309158-(-366535))a=F[a]u=19044722613309-948633 a=a(F)o=w[x[-482421-(-482422)]]U=w[x[64911+-64909]]G=U(E,u)W=o[G]K=a==W K=K and 14021465-234009 or-122828+287999 else i=-162984+162984 K=682909+14430570 z=#T k=z==i end end end end end else if K<12276576-(-250336)then if K<11822026-466371 then if K<10815684-317900 then if K<9220634-(-916550)then if K<10574798-642994 then if K<-813214+10523139 then J=-164485-(-164550)P=153632+-153629 Q=t()w[Q]=a K=w[u]a=K(P,J)K=678910-678910 P=t()T=N(419284-361926)k=v(12016352-299881,{})w[P]=a J=K K=511014-511014 j=K a=l[T]T={a(k)}a=-877852-(-877854)L=N(898019-840620)K={Y(T)}T=K K=T[a]a=N(415558+-358196)k=K K=l[a]z=w[o]b=l[L]L=b(k)b=N(640417-583015)V=z(L,b)z={V()}a=K(Y(z))z=t()w[z]=a a=958483+-958482 V=w[P]b=V V=548325+-548324 L=V V=-335466+335466 K=15220920-(-83389)i=L<V V=a-L else n=1032186+-1032086 d=t()S=N(-74028-(-131401))w[d]=V a=l[S]S=N(112177+-54779)K=a[S]S=-162751-(-162752)C=824936-824681 a=K(S,n)S=t()w[S]=a K=w[u]n=-969314-(-969314)a=K(n,C)n=t()w[n]=a K=w[u]C=-717800+717801 Z=w[S]a=K(C,Z)C=t()w[C]=a h=-426194+426196 a=w[u]D=-356170+356171 Z=a(D,h)a=108897+-108896 K=Z==a Z=t()w[Z]=K R=413492+-403492 q=48136+-48136 a=N(-961154+1018556)h=N(54545-(-2823))g=N(128466+-71067)c=l[g]m=w[u]y={m(q,R)}g=c(Y(y))c=N(-782301-(-839669))e=g..c D=h..e K=N(-207551-(-264917))h=N(-611073+668431)K=k[K]K=K(k,a,D)D=t()w[D]=K a=l[h]e=B(10090870-(-319418),{u,d;P,o,W,z,Z;D,S,C;n;Q})h={a(e)}K={Y(h)}h=K K=w[Z]K=K and 211406+2970573 or 3822645-154151 end else W=w[x[-765926-(-765928)]]o=w[x[860659+-860656]]F=W==o K=291139+2461348 a=F end else if K<10391399-39368 then i=755121+-755121 z=#T k=z==i K=k and 311524+1607066 or 14664959-(-448520)else G=1021586-1021584 U=64721-64720 W=w[x[-332553+332554]]o=W(U,G)W=863799-863798 F=o==W a=F K=F and 2891099-138612 or 9117002-(-916901)end end else if K<10662294-(-522395)then if K<10957128-(-121741)then if K<10052743-(-565481)then K=w[x[328821-328820]]F=M[516327+-516326]o=K W=M[-287920-(-287922)]K=o[W]K=K and-63248+1236442 or 9304073-404658 else y=617568-617567 c=K m=h[y]y=false g=m==y K=g and-150142+756317 or 12193147-844845 e=g end else K=true K=K and 5860111-(-62535)or 15207472-153051 end else if K<-325929+11673123 then o=-549785-(-549977)W=w[x[78095-78092]]F=W*o W=-625466+625723 a=F%W K=13983178-386524 w[x[1048203+-1048200]]=a else K=c K=654854+214141 a=e end end end else if K<12126935-320478 then if K<11050894-(-599966)then if K<-1042046+12688953 then if K<3806+11637805 then K=w[x[754391+-754381]]W=w[x[-468306-(-468317)]]F[K]=W K=w[x[534178-534166]]W={K(F)}a={Y(W)}K=l[N(-102355+159752)]else K=v(-658450-(-757397),{U})b={K()}a={Y(b)}K=l[N(-154148-(-211496))]end else b=J==j K=946018+15194535 V=b end else if K<12622883-834524 then a=7469328-(-627049)o=689920+7985290 W=N(-156867-(-214227))F=W^o K=a-F F=K a=N(-589839+647209)K=a/F a={K}K=l[N(-162875-(-220224))]else K=true K=K and-708731+5381285 or 5745144-(-942404)end end else if K<-99238+12401632 then if K<12934528-736993 then if K<12722475-613634 then a={W}K=l[N(855341+-797958)]else K=-429759-(-474791)end else L=N(213478+-156079)K=l[L]d=N(966503+-909157)i=l[d]L=K(i)K=N(-553200-(-610544))l[K]=L K=3995065-(-930735)end else if K<13449838-1040220 then W=N(-683676-(-741019))a=N(-534048-(-591407))K=l[a]u=N(-425010-(-482399))F=l[W]U=w[x[278794+-278793]]r=6248235456020-(-456009)G=w[x[585438-585436]]E=G(u,r)o=U[E]U=N(-392363+449713)U=F[U]W={U(F,o)}a=K(Y(W))K=a()K=l[N(911594-854242)]a={}else b=w[W]V=b K=b and 11181302-(-469524)or 332185+15808368 end end end end else if K<14587934-(-124985)then if K<-794998+14425590 then if K<-1043621+14050482 then if K<980203+11922633 then if K<999139+11777350 then E=w[G]K=6453555-456942 a=E else W=o K=w[x[860901-860900]]r=838760+-838760 Q=-606757+607012 u=K(r,Q)K=-541755+5589543 F[W]=u W=nil end else k=z n=k K=5938633-(-1960)T[k]=n k=nil end else if K<798822+12524810 then F=N(-488177+545571)K=l[F]W=w[x[-874264-(-874272)]]o=935094-935094 F=K(W,o)K=-938697+17162508 else W=w[x[157864-157861]]o=1042785-1042784 F=W~=o K=F and-322907+3455949 or 185700+11124787 end end else if K<14889334-690189 then if K<968120+13003570 then if K<14250314-512410 then j=E(J)K=6536946-747390 u=P u=nil J=nil else K=w[x[787451-787448]]a=K()K=-151122-(-316293)end else E=nil K=12400962-589813 u=nil U=nil end else if K<756171+13890362 then K=P K=Q and 9902922-343986 or 9006605-507313 a=Q else K=-572863+12362828 end end end else if K<-804314+16123862 then if K<-664830+15734952 then if K<14107405-(-795579)then if K<15456366-625521 then i=N(-662824+720168)K=l[i]i=N(-67292-(-124638))l[i]=K K=5545987-620187 else K=4412886-973040 r=P L=N(-755322+812687)b=l[L]L=N(-513441+570808)V=b[L]b=V(F,r)V=w[x[-238308+238314]]L=V()r=nil z=b+L k=z+E z=464786+-464530 T=k%z L=159986-159985 E=T z=o[W]b=E+L V=U[b]k=z..V o[W]=k end else K=l[N(-514459+571849)]a={}end else if K<128086+14985786 then z=-939983+939984 i=#T n=42973-42972 k=o(z,i)z=E(T,k)k=nil i=w[j]S=z-n d=u(S)K=532433+9641758 i[z]=d z=nil else d=not i V=V+L a=V<=b a=d and a d=V>=b d=i and d a=d or a d=9781207-68107 K=a and d a=410654+12017158 K=K or a end end else if K<-452289+17134705 then if K<16145016-(-69795)then if K<44869+15899745 then a=1169919-(-353474)W=N(168103-110715)o=44934+1123709 F=W^o K=a-F a=N(-889481-(-946844))F=K K=a/F a={K}K=l[N(414859+-357498)]else w[W]=V K=w[W]K=K and 767595+11400616 or 474932+16223682 end else K={}F=K W=-417223+417224 o=w[x[-414979+414988]]U=o K=-728782+5776570 o=-103846+103847 G=o o=370230-370230 E=G<o o=W-G end else if K<16553657-(-141539)then g=793544+-793543 c=h[g]K=4523232-772921 e=c else K=true K=18633+11625429 end end end end end end end K=#I return Y(a)end,{},function(l,N)local Y=o(N)local M=function(M,x,I,H)return K(l,{M;x,I;H},N,Y)end return M end,569141-569141,function(l,N)local Y=o(N)local M=function()return K(l,{},N,Y)end return M end,function(l,N)local Y=o(N)local M=function(M,x,I,H,a)return K(l,{M;x;I;H,a},N,Y)end return M end return(G(-261556+8293914,{}))(Y(a))end)(getfenv and getfenv()or _ENV,unpack or table[N(-46659+104045)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
