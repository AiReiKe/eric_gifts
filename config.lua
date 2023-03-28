Config = {}

Config.Locale = 'tw'

Config.giftname = '新手禮包'  --禮包名稱
Config.command = 'gift' --自訂指令名稱
Config.giftpack = true  --false 是直接獲取禮包內容物

--Config.GiftPed = false
Config.GiftPed = {  -- 用NPC形式領取 如果想用指令獲取模式 這裡填false
    model = "s_m_m_fiboffice_01",
    pos = vec4(-1038.43, -2732.63, 19.16, 182.5),
}

--Config.Blip = false
Config.Blip = { -- 是否在小地圖顯示NPC位置(Only for 有NPC形式領取), 不需要填false
    colour = 1,
    type = 587,
    scale = 1.0
}

Config.oldESX = false   -- Use ESX 1.1/1.2

Config.Item = { --禮包內容物
    {name = 'cash', count = 200000},    --身上錢
    {name = 'bank', count = 100000},    --銀行錢
    {name = 'bread', count = 10},
    {name = 'water', count = 10},
    {name = 'fixkit', count = 3},
    {name = 'bandage', count = 5},
    {name = 'car', model = 'camry18'},  --新手車
    {name = 'aircraft', model = 'lazer'}, --新手飛機
    {name = 'boat', model = 'blazer2'}, --新手船
}

if not IsDuplicityVersion() then
    RegisterNetEvent("eric_gifts:giveCarKey")
    AddEventHandler("eric_gifts:giveCarKey", function(plate)
        TriggerEvent("eric_carlock:addcarkey", plate)    -- 若有車鑰匙系統, 可自行加入給予車鑰匙的function
    end)
end