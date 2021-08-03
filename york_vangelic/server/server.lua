local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
VTunnel = {}
Tunnel.bindInterface("york_vangelic",VTunnel)

-- ESX.RegisterServerCallback('artheist:server:checkRobTime', function(source, cb)
--     local src = source
--     local player = ESX.GetPlayerFromId(src)
    
--     if (os.time() - lastrob) < Config['ArtHeist']['nextRob'] and lastrob ~= 0 then
--         local seconds = Config['ArtHeist']['nextRob'] - (os.time() - lastrob)
--         player.showNotification(Strings['wait_nextrob'] .. ' ' .. math.floor(seconds / 60) .. ' ' .. Strings['minute'])
--         cb(false)
--     else
--         lastrob = os.time()
--         cb(true)
--     end
-- end)

RegisterServerEvent('artheist:server:syncHeistStart')
AddEventHandler('artheist:server:syncHeistStart', function()
    TriggerClientEvent('artheist:client:syncHeistStart', -1)
end)

RegisterServerEvent('artheist:server:syncPainting')
AddEventHandler('artheist:server:syncPainting', function(x)
    TriggerClientEvent('artheist:client:syncPainting', -1, x)
end)

RegisterServerEvent('artheist:server:syncAllPainting')
AddEventHandler('artheist:server:syncAllPainting', function()
    TriggerClientEvent('artheist:client:syncAllPainting', -1)
end)

RegisterServerEvent('artheist:server:rewardItem')
AddEventHandler('artheist:server:rewardItem', function(scene)
    local _source = source
    local user_id = vRP.getUserId(_source)
    if user_id then 
        local item = scene['rewardItem']

        vRP.giveInventoryItem(
            user_id,
            item,
            1
        )
    end
end)

RegisterServerEvent('artheist:server:finishHeist')
AddEventHandler('artheist:server:finishHeist', function()
    local _source = source
    local user_id = vRP.getUserId(_source)

    if user_id then
        for k, v in pairs(Config['ArtHeist']['painting']) do
            local count = vRP.getInventoryItemAmount(v['rewardItem']).count
            if vRP.tryGetInventoryItem(user_id, v['rewardItem'].count, 1) then 
                vRP.giveInventoryItem(
                    user_id,
                    'dollars2',
                    v['paintingPrice']
                )
            end
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timers = 0
local andamento = false
local roubando = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function VTunnel.checkJewelry()
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = System['user_perms']
	if user_id then
		if #policia <= parseInt(System['number_of_cops']) then
			TriggerClientEvent(
				"Notify",
				source,
				"aviso",
				Strings['insufficient_cops_amount'],
				3000
			)
		elseif (os.time()-timers) <= parseInt(System['jewelry_respawn_timer']) then
			TriggerClientEvent(
				"Notify",
				source,
				"aviso",
				"A <b>joalheria</b> não se recuperou do ultimo <b>roubo</b>, aguarde <b>"..vRP.format(parseInt((parseInt(System['jewelry_respawn_timer'])-(os.time()-timers)))).." segundos</b> até que o sistema seja <b>restaurado</b>.",
				3000
			)
		else
			return true
		end
	end
	return false
end

RegisterNetEvent("jewelrystart")
AddEventHandler("jewelrystart",function()
	timers = os.time()
	andamento = true
	TriggerClientEvent('iniciandojewelry',source,x,y,z,h,sec,tipo,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function VTunnel.callPolice(x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent(
		"vrp_sound:fixed",
		-1,
		source,
		x,
		y,
		z,
		100,
		'alarm',
		0.1
	)

	local policia = System['user_perms']
	for l,w in pairs(policia) do
		local player = vRP.getUserSource(parseInt(w))
		if player then
			async(function()
				local ids = idgens:gen()
				vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
				blips[ids] = vRPclient.addBlip(
					player,
					x,
					y,
					z,
					1,
					59,
					"Roubo a Joalheria",
					0.5,
					true
				)
				TriggerClientEvent(
					'chatMessage',
					player,
					"911",
					{65,130,255},
					String['get_them']
				)
				SetTimeout(
					60000,
					function() vRPclient.removeBlip(
						player,blips[ids]
					) 
					idgens:free(ids) 
				end)
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RETURNJEWELRY
-----------------------------------------------------------------------------------------------------------------------------------------
function VTunnel.returnJewelry()
	return andamento
end

function VTunnel.returnJewelry2()
	return roubando
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				timers = {}
				andamento = false
				roubando = false
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("jewelrysetmodel")
AddEventHandler("jewelrysetmodel",function(x,y,z,prop1,prop2)
	TriggerClientEvent("jewelrysetmodel",-1,x,y,z,prop1,prop2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKJEWELS
-----------------------------------------------------------------------------------------------------------------------------------------
function VTunnel.checkJewels(id,x,y,z,xplayer,yplayer,zplayer,heading,prop1,prop2,tipo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if timers[id] == 0 or not timers[id] then
			timers[id] = 600
			TriggerClientEvent(
				'jewelryroubo',
				source,
				6,
				tipo,
				true,
				x,
				y,
				z,
				prop1,
				prop2,
				id
			)
			local quantidade = math.random(1,3)
			local joia = Itens[math.random(5)]
			if id == 4 or id == 13 or id == 14 or id == 17 then
			    SetTimeout(2000,function()
				    vRPclient.setStandBY(source,parseInt(60))
				    Give_item(user_id)
				    TriggerClientEvent(
						"Notify",
						source,
						"sucesso",
						"Roubou <b>"..quantidade.."x "..joia.nome.."</b>"
					)
			    end)
			else
				SetTimeout(3100,function()
				    vRPclient.setStandBY(source,parseInt(60))
				    Give_item()
				    TriggerClientEvent(
						"Notify",
						source,
						"sucesso",
						"Roubou <b>"..quantidade.."x "..joia.nome.."</b>"
					)
			    end)
			end
		else
			TriggerClientEvent(
				"Notify",
				source,
				"aviso",
				"O balcão está vazio, aguarde <b>"..vRP.format(parseInt(timers[id])).." segundos</b> até que a loja se recupera do ultimo <b>roubo</b>."
			)
		end
	end
end

function VTunnel.givePainting(int)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		Give_Painting(user_id,int)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETOLDMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function VTunnel.returnJewels(id,x,y,z,prop1,prop2)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if timers[id] == 0 or not timers[id] and contagem == 0 then
			
			contagem = 600
	    end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMECONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local contagem = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if contagem >= 1 then
			contagem = contagem - 1
			if contagem <= 0 then
				contagem = false
			end
		end
	end
end)
