if Config.UseNewESX then
	ESX = exports["es_extended"]:getSharedObject()
else 
	ESX = nil 

	Citizen.CreateThread(function()
		while ESX == nil do 
			TriggerEvent('esx:getSharedObject', function(obj) 
				ESX = obj 
				Citizen.Wait(0)
			end)
		end
	end)
end

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end 
    PlayerData = ESX.GetPlayerData()
end)

function endjob()
	DeleteEntity(vehicle)
	RemoveBlip(missionblip)
	busy = false
	step1 = false
	results = false
	busy3 = false
	step5 = false
end
shownotify2 = false
blipactive = false
busy = false
step1 = false
results = false
busy3 = false
step5 = false
blipactive2 = false


local inminigame = false
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(0)
		for k, v in pairs(Config.StartCoords) do
			local player = PlayerPedId()
			local playercoords = GetEntityCoords(player)
			local distance = GetDistanceBetweenCoords(playercoords, v.start.x , v.start.y, v.start.z)
			if distance < 1.5 then 
				DrawText3D(v.start.x, v.start.y, v.start.z, (Translation[Config.Locale]['ped_interact']))
				if IsControlJustReleased(0, 38) then 
					openmenu(v)
				end
			end
		end
	end
end)

function startjob(v)
	if not busy then 
		busy = true
		blipactive = false
		Config.MSG(Translation[Config.Locale]['started_mission'])
		local car  = GetHashKey(v.vehiclename)
		RequestModel(car)	
		while not HasModelLoaded(car) do 
			RequestModel(car)
			Citizen.Wait(50)
		end 
		vehicle = CreateVehicle(car, v.spawncoords.x, v.spawncoords.y, v.spawncoords.z, v.carheading, true, false)
		SetVehicleLivery(vehicle, 10)
		SetVehicleDirtLevel(vehicle, 0.0)
		Config.Fuel(vehicle)
		--SetPedIntoVehicle(player, vehicle, -1) --uncomment to Spawn the Player into the Vehicle
		SetEntityAsNoLongerNeeded(vehicle)
		SetVehicleNumberPlateText(vehicle, Config.CarPlateName)
		SetEntityAsMissionEntity(vehicle, false, false)
		missionvehicle = vehicle
		Citizen.CreateThread(function()
			while busy do
				Citizen.Wait(0)
				missionvehiclecoords = GetEntityCoords(missionvehicle)
				local playerPed = PlayerPedId()
				playercoords2 = GetEntityCoords(playerPed)
				if not blipactive2 then
					blipactive2 = true
					fahrzeugblip = AddBlipForEntity(missionvehicle)
					SetBlipSprite(fahrzeugblip, 227)
					SetBlipScale(fahrzeugblip, 0.9)
					SetBlipColour(fahrzeugblip, 3)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(Translation[Config.Locale]['car_blipname'])
					EndTextCommandSetBlipName(fahrzeugblip)
				end
				if IsPedInVehicle(playerPed, missionvehicle, false) then 
					RemoveBlip(fahrzeugblip)
					blipactive2 = false
				end
				if not step1 then 
					step1 = true
					results = Config.MissionCoords[math.random(#Config.MissionCoords)]
					Citizen.Wait(5)
				end
				if not blipactive then 
					blipactive = true
					missionblip = AddBlipForCoord(results.x, results.y, results.z)
					SetBlipSprite(missionblip, 1)
					SetBlipScale(missionblip, 0.9)
					SetBlipColour(missionblip, 3)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(Translation[Config.Locale]['target_blip'])
					EndTextCommandSetBlipName(missionblip)
					SetBlipRoute(missionblip, true)
				end
				if step1 then 
					local playerPed = PlayerPedId()
					local vehicle = missionvehicle
					local trunkpos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
					local playerCoords = GetEntityCoords(PlayerPedId())
					local Distance3 = Vdist(playerCoords, trunkpos)
					local dst = GetDistanceBetweenCoords(playercoords2, results.x, results.y, results.z)
					if dst < 15 then
						DrawMarker(21, results.x, results.y, results.z , 0, 0, 0, 0, 0, 0, 0.5,0.5,0.6, 32,186,252, 150, 0, 0, 2, 1, 0, 0, 0)
						if Distance3 < 9 and not IsPedInAnyVehicle(PlayerPedId(), false) then 
							if not busy3 then 
								DrawText3D(trunkpos.x , trunkpos.y, trunkpos.z , Translation[Config.Locale]['take_toolkit'])
								step4 = true
							end
							if Distance3 < 1 then 
								if IsControlJustReleased(0, 38) then 
									busy3 = true
									SetVehicleDoorOpen(missionvehicle, 5, false, false)
									Citizen.Wait(500)
									TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
									Citizen.Wait(2500)
									ClearPedTasksImmediately(PlayerPedId())
									toolkitprop = CreateObject(GetHashKey("imp_prop_tool_box_01a"), 0, 0, 0, true, true, true)
									local prophand = AttachEntityToEntity(toolkitprop, playerPed, GetPedBoneIndex(playerPed, 28422), 0.3700, 0.0200, 0, 90.00, 0, -90.00, true, true, true, false, 1, true)
									SetEntityNoCollisionEntity(toolkitprop, missionvehicle, false)
									RequestAnimDict('move_weapon@jerrycan@generic')
									while not HasAnimDictLoaded('move_weapon@jerrycan@generic') do 
										Citizen.Wait(50)
									end
									TaskPlayAnim(PlayerPedId(), 'move_weapon@jerrycan@generic', 'idle', 8.0, 8.0, -1, 51, 0, 0, 0, 0)
									Citizen.Wait(1000)
									SetVehicleDoorShut(vehicle, 5, false)
									step5 = true 
								end
							end
						end 
						if step4 then 
							if dst < 1.5 then 
								if not shownotify2 then
									shownotify(Translation[Config.Locale]['press_to_start_fixing'])
								end
								if IsControlJustReleased(0, Config.StartKey) then 
									if step5 then
										local distance2 = Vdist(missionvehiclecoords, results.x, results.y, results.z)
										if distance2 < 15 then
											shownotify2 = true
											FreezeEntityPosition(PlayerPedId(), true)
											SetEntityCoords(PlayerPedId(),results.x, results.y, results.z -1.0, true, false, false, false)
											SetEntityHeading(playerPed, results.w)
											DeleteEntity(toolkitprop)
											if Config.UseMiniGame.enable and not inminigame then
												inminigame = true
												local luck = math.random(100)
												if luck > 50 then 
													if inminigame then
														if GetResourceState("mx_fixwiring") == "started"  and Config.UseMiniGame.fixwiring then
															TriggerEvent("Mx::StartMinigameElectricCircuit", '50%', '100%', '0.8', '30vmin', '1.ogg', function(mist)
																if Callback == mist then
																	if inminigame then
																		--Citizen.Wait(5000)
																		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
																		Citizen.Wait(Config.Waittime * 1000)
																		ClearPedTasks(playerPed)
																		Config.MSG(Translation[Config.Locale]['successfully_repaired'])
																		print("case1")
																		RemoveBlip(missionblip)
																		step1 = false
																		busy3 = false
																		step5 = false
																		blipactive = false
																		FreezeEntityPosition(PlayerPedId(), false)
																		Citizen.Wait(1500)
																		TriggerServerEvent("electric:getmoney")
																		showPictureNotification(Translation[Config.Locale]['img'], string.format(Translation[Config.Locale]['message'], Config.Reward), Translation[Config.Locale]['title'], Translation[Config.Locale]['subtitle'])
																		shownotify2 = false
																		inminigame = false
																	end
																else
																	Config.MSG(Translation[Config.Locale]['failed_minigame'])
																	FreezeEntityPosition(PlayerPedId(), false)
																	inminigame = false
																end
															end)
														else 
															--print("MINIGAME: MX_FIXWIRING NOT STARTED!")
															Citizen.Wait(500)
															TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
															Citizen.Wait(Config.Waittime * 1000)
															ClearPedTasks(playerPed)
															Config.MSG(Translation[Config.Locale]['successfully_repaired'])
															print("case2")
															RemoveBlip(missionblip)
															step1 = false
															busy3 = false
															step5 = false
															blipactive = false
															FreezeEntityPosition(PlayerPedId(), false)
															Citizen.Wait(1500)
															TriggerServerEvent("electric:getmoney")
															showPictureNotification(Translation[Config.Locale]['img'], string.format(Translation[Config.Locale]['message'], Config.Reward), Translation[Config.Locale]['title'], Translation[Config.Locale]['subtitle'])
															shownotify2 = false
															inminigame = false
														end
													end
												else 
													if inminigame then
														if GetResourceState("datacrack") == "started" and Config.UseMiniGame.datacrack then
															TriggerEvent("datacrack:start", 3, function(output)
																if output == true then
																	if inminigame then
																		DeleteEntity(toolkitprop)
																		Citizen.Wait(500)
																		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
																		Citizen.Wait(Config.Waittime * 1000)
																		ClearPedTasks(playerPed)
																		Config.MSG(Translation[Config.Locale]['successfully_repaired'])
																		print("case3")
																		RemoveBlip(missionblip)
																		step1 = false
																		busy3 = false
																		step5 = false
																		blipactive = false
																		FreezeEntityPosition(PlayerPedId(), false)
																		Citizen.Wait(1500)
																		TriggerServerEvent("electric:getmoney")
																		showPictureNotification(Translation[Config.Locale]['img'], string.format(Translation[Config.Locale]['message'], Config.Reward), Translation[Config.Locale]['title'], Translation[Config.Locale]['subtitle'])
																		shownotify2 = false
																		inminigame = false
																	end
																else
																	Config.MSG(Translation[Config.Locale]['failed_minigame'])
																	FreezeEntityPosition(PlayerPedId(), false)
																	inminigame = false
																end
															end)
														else 
															--print("MINIGAME: DATACRACK NOT STARTED!")
															Citizen.Wait(500)
															TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
															Citizen.Wait(Config.Waittime * 1000)
															ClearPedTasks(playerPed)
															Config.MSG(Translation[Config.Locale]['successfully_repaired'])
															print("case4")
															RemoveBlip(missionblip)
															step1 = false
															busy3 = false
															step5 = false
															blipactive = false
															FreezeEntityPosition(PlayerPedId(), false)
															Citizen.Wait(1500)
															TriggerServerEvent("electric:getmoney")
															showPictureNotification(Translation[Config.Locale]['img'], string.format(Translation[Config.Locale]['message'], Config.Reward), Translation[Config.Locale]['title'], Translation[Config.Locale]['subtitle'])
															shownotify2 = false
															inminigame = false
														end
													end
												end
											else 
												Citizen.Wait(500)
												TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
												Citizen.Wait(Config.Waittime * 1000)
												ClearPedTasks(playerPed)
												Config.MSG(Translation[Config.Locale]['successfully_repaired'])
												RemoveBlip(missionblip)
												step1 = false
												busy3 = false
												step5 = false
												blipactive = false
												FreezeEntityPosition(PlayerPedId(), false)
												Citizen.Wait(1500)
												TriggerServerEvent("electric:getmoney")
												showPictureNotification(Translation[Config.Locale]['img'], string.format(Translation[Config.Locale]['message'], Config.Reward), Translation[Config.Locale]['title'], Translation[Config.Locale]['subtitle'])
												shownotify2 = false
												inminigame = false
											end

										else 
											Config.MSG(Translation[Config.Locale]['vehicle_not_in_range'])
										end
									else 
										Config.MSG(Translation[Config.Locale]['toolkit_needed'])
									end
								end
							end						
						end
					end
				end
			end 
		end)
	else 
		Config.MSG(Translation[Config.Locale]['already_startet_mission'])
	end
end 

function openmenu(data)
	local hasjob = false
    if not Config.Job.enable then 
        hasjob = true 
    else 
        if Config.Job.name == ESX.PlayerData.job.name then 
            hasjob = true 
        end
    end
	if hasjob then
		lib.registerContext({
			id = 'electric_1', 
			title = Translation[Config.Locale]['lib_title_menu'],
			icon = 'user',
			options = {
				{
					icon = 'fa-solid fa-bolt',
					iconColor = 'cyan',
					title = Translation[Config.Locale]['lib_start_job'],
					description = Translation[Config.Locale]['lib_start_job_desc'],
					arrow = true,
					onSelect = function()
						startjob(data)
					end, 
				},
				{
					icon = 'fa-solid fa-ban',
					iconColor = 'red',
					title = Translation[Config.Locale]['lib_end_job'],
					readOnly = false,
					description = Translation[Config.Locale]['lib_end_job_desc'],
					arrow = true,
					onSelect = function()
						if busy then
							Config.MSG(Translation[Config.Locale]['canceled_mission'])
							endjob()
						else 
							Config.MSG(Translation[Config.Locale]['no_current_mission'])
						end
					end,
				},
				{
					icon = 'fa-solid fa-shirt',
					iconColor = 'green',
					title = Translation[Config.Locale]['lib_clothing_menu'],
					description = Translation[Config.Locale]['lib_clothing_menu_desc'],
					arrow = true,
					onSelect = function()
						applyclothing()
					end, 
				},
			}
		})
		lib.showContext('electric_1')
	else 
		Config.MSG(Translation[Config.Locale]['dont_have_job'])
	end
end

function applyclothing()
    local playerPed = PlayerPedId()
    RequestAnimDict("clothingshirt")
    while not HasAnimDictLoaded("clothingshirt") do 
        Citizen.Wait(25)
    end 
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 1.0, -1.0, -1, 1, 1, true, true, true)
    Citizen.Wait(2000)
    ClearPedTasks(playerPed)
    if not clothing then
        clothing = true
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            if skin.sex == 0 then
                SetPedComponentVariation(playerPed, 11, Config.Clothing['male']['Torso'].id , Config.Clothing['male']['Torso'].txt , 2)  -- Torso
                SetPedComponentVariation(playerPed, 8, Config.Clothing['male']['TShirt'].id , Config.Clothing['male']['TShirt'].txt , 2) -- Shirt
                SetPedComponentVariation(playerPed, 3, Config.Clothing['male']['Arms'].id , Config.Clothing['male']['Arms'].txt , 2) -- Arms
                SetPedComponentVariation(playerPed, 4, Config.Clothing['male']['Pants'].id , Config.Clothing['male']['Pants'].txt , 2) -- Pants
                SetPedComponentVariation(playerPed, 6, Config.Clothing['male']['Shoes'].id , Config.Clothing['male']['Shoes'].txt , 2) -- Shoes
                SetPedPropIndex(playerPed, 0, Config.Clothing['male']['Hat'].id , Config.Clothing['male']['Hat'].txt, true) -- Hat
            else 
                SetPedComponentVariation(playerPed, 11, Config.Clothing['female']['Torso'].id , Config.Clothing['female']['Torso'].txt , 2)  -- Torso
                SetPedComponentVariation(playerPed, 8, Config.Clothing['female']['TShirt'].id , Config.Clothing['female']['TShirt'].txt , 2) -- Shirt
                SetPedComponentVariation(playerPed, 3, Config.Clothing['female']['Arms'].id , Config.Clothing['female']['Arms'].txt , 2) -- Arms
                SetPedComponentVariation(playerPed, 4, Config.Clothing['female']['Pants'].id , Config.Clothing['female']['Pants'].txt , 2) -- Pants
                SetPedComponentVariation(playerPed, 6, Config.Clothing['female']['Shoes'].id , Config.Clothing['female']['Shoes'].txt , 2) -- Shoes
                SetPedPropIndex(playerPed, 0, Config.Clothing['female']['Hat'].id , Config.Clothing['female']['Hat'].txt, true) -- Hat
            end 
        end)
    else 
        clothing = false
        resetclothes()
    end
    lib.showContext('electric_1')
end

function resetclothes()
    TriggerEvent('skinchanger:getSkin', function(skin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

Citizen.CreateThread(function()
    for k, v in pairs(Config.StartCoords) do
        RequestModel(GetHashKey(v.pedname))
        while not HasModelLoaded(GetHashKey(v.pedname)) do
            Wait(1)
        end
        RequestAnimDict("oddjobs@assassinate@guard")
        while not HasAnimDictLoaded("oddjobs@assassinate@guard") do
            Wait(1)
        end
        local ped =  CreatePed(4, v.pedname, v.start.x, v.start.y, v.start.z -1.0, v.heading, false, false)
        SetEntityHeading(ped, v.heading)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,"oddjobs@assassinate@guard","unarmed_fold_arms", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if busy and DoesEntityExist(toolkitprop) then 
			SetEntityNoCollisionEntity(toolkitprop, GetVehiclePedIsIn(PlayerPedId(), false), false)
		end
	end
end)

Citizen.CreateThread(function()
	for k, v in pairs(Config.StartCoords) do 		
		local kartenblip = AddBlipForCoord(v.start.x, v.start.y, v.start.z)
		SetBlipSprite(kartenblip, 620)
		SetBlipScale(kartenblip, 0.8)
		SetBlipColour(kartenblip, 3)
		SetBlipAsShortRange(kartenblip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Translation[Config.Locale]['blipname'])
		EndTextCommandSetBlipName(kartenblip)
	end
end)

function showPictureNotification(icon, msg, title, subtitle)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg);
    SetNotificationMessage(icon, icon, true, 1, title, subtitle);
    DrawNotification(false, true);
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

function shownotify(msg)
	CurrentActionMsg  = msg
	SetTextComponentFormat('STRING')
	AddTextComponentString(CurrentActionMsg)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end 

AddEventHandler('onResourceStop', function(ressourceName)
    if(GetCurrentResourceName() == ressourceName) then  
        DeleteVehicle(missionvehicle)
		DeleteEntity(toolkitprop)
		endjob()
    end
end)