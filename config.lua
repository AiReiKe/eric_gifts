Config = {}

Config.Locale = 'tw'

Config.giftname = '新手禮包'  --禮包名稱
Config.command = 'gift' --自訂指令名稱
Config.giftpack = true  --false 是直接獲取禮包內容物

Config.Item = { --禮包內容物, bank為銀行錢, cash為身上錢
    {name = 'cash', count = 200000},
    {name = 'bank', count = 100000},
    {name = 'bread', count = 15},
    {name = 'water', count = 15}
}
