local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local RANGO_MAXIMO = 25
local VELOCIDADATAQUE = 0.1

local function getAttackRemote()
    local names = {"Attack", "Hit", "Punch", "Combat", "DealDamage", "Damage", "Strike", "HitRemote"}
    for , name in pairs(names) do
        local found = game.ReplicatedStorage:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            return found
        end
    end
    return nil
end

local remote = getAttackRemote()
_G.KillAura = true

task.spawn(function()
    while G.KillAura do
        if not remote then 
            remote = getAttackRemote() 
        end

        for , enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") and enemy.Character:FindFirstChild("Humanoid") then
                if enemy.Character.Humanoid.Health > 0 then
                    local enemyRoot = enemy.Character.HumanoidRootPart
                    local distancia = (rootPart.Position - enemyRoot.Position).Magnitude

                    if distancia <= RANGO_MAXIMO then
                        if remote then
                            remote:FireServer(enemy.Character, enemy.Character.HumanoidRootPart)
                            remote:FireServer(enemy.Character.Humanoid)
                        end
                    end
                end
            end
        end
        task.wait(VELOCIDAD_ATAQUE)
    end
end)
