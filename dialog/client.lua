ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)


Citizen.CreateThread(function()
    while true do
        sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if GetDistanceBetweenCoords(playerCoords, Config.Coords.x, Config.Coords.y, Config.Coords.z) < 2.0 then
            sleep = 5
            DrawText3D(Config.Coords.x, Config.Coords.y, Config.Coords.z + 0.3, 0.30, '[E] - Maymun Liko ile konusmaya basla')
            if IsControlJustPressed(0, 38) then
                SendNUIMessage({
                    action = 'menu',
                    display = true,
                    question = Config.Dialog.Question,
                    accept = Config.Dialog.Accept,
                    reject = Config.Dialog.Reject,
                    man = Config.Dialog.Man
                })
                SetNuiFocus(true, true)
            end
        else
            sleep = 1000
        end
        Citizen.Wait(sleep)
    end
end)

function DrawText3D(x, y, z, scale, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	-- local scale = 0.35
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropshadow(0)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 380
        DrawRect(_x, _y + 0.0120, 0.0 + factor, 0.025, 41, 11, 41, 100)
	end
end

RegisterNUICallback('closeMenu', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('accept', function()
    TriggerEvent(Config.Dialog.OnTrigger)
end)

RegisterNUICallback('reject', function()
    TriggerEvent(Config.Dialog.OffTrigger)
end)

RegisterNetEvent('onTrigger')
AddEventHandler('onTrigger', function()
    TriggerEvent('notification', "Doğru cevap!")
end)

RegisterNetEvent('offTrigger')
AddEventHandler('offTrigger', function()
    TriggerEvent('notification', "Yanlış cevap!", 2)
end)