Config = {}

Config.Locale = 'en'

Config.Webhook = ''

Config.Account = 'money' -- 'bank' , 'black_money'

Config.Reward = 300 -- The Reward for each Device you repaired

Config.CarPlateName = 'ELECTRIC' -- The Name of the Vehicle Plate

Config.Waittime = 5 -- The Wait Time in Seconds that the Player have to wait after Minigame

Config.ToolKitTrunk = false --- !! set to true if the text doesnt show up with "take toolkit"

Config.UseMiniGame = {
	enable = true, -- Enable / Disable Minigames
	fixwiring = true,-- https://github.com/mxlolshop/minigameFixWiring/
	datacrack = true -- https://github.com/utkuali/datacrack
}

Config.Job = {
    enable = false,
    name = 'trasher'
}

Config.UseNewESX = true

Config.StartKey = 47 --G Key to start for Repairing the Device

Config.MSG = function(msg)
    ESX.ShowNotification(msg) 
    --exports['okokNotify']:Alert("Electrician Job", msg, 3000, 'info') 
    --If you use okokNotify, uncomment this or use your own Notify Script
end

Config.Fuel = function(vehicle)
	-- exports['LegacyFuel']:SetFuel(vehicle, 100) -- Add Fuel
end

Config.StartCoords = {
	{
		start =   vector3(736.9824, 134.1126, 80.7281),
		spawncoords =   vector3(742, 127, 79),
		carheading = 244.45,
		pedname = 's_m_m_gaffer_01',
		heading = 233.7677,
		vehiclename = 'nspeedo',
	},
	{
		start =   vector3(450.5395, -1981.6654, 24.4017), 
		spawncoords =   vector3(454.0340, -1967.2224, 22.9558),
		carheading = 177.8880,
		pedname = 's_m_m_gaffer_01', 
		heading = 181.0699,
		vehiclename = 'nspeedo',
	}
	--[[
		{
			start =   vector3(0,0,0), 
			spawncoords =   vector3(0,0,0),
			carheading =  0.0,
			pedname = 'pedname', 
			heading = 0.0,
			vehiclename = 'vehiclespawnname',
		}
	]]
}

Config.Clothing = {
    ["male"] = {
        ["Torso"] = { id = 71, txt = 0},
        ["TShirt"] = { id = 155, txt = 0},
        ["Arms"] = { id = 66, txt = 0},
        ["Pants"] = { id = 53, txt = 0},
        ["Shoes"] = { id = 27, txt = 0},
        ["Hat"] = { id = 5, txt = 0},
    },
    ["female"] = {
        ["Torso"] = { id = 67, txt = 0},
        ["TShirt"] = { id = 191, txt = 0},
        ["Arms"] = { id = 75, txt = 0},
        ["Pants"] = { id = 55, txt = 0},
        ["Shoes"] = { id = 26, txt = 0},
        ["Hat"] = { id = 5, txt = 0},
    }
}

Config.MissionCoords = {
	vector4(758.71, 136.91, 78.94, 63.04),
	vector4(705.6367, 58.8237, 83.8642, 57.3731),
	vector4(534.3323, 64.3275, 96.2131, 339.4230),
	vector4(351.8224, -224.1157, 54.8941, 68.0866),
	vector4(287.4722, -443.9739, 43.6027, 82.6229),
	vector4(215.2995, -651.6578, 38.5628, 252.1793),
	vector4(171.3939, -767.0478, 32.2576, 66.2343),
	vector4(145.4662, -825.2324, 31.1370, 338.5786),
	vector4(100.5653, -969.2227, 29.3729, 243.1537),
	vector4(138.0711, -1027.7700, 29.3535, 350.2804),
	vector4(195.3668, -801.1793, 31.2464, 81.8623),
	vector4(101.0982, -1082.7650, 29.1924, 159.3599),
	vector4(-295.5944, -645.4796, 33.1992, 181.8663),
	vector4(-517.7743, -860.3887, 30.0168, 80.5083),
	vector4(-547.1727, -942.7381, 23.7900, 62.2609),
	vector4(-614.5042, -942.8254, 21.9555, 272.5279),
	vector4(391.6350, -998.5460, 29.4171, 265.0184),
	vector4(679.7724, -32.8730, 82.9715, 42.1984),
	vector4(891.1613, 41.8322, 78.7264, 233.6204),
	vector4(857.2255, -140.1125, 78.7231, 60.5349),
	vector4(147.6695, -1035.4513, 29.3431, 164.4883),
	vector4(295.5568, -896.0820, 29.2120, 252.0555),
	vector4(214.1687, -853.6418, 30.3870, 339.4955),
	vector4(301.1392, -1269.1143, 29.5181, 6.5780),
	vector4(-609.5130, -1091.6191, 22.3248, 132.9999),
	vector4(875.4760, -2092.6594, 30.5137, 175.3683),
	vector4(-32.9868, -1106.1160, 27.2744, 253.7646),
	vector4(-544.8131, -158.9713, 38.4763, 20.1898),
	vector4(-800.2009, -106.3099, 37.5652, 29.4009),
	vector4(-1231.0833, -327.7384, 37.4014, 26.7014),
}


Translation = {
    ['de'] = {
        ['ped_interact'] = '~g~[E]~s~ Interagieren',

        ['already_startet_mission'] = 'Du hast bereits den Job gestartet',
		['started_mission'] = 'Du hast den Job gestartet',
        ['canceled_mission'] = 'Du hast den Job beendet',
        ['no_current_mission'] = 'Es ist aktuell kein Job aktiv',
        ['car_blipname'] = 'Fahrzeug',
		['target_blip'] = 'ZielOrt',
		['blipname'] = 'Elektriker Job',
		['take_toolkit'] = 'Drücke ~g~[E]~s~ um das Werkzeug herauszuholen',
        ['press_to_start_fixing'] = 'Drücke ~INPUT_DETONATE~ um zu beginnen',
        ['successfully_repaired'] = 'Du hast das Gerät erfolgreich repariert',

		--Picture Notify
		['img'] = 'CHAR_CHEF',
		['message'] = 'Du hast ~g~%s$~s~ erhalten. Weiter so!',
		['title'] = 'Chef',
		['subtitle'] = 'Belohnung erhalten',

		['failed_minigame'] = 'Diagnose Fehlgeschlagen. Neustart erforderlich',
		['vehicle_not_in_range'] = 'Dein Fahrzeug ist nicht in der Nähe',
		['toolkit_needed'] = 'Du brauchst noch dein Werkzeug',

		['lib_title_menu'] = 'Elektriker Job',
		['lib_start_job'] = 'Starte Job',
		['lib_start_job_desc'] = 'Wähle eine Route',


		['lib_clothing_menu'] = 'Wechsel deine Kleidung',
		['lib_clothing_menu_desc'] = 'Wechsel deine Kleidung zum Job Outfit',

		['lib_end_job'] = 'Job beenden',
		['lib_end_job_desc'] = 'Beende den Job',

		['dont_have_job'] = 'Du hast nicht den Job dafür',




    },

    ['en'] = {
		['ped_interact'] = '~g~[E]~s~ Interact',
        ['already_startet_mission'] = 'You already started the Job',
		['started_mission'] = 'You started the Job',
        ['canceled_mission'] = 'You canceled the Job',
		['no_current_mission'] = 'You did not start the Job yet',
        ['car_blipname'] = 'Car',
		['target_blip'] = 'Target',
		['blipname'] = 'Electrician Job',
		['take_toolkit'] = 'Press ~g~[E]~s~ to take the Toolkit',
        ['press_to_start_fixing'] = 'Press ~INPUT_DETONATE~ to start',
        ['successfully_repaired'] = 'You successfully repaired the Device',

		--Picture Notify{
		['img'] = 'CHAR_CHEF',
		['message'] = 'You received ~g~%s$~s~. Good Job!',
		['title'] = 'Chef',
		['subtitle'] = 'Received Reward',

		['failed_minigame'] = 'Diagnosis failed. Reboot required.',
		['vehicle_not_in_range'] = 'Your Vehicle is not in Range',
		['toolkit_needed'] = 'You need your Toolkit',

		['lib_title_menu'] = 'Electric Job',
		['lib_start_job'] = 'Start Job',
		['lib_start_job_desc'] = 'Start the Job',
		
		['lib_clothing_menu'] = 'Change youre Clothing',
		['lib_clothing_menu_desc'] = 'Change to Job Outfit',

		['lib_end_job'] = 'End Job',
		['lib_end_job_desc'] = 'End the Job',

		['dont_have_job'] = 'You dont have the correct Job',
    },
	
    ['es'] = {
		['ped_interact'] = '~g~[E]~s~ Interactuar',
		['no_current_mission'] = 'Actualmente no hay ningún trabajo activo',

        ['already_startet_mission'] = 'Usted ya ha empezado el trabajo',
		['started_mission'] = 'Has empezado el trabajo',
        ['canceled_mission'] = 'Has cancelado el trabajo',
        ['car_blipname'] = 'Coche',
		['target_blip'] = 'Objetivo',
		['blipname'] = 'Trabajo de electricista',
		['take_toolkit'] = 'Presiona ~g~[E]~s~ para equipar el kit de herramientas',
        ['press_to_start_fixing'] = 'Presiona ~INPUT_DETONATE~ para empezar',
        ['successfully_repaired'] = 'Has reparado exitosamente el dispositivo',

		--Picture Notify{
		['img'] = 'CHAR_CHEF',
		['message'] = 'Has recivido ~g~%s$~s~. ¡Buen trabajo!',
		['title'] = 'Chef',
		['subtitle'] = 'Recompensa recivida',


		['failed_minigame'] = 'Diagnóstico fallido. Reinicio requerido.',
		['vehicle_not_in_range'] = 'Tu vehículo no está en el rango',
		['toolkit_needed'] = 'Necesitas tu kit de herramientas',

		['lib_title_menu'] = 'Electric-Job',
		['lib_start_job'] = 'Iniciar trabajo',
		['lib_start_job_desc'] = 'Iniciar el trabajo',

		['lib_clothing_menu'] = 'Cambiar tu ropa',
		['lib_clothing_menu_desc'] = 'Cambiar al uniforme de trabajo',

		['lib_end_job'] = 'Finalizar trabajo',
		['lib_end_job_desc'] = 'Finalizar el trabajo',

		['dont_have_job'] = 'No tienes el trabajo adecuado',

    }

}
