local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Khung nền đen bo tròn (Đặt ở góc trên bên phải)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 270, 0, 36)
-- Canh vị trí góc trên bên phải (cách lề phải 15px, cách lề trên 15px)
mainFrame.Position = UDim2.new(1, -285, 0, 15)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = mainFrame

-- UIListLayout sắp xếp các thành phần nằm ngang
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Parent = mainFrame
uiListLayout.FillDirection = Enum.FillDirection.Horizontal
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 8)

-- Hàm tạo TextLabel gọn gàng
local function createTextLabel(name, order)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.Size = UDim2.new(0, 80, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.LayoutOrder = order
    label.Parent = mainFrame
    return label
end

-- 1. FPS Label (Xanh lá)
local fpsLabel = createTextLabel("FPSLabel", 1)
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)

-- 2. Playtime Label (Thời gian treo trong server - Trắng)
local playtimeLabel = createTextLabel("PlaytimeLabel", 2)

-- 3. Name Label (Che 3 kí tự đầu - Xanh lá)
local nameLabel = createTextLabel("NameLabel", 3)
nameLabel.TextColor3 = Color3.fromRGB(0, 255, 100)

local displayName = player.Name
if #displayName > 3 then
    nameLabel.Text = "***" .. string.sub(displayName, 4)
else
    nameLabel.Text = "***"
end

-- Biến tính toán FPS và Thời gian treo server
local lastTime = tick()
local frameCount = 0

local totalSeconds = 0
local lastTick = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    -- Cập nhật FPS mỗi giây
    if currentTime - lastTime >= 1 then
        fpsLabel.Text = math.floor(frameCount / (currentTime - lastTime)) .. " FPS"
        frameCount = 0
        lastTime = currentTime
    end
    
    -- Cập nhật thời gian treo trong server (đếm lên)
    if currentTime - lastTick >= 1 then
        totalSeconds = totalSeconds + 1
        lastTick = currentTime
        
        local hours = math.floor(totalSeconds / 3600)
        local minutes = math.floor((totalSeconds % 3600) / 60)
        local seconds = totalSeconds % 60
        
        playtimeLabel.Text = string.format("%02dh:%02dm:%02ds", hours, minutes, seconds)
    end
end)
