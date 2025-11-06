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

return(function(...)local y={"\121\088\115\112\121\088\067\084";"\121\114\057\084\079\090\061\061";"\102\101\115\069\079\116\099\084\052\120\057\112\079\055\061\061";"\079\120\089\086\102\109\070\061","\102\119\067\084\080\085\061\061";"\079\088\097\069\107\101\099\100";"\079\088\067\078\079\090\061\061","\090\098\072\078\072\109\050\105\117\111\108\114\121\114\107\043","\122\076\117\051\072\116\069\119\119\119\108\078","\107\101\067\068\102\101\076\061","\102\101\117\112","\117\101\067\078\052\101\117\043\070\081\072\057\107\101\117\110\107\101\117\103\070\090\061\061","\102\119\078\117\102\109\087\109\079\120\115\103\099\116\069\043","\052\088\067\118\079\111\108\068\075\111\108\084\107\120\082\056\111\081\055\061";"\090\088\115\112\102\120\117\110\107\085\061\061";"\098\097\115\087\102\120\072\057\122\085\061\061";"\102\101\115\109\079\098\070\061";"\052\120\117\078\102\109\079\057","\107\114\069\057\111\073\061\061","\076\076\073\082\079\116\069\087\080\097\072\076\119\120\117\076\107\081\118\061";"\047\073\061\061";"\076\101\089\069\122\119\117\043\052\055\061\061";"\075\116\072\084\052\081\107\057\107\085\061\061";"";"\107\101\115\049\107\116\108\087\102\120\052\061";"\098\097\115\054\079\119\118\061","\047\068\073\057\079\077\100\087\047\073\061\061";"\090\121\078\107\079\065\076\061","\080\081\090\118\047\098\069\106\119\098\108\086\102\088\069\108\121\103\105\061","\080\098\050\069\080\098\108\049","\072\119\089\071\122\076\115\077\075\116\117\080\080\101\115\111\099\088\054\061","\105\076\072\049\102\119\069\079\052\084\105\049\076\109\072\087\122\104\076\061";"\119\111\067\048\079\117\090\055\075\103\118\061";"\111\117\090\109\075\116\108\116\080\119\079\055\099\098\050\082","\111\098\072\071\072\101\087\087\076\081\103\088\090\119\076\049","\118\070\088\110\055\085\054\051\098\055\061\061","\072\088\117\084\076\101\089\069\122\119\117\043\052\055\061\061";"\121\088\069\069\052\073\061\061","\052\109\072\043\080\119\082\114";"\098\097\115\114\121\055\061\061","\107\119\082\055\121\119\099\106";"\072\081\099\121\072\110\085\049\105\111\099\103\099\116\107\098\111\085\061\061","\102\104\070\061","\079\109\099\097\121\073\061\061";"\043\117\047\050\099\105\066\082\051\078\090\087\118\074\072\078\066\090\084\103\107\049\090\098\083\057\103\065\106\069\122\070\077\097\050\072\109\100\097\115\107\090\100\081\065\067\101\088\097\104\109\053\115\069\108\099\081\098\043\113\052\117\067\067\122\120\043\103\048\071\048\066\107\110\049\069\108\116\085\102\108\080\077\119\072\052\106\065\056\048\120\118\101\089\101\100\118\120\111\100\066\084\082\101\083\100\111\089\067\082\105\052\054\054\070\061";"\111\088\117\080\107\098\108\082\102\104\099\048\117\111\108\069","\052\088\117\084\102\119\117\084\121\098\072\069\121\120\089\057";"\052\098\079\121\105\120\105\109\090\076\115\109\121\109\099\047\072\085\061\061";"\107\101\115\112\107\119\097\068\079\098\070\061","\117\104\107\097\107\119\108\105\105\120\057\110\105\111\050\049";"\079\098\108\043\102\109\070\061","\102\104\081\061","\117\084\057\089\121\084\099\071\076\088\082\116\076\081\055\109\122\090\061\061","\052\101\099\069\102\101\055\061","\098\097\115\078\079\098\072\069\107\101\067\068\102\101\076\061";"\052\120\067\112\079\101\115\078","\075\052\088\084\103\104\102\113\073\048\043\108\056\119\073\061","\080\101\108\110\099\117\072\084\121\076\072\071\107\111\117\117\117\055\061\061","\105\120\121\049\079\076\079\047\105\109\087\079"}local function J(J)return y[J-(-873201-(-884879))]end for J,L in ipairs({{-279569+279570;863128-863069};{805686+-805685;334445+-334409};{-96888+96925,877891+-877832}})do while L[-153268+153269]<L[571975+-571973]do y[L[80773-80772]],y[L[620125+-620123]],L[344115+-344114],L[113879+-113877]=y[L[-149955+149957]],y[L[-995455+995456]],L[-820165-(-820166)]+(-862667+862668),L[-253845+253847]-(894402-894401)end end do local J=type local L=table.insert local n={g=-106909-(-106945);["\043"]=-664555-(-664605);["\054"]=973501+-973457,o=-237585-(-237604);d=-792543-(-792583);s=-164693+164754,H=462896-462879;c=-628872-(-628885),D=748193-748159;t=-1037940-(-1037947),["\048"]=1043994+-1043983,l=386295+-386286,W=-365160+365201,q=454809+-454750,["\055"]=-807840+807888,P=-982123+982149,x=196301+-196263;V=-620186+620233,r=-950611+950650;y=-953953-(-953977);R=224504-224447;b=-97881+97904,T=-125543-(-125595),e=-170652-(-170658);f=-216721-(-216748);F=40614-40606;a=-499396+499449,z=-408777-(-408807);v=632441+-632385,K=787438+-787420,i=-97581+97593;w=162030+-162008,u=-487907+487928;["\052"]=-944520-(-944548);E=83769+-83736;["\047"]=-806758-(-806772);S=151096+-151033,["\053"]=254433-254371;["\049"]=-671908-(-671959),C=261005-261000,Z=-24265+24281,Q=-139925+139929,k=-239550+239579,Y=331690+-331641,A=831969-831938;["\056"]=930703-930661;m=704273-704218;L=-393645+393665,M=-698983-(-698985);U=858039+-858039,X=-224885-(-224939),p=969845+-969799;j=982006-981963,["\057"]=1035750-1035713,I=474925+-474893,["\050"]=744968-744967,O=288446-288421;B=-1011778+1011838,h=719040-719037;G=-146007+146017,J=-428482+428540,n=-840634+840669;N=-659193+659238,["\051"]=635185-635170}local H=string.char local d=string.len local I=string.sub local g=table.concat local k=y local O=math.floor for y=-736732-(-736733),#k,324078-324077 do local p=k[y]if J(p)=="\115\116\114\105\110\103"then local J=d(p)local a={}local e=-835043-(-835044)local C=10375-10375 local P=-984860+984860 while e<=J do local y=I(p,e,e)local d=n[y]if d then C=C+d*(974879-974815)^((-743442-(-743445))-P)P=P+(519029-519028)if P==-433083+433087 then P=-456447+456447 local y=O(C/(-122100-(-187636)))local J=O((C%(300495+-234959))/(-225657+225913))local n=C%(658414+-658158)L(a,H(y,J,n))C=955738+-955738 end elseif y=="\061"then L(a,H(O(C/(641005+-575469))))if e>=J or I(p,e+(451492-451491),e+(864299-864298))~="\061"then L(a,H(O((C%(369399-303863))/(267536-267280))))end break end e=e+(221133+-221132)end k[y]=g(a)end end end return(function(y,n,H,d,I,g,k,D,a,O,K,l,i,L,U,X,p,P,o,h,C,e)O,U,X,P,C,L,a,h,o,i,K,p,e,D,l={},function(y,J)local n=C(J)local H=function(H,d,I,g,k,O)return L(y,{H,d,I;g;k;O},J,n)end return H end,function(y)p[y]=p[y]-(856867+-856866)if 362968-362968==p[y]then p[y],O[y]=nil,nil end end,function(y)local J,L=-369328+369329,y[459290-459289]while L do p[L],J=p[L]-(-967673-(-967674)),J+(-946831-(-946832))if 903012-903012==p[L]then p[L],O[L]=nil,nil end L=y[J]end end,function(y)for J=-643344+643345,#y,-307120+307121 do p[y[J]]=(334477-334476)+p[y[J]]end if H then local L=H(true)local n=I(L)n[J(-647097-(-658827))],n[J(515766-504071)],n[J(1009610+-997929)]=y,P,function()return-1571344-(-49703)end return L else return d({},{[J(606231+-594536)]=P;[J(78522-66792)]=y;[J(1027954-1016273)]=function()return-2513796-(-992155)end})end end,function(L,H,d,I)local z,s,T,t,j,r,u,N,Q,K,G,Y,B,v,P,V,C,f,b,A,c,p,E,S,F,m,R,Z,M,x,e,W,w,k while L do if L<1042601+5537989 then if L<255208+3500888 then if L<1895548-(-397039)then if L<1911395-607558 then if L<-509796+1542809 then if L<993964-446932 then if L<-272172+720834 then e=-830091+830092 C=O[d[620037-620028]]L={}p=L P=C C=-343563+343564 K=C C=968270+-968270 Z=K<C C=e-K L=-430726+10645195 else E=nil P=nil Z=nil L=988300-(-292148)end else w=a()N={}Z=nil Q=a()s=nil x=l(13115135-(-164387),{w,T;A;K})O[w]=N F=J(895999+-884269)N=a()L=12827988-542910 u=nil O[N]=x M=J(-907207+918909)x={}O[Q]=x V=J(916123-904413)x=y[M]c=O[Q]E=nil C=nil B=nil K=X(K)W={[F]=c,[V]=s}t=nil R={}M=x(R,W)x=U(2605240-(-667947),{Q;w;S;T,A;N})A=X(A)E=J(-372955+384640)u=J(-107243+118979)C=a()S=X(S)T=X(T)N=X(N)Q=X(Q)O[P]=M O[e]=x K=i(254559+2056233,{P,e})O[C]=K S=J(-422029+433721)Z=y[E]K=o(5202826-(-550205),{P,e;C})A=y[u]w=X(w)S=A[S]u={S(A)}A={Z(n(u))}E=A[-688153-(-688154)]T=A[503180+-503177]t=A[481303+-481301]end else if L<660970-(-612435)then if L<-397423+1499291 then k={}L=y[J(-717090+728787)]else C=O[d[-241236-(-241242)]]e=C==p k=e L=-202698+3960323 end else k={e}L=y[J(-524547+536237)]end end else if L<2042734-292825 then if L<938436+704688 then if L<578783-(-963777)then P=J(-840974-(-852654))k=J(991781-980077)L=y[k]T=l(3422247-564396,{})p=O[d[111818+-111814]]C=y[P]t=J(194486+-182777)E=y[t]t={E(T)}Z={n(t)}E=-38901-(-38903)K=Z[E]P=C(K)C=J(-249076-(-260758))e=p(P,C)p={e()}k=L(n(p))p=k e=O[d[-879875+879880]]k=e L=e and 904320-(-237168)or 3524785-(-232840)else x=J(803411+-791713)L=y[x]x=J(972870-961163)y[x]=L L=-29150+2513549 end else L=O[d[920568-920565]]k=L()L=1039075+2443869 end else if L<1591704-(-665210)then L=y[J(-488477-(-500204))]k={}else L=O[d[-623290-(-623297)]]L=L and 9670521-(-538603)or-429257-(-832060)end end end else if L<3546385-577638 then if L<213954+2559519 then if L<1902456-(-559048)then if L<2259643-(-177358)then k=J(753083+-741374)L=y[k]p=h(3191567-(-916800),{d[481180+-481179];d[215039-215037]})k=L(p)k={}L=y[J(-13257+24943)]else Q=not x f=f+m k=f<=v k=Q and k Q=f>=v Q=x and Q k=Q or k Q=1036942+9759142 L=k and Q k=6174753-679568 L=L or k end else L=4271050-797169 end else if L<573561+2330127 then e=J(608465-596732)k=-858227+9786944 C=381673-96571 p=e^C L=k-p p=L k=J(653330+-641607)L=k/p k={L}L=y[J(491109+-479401)]else L=true L=-920888+14164958 end end else if L<2882867-(-532132)then if L<2291308-(-1041620)then if L<-345834+3621076 then e=H[274034+-274032]p=H[-335804-(-335805)]L=O[d[487188+-487187]]C=L L=C[e]L=L and 10088425-(-703575)or 13243292-523934 else L=y[J(386931-375226)]C=J(-809236+820960)e=y[C]C=J(485967-474235)p=e[C]C=O[d[223151+-223150]]e={p(C)}k={n(e)}end else z=O[e]L=z and 12453682-824970 or 13608873-(-585108)r=z end else if L<375317+3106489 then L=true L=L and 6672499-489537 or 268546+819595 else k={}L=y[J(-1012109-(-1023810))]p=nil end end end end else if L<534947+4909357 then if L<-869959+4974423 then if L<4317676-464570 then if L<3273347-(-526095)then if L<785742+2972309 then O[d[837715+-837710]]=k L=-639777+2907581 p=nil else e=O[d[-660302+660303]]K=777261+-777259 P=129314-129313 C=e(P,K)e=-479322+479323 p=C==e L=p and 12191484-1029202 or-933340+13875471 k=p end else C=16482967-608974 k=-221062+617969 e=J(899610-887896)p=e^C L=k-p p=L k=J(-995206-(-1006894))L=k/p k={L}L=y[J(872676+-860992)]end else if L<4102990-21319 then Z=k t=J(-811920+823644)E=J(768440+-756721)k=y[E]E=J(-12318+24029)S=J(-1031326+1043050)L=k[E]E=a()O[E]=L k=y[t]t=J(139817+-128102)L=k[t]A=L t=L u=y[S]L=u and-726204+6716378 or 6786115-538904 T=u else C=J(-439558+451252)e=a()p=H L=true O[e]=L E=J(-261209-(-272918))k=y[C]C=J(-127067+138787)L=k[C]K=a()C=a()P=a()O[C]=L L=h(12333996-(-24190),{})t=h(7933131-(-1041400),{K})O[P]=L L=false O[K]=L Z=y[E]E=Z(t)L=E and 8637771-164985 or 852418+3224636 k=E end end else if L<717008+3905510 then if L<4949430-525240 then if L<359823+3792537 then k=J(581615-569898)e=J(-720779+732500)t=332773+15973589600553 L=y[k]p=y[e]E=J(1022871+-1011171)P=O[d[-839694+839695]]K=O[d[-342572-(-342574)]]Z=K(E,t)C=P[Z]P=J(-685560+697297)P=p[P]e={P(p,C)}k=L(n(e))L=k()k={}L=y[J(61962+-50259)]else z=L j=795083+-795082 b=V[j]j=false s=b==j r=s L=s and 13852639-800147 or 955879+4760875 end else t=A m=J(200403-188709)v=y[m]m=J(322042+-310326)f=v[m]v=f(p,t)f=O[d[-1031915+1031921]]m=f()w=v+m m=-314870-(-314871)N=w+Z w=-81320-(-81576)B=N%w w=C[e]Z=B v=Z+m t=nil f=P[v]N=w..f L=705501+12561204 C[e]=N end else if L<4242334-(-495355)then e=O[d[-20960-(-20963)]]C=640773+-640741 u=915003-914990 p=e%C T=-596106-(-596108)P=O[d[-351490-(-351494)]]E=O[d[-83439-(-83441)]]N=O[d[705026-705023]]B=N-p N=886270+-886238 S=B/N A=u-S t=T^A Z=E/t K=P(Z)u=60290-60034 P=41220+4294926076 C=K%P t=527471-527470 K=83664-83662 P=K^p p=nil e=C/P P=O[d[-687473+687477]]E=e%t t=-473228+4295440524 Z=E*t E=848980+-783444 K=P(Z)P=O[d[-785584+785588]]Z=P(e)C=K+Z K=1015003+-949467 P=C%K Z=C-P K=Z/E E=-493252-(-493508)Z=P%E T=43413+-43157 t=P-Z P=nil e=nil E=t/T T=-969758-(-970014)t=K%T A=K-t C=nil T=A/u K=nil L=2815573-(-486136)A={Z;E,t,T}T=nil t=nil E=nil Z=nil O[d[-178899+178900]]=A else p=H[-961746-(-961747)]k=J(239482-227751)k=p[k]k=k(p)C=O[d[260256-260255]]P=O[d[795424+-795422]]E=192491+17134512271167 Z=J(400475-388792)K=P(Z,E)e=C[K]L=k==e L=L and-401869+2053246 or 3318574-(-164370)end end end else if L<-42805+5937604 then if L<5597989-(-115587)then if L<5685065-73337 then if L<4812685-(-727103)then v=O[e]L=v and 9879220-404841 or 12034312-2797 f=v else t=J(-632558+644294)E=y[t]S=J(552422-540710)C=X(C)T=O[P]A=O[e]B=-590717+9612915856633 k={}u=A(S,B)L=y[J(860570+-848848)]t=T[u]Z=E[t]E=J(-241425-(-253154))E=Z[E]e=X(e)P=X(P)E=E(Z,K)K=nil end else L=O[d[-465216-(-465226)]]e=O[d[-999135-(-999146)]]p[L]=e L=O[d[-92089+92101]]e={L(p)}L=y[J(575435-563701)]k={n(e)}end else if L<-225662+5950822 then L=z k=r L=-126736+15492951 else p=H[565720+-565719]Z=-922379+24332200001357 e=O[d[-329362+329363]]K=J(460947-449256)C=O[d[420341-420339]]P=C(K,Z)k=e[P]e=i(4042758-(-726940),{d[239159+-239158];d[834011+-834009],d[511917-511914]})L=p[k]k=J(-880296-(-892025))k=L[k]p=nil k=k(L,e)L=y[J(-935816-(-947529))]k={}end end else if L<7275210-970100 then if L<5334665-(-874456)then if L<5215025-(-869425)then B=J(656929+-645205)S=y[B]B=J(484626+-472930)u=S[B]L=864033+5383178 T=u else m=717122+-717121 x=-142843+142849 L=O[E]v=L(m,x)x=J(-426908+438606)L=J(930916+-919218)y[L]=v m=y[x]x=-341110+341112 L=m>x L=L and 11335741-952621 or 525549+1018452 end else L=A L=T and-860787+15900602 or 11202670-749306 k=T end else if L<-292055+6779421 then N=w R=N B[N]=R N=nil L=-851348+9467087 else L=8445343-(-1046471)w=#B x=1048319+-1048319 N=w==x end end end end end else if L<30597+11731151 then if L<384201+9098211 then if L<9558771-1027504 then if L<8762473-762309 then if L<813359+6777583 then if L<905629+6543356 then e=O[d[576489+-576487]]C=941605+-941472 p=e*C e=396273+27909571159762 k=p+e e=500557+-500556 p=-118218+35184372207050 L=k%p O[d[-923484-(-923486)]]=L p=O[d[-755291-(-755294)]]k=p~=e L=542730+15328770 else L=-135191+13213845 end else B=nil T=X(T)w=X(w)N=nil C=X(C)Z=nil K=X(K)Z=J(309990+-298271)e=X(e)S=nil t=nil N=-519767+519768 e=nil P=X(P)u=nil w=-41359-(-41615)P=a()S=a()C=nil E=X(E)t=J(-278714+290438)O[P]=e A=X(A)e=a()O[e]=C K=y[Z]Z=J(759851-748133)E=J(-573825-(-585544))A=a()C=K[Z]K=a()O[K]=C Z=y[E]T=J(104336+-92642)E=J(-911878+923589)C=Z[E]B={}E=y[t]t=J(289092-277360)Z=E[t]t=y[T]T=J(753653+-741960)E=t[T]L=8101416-(-514323)t=-798981-(-798981)x=w w=380581-380580 T=a()O[T]=t u={}t=402288+-402286 O[A]=t t={}O[S]=u Q=w u=-776881-(-776881)w=-192833-(-192833)M=Q<w w=N-Q end else if L<-622460+9043928 then L=7402104-(-223784)else Z=O[K]k=Z L=4655271-578217 end end else if L<-187649+9170934 then if L<7678475-(-1018335)then if L<-360796+8980445 then R=not M w=w+Q N=w<=x N=R and N R=w>=x R=M and R N=R or N R=5703548-(-775877)L=N and R N=-466780+6963035 L=L or N else x=268305-268305 w=#B N=w==x L=N and 154419-(-539916)or 8566456-(-925358)end else L=true O[d[-234947+234948]]=L k={}L=y[J(-11014+22701)]end else if L<9082584-(-56026)then u=K(A)Z=T L=12159517-(-125561)Z=nil A=nil else L=-192418+12223933 v=u==S f=v end end end else if L<11350861-876065 then if L<9624438-(-618397)then if L<438133+9776281 then if L<9322749-(-284193)then w=-447183+447184 x=#B N=C(w,x)R=555289+-555288 w=Z(B,N)x=O[S]M=w-R L=719428+7912715 N=nil Q=E(M)x[w]=Q w=nil else p=J(-504117-(-515823))L=y[p]e=O[d[-728351+728359]]C=203779-203779 p=L(e,C)L=-50041-(-452844)end else C=C+K E=not Z e=C<=P e=E and e E=C>=P E=Z and E e=E or e E=13887354-749189 L=e and E e=6171970-553788 L=L or e end else if L<684162+9711217 then m=J(24615-12935)Q=J(603162-591455)L=y[m]x=y[Q]m=L(x)L=J(640541+-628843)y[L]=m L=2907104-422705 else A=J(-120853-(-132549))T=y[A]k=T L=14665072-(-374743)end end else if L<10524565-(-796844)then if L<-80792+11140034 then if L<9988321-(-806530)then L=-884060+2164508 else Q=a()W=-1011837-(-1012092)O[Q]=f M=J(4847+6872)k=y[M]M=J(602195-590484)V=313584+-313582 R=-29545+29645 L=k[M]M=117937+-117936 k=L(M,R)M=a()Y=-749382+759382 O[M]=k c=1006359-1006358 L=O[E]R=-94601+94601 k=L(R,W)R=a()W=971650-971649 G=124894+-124894 O[R]=k L=O[E]F=O[M]k=L(W,F)W=a()O[W]=k k=O[E]F=k(c,V)k=139216-139215 L=F==k F=a()s=J(104642+-92962)k=J(-469041-(-480723))V=J(-953557+965292)O[F]=L z=y[s]b=O[E]j={b(G,Y)}s=z(n(j))z=J(32200-20465)r=s..z L=J(-230607+242306)L=N[L]c=V..r L=L(N,k,c)V=J(170103-158394)c=a()r=h(935235+2864018,{E,Q,A,C,e,w;F,c;M;W;R;T})O[c]=L k=y[V]V={k(r)}L={n(V)}V=L L=O[F]L=L and 418071+13715221 or-942478+4279774 end else L=k and-879874+2372937 or 2319219-51415 end else if L<10883082-(-623720)then L=134447+2320938 F=X(F)W=X(W)R=X(R)Q=X(Q)V=nil c=X(c)M=X(M)else s=185473-185472 z=V[s]r=z L=225519+13968462 end end end end else if L<13074019-(-194095)then if L<737497+12241673 then if L<-890531+13321342 then if L<13310219-1019465 then if L<234399+11818224 then O[e]=f L=O[e]L=L and 828329+7564135 or 3882283-970651 else T,A=E(t,T)L=T and 9497042-421939 or-963193+6555800 end else k=J(608896+-597190)L=y[k]p=J(-962133+973859)k=L(p)k={}L=y[J(836697-824969)]end else if L<-331844+13197989 then L={}O[d[34959-34957]]=L A=53417-53416 t=J(621837-610143)K=35184371461217-(-627615)k=O[d[643439+-643436]]P=k k=e%K O[d[36144-36140]]=k E=1031168-1030913 Z=e%E E=-185268+185270 K=Z+E O[d[796239+-796234]]=K L=13301526-34821 E=y[t]t=J(-478570+490295)Z=E[t]u=A E=Z(p)Z=J(-208049+219728)t=-335655+335656 A=976907-976907 S=u<A C[e]=Z T=E A=t-u Z=-652795-(-653010)else e=O[d[874592+-874590]]C=O[d[956922-956919]]p=e==C k=p L=-181922+11344204 end end else if L<-483075+13654000 then if L<13664297-565850 then if L<12522883-(-531337)then j=-35070-(-35072)b=V[j]L=6571789-855035 j=O[c]s=b==j r=s else L=true L=L and-868628+16142008 or 1531271-(-562956)end else e=C L=O[d[-262331+262332]]t=-411241-(-411241)T=658974-658719 E=L(t,T)p[e]=E e=nil L=9657704-(-556765)end else if L<-219921+13482062 then L=D(546714+7033507,{P})v={L()}k={n(v)}L=y[J(71399-59710)]else B=not S A=A+u t=A<=T t=B and t B=A>=T B=S and B t=B or t B=896546+3661334 L=t and B t=828458-334249 L=L or t end end end else if L<346259+14881438 then if L<13828914-(-328430)then if L<583460+13019724 then if L<13917575-608521 then p=O[d[-140358+140359]]k=#p p=670622-670622 L=k==p L=L and 6217364-(-1017520)or 2618781-(-682928)else e=O[d[45688+-45685]]C=786826-786825 p=e~=C L=p and 364100+4317263 or-422025+16293525 end else r=O[e]L=r and-514858+4735663 or-934613+16300828 k=r end else if L<14948512-6342 then O[e]=r G=-446698+446699 j=O[W]b=j+G s=V[b]z=u+s s=-243194-(-243450)L=z%s b=O[R]s=S+b u=L b=-438135-(-438391)L=-551045+11872471 z=s%b S=z else A=753897+-753894 T=a()u=44151-44086 O[T]=k L=O[E]k=L(A,u)m=J(-315745+327425)A=a()O[A]=k L=-785483-(-785483)B=J(280141-268432)N=l(3990318-161327,{})k=y[B]u=L B={k(N)}L=-865608-(-865608)S=L L={n(B)}B=L k=-39743-(-39745)L=B[k]N=L k=J(-721945-(-733649))L=y[k]w=O[C]v=y[m]m=v(N)v=J(326774+-315092)f=w(m,v)w={f()}k=L(n(w))w=a()O[w]=k f=O[A]v=f k=-890601+890602 f=821266+-821265 m=f f=308543+-308543 x=m<f f=k-m L=2666745-211360 end end else if L<442846+15122449 then if L<188188+15330787 then if L<-184626+15480811 then k=J(943769+-932071)L=y[k]p=J(767180+-755473)k=y[p]p=J(-40687+52394)y[p]=L p=J(-812286+823984)L=-8867+13087521 y[p]=k p=O[d[1025785-1025784]]e=p()else O[e]=k L=496504+10824922 end else L=true L=L and 15095234-(-486254)or 12256764-(-987306)end else if L<152662+15597281 then L=29265+3444616 else C=891819-891636 L=13213231-(-204616)e=O[d[-111205+111208]]p=e*C e=624173-623916 k=p%e O[d[350496-350493]]=k end end end end end end end L=#I return n(k)end,function()e=(12279+-12278)+e p[e]=-491167+491168 return e end,function(y,J)local n=C(J)local H=function(H)return L(y,{H},J,n)end return H end,function(y,J)local n=C(J)local H=function(H,d)return L(y,{H;d},J,n)end return H end,function(y,J)local n=C(J)local H=function(H,d,I,g,k)return L(y,{H;d;I;g,k},J,n)end return H end,function(y,J)local n=C(J)local H=function(...)return L(y,{...},J,n)end return H end,{},651286+-651286,function(y,J)local n=C(J)local H=function()return L(y,{},J,n)end return H end,function(y,J)local n=C(J)local H=function(H,d,I,g)return L(y,{H,d;I,g},J,n)end return H end return(K(3859592-(-225733),{}))(n(k))end)(getfenv and getfenv()or _ENV,unpack or table[J(431759+-420063)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
