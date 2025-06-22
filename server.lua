if Config.UseNewESX then
	ESX = exports["es_extended"]:getSharedObject()
else 
	ESX = nil 
	TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
	end)
end

RegisterServerEvent("electric:getmoney")
AddEventHandler("electric:getmoney", function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney(Config.Account, Config.Reward)
	local amount = Config.Reward
	if Config.Webhook ~= '' then
		sendwebhook(amount)
	end
end)

sendwebhook = function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local webhook = Config.Webhook
	local information = {
		{
			["color"] = '6684876',
			["author"] = {
				["icon_url"] = 'https://i.ibb.co/DgtFmvr6/ps-logo-1-circle.png',
				["url"] = 'https://discord.com/invite/CUXK7CWx3P',
				["name"] = 'Phoenix Studios',
			},
			
			['url'] = 'https://github.com/xrisingphoenix/esx_electricianjob',
			["title"] = 'Electrician Job',

			["description"] = xPlayer.getName()..' has done the Job and got '..amount..'$',

			["footer"] = {
				["text"] = os.date('%d/%m/%Y [%X] • PHOENIX STUDIOS'),
				["icon_url"] = 'https://i.ibb.co/60rCYFmk/logo2.png',
			}
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = 'PHOENIX STUDIOS', embeds = information, avatar_url = 'https://i.ibb.co/mV504dFz/ps-logo-2-circle.png' }), {['Content-Type'] = 'application/json'}) 
end
