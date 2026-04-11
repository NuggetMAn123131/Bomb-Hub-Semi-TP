--========================
-- CONFIG
--========================
local VALID_KEY = "BH-KEY-0"

--========================
-- SERVICES
--========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- prevent duplicates
if playerGui:FindFirstChild("KeySystemUI") then
	return
end

--========================
-- KEY GUI
--========================
local gui = Instance.new("ScreenGui")
gui.Name = "KeySystemUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0.4
bg.Parent = gui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 190)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "BOMB HUB ACCESS"
title.TextColor3 = Color3.fromRGB(255,140,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.8,0,0,40)
box.Position = UDim2.new(0.1,0,0.45,0)
box.PlaceholderText = "Enter Key..."
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(35,35,35)
box.TextColor3 = Color3.fromRGB(255,255,255)
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)

local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0.8,0,0,40)
submit.Position = UDim2.new(0.1,0,0.72,0)
submit.Text = "UNLOCK"
submit.BackgroundColor3 = Color3.fromRGB(40,40,40)
submit.TextColor3 = Color3.fromRGB(255,140,0)
submit.Font = Enum.Font.GothamBold
submit.TextSize = 14
submit.Parent = frame
Instance.new("UICorner", submit).CornerRadius = UDim.new(0,8)

--========================
-- STEP 2: YOUR HUB GOES HERE
--========================
local function loadMainScript()
--// WAIT FOR GAME
repeat task.wait() until game:IsLoaded()

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

--// COLORS
local ORANGE = Color3.fromRGB(255,120,0)
local BLACK = Color3.fromRGB(0,0,0)

--// CHARACTER
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(c)
	char = c
	root = char:WaitForChild("HumanoidRootPart")
	hum = char:WaitForChild("Humanoid")
end)

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "Bomb Hub"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,260,0,420)
frame.Position = UDim2.new(0,40,0.5,-210)
frame.BackgroundColor3 = Color3.fromRGB(5,5,5)
frame.BackgroundTransparency = 0.05
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner",frame)

-- FLASH BORDER (BLACK ↔ ORANGE)
local stroke = Instance.new("UIStroke",frame)
stroke.Thickness = 3

local t = 0
RunService.Heartbeat:Connect(function(dt)
	t += dt * 3
	local v = (math.sin(t)+1)/2
	stroke.Color = Color3.new(ORANGE.R*v, ORANGE.G*v, ORANGE.B*v)
end)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Bomb Hub Semi Tp"
title.TextSize = 20

-- TITLE FLASH
local t2 = 0
RunService.Heartbeat:Connect(function(dt)
	t2 += dt*3
	local v = (math.sin(t2)+1)/2
	title.TextColor3 = Color3.new(ORANGE.R*v, ORANGE.G*v, ORANGE.B*v)
end)

-- TOGGLE CREATOR
local function createToggle(name,y)

	local holder = Instance.new("Frame",frame)
	holder.Size = UDim2.new(0.85,0,0,40)
	holder.Position = UDim2.new(0.075,0,0,y)
	holder.BackgroundTransparency = 1

	local label = Instance.new("TextLabel",holder)
	label.Size = UDim2.new(0.6,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = name
	label.Font = Enum.Font.Gotham
	label.TextColor3 = Color3.new(1,1,1)
	label.TextSize = 15
	label.TextXAlignment = Enum.TextXAlignment.Left

	local switch = Instance.new("Frame",holder)
	switch.Size = UDim2.new(0,50,0,22)
	switch.Position = UDim2.new(1,-55,0.5,-11)
	switch.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner",switch)

	local knob = Instance.new("Frame",switch)
	knob.Size = UDim2.new(0,18,0,18)
	knob.Position = UDim2.new(0,2,0.5,-9)
	knob.BackgroundColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",knob)

	local enabled = false

	switch.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			enabled = not enabled
			if enabled then
				knob:TweenPosition(UDim2.new(1,-20,0.5,-9),"Out","Quad",0.25,true)
				switch.BackgroundColor3 = ORANGE
			else
				knob:TweenPosition(UDim2.new(0,2,0.5,-9),"Out","Quad",0.25,true)
				switch.BackgroundColor3 = Color3.fromRGB(40,40,40)
			end
		end
	end)

	return function()
		return enabled
	end
end

-- BUTTON CREATOR
local function createButton(text,y)
	local b = Instance.new("TextButton",frame)
	b.Size = UDim2.new(0.85,0,0,34)
	b.Position = UDim2.new(0.075,0,0,y)
	b.BackgroundColor3 = Color3.fromRGB(30,30,30)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.Text = text
	Instance.new("UICorner",b)
	return b
end

-- TOGGLES
local qcToggle = createToggle("Quantum Cloner (V)",70)
local dragToggle = createToggle("Drag Platforms",120)
local tracerToggle = createToggle("Tracers", 170)

-- BUTTONS
local tpEnemy = createButton("TP Podium 1",225)
local tpMid = createButton("TP Podium 2",280)
local tpYour = createButton("TP Podium 3",330)

local function createPlatform(pos, name)

	local p = Instance.new("Part")
	p.Size = Vector3.new(6, 0.15, 6) -- SMALLER PODIUM
	p.Anchored = true
	p.CanCollide = false
	p.Position = pos
	p.Color = BLACK
	p.Transparency = 0.35
	p.Material = Enum.Material.SmoothPlastic
	p.Parent = workspace

	-- glow outline
	local outline = Instance.new("SelectionBox", p)
	outline.Adornee = p
	outline.LineThickness = 0.03
	outline.Color3 = ORANGE
	outline.SurfaceTransparency = 1


	-- label
	local bill = Instance.new("BillboardGui", p)
	bill.Size = UDim2.new(0,150,0,30)
	bill.StudsOffset = Vector3.new(0,2,0)
	bill.AlwaysOnTop = true

	local text = Instance.new("TextLabel", bill)
	text.Size = UDim2.new(1,0,1,0)
	text.BackgroundTransparency = 1
	text.Text = name
	text.Font = Enum.Font.GothamBold
	text.TextColor3 = ORANGE
	text.TextScaled = true

	return p
end

-- CREATE PLATFORMS
local start = root.Position

local yourPlat = createPlatform(start + Vector3.new(-12, 2, 0), "Podium 3")
local midPlat = createPlatform(start + Vector3.new(0, 2, 0), "Podium 2")
local enemyPlat = createPlatform(start + Vector3.new(12, 2, 0), "Podium 1")

-- TOOL PULL OUT
local function pullOutTool()
	local tool = player.Backpack:FindFirstChild("Witch Broom") 
		or player.Backpack:FindFirstChild("Flying Carpet")
	if tool then
		tool.Parent = char
	end
end

-- TP
local function tp(part)
	pullOutTool()
	root.CFrame = part.CFrame + Vector3.new(0,3,0)
end

tpEnemy.MouseButton1Click:Connect(function() tp(enemyPlat) end)
tpMid.MouseButton1Click:Connect(function() tp(midPlat) end)
tpYour.MouseButton1Click:Connect(function() tp(yourPlat) end)

-- DRAG SYSTEM
local dragging = nil
local dragOffset = Vector3.new()

mouse.Button1Down:Connect(function()
	if dragToggle() then
		local target = mouse.Target
		if target == yourPlat or target == midPlat or target == enemyPlat then
			dragging = target
			dragOffset = dragging.Position - mouse.Hit.Position
		end
	end
end)

mouse.Button1Up:Connect(function()
	dragging = nil
end)

RunService.RenderStepped:Connect(function()
	if dragging then
		local pos = mouse.Hit.Position
		dragging.Position = Vector3.new(pos.X+dragOffset.X, dragging.Position.Y, pos.Z+dragOffset.Z)
	end
end)

-- ESP
local tracerBeams = {}

RunService.RenderStepped:Connect(function()

	if not tracerToggle() then
		for _,v in pairs(tracerBeams) do
			v.beam:Destroy()
			v.a0:Destroy()
			v.a1:Destroy()
		end
		tracerBeams = {}
		return
	end

	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then

			local char = plr.Character
			local hrp = char.HumanoidRootPart

			if not tracerBeams[plr] then

				local a0 = Instance.new("Attachment", root)
				local a1 = Instance.new("Attachment", hrp)

				local beam = Instance.new("Beam")
				beam.Attachment0 = a0
				beam.Attachment1 = a1
				beam.Color = ColorSequence.new(ORANGE)
				beam.Width0 = 0.12
				beam.Width1 = 0.12
				beam.LightEmission = 1
				beam.LightInfluence = 0
				beam.FaceCamera = true
				beam.Parent = root

				tracerBeams[plr] = {
					beam = beam,
					a0 = a0,
					a1 = a1
				}
			end
		end
	end
end)

Players.PlayerRemoving:Connect(function(plr)
	if tracerBeams[plr] then
		tracerBeams[plr].beam:Destroy()
		tracerBeams[plr].a0:Destroy()
		tracerBeams[plr].a1:Destroy()
		tracerBeams[plr] = nil
	end
end)



-- QUANTUM CLONER
local qcEquipped = false

UIS.InputBegan:Connect(function(input,gpe)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.V then
		if not qcToggle() then return end
		
		local tool = char:FindFirstChild("Quantum Cloner") or player.Backpack:FindFirstChild("Quantum Cloner")
		if not tool then return end

		if qcEquipped then
			hum:UnequipTools()
			qcEquipped = false
		else
			tool.Parent = char
			qcEquipped = true
		end
	end
end)

-- CTRL TOGGLE UI
local visible = true

UIS.InputBegan:Connect(function(i,g)
	if g then return end
	if i.KeyCode == Enum.KeyCode.LeftControl then
		visible = not visible
		frame.Visible = visible
	end
end)



local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ===== LOADING SCREEN =====
local loadGui = Instance.new("ScreenGui")
loadGui.Parent = player:WaitForChild("PlayerGui")

local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1, 0, 1, 0)
loadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadFrame.Parent = loadGui

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(1, 0, 1, 0)
loadText.BackgroundTransparency = 1
loadText.Text = "LOADING..."
loadText.TextColor3 = Color3.fromRGB(255, 120, 0)
loadText.Font = Enum.Font.GothamBold
loadText.TextSize = 40
loadText.Parent = loadFrame

-- 🔥 flash black ↔ orange effect
task.spawn(function()
	for i = 1, 6 do
		TweenService:Create(loadFrame, TweenInfo.new(0.25), {
			BackgroundColor3 = Color3.fromRGB(255, 120, 0)
		}):Play()

		task.wait(0.25)

		TweenService:Create(loadFrame, TweenInfo.new(0.25), {
			BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		}):Play()

		task.wait(0.25)
	end

	-- fade out loading screen
	TweenService:Create(loadFrame, TweenInfo.new(0.6), {
		BackgroundTransparency = 1
	}):Play()

	TweenService:Create(loadText, TweenInfo.new(0.6), {
		TextTransparency = 1
	}):Play()

	task.wait(0.7)
	loadGui:Destroy()
end)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "AutoFarmGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 110)
frame.Position = UDim2.new(0.5, -110, 0.5, -55)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Active = true
frame.Draggable = true
frame.BackgroundTransparency = 1
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- 🔥 glow border
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 120, 0)
stroke.Thickness = 2
stroke.Transparency = 0.3
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Auto Pick up (buggy)"
title.TextColor3 = Color3.fromRGB(255, 140, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextTransparency = 1
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.Position = UDim2.new(0, 0, 0.35, 0)
status.BackgroundTransparency = 1
status.Text = "Status: OFF"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.TextTransparency = 1
status.Parent = frame

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 35)
toggle.Position = UDim2.new(0.1, 0, 0.65, 0)
toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggle.Text = "Toggle Auto pick up"
toggle.TextColor3 = Color3.fromRGB(255, 140, 0)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
toggle.BackgroundTransparency = 1
toggle.Parent = frame

local tcorner = Instance.new("UICorner")
tcorner.CornerRadius = UDim.new(0, 8)
tcorner.Parent = toggle

-- ===== FADE IN GUI =====
task.wait(1)

TweenService:Create(frame, TweenInfo.new(0.6), {BackgroundTransparency = 0.2}):Play()
TweenService:Create(title, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
TweenService:Create(status, TweenInfo.new(0.6), {TextTransparency = 0}):Play()
TweenService:Create(toggle, TweenInfo.new(0.6), {BackgroundTransparency = 0.2}):Play()

-- 🔥 glow pulse
task.spawn(function()
	while true do
		TweenService:Create(stroke, TweenInfo.new(1), {Transparency = 0.05}):Play()
		task.wait(1)
		TweenService:Create(stroke, TweenInfo.new(1), {Transparency = 0.4}):Play()
		task.wait(1)
	end
end)

-- ===== LOGIC =====
local enabled = false

toggle.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		status.Text = "Status: ON"
		toggle.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
	else
		status.Text = "Status: OFF"
		toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	end
end)

-- ===== AUTO Pick up =====
ProximityPromptService.PromptShown:Connect(function(prompt)
	if not enabled then return end
	if not prompt.Enabled then return end

	task.wait(0.1)
	fireproximityprompt(prompt)
end)


------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

------------------------------------------------
-- SPEED SETTINGS
------------------------------------------------
local speedEnabled = false
local SPEED = 29
local speedConn

------------------------------------------------
-- GUI
------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "SpeedHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 180, 0, 80)
main.Position = UDim2.new(0.5, -90, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BackgroundTransparency = 0.35
main.Active = true
main.Draggable = true
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 120, 0)
stroke.Transparency = 0.2
stroke.Parent = main

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "Speed Boost - B"
text.TextColor3 = Color3.fromRGB(255, 140, 0)
text.Font = Enum.Font.GothamBold
text.TextSize = 14
text.Parent = main

------------------------------------------------
-- FLASH ANIMATION
------------------------------------------------
local flashing = false

local function flashEffect()
	while flashing do
		TweenService:Create(stroke, TweenInfo.new(0.2), {
			Color = Color3.fromRGB(0, 0, 0)
		}):Play()

		task.wait(0.2)

		TweenService:Create(stroke, TweenInfo.new(0.2), {
			Color = Color3.fromRGB(255, 120, 0)
		}):Play()

		task.wait(0.2)
	end
end

------------------------------------------------
-- APPLY SPEED
------------------------------------------------
local function applySpeed(char)
	if not char then return end
	local hum = char:FindFirstChild("Humanoid")
	if not hum then return end

	hum.WalkSpeed = speedEnabled and SPEED or 16
end

------------------------------------------------
-- TOGGLE FUNCTION
------------------------------------------------
local function toggleSpeed()
	speedEnabled = not speedEnabled

	-- stop old loop
	if speedConn then
		speedConn:Disconnect()
		speedConn = nil
	end

	local char = player.Character
	applySpeed(char)

	if speedEnabled then
		speedConn = RunService.RenderStepped:Connect(function()
			local c = player.Character
			if c and c:FindFirstChild("Humanoid") then
				c.Humanoid.WalkSpeed = SPEED
			end
		end)

		flashing = true
		task.spawn(flashEffect)
	else
		flashing = false
	end
end

------------------------------------------------
-- B KEYBIND
------------------------------------------------
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.B then
		toggleSpeed()
	end
end)

------------------------------------------------
-- RESPAWN SUPPORT
------------------------------------------------
player.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	if speedEnabled then
		applySpeed(char)

		if speedConn then
			speedConn:Disconnect()
		end

		speedConn = RunService.RenderStepped:Connect(function()
			if char and char:FindFirstChild("Humanoid") then
				char.Humanoid.WalkSpeed = SPEED
			end
		end)
	end
end)


if game:IsLoaded() then
	print("Bomb Hub Semi TP Loaded! Enjoy🔥")
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "NeonPotionUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 150)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.25
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 120, 0)
stroke.Transparency = 0.3
stroke.Parent = frame

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 90, 0)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 30)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
grad.Rotation = 0
grad.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = "Potion - F"
title.TextColor3 = Color3.fromRGB(255, 140, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

-- BUTTON
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0.8, 0, 0, 45)
toggle.Position = UDim2.new(0.1, 0, 0.5, 0)
toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toggle.Text = "OFF"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 18
toggle.AutoButtonColor = false
toggle.Parent = frame

Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 1.5
toggleStroke.Color = Color3.fromRGB(255, 120, 0)
toggleStroke.Transparency = 0.5
toggleStroke.Parent = toggle

-- SMOOTH DRAG
local dragging, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- OPEN ANIMATION
frame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Size = UDim2.new(0, 240, 0, 150)
}):Play()

-- GLOW PULSE
task.spawn(function()
	while true do
		TweenService:Create(stroke, TweenInfo.new(1), {Transparency = 0.1}):Play()
		task.wait(1)
		TweenService:Create(stroke, TweenInfo.new(1), {Transparency = 0.6}):Play()
		task.wait(1)
	end
end)

-- GRADIENT SPIN
task.spawn(function()
	while true do
		grad.Rotation += 2
		task.wait(0.03)
	end
end)

-- POTION FUNCTION
local enabled = false

local function usePotion()
	local char = player.Character or player.CharacterAdded:Wait()
	local backpack = player:WaitForChild("Backpack")

	local tool = backpack:FindFirstChild("Giant Potion") or char:FindFirstChild("Giant Potion")
	if tool then
		char.Humanoid:EquipTool(tool)
		task.wait(0.1)
		tool:Activate()
	end
end

-- UPDATE UI
local function updateToggleUI()
	if enabled then
		toggle.Text = "ON"
		TweenService:Create(toggle, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(0, 170, 70)
		}):Play()
	else
		toggle.Text = "OFF"
		TweenService:Create(toggle, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		}):Play()
	end
end

-- TOGGLE SYSTEM
local function setToggle()
	enabled = not enabled
	updateToggleUI()

	if enabled then
		usePotion()
	end
end

toggle.MouseButton1Click:Connect(setToggle)

-- KEYBIND (F)
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if UIS:GetFocusedTextBox() then return end
	if UIS.ModalEnabled then return end

	if input.KeyCode == Enum.KeyCode.F then
		setToggle()
	end
end)


	print("BOMB HUB LOADED")

	local hub = Instance.new("ScreenGui")
	hub.Name = "MainHub"
	hub.ResetOnSpawn = false
	hub.Parent = playerGui

	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 260, 0, 120)
	main.Position = UDim2.new(0.5,0,0.5,0)
	main.AnchorPoint = Vector2.new(0.5,0.5)
	main.BackgroundColor3 = Color3.fromRGB(25,25,25)
	main.Parent = hub

	Instance.new("UICorner", main)

	local text = Instance.new("TextLabel")
	text.Size = UDim2.new(1,0,1,0)
	text.BackgroundTransparency = 1
	text.Text = "BOMB HUB LOADED"
	text.TextColor3 = Color3.fromRGB(255,120,0)
	text.Font = Enum.Font.GothamBold
	text.TextSize = 18
	text.Parent = main

	-- auto remove "loading box"
	task.delay(2, function()
		if hub then hub:Destroy() end
	end)
end

--========================
-- KEY CHECK
--========================
submit.MouseButton1Click:Connect(function()

	if box.Text == VALID_KEY then

		submit.Text = "ACCESS GRANTED"
		submit.TextColor3 = Color3.fromRGB(0,255,120)

		task.wait(0.8)

		gui:Destroy()
		loadMainScript()

	else
		submit.Text = "WRONG KEY"
		submit.TextColor3 = Color3.fromRGB(255,0,0)

		task.wait(0.8)

		submit.Text = "UNLOCK"
		submit.TextColor3 = Color3.fromRGB(255,140,0)
	end
end)