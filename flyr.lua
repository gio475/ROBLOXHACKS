local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local flying = false
local speed = 50 -- Puedes cambiar la velocidad aquí

-- Función principal de vuelo
local function toggleFly()
    flying = not flying

    if flying then
        -- Creamos la fuerza para mantenernos en el aire
        local bg = Instance.new("BodyGyro", root)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = root.CFrame
        bg.Name = "FlyGyro"

        local bv = Instance.new("BodyVelocity", root)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Name = "FlyVelocity"

        humanoid.PlatformStand = true -- Evita que el personaje intente caminar

        -- Bucle de movimiento
        task.spawn(function()
            while flying do
                task.wait()
                -- Movemos el personaje hacia donde mira la cámara
                bv.velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                bg.cframe = workspace.CurrentCamera.CFrame
            end
        end)
    else
        -- Limpiamos todo al desactivar
        humanoid.PlatformStand = false
        if root:FindFirstChild("FlyGyro") then root.FlyGyro:Destroy() end
        if root:FindFirstChild("FlyVelocity") then root.FlyVelocity:Destroy() end
    end
end

-- Activar con la tecla F
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)
