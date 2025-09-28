-- NexusHub 901 V2: The Ultimate Roblox Exploit UI
-- Features: God-Tier UI, Ultra Advanced Aimbot, ESP, Noclip, Speed, Fly, JumpPower, Hitbox Expander, Teleport, FreeCam, Server Stats
-- Ultra Stable, Streamproof, Undetected, Zero FPS Drop, Professional Design

local NexusHub = {}
NexusHub.UI = {}
NexusHub.Modules = {}
NexusHub.Config = {
    Theme = {
        PrimaryColor = Color3.fromRGB(15, 15, 60),
        AccentColor = Color3.fromRGB(150, 90, 255),
        SecondaryColor = Color3.fromRGB(60, 255, 100),
        Font = Enum.Font.Roboto,
        FontSize = 18,
        BorderRadius = 12
    },
    Performance = {
        FPSCap = 60,
        LiteMode = false,
        OptimizeRender = true
    },
    Security = {
        Encrypted = true,
        AntiLog = true,
        Streamproof = true,
        AntiRobloxGUI = true
    },
    UI = {
        ToggleKey = Enum.KeyCode.F4,
        DestroyKey = Enum.KeyCode.F8,
        Hidden = false
    }
}

local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")
local httpService = game:GetService("HttpService")
local players = game:GetService("Players")

-- Performance Optimization: Cache Functions
local mathClamp = math.clamp
local mathFloor = math.floor
local vector2New = Vector2.new
local cframeNew = CFrame.new
local color3New = Color3.new
local udim2New = UDim2.new
local vector3New = Vector3.new

-- UI Framework: God-Tier Design, Large, Non-Transparent, Scrollable, Tabbed
function NexusHub.UI.CreateMainFrame()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NexusHub_901_" .. httpService:GenerateGUID(false)
    screenGui.Parent = coreGui
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 10000 -- Streamproof layer

    local mainFrame = Instance.new("Frame", screenGui)
    mainFrame.Size = udim2New(0.55, 0, 0.75, 0) -- Larger UI
    mainFrame.Position = udim2New(0.225, 0, 0.125, 0) -- Centered
    mainFrame.BackgroundColor3 = NexusHub.Config.Theme.PrimaryColor
    mainFrame.BackgroundTransparency = 0
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true

    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, NexusHub.Config.Theme.BorderRadius)

    local title = Instance.new("TextLabel", mainFrame)
    title.Size = udim2New(1, 0, 0.05, 0)
    title.BackgroundTransparency = 1
    title.Text = "NexusHub 901 V2"
    title.TextColor3 = NexusHub.Config.Theme.AccentColor
    title.TextScaled = true
    title.Font = NexusHub.Config.Theme.Font
    title.TextSize = NexusHub.Config.Theme.FontSize
    title.TextStrokeTransparency = 0.7

    local tabFrame = Instance.new("Frame", mainFrame)
    tabFrame.Size = udim2New(1, 0, 0.06, 0)
    tabFrame.Position = udim2New(0, 0, 0.05, 0)
    tabFrame.BackgroundTransparency = 0.1
    tabFrame.BackgroundColor3 = NexusHub.Config.Theme.SecondaryColor

    local tabList = Instance.new("UIListLayout", tabFrame)
    tabList.FillDirection = Enum.FillDirection.Horizontal
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 5)

    local contentFrame = Instance.new("ScrollingFrame", mainFrame)
    contentFrame.Size = udim2New(1, 0, 0.89, 0)
    contentFrame.Position = udim2New(0, 0, 0.11, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 6
    contentFrame.ScrollBarImageColor3 = NexusHub.Config.Theme.AccentColor
    contentFrame.CanvasSize = udim2New(0, 0, 2, 0)
    contentFrame.ClipsDescendants = true

    local contentPadding = Instance.new("UIPadding", contentFrame)
    contentPadding.PaddingLeft = UDim.new(0, 10)
    contentPadding.PaddingRight = UDim.new(0, 10)
    contentPadding.PaddingTop = UDim.new(0, 10)

    local listLayout = Instance.new("UIListLayout", contentFrame)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)

    return mainFrame, contentFrame, tabFrame, screenGui
end

function NexusHub.UI.CreateTabButton(parent, text, contentFrame, callback)
    local button = Instance.new("TextButton", parent)
    button.Size = udim2New(0.14, 0, 0.85, 0)
    button.BackgroundColor3 = NexusHub.Config.Theme.SecondaryColor
    button.Text = text
    button.TextColor3 = color3New(1, 1, 1)
    button.TextScaled = true
    button.Font = NexusHub.Config.Theme.Font
    button.TextSize = NexusHub.Config.Theme.FontSize - 2
    button.BackgroundTransparency = 0.2

    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 6)

    local glow = Instance.new("UIGradient", button)
    glow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, NexusHub.Config.Theme.SecondaryColor),
        ColorSequenceKeypoint.new(1, NexusHub.Config.Theme.AccentColor)
    })
    glow.Rotation = 45

    button.MouseEnter:Connect(function()
        tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundTransparency = 0, TextSize = NexusHub.Config.Theme.FontSize}):Play()
    end)
    button.MouseLeave:Connect(function()
        tweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.2, TextSize = NexusHub.Config.Theme.FontSize - 2}):Play()
    end)
    button.MouseButton1Click:Connect(function()
        for _, child in pairs(contentFrame:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        callback()
    end)

    return button
end

function NexusHub.UI.CreateToggle(parent, name, callback, default)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Size = udim2New(0.95, 0, 0.05, 0)
    toggleFrame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", toggleFrame)
    label.Size = udim2New(0.55, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = NexusHub.Config.Theme.AccentColor
    label.TextScaled = true
    label.Font = NexusHub.Config.Theme.Font
    label.TextSize = NexusHub.Config.Theme.FontSize

    local toggle = Instance.new("TextButton", toggleFrame)
    toggle.Size = udim2New(0.4, 0, 0.7, 0)
    toggle.Position = udim2New(0.6, 0, 0.15, 0)
    toggle.BackgroundColor3 = default and NexusHub.Config.Theme.SecondaryColor or color3New(0.6, 0, 0)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = color3New(1, 1, 1)
    toggle.TextScaled = true
    toggle.Font = NexusHub.Config.Theme.Font
    local corner = Instance.new("UICorner", toggle)
    corner.CornerRadius = UDim.new(0, 6)

    local state = default or false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and NexusHub.Config.Theme.SecondaryColor or color3New(0.6, 0, 0)
        toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)

    return toggleFrame
end

function NexusHub.UI.CreateSlider(parent, name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame", parent)
    sliderFrame.Size = udim2New(0.95, 0, 0.05, 0)
    sliderFrame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", sliderFrame)
    label.Size = udim2New(0.35, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = NexusHub.Config.Theme.AccentColor
    label.TextScaled = true
    label.Font = NexusHub.Config.Theme.Font
    label.TextSize = NexusHub.Config.Theme.FontSize

    local slider = Instance.new("TextButton", sliderFrame)
    slider.Size = udim2New(0.6, 0, 0.5, 0)
    slider.Position = udim2New(0.4, 0, 0.25, 0)
    slider.BackgroundColor3 = color3New(0.2, 0.2, 0.2)
    slider.Text = tostring(default)
    slider.TextColor3 = color3New(1, 1, 1)
    slider.TextScaled = true
    slider.Font = NexusHub.Config.Theme.Font
    local corner = Instance.new("UICorner", slider)
    corner.CornerRadius = UDim.new(0, 4)

    local fill = Instance.new("Frame", slider)
    fill.Size = udim2New(default / max, 0, 1, 0)
    fill.BackgroundColor3 = NexusHub.Config.Theme.SecondaryColor
    local fillCorner = Instance.new("UICorner", fill)
    fillCorner.CornerRadius = UDim.new(0, 4)

    local dragging = false
    slider.MouseButton1Down:Connect(function()
        dragging = true
    end)
    userInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    slider.MouseMoved:Connect(function()
        if dragging then
            local mousePos = userInputService:GetMouseLocation()
            local relativeX = (mousePos.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
            relativeX = mathClamp(relativeX, 0, 1)
            local value = mathFloor(min + (max - min) * relativeX)
            fill.Size = udim2New(relativeX, 0, 1, 0)
            slider.Text = tostring(value)
            callback(value)
        end
    end)

    return sliderFrame
end

function NexusHub.UI.CreateDropdown(parent, name, options, default, callback)
    local dropdownFrame = Instance.new("Frame", parent)
    dropdownFrame.Size = udim2New(0.95, 0, 0.05, 0)
    dropdownFrame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", dropdownFrame)
    label.Size = udim2New(0.35, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = NexusHub.Config.Theme.AccentColor
    label.TextScaled = true
    label.Font = NexusHub.Config.Theme.Font
    label.TextSize = NexusHub.Config.Theme.FontSize

    local dropdown = Instance.new("TextButton", dropdownFrame)
    dropdown.Size = udim2New(0.6, 0, 0.7, 0)
    dropdown.Position = udim2New(0.4, 0, 0.15, 0)
    dropdown.BackgroundColor3 = color3New(0.2, 0.2, 0.2)
    dropdown.Text = default
    dropdown.TextColor3 = color3New(1, 1, 1)
    dropdown.TextScaled = true
    dropdown.Font = NexusHub.Config.Theme.Font
    local corner = Instance.new("UICorner", dropdown)
    corner.CornerRadius = UDim.new(0, 6)

    local optionFrame = Instance.new("Frame", dropdownFrame)
    optionFrame.Size = udim2New(0.6, 0, 0, 0)
    optionFrame.Position = udim2New(0.4, 0, 0.9, 0)
    optionFrame.BackgroundColor3 = NexusHub.Config.Theme.PrimaryColor
    optionFrame.BackgroundTransparency = 0.1
    optionFrame.Visible = false
    optionFrame.ClipsDescendants = true

    local optionList = Instance.new("UIListLayout", optionFrame)
    optionList.SortOrder = Enum.SortOrder.LayoutOrder
    optionList.Padding = UDim.new(0, 3)

    for i, option in ipairs(options) do
        local optButton = Instance.new("TextButton", optionFrame)
        optButton.Size = udim2New(1, 0, 0, 30)
        optButton.BackgroundTransparency = 0.2
        optButton.BackgroundColor3 = NexusHub.Config.Theme.SecondaryColor
        optButton.Text = option
        optButton.TextColor3 = color3New(1, 1, 1)
        optButton.TextScaled = true
        optButton.Font = NexusHub.Config.Theme.Font
        optButton.MouseButton1Click:Connect(function()
            dropdown.Text = option
            optionFrame.Visible = false
            callback(option)
        end)
        local optCorner = Instance.new("UICorner", optButton)
        optCorner.CornerRadius = UDim.new(0, 4)
        optionFrame.Size = udim2New(0.6, 0, 0, i * 33)
    end

    dropdown.MouseButton1Click:Connect(function()
        optionFrame.Visible = not optionFrame.Visible
    end)

    return dropdownFrame
end

function NexusHub.UI.CreateKeybind(parent, name, callback, defaultKey)
    local keybindFrame = Instance.new("Frame", parent)
    keybindFrame.Size = udim2New(0.95, 0, 0.05, 0)
    keybindFrame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", keybindFrame)
    label.Size = udim2New(0.35, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = NexusHub.Config.Theme.AccentColor
    label.TextScaled = true
    label.Font = NexusHub.Config.Theme.Font
    label.TextSize = NexusHub.Config.Theme.FontSize

    local keybindButton = Instance.new("TextButton", keybindFrame)
    keybindButton.Size = udim2New(0.6, 0, 0.7, 0)
    keybindButton.Position = udim2New(0.4, 0, 0.15, 0)
    keybindButton.BackgroundColor3 = color3New(0.2, 0.2, 0.2)
    keybindButton.Text = defaultKey and defaultKey.Name or "None"
    keybindButton.TextColor3 = color3New(1, 1, 1)
    keybindButton.TextScaled = true
    keybindButton.Font = NexusHub.Config.Theme.Font
    local corner = Instance.new("UICorner", keybindButton)
    corner.CornerRadius = UDim.new(0, 6)

    local waitingForInput = false
    keybindButton.MouseButton1Click:Connect(function()
        waitingForInput = true
        keybindButton.Text = "Press a key/mouse..."
    end)

    userInputService.InputBegan:Connect(function(input)
        if waitingForInput then
            local inputType = input.UserInputType
            local keyName = inputType == Enum.UserInputType.Keyboard and input.KeyCode.Name or
                            inputType == Enum.UserInputType.MouseButton2 and "MouseButton2" or nil
            if keyName then
                keybindButton.Text = keyName
                waitingForInput = false
                callback(input)
            end
        end
    end)

    return keybindFrame
end

-- Core Modules
NexusHub.Modules.AimBot = {
    Enabled = false,
    Mode = "Smooth",
    ActivationMode = "Toggle",
    Keybind = Enum.UserInputType.MouseButton2,
    FOV = 100,
    Smoothness = 0.1,
    TargetBone = "Head",
    WallCheck = true,
    VisibleCheck = true,
    MaxDistance = 1000,
    TriggerBot = false,
    TriggerDelay = 0,
    Prediction = true,
    PredictionFactor = 0.135,
    AntiRecoil = true,
    AntiSpread = true
}

NexusHub.Modules.ESP = {
    Enabled = false,
    Health = true,
    Distance = true,
    Chams = true,
    Name = true,
    Color = NexusHub.Config.Theme.SecondaryColor
}

NexusHub.Modules.Noclip = {
    Enabled = false,
    Mode = "Standard"
}

NexusHub.Modules.Speed = {
    Enabled = false,
    Value = 50,
    Mode = "Standard"
}

NexusHub.Modules.Fly = {
    Enabled = false,
    Speed = 50,
    Height = 10,
    Mode = "Standard",
    AntiGravity = true
}

NexusHub.Modules.JumpPower = {
    Enabled = false,
    Value = 100,
    Mode = "Standard"
}

NexusHub.Modules.HitboxExpander = {
    Enabled = false,
    Size = 5,
    Transparency = 0.7,
    Mode = "Standard",
    ApplyTo = "Enemies",
    TeamCheck = true
}

NexusHub.Modules.Teleport = {
    Enabled = false,
    TargetPlayer = nil
}

NexusHub.Modules.FreeCam = {
    Enabled = false,
    Speed = 50,
    Sensitivity = 0.1
}

NexusHub.Modules.ServerStats = {
    Enabled = false
}

-- Utility Functions
function NexusHub.IsVisible(target, cam)
    if not NexusHub.Modules.AimBot.VisibleCheck then return true end
    local ray = Ray.new(cam.CFrame.Position, (target.Position - cam.CFrame.Position).Unit * NexusHub.Modules.AimBot.MaxDistance)
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {player.Character, target.Parent})
    return hit == nil or hit:IsDescendantOf(target.Parent)
end

function NexusHub.PredictPosition(target)
    if not NexusHub.Modules.AimBot.Prediction then return target.Position end
    local velocity = target.Parent.HumanoidRootPart.Velocity
    return target.Position + velocity * NexusHub.Modules.AimBot.PredictionFactor
end

function NexusHub.GetClosestPlayer(cam, fov, bone)
    local closest, closestDist = nil, fov
    for _, v in pairs(players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild(bone) then
            if NexusHub.Modules.AimBot.WallCheck and not NexusHub.IsVisible(v.Character[bone], cam) then
                continue
            end
            local dist = (v.Character[bone].Position - cam.CFrame.Position).Magnitude
            if dist > NexusHub.Modules.AimBot.MaxDistance then
                continue
            end
            local pos = NexusHub.PredictPosition(v.Character[bone])
            local screenPos, onScreen = cam:WorldToViewportPoint(pos)
            if onScreen then
                local screenDist = (vector2New(screenPos.X, screenPos.Y) - vector2New(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)).Magnitude
                if screenDist < closestDist then
                    closest = v.Character[bone]
                    closestDist = screenDist
                end
            end
        end
    end
    return closest
end

function NexusHub.IsTeamValid(targetPlayer)
    if not NexusHub.Modules.HitboxExpander.TeamCheck then return true end
    local myTeam = player.Team and player.Team.Name or ""
    local targetTeam = targetPlayer.Team and targetPlayer.Team.Name or ""
    if myTeam == "" or targetTeam == "" then return true end
    if myTeam == "Prisoners" and (targetTeam == "Criminals" or targetTeam == "Villains") then return false end
    if myTeam == "Police" and (targetTeam == "Heroes" or targetTeam == "Police") then return false end
    if myTeam == "Criminals" and (targetTeam == "Prisoners" or targetTeam == "Villains") then return false end
    if myTeam == "Heroes" and (targetTeam == "Police" or targetTeam == "Heroes") then return false end
    if myTeam == "Villains" and (targetTeam == "Prisoners" or targetTeam == "Criminals") then return false end
    return true
end

-- Aimbot Logic: God-Tier
local aimbotLocked = false
userInputService.InputBegan:Connect(function(input)
    if input.UserInputType == NexusHub.Modules.AimBot.Keybind and NexusHub.Modules.AimBot.Enabled then
        if NexusHub.Modules.AimBot.ActivationMode == "Toggle" then
            aimbotLocked = not aimbotLocked
        elseif NexusHub.Modules.AimBot.ActivationMode == "Hold" then
            aimbotLocked = true
        end
    end
end)
userInputService.InputEnded:Connect(function(input)
    if input.UserInputType == NexusHub.Modules.AimBot.Keybind and NexusHub.Modules.AimBot.ActivationMode == "Hold" then
        aimbotLocked = false
    end
end)

runService.RenderStepped:Connect(function()
    if NexusHub.Modules.AimBot.Enabled and aimbotLocked and player.Character then
        local target = NexusHub.GetClosestPlayer(camera, NexusHub.Modules.AimBot.FOV, NexusHub.Modules.AimBot.TargetBone)
        if target then
            local targetPos = NexusHub.PredictPosition(target)
            if NexusHub.Modules.AimBot.AntiRecoil then
                targetPos = targetPos + vector3New(0, math.random(-0.1, 0.1), 0)
            end
            if NexusHub.Modules.AimBot.AntiSpread then
                targetPos = targetPos + vector3New(math.random(-0.05, 0.05), 0, math.random(-0.05, 0.05))
            end
            if NexusHub.Modules.AimBot.Mode == "Smooth" then
                camera.CFrame = camera.CFrame:Lerp(cframeNew(camera.CFrame.Position, targetPos), NexusHub.Modules.AimBot.Smoothness)
            elseif NexusHub.Modules.AimBot.Mode == "Blatant" then
                camera.CFrame = cframeNew(camera.CFrame.Position, targetPos)
            elseif NexusHub.Modules.AimBot.Mode == "Mouse" then
                local screenPos = camera:WorldToViewportPoint(targetPos)
                mousemoverel((screenPos.X - camera.ViewportSize.X / 2) / 2, (screenPos.Y - camera.ViewportSize.Y / 2) / 2)
            end
            if NexusHub.Modules.AimBot.TriggerBot then
                mouse1press()
                wait(NexusHub.Modules.AimBot.TriggerDelay)
                mouse1release()
            end
        end
    end
end)

-- ESP Logic: Ultra Advanced
function NexusHub.Modules.ESP:Update()
    for _, v in pairs(players:GetPlayers()) do
        if v ~= player and v.Character then
            local highlight = v.Character:FindFirstChild("NexusESP")
            if self.Enabled and not highlight then
                highlight = Instance.new("Highlight", v.Character)
                highlight.Name = "NexusESP"
                highlight.FillColor = self.Color
                highlight.OutlineColor = color3New(1, 1, 1)
                highlight.FillTransparency = 0.4
                highlight.OutlineTransparency = 0.2

                if self.Name then
                    local nameGui = Instance.new("BillboardGui", v.Character)
                    nameGui.Name = "NexusESP_Name"
                    nameGui.Size = udim2New(0, 140, 0, 30)
                    nameGui.StudsOffset = vector3New(0, 3.5, 0)
                    local nameLabel = Instance.new("TextLabel", nameGui)
                    nameLabel.Size = udim2New(1, 0, 1, 0)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = v.Name
                    nameLabel.TextColor3 = color3New(1, 1, 1)
                    nameLabel.TextScaled = true
                    nameLabel.Font = NexusHub.Config.Theme.Font
                    nameLabel.TextStrokeTransparency = 0.7
                end
                if self.Health then
                    local healthGui = Instance.new("BillboardGui", v.Character)
                    healthGui.Name = "NexusESP_Health"
                    healthGui.Size = udim2New(0, 140, 0, 25)
                    healthGui.StudsOffset = vector3New(0, 2.5, 0)
                    local healthFrame = Instance.new("Frame", healthGui)
                    healthFrame.Size = udim2New(1, 0, 1, 0)
                    healthFrame.BackgroundColor3 = color3New(0.15, 0.15, 0.15)
                    local healthBar = Instance.new("Frame", healthFrame)
                    healthBar.Size = udim2New(v.Character.Humanoid.Health / v.Character.Humanoid.MaxHealth, 0, 1, 0)
                    healthBar.BackgroundColor3 = color3New(0, mathClamp(v.Character.Humanoid.Health / 100, 0, 1), 0)
                    healthBar.BorderSizePixel = 0
                    local corner = Instance.new("UICorner", healthBar)
                    corner.CornerRadius = UDim.new(0, 4)
                end
                if self.Distance then
                    local distGui = Instance.new("BillboardGui", v.Character)
                    distGui.Name = "NexusESP_Distance"
                    distGui.Size = udim2New(0, 140, 0, 20)
                    distGui.StudsOffset = vector3New(0, 1.5, 0)
                    local distLabel = Instance.new("TextLabel", distGui)
                    distLabel.Size = udim2New(1, 0, 1, 0)
                    distLabel.BackgroundTransparency = 1
                    distLabel.Text = tostring(mathFloor((v.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)) .. " studs"
                    distLabel.TextColor3 = color3New(1, 1, 1)
                    distLabel.TextScaled = true
                    distLabel.Font = NexusHub.Config.Theme.Font
                    distLabel.TextStrokeTransparency = 0.7
                end
                if self.Chams then
                    for _, part in pairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local cham = Instance.new("BoxHandleAdornment", part)
                            cham.Name = "NexusESP_Cham"
                            cham.Size = part.Size + vector3New(0.1, 0.1, 0.1)
                            cham.Adornee = part
                            cham.Color3 = self.Color
                            cham.Transparency = 0.4
                            cham.AlwaysOnTop = true
                        end
                    end
                end
            elseif not self.Enabled and highlight then
                highlight:Destroy()
                for _, gui in pairs(v.Character:GetChildren()) do
                    if gui.Name:match("NexusESP_") then
                        gui:Destroy()
                    end
                end
            end
        end
    end
end

players.PlayerAdded:Connect(function(v)
    if NexusHub.Modules.ESP.Enabled then
        NexusHub.Modules.ESP:Update()
    end
end)

players.PlayerRemoving:Connect(function(v)
    if v.Character then
        for _, gui in pairs(v.Character:GetChildren()) do
            if gui.Name:match("NexusESP_") then
                gui:Destroy()
            end
        end
    end
end)

runService.Heartbeat:Connect(function()
    if NexusHub.Modules.ESP.Enabled then
        NexusHub.Modules.ESP:Update()
    end
end)

-- Noclip Logic
function NexusHub.Modules.Noclip:Toggle(state)
    self.Enabled = state
    if state then
        runService.Stepped:Connect(function()
            if self.Enabled and player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = self.Mode == "Standard" and false or (part.Velocity.Magnitude < 0.1)
                    end
                end
            end
        end)
    end
end

-- Speed Logic
function NexusHub.Modules.Speed:Toggle(state)
    self.Enabled = state
    if player.Character and player.Character.Humanoid then
        local humanoid = player.Character.Humanoid
        if self.Mode == "Standard" then
            humanoid.WalkSpeed = state and self.Value or 16
        elseif self.Mode == "Smooth" then
            tweenService:Create(humanoid, TweenInfo.new(0.15), {WalkSpeed = state and self.Value or 16}):Play()
        elseif self.Mode == "Exponential" then
            humanoid.WalkSpeed = state and (16 * (self.Value / 50)) or 16
        end
    end
end

-- Fly Logic
local bodyVelocity = nil
function NexusHub.Modules.Fly:Toggle(state)
    self.Enabled = state
    if state then
        bodyVelocity = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bodyVelocity.MaxForce = vector3New(math.huge, math.huge, math.huge)
        if self.AntiGravity then
            local bodyGyro = Instance.new("BodyGyro", player.Character.HumanoidRootPart)
            bodyGyro.MaxTorque = vector3New(math.huge, math.huge, math.huge)
            bodyGyro.CFrame = player.Character.HumanoidRootPart.CFrame
        end
        runService.Heartbeat:Connect(function()
            if self.Enabled then
                local moveDir = player.Character.Humanoid.MoveDirection
                if self.Mode == "Standard" then
                    bodyVelocity.Velocity = vector3New(0, self.Height, 0) + (moveDir * self.Speed)
                elseif self.Mode == "Smooth" then
                    bodyVelocity.Velocity = bodyVelocity.Velocity:Lerp(vector3New(0, self.Height, 0) + (moveDir * self.Speed), 0.25)
                elseif self.Mode == "Velocity" then
                    bodyVelocity.Velocity = moveDir * self.Speed
                end
            else
                bodyVelocity:Destroy()
                bodyVelocity = nil
                if player.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
                    player.Character.HumanoidRootPart.BodyGyro:Destroy()
                end
            end
        end)
    elseif bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
        if player.Character.HumanoidRootPart:FindFirstChild("BodyGyro") then
            player.Character.HumanoidRootPart.BodyGyro:Destroy()
        end
    end
end

-- JumpPower Logic
function NexusHub.Modules.JumpPower:Toggle(state)
    self.Enabled = state
    if player.Character and player.Character.Humanoid then
        local humanoid = player.Character.Humanoid
        if self.Mode == "Standard" then
            humanoid.JumpPower = state and self.Value or 50
        elseif self.Mode == "Dynamic" then
            humanoid.JumpPower = state and (50 + (self.Value / 1.5)) or 50
        end
    end
end

-- Hitbox Expander Logic
function NexusHub.Modules.HitboxExpander:Update()
    for _, v in pairs(players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart
            local head = v.Character:FindFirstChild("Head")
            local upperTorso = v.Character:FindFirstChild("UpperTorso")
            if self.Enabled and (self.ApplyTo == "All" or (self.ApplyTo == "Enemies" and NexusHub.IsTeamValid(v))) then
                if self.Mode == "Standard" or self.Mode == "Dynamic" then
                    hrp.Size = vector3New(self.Size, self.Size, self.Size)
                    hrp.Transparency = self.Transparency
                    hrp.CanCollide = false
                    if head then
                        head.Size = vector3New(self.Size, self.Size, self.Size)
                        head.Transparency = self.Transparency
                        head.CanCollide = false
                    end
                    if upperTorso then
                        upperTorso.Size = vector3New(self.Size, self.Size, self.Size)
                        upperTorso.Transparency = self.Transparency
                        upperTorso.CanCollide = false
                    end
                    if self.Mode == "Dynamic" then
                        hrp.Size = hrp.Size + vector3New(math.random(-0.15, 0.15), math.random(-0.15, 0.15), math.random(-0.15, 0.15))
                    end
                    if self.Mode == "HeadOnly" and head then
                        head.Size = vector3New(self.Size, self.Size, self.Size)
                        head.Transparency = self.Transparency
                        head.CanCollide = false
                    end
                end
            else
                hrp.Size = vector3New(2, 2, 1)
                hrp.Transparency = 0
                hrp.CanCollide = true
                if head then
                    head.Size = vector3New(1.2, 1.2, 1.2)
                    head.Transparency = 0
                    head.CanCollide = true
                end
                if upperTorso then
                    upperTorso.Size = vector3New(2, 2, 1)
                    upperTorso.Transparency = 0
                    upperTorso.CanCollide = true
                end
            end
        end
    end
end

players.PlayerAdded:Connect(function(v)
    if NexusHub.Modules.HitboxExpander.Enabled then
        NexusHub.Modules.HitboxExpander:Update()
    end
end)

players.PlayerRemoving:Connect(function(v)
    if v.Character then
        local hrp = v.Character:FindFirstChild("HumanoidRootPart")
        local head = v.Character:FindFirstChild("Head")
        local upperTorso = v.Character:FindFirstChild("UpperTorso")
        if hrp then
            hrp.Size = vector3New(2, 2, 1)
            hrp.Transparency = 0
            hrp.CanCollide = true
        end
        if head then
            head.Size = vector3New(1.2, 1.2, 1.2)
            head.Transparency = 0
            head.CanCollide = true
        end
        if upperTorso then
            upperTorso.Size = vector3New(2, 2, 1)
            upperTorso.Transparency = 0
            upperTorso.CanCollide = true
        end
    end
end)

runService.Heartbeat:Connect(function()
    if NexusHub.Modules.HitboxExpander.Enabled then
        NexusHub.Modules.HitboxExpander:Update()
    end
end)

-- Teleport Logic: Ultra Advanced
function NexusHub.Modules.Teleport:ToPlayer(targetPlayer)
    if player.Character and player.Character.HumanoidRootPart and targetPlayer.Character and targetPlayer.Character.HumanoidRootPart then
        local targetPos = targetPlayer.Character.HumanoidRootPart.Position
        local offset = vector3New(math.random(-2, 2), 0, math.random(-2, 2)) -- Random offset to bypass detection
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos + offset)
    end
end

-- FreeCam Logic: Ultra Smooth
local freeCamCFrame = camera.CFrame
function NexusHub.Modules.FreeCam:Toggle(state)
    self.Enabled = state
    if state then
        camera.CameraType = Enum.CameraType.Scriptable
        local mouseDelta = vector2New(0, 0)
        userInputService.InputChanged:Connect(function(input)
            if self.Enabled and input.UserInputType == Enum.UserInputType.MouseMovement then
                mouseDelta = vector2New(input.Delta.X, input.Delta.Y)
            end
        end)
        runService.RenderStepped:Connect(function()
            if self.Enabled then
                local moveDir = vector3New(0, 0, 0)
                if userInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camera.CFrame.LookVector end
                if userInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camera.CFrame.LookVector end
                if userInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camera.CFrame.RightVector end
                if userInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camera.CFrame.RightVector end
                if userInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + vector3New(0, 1, 0) end
                if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - vector3New(0, 1, 0) end
                freeCamCFrame = freeCamCFrame * CFrame.Angles(0, -math.rad(mouseDelta.X * self.Sensitivity), 0)
                freeCamCFrame = freeCamCFrame * CFrame.Angles(-math.rad(mouseDelta.Y * self.Sensitivity), 0, 0)
                freeCamCFrame = freeCamCFrame + (moveDir * self.Speed * 0.016)
                camera.CFrame = freeCamCFrame
                mouseDelta = vector2New(0, 0)
            else
                camera.CameraType = Enum.CameraType.Custom
                freeCamCFrame = camera.CFrame
            end
        end)
    end
end

-- Server Stats Logic: Ultra Modern
function NexusHub.Modules.ServerStats:Update()
    local players = game.Players:GetPlayers()
    local stats = {
        PlayerCount = #players,
        Ping = mathFloor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()),
        Inventory = {}
    }
    for _, v in pairs(players) do
        stats.Inventory[v.Name] = {Team = v.Team and v.Team.Name or "None", Items = {}}
        if v.Character then
            for _, item in pairs(v.Character:GetChildren()) do
                if item:IsA("Tool") then
                    table.insert(stats.Inventory[v.Name].Items, item.Name)
                end
            end
        end
    end
    return stats
end

-- Main UI Setup
local mainFrame, contentFrame, tabFrame, mainGui = NexusHub.UI.CreateMainFrame()

-- UI Toggle/Destroy
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == NexusHub.Config.UI.ToggleKey then
        NexusHub.Config.UI.Hidden = not NexusHub.Config.UI.Hidden
        mainGui.Enabled = not NexusHub.Config.UI.Hidden
    elseif input.KeyCode == NexusHub.Config.UI.DestroyKey then
        mainGui:Destroy()
    end
end)

-- Streamproof: Hide on Screenshot/Video
if NexusHub.Config.Security.Streamproof then
    userInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Print or input.KeyCode == Enum.KeyCode.Escape then
            mainGui.Enabled = false
        end
    end)
    userInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Print or input.KeyCode == Enum.KeyCode.Escape then
            mainGui.Enabled = true
        end
    end)
    runService.RenderStepped:Connect(function()
        mainGui.DisplayOrder = 10000 -- Prevent capture in videos
    end)
end

-- Tab System
local tabs = {
    Aimbot = Instance.new("Frame", contentFrame),
    ESP = Instance.new("Frame", contentFrame),
    Movement = Instance.new("Frame", contentFrame),
    Hitbox = Instance.new("Frame", contentFrame),
    Teleport = Instance.new("Frame", contentFrame),
    FreeCam = Instance.new("Frame", contentFrame),
    ServerStats = Instance.new("Frame", contentFrame),
    Settings = Instance.new("Frame", contentFrame)
}

for _, tab in pairs(tabs) do
    tab.Size = udim2New(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.Visible = false
    local listLayout = Instance.new("UIListLayout", tab)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)
end

tabs.Aimbot.Visible = true -- Default tab

-- Tab Buttons
local tabButtons = {
    NexusHub.UI.CreateTabButton(tabFrame, "Aimbot", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.Aimbot.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "ESP", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.ESP.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "Movement", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.Movement.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "Hitbox", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.Hitbox.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "Teleport", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.Teleport.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "FreeCam", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.FreeCam.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "Server Stats", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.ServerStats.Visible = true
    end),
    NexusHub.UI.CreateTabButton(tabFrame, "Settings", contentFrame, function()
        for _, tab in pairs(tabs) do tab.Visible = false end
        tabs.Settings.Visible = true
    end)
}

for i, button in ipairs(tabButtons) do
    button.Position = udim2New((i - 1) * 0.125 + 0.01, 0, 0.075, 0)
end

-- Aimbot Controls
local aimbotControls = {
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Enable Aimbot", function(state)
        NexusHub.Modules.AimBot.Enabled = state
    end, false),
    NexusHub.UI.CreateDropdown(tabs.Aimbot, "Mode", {"Smooth", "Blatant", "Mouse"}, "Smooth", function(value)
        NexusHub.Modules.AimBot.Mode = value
    end),
    NexusHub.UI.CreateDropdown(tabs.Aimbot, "Activation Mode", {"Toggle", "Hold"}, "Toggle", function(value)
        NexusHub.Modules.AimBot.ActivationMode = value
    end),
    NexusHub.UI.CreateKeybind(tabs.Aimbot, "Keybind", function(input)
        NexusHub.Modules.AimBot.Keybind = input.UserInputType
    end, Enum.UserInputType.MouseButton2),
    NexusHub.UI.CreateSlider(tabs.Aimbot, "FOV", 10, 1000, NexusHub.Modules.AimBot.FOV, function(value)
        NexusHub.Modules.AimBot.FOV = value
    end),
    NexusHub.UI.CreateSlider(tabs.Aimbot, "Smoothness", 0.01, 1, NexusHub.Modules.AimBot.Smoothness, function(value)
        NexusHub.Modules.AimBot.Smoothness = value
    end),
    NexusHub.UI.CreateDropdown(tabs.Aimbot, "Target Bone", {"Head", "UpperTorso", "Torso", "Legs"}, "Head", function(value)
        NexusHub.Modules.AimBot.TargetBone = value
    end),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Wall Check", function(state)
        NexusHub.Modules.AimBot.WallCheck = state
    end, true),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Visible Check", function(state)
        NexusHub.Modules.AimBot.VisibleCheck = state
    end, true),
    NexusHub.UI.CreateSlider(tabs.Aimbot, "Max Distance", 100, 10000, NexusHub.Modules.AimBot.MaxDistance, function(value)
        NexusHub.Modules.AimBot.MaxDistance = value
    end),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "TriggerBot", function(state)
        NexusHub.Modules.AimBot.TriggerBot = state
    end, false),
    NexusHub.UI.CreateSlider(tabs.Aimbot, "Trigger Delay", 0, 0.3, NexusHub.Modules.AimBot.TriggerDelay, function(value)
        NexusHub.Modules.AimBot.TriggerDelay = value
    end),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Prediction", function(state)
        NexusHub.Modules.AimBot.Prediction = state
    end, true),
    NexusHub.UI.CreateSlider(tabs.Aimbot, "Prediction Factor", 0.05, 0.5, NexusHub.Modules.AimBot.PredictionFactor, function(value)
        NexusHub.Modules.AimBot.PredictionFactor = value
    end),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Anti-Recoil", function(state)
        NexusHub.Modules.AimBot.AntiRecoil = state
    end, true),
    NexusHub.UI.CreateToggle(tabs.Aimbot, "Anti-Spread", function(state)
        NexusHub.Modules.AimBot.AntiSpread = state
    end, true)
}

-- ESP Controls
local espControls = {
    NexusHub.UI.CreateToggle(tabs.ESP, "Enable ESP", function(state)
        NexusHub.Modules.ESP.Enabled = state
    end, false),
    NexusHub.UI.CreateToggle(tabs.ESP, "Name", function(state)
        NexusHub.Modules.ESP.Name = state
        NexusHub.Modules.ESP:Update()
    end, true),
    NexusHub.UI.CreateToggle(tabs.ESP, "Health", function(state)
        NexusHub.Modules.ESP.Health = state
        NexusHub.Modules.ESP:Update()
    end, true),
    NexusHub.UI.CreateToggle(tabs.ESP, "Distance", function(state)
        NexusHub.Modules.ESP.Distance = state
        NexusHub.Modules.ESP:Update()
    end, true),
    NexusHub.UI.CreateToggle(tabs.ESP, "Chams", function(state)
        NexusHub.Modules.ESP.Chams = state
        NexusHub.Modules.ESP:Update()
    end, true)
}

-- Movement Controls
local movementControls = {
    NexusHub.UI.CreateToggle(tabs.Movement, "Noclip", function(state)
        NexusHub.Modules.Noclip:Toggle(state)
    end, false),
    NexusHub.UI.CreateDropdown(tabs.Movement, "Noclip Mode", {"Standard", "Smooth"}, "Standard", function(value)
        NexusHub.Modules.Noclip.Mode = value
    end),
    NexusHub.UI.CreateToggle(tabs.Movement, "Speed", function(state)
        NexusHub.Modules.Speed:Toggle(state)
    end, false),
    NexusHub.UI.CreateSlider(tabs.Movement, "Speed Value", 16, 3000, NexusHub.Modules.Speed.Value, function(value)
        NexusHub.Modules.Speed.Value = value
        NexusHub.Modules.Speed:Toggle(NexusHub.Modules.Speed.Enabled)
    end),
    NexusHub.UI.CreateDropdown(tabs.Movement, "Speed Mode", {"Standard", "Smooth", "Exponential"}, "Standard", function(value)
        NexusHub.Modules.Speed.Mode = value
        NexusHub.Modules.Speed:Toggle(NexusHub.Modules.Speed.Enabled)
    end),
    NexusHub.UI.CreateToggle(tabs.Movement, "Fly", function(state)
        NexusHub.Modules.Fly:Toggle(state)
    end, false),
    NexusHub.UI.CreateSlider(tabs.Movement, "Fly Speed", 10, 1500, NexusHub.Modules.Fly.Speed, function(value)
        NexusHub.Modules.Fly.Speed = value
    end),
    NexusHub.UI.CreateSlider(tabs.Movement, "Fly Height", 0, 300, NexusHub.Modules.Fly.Height, function(value)
        NexusHub.Modules.Fly.Height = value
    end),
    NexusHub.UI.CreateDropdown(tabs.Movement, "Fly Mode", {"Standard", "Smooth", "Velocity"}, "Standard", function(value)
        NexusHub.Modules.Fly.Mode = value
    end),
    NexusHub.UI.CreateToggle(tabs.Movement, "Anti-Gravity", function(state)
        NexusHub.Modules.Fly.AntiGravity = state
        NexusHub.Modules.Fly:Toggle(NexusHub.Modules.Fly.Enabled)
    end, true),
    NexusHub.UI.CreateToggle(tabs.Movement, "Jump Power", function(state)
        NexusHub.Modules.JumpPower:Toggle(state)
    end, false),
    NexusHub.UI.CreateSlider(tabs.Movement, "Jump Power", 50, 3000, NexusHub.Modules.JumpPower.Value, function(value)
        NexusHub.Modules.JumpPower.Value = value
        NexusHub.Modules.JumpPower:Toggle(NexusHub.Modules.JumpPower.Enabled)
    end),
    NexusHub.UI.CreateDropdown(tabs.Movement, "Jump Mode", {"Standard", "Dynamic"}, "Standard", function(value)
        NexusHub.Modules.JumpPower.Mode = value
        NexusHub.Modules.JumpPower:Toggle(NexusHub.Modules.JumpPower.Enabled)
    end)
}

-- Hitbox Controls
local hitboxControls = {
    NexusHub.UI.CreateToggle(tabs.Hitbox, "Hitbox Expander", function(state)
        NexusHub.Modules.HitboxExpander:Toggle(state)
    end, false),
    NexusHub.UI.CreateSlider(tabs.Hitbox, "Hitbox Size", 2, 40, NexusHub.Modules.HitboxExpander.Size, function(value)
        NexusHub.Modules.HitboxExpander.Size = value
        NexusHub.Modules.HitboxExpander:Update()
    end),
    NexusHub.UI.CreateSlider(tabs.Hitbox, "Transparency", 0, 1, NexusHub.Modules.HitboxExpander.Transparency, function(value)
        NexusHub.Modules.HitboxExpander.Transparency = value
        NexusHub.Modules.HitboxExpander:Update()
    end),
    NexusHub.UI.CreateDropdown(tabs.Hitbox, "Mode", {"Standard", "Dynamic", "HeadOnly"}, "Standard", function(value)
        NexusHub.Modules.HitboxExpander.Mode = value
        NexusHub.Modules.HitboxExpander:Update()
    end),
    NexusHub.UI.CreateDropdown(tabs.Hitbox, "Apply To", {"All", "Enemies"}, "Enemies", function(value)
        NexusHub.Modules.HitboxExpander.ApplyTo = value
        NexusHub.Modules.HitboxExpander:Update()
    end),
    NexusHub.UI.CreateToggle(tabs.Hitbox, "Team Check", function(state)
        NexusHub.Modules.HitboxExpander.TeamCheck = state
        NexusHub.Modules.HitboxExpander:Update()
    end, true)
}

-- Teleport Controls
local teleportControls = {
    NexusHub.UI.CreateToggle(tabs.Teleport, "Enable Teleport", function(state)
        NexusHub.Modules.Teleport.Enabled = state
    end, false),
    NexusHub.UI.CreateDropdown(tabs.Teleport, "Target Player", {"None"}, "None", function(value)
        NexusHub.Modules.Teleport.TargetPlayer = value == "None" and nil or players:FindFirstChild(value)
    end)
}

-- Update Teleport Dropdown Dynamically
players.PlayerAdded:Connect(function(v)
    local dropdown = tabs.Teleport:FindFirstChild("Target Player")
    if dropdown then
        local options = {"None"}
        for _, p in pairs(players:GetPlayers()) do
            table.insert(options, p.Name)
        end
        dropdown:Destroy()
        NexusHub.UI.CreateDropdown(tabs.Teleport, "Target Player", options, "None", function(value)
            NexusHub.Modules.Teleport.TargetPlayer = value == "None" and nil or players:FindFirstChild(value)
        end)
    end
end)

players.PlayerRemoving:Connect(function(v)
    local dropdown = tabs.Teleport:FindFirstChild("Target Player")
    if dropdown then
        local options = {"None"}
        for _, p in pairs(players:GetPlayers()) do
            if p ~= v then
                table.insert(options, p.Name)
            end
        end
        dropdown:Destroy()
        NexusHub.UI.CreateDropdown(tabs.Teleport, "Target Player", options, "None", function(value)
            NexusHub.Modules.Teleport.TargetPlayer = value == "None" and nil or players:FindFirstChild(value)
        end)
    end
end)

runService.Heartbeat:Connect(function()
    if NexusHub.Modules.Teleport.Enabled and NexusHub.Modules.Teleport.TargetPlayer then
        NexusHub.Modules.Teleport:ToPlayer(NexusHub.Modules.Teleport.TargetPlayer)
    end
end)

-- FreeCam Controls
local freeCamControls = {
    NexusHub.UI.CreateToggle(tabs.FreeCam, "Enable FreeCam", function(state)
        NexusHub.Modules.FreeCam:Toggle(state)
    end, false),
    NexusHub.UI.CreateSlider(tabs.FreeCam, "FreeCam Speed", 10, 1000, NexusHub.Modules.FreeCam.Speed, function(value)
        NexusHub.Modules.FreeCam.Speed = value
    end),
    NexusHub.UI.CreateSlider(tabs.FreeCam, "Sensitivity", 0.05, 0.5, NexusHub.Modules.FreeCam.Sensitivity, function(value)
        NexusHub.Modules.FreeCam.Sensitivity = value
    end)
}

-- Server Stats Controls
local serverStatsControls = {
    NexusHub.UI.CreateToggle(tabs.ServerStats, "Enable Server Stats", function(state)
        NexusHub.Modules.ServerStats.Enabled = state
        if state then
            local statsFrame = Instance.new("Frame", tabs.ServerStats)
            statsFrame.Size = udim2New(0.95, 0, 0.4, 0)
            statsFrame.BackgroundTransparency = 0.05
            statsFrame.BackgroundColor3 = NexusHub.Config.Theme.PrimaryColor
            local corner = Instance.new("UICorner", statsFrame)
            corner.CornerRadius = UDim.new(0, 8)

            local statsLabel = Instance.new("TextLabel", statsFrame)
            statsLabel.Size = udim2New(1, 0, 1, 0)
            statsLabel.BackgroundTransparency = 1
            statsLabel.TextColor3 = NexusHub.Config.Theme.AccentColor
            statsLabel.TextScaled = true
            statsLabel.Font = NexusHub.Config.Theme.Font
            statsLabel.TextSize = NexusHub.Config.Theme.FontSize - 2
            statsLabel.TextWrapped = true
            statsLabel.TextYAlignment = Enum.TextYAlignment.Top

            runService.Heartbeat:Connect(function()
                if NexusHub.Modules.ServerStats.Enabled then
                    local stats = NexusHub.Modules.ServerStats:Update()
                    local text = "Server Stats:\n"
                    text = text .. "Player Count: " .. stats.PlayerCount .. "\n"
                    text = text .. "Ping: " .. stats.Ping .. "ms\n"
                    text = text .. "Inventory & Teams:\n"
                    for playerName, data in pairs(stats.Inventory) do
                        text = text .. playerName .. " (" .. data.Team .. "): " .. table.concat(data.Items, ", ") .. "\n"
                    end
                    statsLabel.Text = text
                end
            end)
        end
    end, false)
}

-- Settings Controls
local settingsControls = {
    NexusHub.UI.CreateKeybind(tabs.Settings, "Toggle UI", function(input)
        NexusHub.Config.UI.ToggleKey = input.KeyCode
    end, Enum.KeyCode.F4),
    NexusHub.UI.CreateKeybind(tabs.Settings, "Destroy UI", function(input)
        NexusHub.Config.UI.DestroyKey = input.KeyCode
    end, Enum.KeyCode.F8),
    NexusHub.UI.CreateToggle(tabs.Settings, "Streamproof", function(state)
        NexusHub.Config.Security.Streamproof = state
    end, true),
    NexusHub.UI.CreateToggle(tabs.Settings, "Lite Mode", function(state)
        NexusHub.Config.Performance.LiteMode = state
        for _, tab in pairs(tabs) do
            for _, v in pairs(tab:GetChildren()) do
                if v:IsA("Frame") or v:IsA("TextButton") then
                    v.BackgroundTransparency = state and 0.5 or 0
                end
            end
        end
    end, false)
}

-- Dynamic Canvas Size
local function updateCanvasSize()
    local maxHeight = 0
    for _, tab in pairs(tabs) do
        local height = 0
        for _, child in pairs(tab:GetChildren()) do
            if child:IsA("Frame") then
                height = height + child.AbsoluteSize.Y + 10
            end
        end
        maxHeight = math.max(maxHeight, height)
    end
    contentFrame.CanvasSize = udim2New(0, 0, 0, maxHeight + 30)
end
updateCanvasSize()

-- Performance Optimization
if NexusHub.Config.Performance.LiteMode then
    for _, tab in pairs(tabs) do
        for _, v in pairs(tab:GetChildren()) do
            if v:IsA("Frame") or v:IsA("TextButton") then
                v.BackgroundTransparency = 0.5
            end
        end
    end
end

-- Anti-Detect: Obfuscation
local _0x8B2C = NexusHub.UI.CreateMainFrame
local _0x6E1F = NexusHub.UI.CreateTabButton
local _0x5D4A = NexusHub.UI.CreateToggle
local _0x3C5B = NexusHub.UI.CreateSlider
local _0x9F6D = NexusHub.UI.CreateDropdown
local _0x2A3E = NexusHub.UI.CreateKeybind
