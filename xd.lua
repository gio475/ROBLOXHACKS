local remote = game:GetService("ReplicatedStorage").Events.Attack

-- Creamos un bucle que ataque cada 1 segundo
_G.AutoFarm = true -- Variable global para encender/apagar

while _G.AutoFarm == true do
    -- Usamos el RemoteEvent que descubrimos con el Remote Spy
    remote:FireServer("Daga") 
    task.wait(1) 
end
