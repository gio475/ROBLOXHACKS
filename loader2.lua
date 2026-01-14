local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- CONFIGURACIÓN
local RANGO_MAXIMO = 20 -- Puedes subir este número (ej. 50) para golpear desde más lejos
local VELOCIDADATAQUE = 0.9 -- Segundos entre cada golpe

-- BUSCADOR AUTOMÁTICO DE EVENTOS (Intenta adivinar el remote del juego)
local function getAttackRemote()
    local names = {"Attack", "Hit", "Punch", "Combat", "DealDamage", "Damage"}
    for , name in pairs(names) do
        local found = game.ReplicatedStorage:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            return found
        end
    end
    return nil
end

local remote = getAttackRemote()

-- BUCLE PRINCIPAL
_G.KillAura = true
print("Kill Aura Iniciado. Buscando Remote...")

task.spawn(function()
    while G.KillAura do
        if not remote then remote = getAttackRemote() end -- Reintenta si no lo halló

        for , enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                local enemyRoot = enemy.Character.HumanoidRootPart
                -- Calculamos la distancia (Magnitude)
                local distancia = (rootPart.Position - enemyRoot.Position).Magnitude

                if distancia <= RANGO_MAXIMO then
                    if remote then
                        -- Enviamos el golpe al servidor
                        -- Nota: Algunos juegos requieren el brazo o la cabeza como argumento
                        remote:FireServer(enemy.Character, enemy.Character.Head)
                    end
                end
            end
        end
        task.wait(0.9)
    end
end)
