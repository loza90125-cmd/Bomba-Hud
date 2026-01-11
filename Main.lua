main.lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer

-- ID DE LA IMAGEN DE LA BOMBA (La de tu foto)
local BOMB_IMAGE_ID = "rbxassetid://14597655053" 

--// 0. NOTIFICACIÓN DE BIENVENIDA
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "BOMBA HUD X";
    Text = "¡Bienvenido, " .. Player.Name .. "!";
    Icon = BOMB_IMAGE_ID;
    Duration = 5;
})

--// 1. TEMA Y ESTILOS
local Theme = {
    Background = Color3.fromRGB(15, 15, 20),
    Sidebar = Color3.fromRGB(22, 22, 28),
    Item = Color3.fromRGB(32, 32, 38),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(190, 190, 190),
    Accent = Color3.fromRGB(255, 45, 45), -- Rojo Bomba
}

local function Round(obj, r)
    local c = Instance.new("UICorner", obj)
    c.CornerRadius = UDim.new(0, r)
    return c
end

--// 2. LIMPIEZA
pcall(function()
    if CoreGui:FindFirstChild("BombaHudX") then CoreGui.BombaHudX:Destroy() end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BombaHudX"
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = Player.PlayerGui end

--// 3. LOADER FALSO
local Loader = Instance.new("Frame", ScreenGui)
Loader.Size = UDim2.new(0, 250, 0, 100)
Loader.Position = UDim2.new(0.5, -125, 0.5, -50)
Loader.BackgroundColor3 = Theme.Background
Round(Loader, 10)

local LoadIcon = Instance.new("ImageLabel", Loader)
LoadIcon.Size = UDim2.new(0,40,0,40); LoadIcon.Position = UDim2.new(0.5,-20,0.2,0)
LoadIcon.BackgroundTransparency = 1; LoadIcon.Image = BOMB_IMAGE_ID

local LoadTxt = Instance.new("TextLabel", Loader)
LoadTxt.Size = UDim2.new(1,0,0,30); LoadTxt.Position = UDim2.new(0,0,0.6,0)
LoadTxt.BackgroundTransparency=1; LoadTxt.TextColor3 = Theme.Accent
LoadTxt.Font = Enum.Font.GothamBlack; LoadTxt.Text = "CARGANDO..."
LoadTxt.TextStrokeTransparency = 0.8; LoadTxt.TextStrokeColor3 = Color3.new(0,0,0)

task.wait(1.5)
Loader:TweenSizeAndPosition(UDim2.new(0,0,0,0), UDim2.new(0.5,0,0.5,0), "In", "Back", 0.5, true, function() Loader:Destroy() end)

--// 4. INTERFAZ PRINCIPAL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 350)
Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Theme.Background
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Visible = false
Round(Main, 12)
task.wait(0.6) Main.Visible = true

local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2; Stroke.Transparency = 0.6; Stroke.Color = Theme.Accent

-- BARRA LATERAL
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Theme.Sidebar
Round(Sidebar, 12)
local SideFix = Instance.new("Frame", Sidebar)
SideFix.Size = UDim2.new(0, 10, 1, 0); SideFix.Position = UDim2.new(1, -10, 0, 0)
SideFix.BackgroundColor3 = Theme.Sidebar; SideFix.BorderSizePixel = 0

local TitleHeader = Instance.new("Frame", Sidebar)
TitleHeader.Size = UDim2.new(1,0,0,80); TitleHeader.BackgroundTransparency=1

local TitleIcon = Instance.new("ImageLabel", TitleHeader)
TitleIcon.Size = UDim2.new(0,30,0,30); TitleIcon.Position = UDim2.new(0,15,0,25)
TitleIcon.BackgroundTransparency = 1; TitleIcon.Image = BOMB_IMAGE_ID

local Title = Instance.new("TextLabel", TitleHeader)
Title.Text = "BOMBA\nHUD X"
Title.Size = UDim2.new(1, -50, 1, 0); Title.Position = UDim2.new(0,50,0,0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Theme.Text
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextStrokeTransparency = 0.8; Title.TextStrokeColor3 = Color3.new(0,0,0)

local TitleAccent = Instance.new("Frame", TitleHeader)
TitleAccent.Size = UDim2.new(0, 40, 0, 4); TitleAccent.Position = UDim2.new(0, 15, 0.8, 0)
TitleAccent.BackgroundColor3 = Theme.Accent; Round(TitleAccent, 2)

-- ÁREA DE CONTENIDO
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -180, 1, -20)
Content.Position = UDim2.new(0, 170, 0, 10)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Theme.Accent
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.CanvasSize = UDim2.new(0,0,0,0)

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0, 12)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

--// GENERADORES UI
local function Section(text)
    local l = Instance.new("TextLabel", Content)
    l.Size = UDim2.new(1, 0, 0, 25)
    l.BackgroundTransparency = 1; l.Text = text
    l.TextColor3 = Theme.TextDark; l.Font = Enum.Font.GothamBold; l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextStrokeTransparency = 0.9; l.TextStrokeColor3 = Color3.new(0,0,0)
end

local function Toggle(text, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1, -10, 0, 45); btn.BackgroundColor3 = Theme.Item; btn.Text = ""
    Round(btn, 8)
    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(0.7, 0, 1, 0); lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = text; lbl.TextColor3 = Theme.Text
    lbl.Font = Enum.Font.GothamSemibold; lbl.TextSize = 14; lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextStrokeTransparency = 0.8; lbl.TextStrokeColor3 = Color3.new(0,0,0)
    
    local toggler = Instance.new("Frame", btn)
    toggler.Size = UDim2.new(0, 44, 0, 22); toggler.Position = UDim2.new(1, -50, 0.5, -11)
    toggler.BackgroundColor3 = Color3.fromRGB(50, 50, 50); Round(toggler, 12)
    
    local circle = Instance.new("ImageLabel", toggler)
    circle.Size = UDim2.new(0, 18, 0, 18); circle.Position = UDim2.new(0, 2, 0.5, -9)
    circle.BackgroundTransparency = 1
    -- Icono del toggle (puedes cambiarlo si quieres)
    circle.Image = "rbxassetid://7072724671" 

    local on = false
    btn.MouseButton1Click:Connect(function()
        on = not on
        if on then
            TweenService:Create(toggler, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Theme.Accent}):Play()
            circle:TweenPosition(UDim2.new(1, -20, 0.5, -9), "Out", "Back", 0.3, true)
            TweenService:Create(circle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Rotation = 360}):Play()
        else
            TweenService:Create(toggler, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            circle:TweenPosition(UDim2.new(0, 2, 0.5, -9), "Out", "Back", 0.3, true)
            TweenService:Create(circle, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Rotation = 0}):Play()
        end
        callback(on)
    end)
end

local function Slider(text, min, max, default, callback)
    local frame = Instance.new("Frame", Content)
    frame.Size = UDim2.new(1, -10, 0, 65); frame.BackgroundColor3 = Theme.Item; Round(frame, 8)
    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(1, -20, 0, 30); lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Theme.Text; lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextStrokeTransparency = 0.8; lbl.TextStrokeColor3 = Color3.new(0,0,0)
    local slideBg = Instance.new("TextButton", frame)
    slideBg.Size = UDim2.new(1, -30, 0, 8); slideBg.Position = UDim2.new(0, 15, 0, 40)
    slideBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20); slideBg.Text = ""; slideBg.AutoButtonColor = false
    Round(slideBg, 4)
    local fill = Instance.new("Frame", slideBg)
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Theme.Accent; Round(fill, 4)
    
    local function Set(v)
        local val = math.clamp(v, min, max)
        lbl.Text = text .. ": " .. val
        fill.Size = UDim2.new((val-min)/(max-min), 0, 1, 0)
        callback(val)
    end
    local dragging = false
    slideBg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local pos = math.clamp((i.Position.X - slideBg.AbsolutePosition.X) / slideBg.AbsoluteSize.X, 0, 1)
            Set(math.floor(min + ((max - min) * pos)))
        end
    end)
end

local function Button(text, color, callback)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1, -10, 0, 40); btn.BackgroundColor3 = Theme.Item
    btn.Text = "  " .. text; btn.TextColor3 = Theme.Text
    btn.Font = Enum.Font.GothamSemibold; btn.TextXAlignment = Enum.TextXAlignment.Left; Round(btn, 6)
    btn.TextStrokeTransparency = 0.8; btn.TextStrokeColor3 = Color3.new(0,0,0)
    local indicator = Instance.new("Frame", btn)
    indicator.Size = UDim2.new(0, 4, 0, 20); indicator.Position = UDim2.new(0, 0, 0.5, -10)
    indicator.BackgroundColor3 = color; Round(indicator, 2)
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50,50,50)}):Play()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Theme.Item}):Play()
        callback()
    end)
end

--// LÓGICA PRINCIPAL

-- 1. VELOCIDAD + ANIMACION FIJA + ANTI-LAG
Section("JUGADOR")
local speedVal = 100
local speedActive = false
local animTrack = nil
local RUN_ANIM_ID = "rbxassetid://507767714" -- Animación R15 estándar

Slider("Velocidad", 16, 1000, 100, function(v) speedVal = v end)

Toggle("Activar Velocidad", function(state)
    speedActive = state
    if not state and animTrack then
        animTrack:Stop(); animTrack = nil
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    local char = Player.Character; if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    
    if speedActive and root and hum then
        if hum.MoveDirection.Magnitude > 0 then
            local moveDir = hum.MoveDirection
            local nextPos = moveDir * (speedVal * dt)
            local params = RaycastParams.new(); params.FilterDescendantsInstances = {char}; params.FilterType = Enum.RaycastFilterType.Exclude
            local ray = workspace:Raycast(root.Position, nextPos * 1.5, params)
            if not ray then
                root.CFrame = root.CFrame + Vector3.new(nextPos.X, 0, nextPos.Z)
                root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0) 
            end
            if not animTrack then
                local anim = Instance.new("Animation"); anim.AnimationId = RUN_ANIM_ID
                animTrack = hum:LoadAnimation(anim)
                animTrack.Priority = Enum.AnimationPriority.Action
                animTrack.Looped = true
            end
            if not animTrack.IsPlaying then
                animTrack:Play()
                animTrack:AdjustSpeed(1) 
            end
        else
            if animTrack and animTrack.IsPlaying then animTrack:Stop() end
        end
    end
end)

-- 2. GOD MODE
local god = false
Toggle("Modo Fantasma", function(state)
    god = state
    if not god and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanTouch = true end
        end
    end
end)
RunService.Stepped:Connect(function()
    if god and Player.Character then
        for _, v in pairs(Player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanTouch = false end
        end
    end
end)

-- 3. TELEPORTS
Section("VIAJES RÁPIDOS")
local function TP(x,y,z) if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then Player.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z) end end
Button("LOBBY", Color3.fromRGB(200, 200, 200), function() TP(120.3, 3.2, 0.9) end)
Button("ZONA COMÚN", Color3.fromRGB(46, 204, 113), function() TP(235.1, 3.2, -0.3) end)
Button("ZONA NO COMÚN", Color3.fromRGB(52, 152, 219), function() TP(335.0, 3.2, 1.7) end)
Button("ZONA RARA", Color3.fromRGB(0, 100, 255), function() TP(465.7, 3.2, 2.0) end)
Button("ZONA ÉPICA", Color3.fromRGB(155, 89, 182), function() TP(645.6, 3.2, 4.7) end)
Button("ZONA LEGENDARIA", Color3.fromRGB(230, 126, 34), function() TP(897.5, 3.2, 8.4) end)
Button("ZONA MÍTICA", Color3.fromRGB(231, 76, 60), function() TP(1308.3, 3.2, 5.4) end)
Button("ZONA CÓSMICA", Color3.fromRGB(142, 68, 173), function() TP(2012.2, 3.2, 1.6) end)
Button("ZONA SECRETA", Color3.fromRGB(80, 80, 80), function() TP(2445.9, 3.2, 3.5) end)
Button("ZONA CELESTIAL", Color3.fromRGB(255, 215, 0), function() TP(2792.4, 3.2, -0.8) end)

-- CIERRE Y BOTÓN DE BOMBA (REDISEÑADO)
local CloseBtn = Instance.new("TextButton", Sidebar)
CloseBtn.Size = UDim2.new(1, -20, 0, 45)
CloseBtn.Position = UDim2.new(0, 10, 1, -55)
CloseBtn.BackgroundColor3 = Theme.Accent -- Botón rojo sólido
CloseBtn.Text = "✖ CERRAR" -- Texto limpio con icono
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
Round(CloseBtn, 8)

local open = true
CloseBtn.MouseButton1Click:Connect(function()
    open = not open
    if open then
        Main:TweenSize(UDim2.new(0, 550, 0, 350), "Out", "Back", 0.4, true)
        Content.Visible = true
    else
        Main:TweenSize(UDim2.new(0, 550, 0, 0), "In", "Back", 0.4, true)
        Content.Visible = false
        
        -- BOTÓN DE REAPERTURA CON LA FOTO REAL
        local BombBtn = Instance.new("ImageButton", ScreenGui)
        BombBtn.Name = "ReopenBomb"
        BombBtn.Size = UDim2.new(0, 70, 0, 70)
        BombBtn.Position = UDim2.new(0, 30, 0.5, -35)
        BombBtn.BackgroundColor3 = Theme.Background
        BombBtn.ImageColor3 = Color3.new(1,1,1)
        Round(BombBtn, 35)
        
        -- USA LA ID REAL DE TU FOTO AQUI
        BombBtn.Image = BOMB_IMAGE_ID
        
        local BombStroke = Instance.new("UIStroke", BombBtn)
        BombStroke.Color = Theme.Accent; BombStroke.Thickness = 3

        BombBtn.MouseButton1Click:Connect(function()
            Main:TweenSize(UDim2.new(0, 550, 0, 350), "Out", "Back", 0.4, true)
            Content.Visible = true
            BombBtn:Destroy()
            open = true
        end)
    end
end)
