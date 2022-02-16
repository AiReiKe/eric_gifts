Config = {}

Config.Locale = 'tw'

Config.giftname = '新手禮包'  --禮包名稱
Config.command = 'gift' --自訂指令名稱
Config.giftpack = true  --false 是直接獲取禮包內容物
Config.WeaponItem = false   --武器是否導入Sql算在物件內, false為否

Config.Item = { --禮包內容物
    {name = 'cash', count = 200000},    --身上錢
    {name = 'bank', count = 100000},    --銀行錢
    {name = 'WEAPON_BAT', count = 0},    --武器. 如果Config.WeaponItem為true, count為子彈數量
    {name = 'bread', count = 10},
    {name = 'water', count = 10},
    {name = 'fixkit', count = 3},
    {name = 'bandage', count = 5},
    {name = 'car', model = 'camry18'},  --新手車
    {name = 'aircraft', model = 'lazer'}, --新手飛機
    {name = 'boat', model = 'blazer2'}, --新手船
}