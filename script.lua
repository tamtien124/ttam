--// =========================
--// 🔥 THBao ULTIMATE INTRO
--// =========================

local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local intro = Instance.new("ScreenGui", game.CoreGui)
intro.Name = "TTAM_ULTIMATE"

local bg = Instance.new("Frame", intro)
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(10,10,10)
bg.BackgroundTransparency = 1

local logo = Instance.new("TextLabel", bg)
logo.Size = UDim2.new(0,120,0,120)
logo.Position = UDim2.new(0.5,-60,0.38,-60)
logo.BackgroundTransparency = 1
logo.Text = "💎"
logo.TextScaled = true
logo.TextTransparency = 1

local title = Instance.new("TextLabel", bg)
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0.52,0)
title.BackgroundTransparency = 1
title.Text = "THBao"
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(255,0,255)
title.TextTransparency = 1

local sub = Instance.new("TextLabel", bg)
sub.Size = UDim2.new(1,0,0,30)
sub.Position = UDim2.new(0,0,0.58,0)
sub.BackgroundTransparency = 1
sub.Text = "Loading..."
sub.Font = Enum.Font.Gotham
sub.TextSize = 14
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.TextTransparency = 1

local barBG = Instance.new("Frame", bg)
barBG.Size = UDim2.new(0,220,0,6)
barBG.Position = UDim2.new(0.5,-110,0.65,0)
barBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBG.BackgroundTransparency = 1
Instance.new("UICorner", barBG)

local bar = Instance.new("Frame", barBG)
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,0,255)
Instance.new("UICorner", bar)

-- SOUND
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://9118828563"
sound.Volume = 0.5
sound.Parent = SoundService
sound:Play()

-- FADE IN
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(logo, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(sub, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
TweenService:Create(barBG, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 18}):Play()

task.wait(0.5)
TweenService:Create(bar, TweenInfo.new(1.5), {
    Size = UDim2.new(1,0,1,0)
}):Play()

task.wait(2)

-- FADE OUT + SOUND
TweenService:Create(sound, TweenInfo.new(0.8), {Volume = 0}):Play()
TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(logo, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(title, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(sub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
TweenService:Create(barBG, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()

task.wait(0.8)
sound:Destroy()
blur:Destroy()
intro:Destroy()

--// =========================
--// 🔔 NOTIFICATION (ĐÃ ĐỔI)
--// =========================

pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "THBao",
        Text = "Cảm ơn bạn đã sử dụng tab đơn BUY THBao!\nChúc bạn trải nghiệm tốt ✨",
        Duration = 5,
        Icon = "rbxassetid://6031280882"
    })
end)

--// =========================
--// UI
--// =========================

for _, v in pairs(game.CoreGui:GetChildren()) do
    if v.Name == "TTAM_V17" then v:Destroy() end
end

local Http = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function maskName(str)
    if #str > 10 then return str:sub(1, 10) .. "***" end
    return str:sub(1, 5) .. "***"
end
local displayName = maskName(player.Name)

local data = { Don = "Chưa nhập đơn", Status = "ĐANG XỬ LÝ" }

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TTAM_V17"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 175, 0, 80)
main.Position = UDim2.new(0.5, -87, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 105, 180)

RunService.RenderStepped:Connect(function()
    stroke.Transparency = 0.3 + math.sin(tick()*2)*0.2
end)

local settingsBtn = Instance.new("TextButton", main)
settingsBtn.Size = UDim2.new(0, 22, 0, 22)
settingsBtn.Position = UDim2.new(1, -26, 0, 4)
settingsBtn.Text = "⚡"
settingsBtn.BackgroundTransparency = 1
settingsBtn.TextColor3 = Color3.new(1, 1, 1)
settingsBtn.TextSize = 16

local infoContent = Instance.new("TextLabel", main)
infoContent.Size = UDim2.new(1, -12, 1, -10)
infoContent.Position = UDim2.new(0, 10, 0, 5)
infoContent.BackgroundTransparency = 1
infoContent.Font = Enum.Font.GothamBold
infoContent.TextColor3 = Color3.new(1, 1, 1)
infoContent.TextSize = 15
infoContent.RichText = true

local setFrame = Instance.new("Frame", main)
setFrame.Size = UDim2.new(1, 0, 1, 0)
setFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
setFrame.Visible = false
Instance.new("UICorner", setFrame)

settingsBtn.MouseButton1Click:Connect(function()
    setFrame.Visible = not setFrame.Visible
end)

local fps = 60
RunService.RenderStepped:Connect(function(dt)
    fps = math.floor(1/dt)
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())

    infoContent.Text =
        '<font color="#FF00FF" size="16">'..displayName..'</font>\n'..
        '<font color="#AAAAAA">Đơn:</font> <font color="#00FF00">'..data.Don..'</font>\n'..
        '<font color="#00FFFF">FPS: '..fps..'</font> | <font color="#FF5555">Ping: '..ping..'ms</font>\n'..
        '<font color="#FFD700">'..data.Status..'</font>'
end)
