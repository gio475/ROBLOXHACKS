local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local rs = game:GetService("ReplicatedStorage")

-- Los ataques detectados en tu consola
local punchSequences = {"Punch1", "Punch2", "Punch3", "Punch4", "PunchDash"}
local remote = rs:FindFirstChild("CombatEvent", true) or rs:FindFirstChild("Hit", true)

_G.KillFarm = true

task.spawn(function()
    while G.KillFarm do
        for , enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("Humanoid") then
                local eRoot = enemy.Character:FindFirstChild("HumanoidRootPart")
                local eHum = enemy.Character.Humanoid

                if eRoot and eHum.Health > 0 then
                    local dist = (root.Position - eRoot.Position).Magnitude

                    if dist < 30 then -- Solo ataca si estás en el rango
                        -- Teletransporte instantáneo para evitar "Too far from hitbox"
                        local originalPos = root.CFrame
                        root.CFrame = eRoot.CFrame * CFrame.new(0, 0, 2)

                        -- Envío de la secuencia de golpes detectada en tu F9
                        for _, punch in pairs(punchSequences) do
                            if remote then
                                remote:FireServer(punch, enemy.Character)
                            end
                        end

                        task.wait(0.05)
                        root.CFrame = originalPos -- Regresas a tu posición
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)
