local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Crear la Interfaz Principal
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
local Title = Instance.new("TextLabel", MainFrame)
local SpeedBtn = Instance.new("TextButton", MainFrame)
local JumpBtn = Instance.new("TextButton", MainFrame)
local FlyBtn = Instance.new("TextButton", MainFrame)

-- Diseño del Menú
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true -- Para que puedas moverlo

Title.Text = "MI EXPLOIT HUB"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.TextColor3 = Color3.new(1, 1, 1)

-- Estilo de los Botones
local function styleButton(btn, text, pos)
    btn.Text = text
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
end

styleButton(SpeedBtn, "Velocidad (100)", UDim2.new(0, 10, 0, 50))
styleButton(JumpBtn, "Super Salto", UDim2.new(0, 10, 0, 100))
styleButton(FlyBtn, "Vuelo (F)", UDim2.new(0, 10, 0, 150))

--- LÓGICA DE LAS FUNCIONES ---

-- 1. Velocidad
SpeedBtn.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 100
    SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Se pone verde
end)

-- 2. Salto
JumpBtn.MouseButton1Click:Connect(function()
    player.Character.Humanoid.JumpPower = 150
    JumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end)
-- 3. Vuelo (Usando la lógica que vimos antes)
local flying = false
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        -- Aquí podrías llamar a la función de vuelo que escribimos antes
    else
        FlyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end
end)
