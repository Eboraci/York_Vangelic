local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
VTunnel = Tunnel.getInterface("york_vangelic")
vRP = Proxy.getInterface("vRP")
--https://github.com/eboraci
--York#2030
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local hasRobberyStarted = false
local tipo = 0
local segundos = 0
local statuses = false
local paintingsRobbed = 0
local isAllPaintingsRobbed = false 
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1 , ['x'] = -626.3253 , ['y'] = -239.0511 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab2_end" , ['prop1'] = "des_jewel_cab2_start", ['xplayer'] = -626.80908203125, ['yplayer'] = -238.34339904785, ['zplayer'] = 38.057006835938, ['heading'] = 221.73 },
	{ ['id'] = 2 , ['x'] = -625.2751 , ['y'] = -238.2881 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -625.80285644531, ['yplayer'] = -237.60856628418, ['zplayer'] = 38.056999206543, ['heading'] = 221.73 },
	{ ['id'] = 3 , ['x'] = -626.5439 , ['y'] = -233.6047 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -627.08929443359, ['yplayer'] = -232.89517211914, ['zplayer'] = 38.057006835938, ['heading'] = 221.73 }, 
	{ ['id'] = 4 , ['x'] = -626.1613 , ['y'] = -234.1315 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab4_end" , ['prop1'] = "des_jewel_cab4_start", ['xplayer'] = -625.57720947266, ['yplayer'] = -234.80921936035, ['zplayer'] = 38.057010650635, ['heading'] = 31.56 },
	{ ['id'] = 5 , ['x'] = -627.2115 , ['y'] = -234.8942 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -626.64904785156, ['yplayer'] = -235.61465454102, ['zplayer'] = 38.05700302124, ['heading'] = 31.56 },
	{ ['id'] = 6 , ['x'] = -619.8483 , ['y'] = -234.9137 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -620.44061279297, ['yplayer'] = -234.19891357422, ['zplayer'] = 38.056999206543, ['heading'] = 221.73 },
	{ ['id'] = 7 , ['x'] = -617.0856 , ['y'] = -230.1627 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab2_end" , ['prop1'] = "des_jewel_cab2_start", ['xplayer'] = -617.83697509766, ['yplayer'] = -230.68539428711, ['zplayer'] = 38.057006835938, ['heading'] = 306.23 },
	{ ['id'] = 8 , ['x'] = -617.8492 , ['y'] = -229.1128 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -618.51141357422, ['yplayer'] = -229.69427490234, ['zplayer'] = 38.056999206543, ['heading'] = 306.23 },
	{ ['id'] = 9 , ['x'] = -621.5175 , ['y'] = -228.9474 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -620.89727783203, ['yplayer'] = -228.3892364502, ['zplayer'] = 38.057006835938, ['heading'] = 127.12 },
	{ ['id'] = 10 , ['x'] = -619.9662 , ['y'] = -226.198 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -620.61871337891, ['yplayer'] = -226.81732177734, ['zplayer'] = 38.057006835938, ['heading'] = 306.23 },
	{ ['id'] = 11 , ['x'] = -625.3300 , ['y'] = -227.3697 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -624.95703125, ['yplayer'] = -228.04200744629, ['zplayer'] = 38.057010650635, ['heading'] = 31.56 },
	{ ['id'] = 12 , ['x'] = -623.6147 , ['y'] = -228.6247 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab2_end" , ['prop1'] = "des_jewel_cab2_start", ['xplayer'] = -624.16003417969, ['yplayer'] = -227.90766906738, ['zplayer'] = 38.057006835938, ['heading'] = 221.73 },
	{ ['id'] = 13 , ['x'] = -623.9558 , ['y'] = -230.7263 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab4_end" , ['prop1'] = "des_jewel_cab4_start", ['xplayer'] = -624.64788818359, ['yplayer'] = -231.24926757813, ['zplayer'] = 38.057006835938, ['heading'] = 306.23 },
	{ ['id'] = 14 , ['x'] = -624.2796 , ['y'] = -226.6066 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab4_end" , ['prop1'] = "des_jewel_cab4_start", ['xplayer'] = -623.79742431641, ['yplayer'] = -227.30368041992, ['zplayer'] = 38.05700302124, ['heading'] = 31.56 },
	{ ['id'] = 15 , ['x'] = -619.2031 , ['y'] = -227.2482 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab2_end" , ['prop1'] = "des_jewel_cab2_start", ['xplayer'] = -619.91357421875, ['yplayer'] = -227.81005859375, ['zplayer'] = 38.057006835938, ['heading'] = 306.23 },
	{ ['id'] = 16 , ['x'] = -620.1764 , ['y'] = -230.7865 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -619.44543457031, ['yplayer'] = -230.30876159668, ['zplayer'] = 38.057022094727, ['heading'] = 127.12 },
	{ ['id'] = 17 , ['x'] = -620.5214 , ['y'] = -232.8823 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab4_end" , ['prop1'] = "des_jewel_cab4_start", ['xplayer'] = -620.04870605469, ['yplayer'] = -233.48422241211, ['zplayer'] = 38.057006835938, ['heading'] = 31.56 },
	{ ['id'] = 18 , ['x'] = -622.6159 , ['y'] = -232.5636 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -623.3056640625, ['yplayer'] = -233.11682128906, ['zplayer'] = 38.057010650635, ['heading'] = 306.23 },
	{ ['id'] = 19 , ['x'] = -627.5945 , ['y'] = -234.3678 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab_end" , ['prop1'] = "des_jewel_cab_start", ['xplayer'] = -628.11602783203, ['yplayer'] = -233.64642333984, ['zplayer'] = 38.057010650635, ['heading'] = 221.73 },
	{ ['id'] = 20 , ['x'] = -618.7984 , ['y'] = -234.1509 , ['z'] = 37.64523 , ['prop2'] = "des_jewel_cab3_end" , ['prop1'] = "des_jewel_cab3_start", ['xplayer'] = -619.36053466797, ['yplayer'] = -233.41262817383, ['zplayer'] = 38.057014465332, ['heading'] = 221.73 }
}

Config = {}
Config['ArtHeist'] = {
    ['nextRob'] = 1800, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(244.346, 374.012, 105.738),
        peds = {
            {pos = vector3(244.346, 374.012, 105.738), heading = 156.39, ped = 's_m_m_highsec_01'},
            {pos = vector3(243.487, 372.176, 105.738), heading = 265.63, ped = 's_m_m_highsec_02'},
            {pos = vector3(245.074, 372.730, 105.738), heading = 73.3, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['sellPainting'] ={ -- sell painting coords
        pos = vector3(288.558, -2981.1, 5.90696),
        peds = {
            {pos = vector3(288.558, -2981.1, 5.90696), heading = 135.88, ped = 's_m_m_highsec_01'},
            {pos = vector3(287.190, -2980.9, 5.72252), heading = 218.0, ped = 's_m_m_highsec_02'},
            {pos = vector3(287.731, -2982.6, 5.82852), heading = 336.08, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintinge', -- u need add item to database
            paintingPrice = '300', -- price of the reward item for sell
            scenePos = vector3(-626.70, -228.3, 38.06), -- animation coords
            sceneRot = vector3(0.0, 0.0, 90.0), -- animation rotation
            object = 'ch_prop_vault_painting_01e', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(-627.20, -228.31, 38.06), -- object spawn coords
            objHeading = 94.75 -- object spawn heading
        },
        {
            rewardItem = 'paintingi',
            paintingPrice = '300', 
            scenePos = vector3(-622.97, -225.64, 38.06), 
            sceneRot = vector3(0.0, 0.0, -20.0),
            object = 'ch_prop_vault_painting_01i', 
            objectPos = vector3(-622.80, -225.14, 38.06), 
            objHeading = 345.85
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '300', 
            scenePos = vector3(-617.48, -233.22, 38.06), 
            sceneRot = vector3(0.0, 0.0, -90.0),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(-617.00, -233.22, 38.06), 
            objHeading = 269.53
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '300', 
            scenePos = vector3(-621.25, -235.78, 38.06), 
            sceneRot = vector3(0.0, 0.0, 160.0),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(-621.25, -236.38, 38.06), 
            objHeading = 161.22
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '300', 
            scenePos = vector3(1397.586, 1165.579, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 90.0),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(1397.136, 1165.579, 114.5336), 
            objHeading = 90.0
        },
        {
            rewardItem = 'paintingg',
            paintingPrice = '300', 
            scenePos = vector3(1397.976, 1165.679, 113.4136), 
            sceneRot = vector3(0.0, 0.0, 0.0),
            object = 'ch_prop_vault_painting_01g', 
            objectPos = vector3(1397.936, 1166.079, 114.5336), 
            objHeading = 0.0
        },
    },
    ['objects'] = { -- dont change (required)
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { -- dont change (required)
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
}


ArtHeist = {
    ['start'] = false,
    ['cuting'] = false,
    ['startPeds'] = {},
    ['sellPeds'] = {},
    ['cut'] = 0,
    ['objects'] = {},
    ['scenes'] = {},
    ['painting'] = {}
}


Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        local sleep = 1000
        local startRobb = Locations['robbery_start']
        local heistDist = #(pedCo - startRobb)
        if heistDist <= 3.0 and not hasRobberyStarted then
            sleep = 1
            DrawText3Ds(
                startRobb.x,
                startRobb.y,
                startRobb.z,
                Strings['start_robbery']
            )
            if IsControlJustPressed(0, 38) then
                if VTunnel.checkJewelry() then
                    hasRobberyStarted = true
                    StartHeist()
                    TriggerEvent(
                        'Notify',
                        'importante',
                        Strings['robbery_started'],
                        3000
                    )
                end
            end
        end
        if ArtHeist['start'] then
            for k, v in pairs(Config['ArtHeist']['painting']) do
                local dist = #(pedCo - v['scenePos'])
                if dist <= 1.0 then
                    sleep = 1
                    if not v['taken'] then
                        SendNotification({
                            text = Strings['start_stealing'],
                            type = 'topLeft',
                            timeout = 6000,
                        })
                        if IsControlJustPressed(0, 38) then
                            if not ArtHeist['cuting'] then
                                HeistAnimation(k)
                            else
                                TriggerEvent(
                                    'Notify',
                                    'importante',
                                    Strings['already_cuting']
                                )
                            end
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

RegisterNetEvent('artheist:client:syncHeistStart')
AddEventHandler('artheist:client:syncHeistStart', function()
    ArtHeist['start'] = not ArtHeist['start']
end)

RegisterNetEvent('artheist:client:syncPainting')
AddEventHandler('artheist:client:syncPainting', function(x)
    Config['ArtHeist']['painting'][x]['taken'] = true
end)

RegisterNetEvent('artheist:client:syncAllPainting')
AddEventHandler('artheist:client:syncAllPainting', function(x)
    for k, v in pairs(Config['ArtHeist']['painting']) do
        v['taken'] = false
    end
end)

function FinishHeist()
    TriggerServerEvent('artheist:server:finishHeist')
    hasRobberyStarted = false
end

function StartHeist()
    if ArtHeist['start'] then 
        TriggerEvent(
            'Notify',
            'importante',
            Strings['already_heist']
        ) 
        return
    end
    for k, v in pairs(ArtHeist['startPeds']) do
        TaskTurnPedToFaceEntity(v, PlayerPedId(), 1000)
    end
    local paintingList = {}
    for k, v in pairs(Config['ArtHeist']['painting']) do
        table.insert(paintingList, {v['object']})
    end
    TriggerServerEvent('artheist:server:syncHeistStart')
    for k, v in pairs(Config['ArtHeist']['painting']) do
        loadModel(v['object'])
        ArtHeist['painting'][k] = CreateObjectNoOffset(GetHashKey(v['object']), v['objectPos'], 1, 1, 0)
        SetEntityRotation(ArtHeist['painting'][k], 0, 0, v['objHeading'], 2, true)
    end
end

function HeistAnimation(sceneId)
    local ped = PlayerPedId()
    local pedCo, pedRotation = GetEntityCoords(ped), vector3(0.0, 0.0, 0.0)
    local scenes = {false, false, false, false}
    local animDict = "anim_heist@hs3f@ig11_steal_painting@male@"
    local scene = Config['ArtHeist']['painting'][sceneId]
    TriggerServerEvent('artheist:server:syncPainting', sceneId)
    loadAnimDict(animDict)
    
    for k, v in pairs(Config['ArtHeist']['objects']) do
        loadModel(v)
        ArtHeist['objects'][k] = CreateObject(GetHashKey(v), pedCo, 1, 1, 0)
    end
    
    ArtHeist['objects'][3] = ArtHeist['painting'][sceneId]
    
    for i = 1, 10 do
        ArtHeist['scenes'][i] = NetworkCreateSynchronisedScene(scene['scenePos']['x'], scene['scenePos']['y'], scene['scenePos']['z'] - 1.0, scene['sceneRot'], 2, true, false, 1065353216, 0, 1065353216)
        NetworkAddPedToSynchronisedScene(ped, ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][1], 4.0, -4.0, 1033, 0, 1000.0, 0)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][3], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][3], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][1], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][4], 1.0, -1.0, 1148846080)
        NetworkAddEntityToSynchronisedScene(ArtHeist['objects'][2], ArtHeist['scenes'][i], animDict, 'ver_01_'..Config['ArtHeist']['animations'][i][5], 1.0, -1.0, 1148846080)
    end
    
    ArtHeist['cuting'] = true
    FreezeEntityPosition(ped, true)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][1])
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][2])
    repeat
        SendNotification({
            text = Strings['cut_right'],
            type = 'topLeft',
            timeout = 6000,
        })
        if IsControlJustPressed(0, 38) then
            scenes[1] = true
        end
        Wait(1)
    until scenes[1] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][3])
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][4])
    repeat
        SendNotification({
            text = Strings['cut_down'],
            type = 'topLeft',
            timeout = 6000,
        })
        if IsControlJustPressed(0, 38) then
            scenes[2] = true
        end
        Wait(1)
    until scenes[2] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][5])
    Wait(3000)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][6])
    repeat
        SendNotification({
            text = Strings['cut_left'],
            type = 'topLeft',
            timeout = 6000,
        })
        if IsControlJustPressed(0, 38) then
            scenes[3] = true
        end
        Wait(1)
    until scenes[3] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][7])
    Wait(3000)
    repeat
        SendNotification({
            text = Strings['cut_down'],
            type = 'topLeft',
            timeout = 6000,
        })
        if IsControlJustPressed(0, 38) then
            scenes[4] = true
        end
        Wait(1)
    until scenes[4] == true
    NetworkStartSynchronisedScene(ArtHeist['scenes'][9])
    Wait(1500)
    NetworkStartSynchronisedScene(ArtHeist['scenes'][10])
    Wait(7500)
    TriggerServerEvent('artheist:server:rewardItem', scene)
    ClearPedTasks(ped)
	FreezeEntityPosition(ped, false)
    RemoveAnimDict(animDict)
    for k, v in pairs(ArtHeist['objects']) do
        DeleteObject(v)
    end
    DeleteObject(ArtHeist['painting'][sceneId])
    ArtHeist['objects'] = {}
    ArtHeist['scenes'] = {}
    ArtHeist['cuting'] = false
    ArtHeist['cut'] = ArtHeist['cut'] + 1
    scenes = {false, false, false, false}
    if ArtHeist['cut'] == #Config['ArtHeist']['painting'] then
        TriggerServerEvent('artheist:server:syncHeistStart')
        TriggerServerEvent('artheist:server:syncAllPainting')
        TriggerEvent('Notify', 'importante', Strings['go_sell'])
        RemoveBlip(stealBlip)
        sellBlip = addBlip(Config['ArtHeist']['sellPainting']['pos'], 500, 0, Strings['sell_blip'])
        ArtHeist['cut'] = 0
    end
    paintingsRobbed = paintingsRobbed + 1
    VTunnel.givePainting(paintingsRobbed)
    if paintingsRobbed == 4 then
        isAllPaintingsRobbed = true 
    end 
    TriggerEvent(
        'Notify',
        'importante',
        Strings['received_painting'],
        3000
    )
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(50)
    end
end

function loadModel(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Citizen.Wait(50)
    end
end

function addBlip(coords, sprite, colour, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.8)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    return blip
end

AddEventHandler('onResourceStop', function (resource)
    if resource == GetCurrentResourceName() then
        for k, v in pairs(ArtHeist['painting']) do
            DeleteObject(v)
        end
        for k, v in pairs(ArtHeist['objects']) do
            DeleteObject(v)
        end
    end
end)

-- ------------------------------------------------------------------------------------------------------------------------------------
-- JEWELRY
-- ------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		local ped = PlayerPedId()
		if #(vec3(-622.18,-230.92,38.05) - GetEntityCoords(ped)) <= 20 and not VTunnel.returnJewelry2() then
			for _,v in pairs(locais) do
				VTunnel.returnJewels(v.id,v.x,v.y,v.z,v.prop1,v.prop2)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBANDO AS JOIAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local ped = PlayerPedId()
	while true do
		local sleep = 500
		local distance = #(vec3(-622.18,-230.92,38.05) - GetEntityCoords(ped))
		if distance <= 20 then
		    for _,v in pairs(locais) do
		    	local distance2 = #(vec3(v.x,v.y,v.z)- GetEntityCoords(ped))
			    if distance2 <= 1.1 and not andamento and hasRobberyStarted then
                    sleep = 1
			        DrawText3Ds(
                        v.x,
                        v.y,
                        v.z+0.55,
                        Strings['get_jewels']
                    )
				    if IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) then
				    	if isAllPaintingsRobbed then
						    if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_ASSAULTRIFLE") or GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_SMG") then
					            VTunnel.checkJewels(v.id,
                                v.x,
                                v.y,
                                v.z,
                                v.xplayer,
                                v.yplayer,
                                v.zplayer,
                                v.heading,
                                v.prop1,
                                v.prop2,
                                2
                            )
                                SetEntityHeading(ped, v.heading)
					        else
					            TriggerEvent(
                                    "Notify",
                                    "negado",
                                    Strings['weapon_needed'],
                                    2000
                                )
				            end
				        else
						    TriggerEvent(
                                "Notify",
                                "negado",
                                Strings['paintings_first'],
                                3000
                            )
                            TriggerEvent(
                                "Notify",
                                "importante",
                                "<b>Quadros</b> restantes: "..(4 - paintingsRobbed),
                                3000
                            )
					    end
				    end
			    end
		    end
		end
        Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandojewelry")
AddEventHandler("iniciandojewelry",function(x,y,z,h,sec,mod,status)
	andamento = status
	if status then
		tipo = mod
		segundos = sec
		ClearPedTasks(PlayerPedId())
		SetEntityHeading(PlayerPedId(),h)
		SetEntityCoords(
            PlayerPedId(),
            x,
            y,
            z-1,
            false,
            false,
            false,
            false
        )
		SetCurrentPedWeapon(
            PlayerPedId(),
            GetHashKey("WEAPON_UNARMED"),
            true
        )
		TriggerEvent('cancelando',true)
	else
		TriggerEvent('cancelando',false)
		ClearPedTasks(PlayerPedId())
	end
end)

RegisterNetEvent("jewelryroubo")
AddEventHandler("jewelryroubo",function(sec,mod,status,x,y,z,prop1,prop2,id)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
	andamento = status
	if status then
        if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
	        RequestNamedPtfxAsset("scr_jewelheist")
        end
        while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
	        Citizen.Wait(0)
        end
        Wait(300)
		tipo = mod
		segundos = sec
		ClearPedTasks(PlayerPedId())
		TriggerEvent('cancelando',true)
        SetPtfxAssetNextCall("scr_jewelheist")
		StartParticleFxLoopedAtCoord(
            "scr_jewel_cab_smash",
            x,
            y,
            z,
            0.0, 0.0, 0.0,
            1.0,
            false,
            false,
            false,
            false
        )
		loadAnimDict("missheist_jewel") 
		if id == 4 or id == 13 or id == 14 or id == 17 then
			local random = math.random(1,2)
			if random == 1 then
		        TaskPlayAnim(
                    ped, 
                    "missheist_jewel", 
                    "smash_case_tray_b", 
                    8.0, 
                    1.0, 
                    -1, 
                    2, 
                    0, 
                    0, 
                    0, 
                    0 
                )
		        TriggerEvent(
                    "progress",
                    1700,
                    "roubando"
                )
		        SetTimeout(1700,function()
		    	    PlaySound(
                        -1, 
                        "PICK_UP", 
                        "HUD_FRONTEND_DEFAULT_SOUNDSET", 
                        0, 
                        0, 
                        1
                    )
		            StopAnimTask(
                        ped,
                        "missheist_jewel",
                        "smash_case_tray_b",
                        1.0
                    )
		            TriggerEvent('cancelando',false)
		        end)
		    else
		    	TaskPlayAnim(
                    ped, 
                    "missheist_jewel", 
                    "smash_case_necklace_skull", 
                    8.0, 
                    1.0, 
                    -1, 
                    2, 
                    0, 
                    0, 
                    0, 
                    0 
                )
		    	TriggerEvent(
                    "progress",
                    2000,
                    "roubando"
                )
			    SetTimeout(2000,function()
			    	PlaySound(
                        -1, 
                        "PICK_UP", 
                        "HUD_FRONTEND_DEFAULT_SOUNDSET", 
                        0, 
                        0, 
                        1
                    )
		            StopAnimTask(
                        ped,
                        "missheist_jewel",
                        "smash_case_necklace_skull",
                        1.0
                    )
		            TriggerEvent('cancelando',false)
		        end)
		    end
		    Wait(350)
	        TriggerServerEvent(
                "jewelrysetmodel",
                x,
                y,
                z,
                prop1,
                prop2
            )
		else
			local random = math.random(1,2)
			if random == 1 then
			    TaskPlayAnim(
                    ped, 
                    "missheist_jewel", 
                    "smash_case_b", 
                    8.0, 
                    1.0, 
                    -1, 
                    2, 
                    0, 
                    0, 
                    0, 
                    0 
                )
			    TriggerEvent(
                    "progress",
                    3800,
                    "roubando"
                )
			    SetTimeout(3800,function()
		            StopAnimTask(
                        ped,
                        "missheist_jewel",
                        "smash_case_b",
                        1.0
                    )               
		            TriggerEvent('cancelando',false)
		        end)
		        SetTimeout(3200,function()
		            PlaySound(
                        -1, 
                        "PICK_UP", 
                        "HUD_FRONTEND_DEFAULT_SOUNDSET", 
                        0, 
                        0, 
                        1
                    )
		        end)
			else
				TaskPlayAnim(
                    ped, 
                    "missheist_jewel", 
                    "smash_case_f", 
                    8.0, 
                    1.0, 
                    -1, 
                    2, 
                    0, 
                    0, 
                    0, 
                    0 
                )
			    TriggerEvent(
                    "progress",
                    2700,
                    "roubando"
                )
			    SetTimeout(2700,function()
		            StopAnimTask(
                        ped,
                        "missheist_jewel",
                        "smash_case_f",
                        1.0
                    )
		            TriggerEvent('cancelando',false)
		        end)
		        SetTimeout(1800,function()
		            PlaySound(
                        -1, 
                        "PICK_UP", 
                        "HUD_FRONTEND_DEFAULT_SOUNDSET", 
                        0, 
                        0, 
                        1
                    )
		        end)
			end
			Wait(350)
	        TriggerServerEvent(
                "jewelrysetmodel",
                x,
                y,
                z,
                prop1,
                prop2
            )
		end 
	end
    RemoveAnimDict("missheist_jewel")
    RemoveNamedPtfxAsset("scr_jewelheist")
end)

RegisterNetEvent("jewelrysetmodel")
AddEventHandler("jewelrysetmodel",function(x,y,z,prop1,prop2)
	CreateModelSwap(x,y,z,0.2,GetHashKey(prop1),GetHashKey(prop2),false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				tipo = 0
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.34, 0.34)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.001+ factor, 0.028, 0, 0, 0, 78)
end

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function enableCam()
	local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(),0,2.0,0)

	if DoesCamExist(cam) then
        RenderScriptCams(false,true,250,1,0)
        DestroyCam(cam,false)
        return
	end

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
    SetCamActive(cam,true)
    RenderScriptCams(true,false,0,true,true)
    SetCamCoord(cam,coords.x + 4,coords.y,coords.z+0.5)
    SetCamRot(cam,0.0,0.0,GetEntityHeading(PlayerPedId()))
end

RegisterCommand('camera', function()
    enableCam()
end)

-- ------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFICATIONS
-- ------------------------------------------------------------------------------------------------------------------------------------

local body = {
	-- Text
	scale = 0.3,
	offsetLine = 0.02,
	-- Warp
	offsetX = 0.005,
	offsetY = 0.004,
	-- Sprite
	dict = 'commonmenu',
	sprite = 'gradient_bgd',
	width = 0.14,
	height = 0.012,
	heading = -90.0,
	-- Betwenn != notifications
	gap = 0.002,
}

local defaultText = '~r~~h~ERROR : ~h~~s~The text of the notification is nil.'
local defaultType = 'topRight'
local defaultTimeout = 6000

RequestStreamedTextureDict(body.dict) -- Load the sprite dict. properly

-- --------------------------------------------
-- Calculus functions
-- --------------------------------------------

local function goDown(v, id) -- Notifications will go under the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function goUp(v, id) -- Notifications will go above the previous notifications
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function centeredDown(v, id) -- Notification will stay centered from the default position and new notification will go at the bottom
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 - body.gap/2
			v[id].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 + body.gap
		end
	end
end

local function centeredUp(v, id) -- Notification will stay centered from the default position and new notification will go at the top
	for i = 1, #v do
		if v[i].draw and i ~= id then
			v[i].y = v[i].y + (body.height + (v[id].lines*2 + 1)*body.offsetLine)/4 + body.gap/2
			v[id].y = v[i].y - (body.height + (v[id].lines*2 + 1)*body.offsetLine)/2 - body.gap
		end
	end
end

local function CountLines(v, text)
	BeginTextCommandLineCount("STRING")
    SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)
	AddTextComponentSubstringPlayerName(text)
	local nbrLines = GetTextScreenLineCount(v.x + body.offsetX, v.y + body.offsetY)
	return nbrLines
end

local function DrawText(v, text)
	SetTextScale(body.scale, body.scale)
    SetTextWrap(v.x, v.x + body.width - body.offsetX)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(v.x + body.offsetX, v.y + body.offsetY)
end

local function DrawBackground(v)
	DrawSprite(body.dict, body.sprite, v.x + body.width/2, v.y + (body.height + v.lines*body.offsetLine)/2, body.width, body.height + v.lines*body.offsetLine, body.heading, 255, 255, 255, 255)
end

-- --------------------------------------------
-- Different options
-- --------------------------------------------

local positions = {
	['centerRight'] = { x = 0.85, y = 0.5, notif = {}, offset = centeredUp },
	['centerLeft'] = { x = 0.01, y = 0.5, notif = {}, offset = centeredUp },
	['topRight'] = { x = 0.85, y = 0.015, notif = {}, offset = goDown },
	['topLeft'] = { x = 0.01, y = 0.015, notif = {}, offset = goDown },
	['bottomRight'] = { x = 0.85, y = 0.955, notif = {}, offset = goUp },
	['bottomLeft'] = { x = 0.015, y = 0.75, notif = {}, offset = goUp },
	-- ['position name'] = { starting x, starting y, notif = {} (nothing toput here it's juste the handle), offset = the way multiple notifications will stack up}
}

-- --------------------------------------------
-- Main
-- --------------------------------------------

function SendNotification(options)
	local text = options.text or defaultText
	local type = options.type or defaultType
	local timeout = options.timeout or defaultTimeout

	local p = positions[type]
	local id = #p.notif + 1
	local nbrLines = CountLines(p, text)

	p.notif[id] = {
		x = p.x,
		y = p.y,
		lines = nbrLines, 
		draw = true,
	}

	if id > 1 then
		p.offset(p.notif, id)
	end

	DrawBackground(p.notif[id])
	DrawText(p.notif[id], text)
end