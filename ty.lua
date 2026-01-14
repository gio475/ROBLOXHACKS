local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local lplayer = Players.LocalPlayer

-- AQUÍ DEBES PONER EL NOMBRE DEL REMOTE QUE ENCONTRASTE CON EL SPY
-- Ejemplo: ReplicatedStorage.Remotes.CombatEvent
local AttackRemote = ReplicatedStorage:FindFirstChild("Attack", true) 

_G.AutoFarm = true -- Interruptor

task.spawn(function()
    while G.AutoFarm do
        for , v in pairs(Players:GetPlayers()) do
            -- No nos atacamos a nosotros mismos ni a gente sin personaje
            if v ~= lplayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local targetPart = v.Character.Head

                -- Simulamos el ataque (Esto varía según lo que diga tu RemoteSpy)
                -- Muchos juegos piden el objetivo y el tipo de ataque
                if AttackRemote then
                    AttackRemote:FireServer(v.Character, "NormalPunch") 
                end
            end
        end
        task.wait(1) -- Velocidad del ataque (ajusta para evitar baneos)
    end
end)
