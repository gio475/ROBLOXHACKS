local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")
local inputService = game:GetService("UserInputService")

local noclip = false

-- Función que apaga las colisiones
runService.Stepped:Connect(function()
    if noclip then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Tecla para activar/desactivar (Tecla N)
inputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.N then
        noclip = not noclip
        print("NoClip estado: " .. tostring(noclip))

        -- Notificación visual en el juego
        game.StarterGui:SetCore("SendNotification", {
            Title = "NoClip Status",
            Text = noclip and "Activado (N)" or "Desactivado (N)",
            Duration = 2
        })
    end
end)
