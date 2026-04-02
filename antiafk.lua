--loadstring(game:HttpGet("https://raw.githubusercontent.com/haryas09155-spec/anti-afk/main/antiafk.lua))()
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local VirtualUser = game:GetService("VirtualUser")

-- Variables
local Player = Players.LocalPlayer
local StartTime = tick()

-- Create GUI
local AntiAFKGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local StatusDot = Instance.new("Frame")
local DotCorner = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local Divider1 = Instance.new("Frame")
local Divider2 = Instance.new("Frame")
local Footer = Instance.new("TextLabel")

-- GUI Properties (Smaller Scale)
AntiAFKGui.Name = "Haryas script"
AntiAFKGui.Parent = CoreGui
AntiAFKGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = AntiAFKGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 140) -- Reduced from 350x180
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(35, 35, 35)
UIStroke.Thickness = 1
UIStroke.Parent = MainFrame

StatusDot.Name = "StatusDot"
StatusDot.Parent = MainFrame
StatusDot.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
StatusDot.Position = UDim2.new(0, 12, 0, 15)
StatusDot.Size = UDim2.new(0, 7, 0, 7)

DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = StatusDot

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 28, 0, 8)
Title.Size = UDim2.new(0, 200, 0, 20)
Title.Font = Enum.Font.GothamMedium
Title.Text = "Anti-AFK · by hassanxzayn"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -25, 0, 8)
CloseButton.Size = UDim2.new(0, 15, 0, 15)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(120, 120, 120)
CloseButton.TextSize = 16

Divider1.Name = "Divider"
Divider1.Parent = MainFrame
Divider1.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Divider1.BorderSizePixel = 0
Divider1.Position = UDim2.new(0, 12, 0, 35)
Divider1.Size = UDim2.new(1, -24, 0, 1)

-- Metrics Setup
local function CreateStat(name, xPos)
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Parent = MainFrame
    titleLbl.BackgroundTransparency = 1
    titleLbl.Position = UDim2.new(0, xPos, 0, 48)
    titleLbl.Size = UDim2.new(0, 50, 0, 15)
    titleLbl.Font = Enum.Font.Gotham
    titleLbl.Text = name:upper()
    titleLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
    titleLbl.TextSize = 11
    
    local valLbl = Instance.new("TextLabel")
    valLbl.Parent = MainFrame
    valLbl.BackgroundTransparency = 1
    valLbl.Position = UDim2.new(0, xPos, 0, 68)
    valLbl.Size = UDim2.new(0, 50, 0, 20)
    valLbl.Font = Enum.Font.GothamBold
    valLbl.Text = "0"
    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    valLbl.TextSize = 18
    valLbl.TextXAlignment = Enum.TextXAlignment.Left
    return valLbl
end

local PingValue = CreateStat("Ping", 12)
local FPSValue = CreateStat("FPS", 115)
local TimeValue = CreateStat("Time", 205)

Divider2.Name = "Divider"
Divider2.Parent = MainFrame
Divider2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Divider2.BorderSizePixel = 0
Divider2.Position = UDim2.new(0, 12, 0, 105)
Divider2.Size = UDim2.new(1, -24, 0, 1)

Footer.Name = "Footer"
Footer.Parent = MainFrame
Footer.BackgroundTransparency = 1
Footer.Position = UDim2.new(0, 12, 0, 115)
Footer.Size = UDim2.new(0, 200, 0, 15)
Footer.Font = Enum.Font.Gotham
Footer.Text = "Haryas script"
Footer.TextColor3 = Color3.fromRGB(180, 180, 180)
Footer.TextSize = 13
Footer.TextXAlignment = Enum.TextXAlignment.Left

-- Functionality
CloseButton.MouseButton1Click:Connect(function()
    AntiAFKGui:Destroy()
end)

Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local FrameCount = 0
local LastUpdate = tick()

RunService.RenderStepped:Connect(function()
    FrameCount = FrameCount + 1
    local now = tick()
    
    if now - LastUpdate >= 1 then
        FPSValue.Text = tostring(FrameCount)
        FrameCount = 0
        LastUpdate = now
    end
    
    local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    PingValue.Text = tostring(ping)
    
    local duration = math.floor(now - StartTime)
    local hours = math.floor(duration / 3600)
    local mins = math.floor((duration % 3600) / 60)
    local secs = duration % 60
    TimeValue.Text = string.format("%d:%d:%d", hours, mins, secs)
end)
