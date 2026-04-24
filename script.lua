local Http = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- FIX TRÙNG UI
pcall(function()
	local old = game.CoreGui:FindFirstChild("TTAM_GUI")
	if old then old:Destroy() end
end)

-- FILE THEO ACC
local file = "ttam_" .. player.UserId .. ".json"

-- LOAD
local data = { Don = "Chưa nhập" }
if isfile and isfile(file) then
	local ok, decoded = pcall(function()
		return Http:JSONDecode(readfile(file))
	end)
	if ok then data = decoded end
end

-- SAVE
local function save()
	if writefile then
		writefile(file, Http:JSONEncode(data))
	end
end

-- ẨN TÊN
local function hideName(name)
	if not name then return "" end
	if #name > 6 then
		return string.sub(name,1,6).."***"
	else
		return string.sub(name,1,3).."***"
	end
end

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TTAM_GUI"

-- FRAME
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,135)
frame.Position = UDim2.new(0.5,-130,0.18,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 2

-- TITLE
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,24)
title.Text = "TTam Tab"
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- INFO
local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,-14,0,70)
info.Position = UDim2.new(0,7,0,24)
info.BackgroundTransparency = 1
info.Font = Enum.Font.GothamBold
info.TextSize = 16
info.RichText = true
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top

-- INPUT
local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.55,0,0,22)
box.Position = UDim2.new(0.05,0,1,-26)
box.PlaceholderText = "Nhập tên đơn..."
box.BackgroundColor3 = Color3.fromRGB(40,40,40)
box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box)

-- BUTTON
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.35,0,0,22)
btn.Position = UDim2.new(0.6,0,1,-26)
btn.Text = "Save"
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn)

btn.MouseButton1Click:Connect(function()
	if box.Text ~= "" then
		data.Don = box.Text
		save()
	end
end)

-- TAB
local toggle = Instance.new("TextButton", gui)
toggle.Size = UDim2.new(0,55,0,26)
toggle.Position = UDim2.new(0,10,0,10)
toggle.Text = "Tab"
toggle.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", toggle)

-- MINI FPS/PING
local mini = Instance.new("TextLabel", gui)
mini.Size = UDim2.new(0,150,0,26)
mini.Position = UDim2.new(0,70,0,10)
mini.BackgroundTransparency = 1
mini.Font = Enum.Font.GothamBold
mini.TextSize = 16
mini.TextXAlignment = Enum.TextXAlignment.Left
mini.Visible = false

toggle.MouseButton1Click:Connect(function()
	frame.Visible = not frame.Visible
	mini.Visible = not frame.Visible
end)

-- FPS
local last = tick()
local fps = 60
local frames = 0

-- 🌈 7 MÀU CHO TAB
local colors = {
	Color3.fromRGB(255,0,0),
	Color3.fromRGB(255,127,0),
	Color3.fromRGB(255,255,0),
	Color3.fromRGB(0,255,0),
	Color3.fromRGB(0,255,255),
	Color3.fromRGB(0,0,255),
	Color3.fromRGB(139,0,255)
}

local index = 1
local lastSwitch = tick()

RunService.RenderStepped:Connect(function()
	-- FPS
	frames += 1
	if tick()-last>=1 then
		fps = frames
		frames = 0
		last = tick()
	end

	-- PING
	local ping = 0
	pcall(function()
		ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
	end)

	-- 🌈 TAB đổi màu
	if tick() - lastSwitch > 0.25 then
		index += 1
		if index > #colors then index = 1 end
		lastSwitch = tick()
	end

	local tabColor = colors[index]

	stroke.Color = tabColor
	title.TextColor3 = tabColor
	toggle.BackgroundColor3 = tabColor

	-- 🎯 MINI đổi theo tình trạng
	local miniColor = Color3.new(1,1,1)

	if ping > 150 then
		miniColor = Color3.fromRGB(255,0,0)
	elseif fps < 40 then
		miniColor = Color3.fromRGB(255,200,0)
	end

	-- TEXT
	info.Text =
		'<font color="#00FFFF">👤 '..hideName(player.Name)..'</font>'..
		'\n<font color="#FF5555">⚔️ '..data.Don..'</font>'..
		'\n<font color="#FFFF00">FPS: '..fps..'</font>'..
		' <font color="#00FF00">| Ping: '..ping..'ms</font>'..
		'\n\n<font size="17" color="#FFFFFF">Player: '..#Players:GetPlayers()..'/'..Players.MaxPlayers..'</font>'

	mini.Text = "FPS: "..fps.." | "..ping.."ms"
	mini.TextColor3 = miniColor
end)
