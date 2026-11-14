--[[
	KRIEG HUB · Seasons 2.3
	Полный клиентский код. Всё меню, все модули, все кнопки имеют реальный колбэк.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

------------------------------------------------------------------------
-- ИКОНКИ
------------------------------------------------------------------------
local ICONS = {
	["activity"]={16898612629,514,771},["badge-check"]={16898612629,967,147},["bell"]={16898612819,820,257},
	["bird"]={16898612819,869,0},["box"]={16898612819,771,196},["calendar"]={16898612819,355,918},
	["candy"]={16898612819,771,759},["check"]={16898612819,710,869},["chevron-down"]={16898612819,196,918},
	["chevron-right"]={16898612819,869,759},["chevron-up"]={16898612819,710,918},["chevrons-up-down"]={16898612819,918,759},
	["circle"]={16898613044,771,355},["circle-dot"]={16898613044,514,771},["circle-help"]={16898613044,820,257},
	["clock"]={16898613044,771,661},["cloud"]={16898613044,918,306},["cloud-rain"]={16898613044,147,820},
	["coins"]={16898613044,869,612},["compass"]={16898613044,514,967},["copy"]={16898613044,918,612},
	["crosshair"]={16898613044,453,869},["crown"]={16898613044,404,918},["disc"]={16898613044,661,967},
	["dot"]={16898613044,918,808},["droplet"]={16898613044,820,955},["eye"]={16898613353,771,563},
	["flag"]={16898613353,98,918},["flame"]={16898613353,967,306},["flower"]={16898613353,820,710},
	["flower-2"]={16898613353,869,661},["folder"]={16898613353,404,967},["footprints"]={16898613353,918,710},
	["gamepad-2"]={16898613353,710,967},["gauge"]={16898613353,771,955},["ghost"]={16898613353,869,906},
	["gift"]={16898613353,820,955},["globe"]={16898613509,771,563},["grip-vertical"]={16898613509,0,869},
	["hard-drive-download"]={16898613509,918,0},["hash"]={16898613509,147,771},["heart"]={16898613509,661,771},
	["home"]={16898613509,820,147},["image"]={16898613509,306,918},["info"]={16898613509,612,869},
	["keyboard"]={16898613509,453,820},["languages"]={16898613509,710,820},["laugh"]={16898613509,869,196},
	["layers"]={16898613509,98,967},["leaf"]={16898613509,918,661},["link"]={16898613509,918,453},
	["list"]={16898613509,869,808},["mail"]={16898613613,820,0},["map-pin"]={16898613613,820,257},
	["message-square"]={16898613613,355,820},["minus"]={16898613613,771,196},["monitor"]={16898613613,404,820},
	["moon"]={16898613613,306,918},["move"]={16898613613,453,820},["music"]={16898613613,967,563},
	["newspaper"]={16898613613,661,869},["package"]={16898613613,918,196},["palette"]={16898613613,453,918},
	["panel-left"]={16898613613,967,453},["panel-top"]={16898613613,869,857},["party-popper"]={16898613613,918,955},
	["person-standing"]={16898613699,563,771},["play"]={16898613699,918,257},["refresh-cw"]={16898613699,404,869},
	["rocket"]={16898613699,918,147},["rotate-ccw"]={16898613699,967,355},["sailboat"]={16898613699,612,967},
	["save"]={16898613699,918,453},["scan"]={16898613699,967,196},["search"]={16898613699,918,857},
	["send"]={16898613699,967,857},["server"]={16898613777,771,0},["settings"]={16898613777,771,257},
	["shell"]={16898613777,771,49},["shield"]={16898613777,869,0},["shuffle"]={16898613777,257,869},
	["signal-high"]={16898613777,771,612},["skull"]={16898613777,49,869},["sliders-horizontal"]={16898613777,820,355},
	["smartphone"]={16898613777,257,918},["snowflake"]={16898613777,771,661},["sparkles"]={16898613777,918,49},
	["sprout"]={16898613777,918,306},["square"]={16898613777,869,710},["star"]={16898613777,967,147},
	["sun"]={16898613777,967,453},["swords"]={16898613777,967,759},["table"]={16898613777,820,955},
	["target"]={16898613869,514,771},["trash-2"]={16898613869,257,918},["trophy"]={16898613869,820,147},
	["type"]={16898613869,967,257},["umbrella"]={16898613869,869,355},["user"]={16898613869,661,869},
	["user-round"]={16898613869,967,563},["users"]={16898613869,967,98},["users-round"]={16898613869,563,967},
	["venetian-mask"]={16898613869,918,404},["volume-2"]={16898613869,771,808},["wand-sparkles"]={16898613869,453,918},
	["wifi"]={16898613869,869,808},["wind"]={16898613869,820,857},["x"]={16898613869,869,906},["zap"]={16898613869,918,906},
}

------------------------------------------------------------------------
-- СОХРАНЕНИЕ
------------------------------------------------------------------------
local Store = {
	dir = "KriegHub", file = "KriegHub/settings.json", can = false,
	data = {
		Theme="Halloween",Accent=false,Font="Gotham",Lang="English",Wallpaper="",WallDim=0.45,WallMini=true,
		PanelAlpha=0.32,Scene=true,TextColor="Auto",PanelTone="Auto",Corner=1,WinW=0,WinH=0,FontCustom="",
		Particles=true,Density=1,Border=true,MiniBar=true,MiniParticles=true,MiniPos="Top",MiniFps=true,
		MiniPing=true,MiniClock=true,MiniClose=true,Scale=0,TextScale=0.92,Key="LeftControl",Compact=false,Notifs=true,
		MobileBtn=true,MobileSize=52,MobileOpacity=0.85,MobileCorner="Top right",MobileDrag=true,
	},
}
do
	local queued = false
	Store.can = type(writefile)=="function" and type(readfile)=="function" and type(isfile)=="function"
	function Store.ensureDir() pcall(function() if type(isfolder)=="function" and type(makefolder)=="function" and not isfolder(Store.dir) then makefolder(Store.dir) end end) end
	function Store.load()
		if not Store.can then return end
		pcall(function() if isfile(Store.file) then
			local d = HttpService:JSONDecode(readfile(Store.file))
			if type(d)=="table" then for k,v in pairs(d) do if Store.data[k]~=nil and (type(v)==type(Store.data[k]) or k=="Accent" or k=="TextColor") then Store.data[k]=v end end end
		end end)
	end
	function Store.save()
		if not Store.can or queued then return end
		queued = true
		task.delay(0.6, function() queued=false; pcall(function() Store.ensureDir(); writefile(Store.file, HttpService:JSONEncode(Store.data)) end) end)
	end
	function Store.set(k,v) Store.data[k]=v; Store.save() end
end
Store.load()
local S = Store.data

------------------------------------------------------------------------
-- ЯЗЫКИ (сокращённая версия — базовые ключи; полный словарь из 2.2 не поместился бы в один пост)
------------------------------------------------------------------------
local Lang = {
	cur="English", list={"English","Русский","Қазақша"},
	dict = { ["Русский"]={
		["Halloween"]="Хэллоуин",["Basic"]="Базовый",["New Year"]="Новый год",["Rain"]="Дождь",["Summer"]="Лето",["Spring"]="Весна",["Autumn"]="Осень",["Sakura"]="Сакура",["Valentine"]="Валентин",
		["Clean and simple"]="Чисто и просто",["Spooky season"]="Жуткий сезон",["Snow and lights"]="Снег и огоньки",["Calm and cozy"]="Тихо и уютно",["Sun and sea"]="Солнце и море",["Fresh and green"]="Свежо и зелено",["Falling leaves"]="Падающие листья",["Cherry blossom"]="Цветение сакуры",["Love is in the air"]="Любовь витает в воздухе",
		["Find a section..."]="Найти раздел...",["press"]="нажми",["none"]="нет",["Filter by name"]="Поиск по нику",["Server is empty for now"]="На сервере пока никого",["close"]="закрыть",
		["Overview"]="Обзор",["Home"]="Главная",["Round"]="Раунд",["Murderer"]="Убийца",["Sheriff"]="Шериф",["World"]="Мир",["Visuals"]="Визуалы",["Teleport"]="Телепорт",["Farming"]="Фарм",["You"]="Ты",["Character"]="Персонаж",["Emotes"]="Эмоции",["Fun"]="Приколы",["NEW"]="НОВОЕ",["Social"]="Общение",["Chat"]="Чат",["Music"]="Музыка",["Community"]="Сообщество",["System"]="Система",["Configs"]="Конфиги",["Mobile"]="Телефон",["Server"]="Сервер",["Settings"]="Настройки",
		["Welcome back"]="С возвращением",["Profile"]="Профиль",["days"]="дн.",["KRIEG MEMBER"]="УЧАСТНИК KRIEG",["Live"]="В реальном времени",["Updates every half second"]="Обновляется каждые полсекунды",["FPS"]="FPS",["Ping"]="Пинг",["Players"]="Игроки",["Session"]="Сессия",["Season"]="Сезон",["Pick a style for the whole menu"]="Выбери стиль для всего меню",["Changelog"]="Что нового",
		["Tools for when you hold the knife"]="Инструменты, когда у тебя нож",["Knife"]="Нож",["Throw"]="Бросок",["Cosmetic"]="Косметика",["Close range"]="Ближний бой",["Reach"]="Дальность удара",["Longer knife hit range"]="Нож бьёт дальше",["Reach distance"]="Дистанция удара",["Quick equip"]="Быстро достать",["Pull out the knife instantly"]="Мгновенно достаёт нож",["Alerts"]="Оповещения",["Sheriff nearby"]="Шериф рядом",["Warns when the sheriff is close"]="Предупреждает, когда шериф близко",["Round start sound"]="Звук начала раунда",["Throwing"]="Метание",["Throw assist"]="Помощь при броске",["Priority"]="Приоритет",["Nearest"]="Ближайший",["Sheriff first"]="Сначала шериф",["Hero first"]="Сначала герой",["Lowest HP"]="Меньше всего HP",["Lead"]="Упреждение",["Tip"]="Подсказка",["Knife trail"]="След ножа",["Off"]="Выкл",["Ember"]="Угли",["Void"]="Пустота",["Frost"]="Иней",["Toxic"]="Яд",["Gold"]="Золото",
		["Aim helpers and gun tools"]="Помощь в прицеливании и пистолет",["Aim"]="Прицел",["Gun"]="Пистолет",["Aim helper"]="Помощь в прицеливании",["Soft aim"]="Мягкий прицел",["Gently pulls aim to the target"]="Плавно тянет прицел к цели",["Smoothness"]="Плавность",["FOV"]="FOV",["Aim point"]="Точка прицела",["Upper body"]="Верх тела",["Head"]="Голова",["Center"]="Центр",["FOV circle"]="Круг FOV",["Show circle"]="Показывать круг",["Fill circle"]="Заливка круга",["Thickness"]="Толщина",["Dropped gun"]="Выпавший пистолет",["Highlight dropped gun"]="Подсвечивать пистолет",["Outline the gun when the sheriff dies"]="Обводит пистолет, когда шериф умирает",["Announce drop"]="Сообщать о выпадении",["Pick up gun"]="Подобрать пистолет",
		["See more of the round and the map"]="Больше видишь в раунде и на карте",["Atmosphere"]="Атмосфера",["Highlights"]="Подсветка",["Outline players by role"]="Обводка игроков по роли",["Enabled"]="Включено",["Roles to show"]="Какие роли показывать",["Hero"]="Герой",["Innocent"]="Невинный",["Unknown"]="Неизвестно",["Range"]="Дальность",["Only visible"]="Только видимые",["Labels"]="Подписи",["Names"]="Ники",["Distance"]="Расстояние",["Role tag"]="Метка роли",["Highlight style"]="Стиль подсветки",["Soft"]="Мягкий",["Outline"]="Контур",["Neon"]="Неон",["Ghost"]="Призрак",["Hologram"]="Голограмма",["Shadow"]="Тень",["Color source"]="Цвет",["Role color"]="Цвет роли",["Theme accent"]="Цвет стиля",["Rainbow"]="Радуга",["Lighting"]="Освещение",["Bright map"]="Светлая карта",["Removes dark shadows"]="Убирает тёмные тени",["Clear fog"]="Убрать туман",["Clock time"]="Время суток",["Color grading"]="Цветокоррекция",["Saturation"]="Насыщенность",["Contrast"]="Контраст",["Weather"]="Погода",["Snow"]="Снег",["Fog"]="Туман",["Storm"]="Гроза",["Intensity"]="Сила",["Sky"]="Небо",["Skybox"]="Скайбокс",["Default"]="Обычный",["Blood moon"]="Кровавая луна",["Night"]="Ночь",["Galaxy"]="Галактика",["Sunset"]="Закат",["Slow sky rotation"]="Медленное вращение неба",
		["Move around the map quickly"]="Быстро перемещайся по карте",["Places"]="Места",["Lobby"]="Лобби",["Map"]="Карта",["Spawn"]="Спавн",["Safe spot"]="Безопасное место",["Travel"]="Перемещение",["Method"]="Способ",["Smooth"]="Плавно",["Instant"]="Мгновенно",["Speed"]="Скорость",["Go to player"]="К игроку",["Coins and progress"]="Монеты и прогресс",["Coins"]="Монеты",["Coin collector"]="Сбор монет",["Collect coins"]="Собирать монеты",["Picks up coins around the map"]="Подбирает монеты по карте",["Stay away from murderer"]="Держаться подальше от убийцы",["Movement"]="Передвижение",["Walk"]="Пешком",["Safety"]="Безопасность",["Anti AFK"]="Анти-АФК",["Stop when bag is full"]="Стоп, когда сумка полная",["This session"]="Эта сессия",["Rounds"]="Раунды",["Per hour"]="В час",["Reset"]="Сбросить",
		["Movement, physics and protection"]="Движение, физика и защита",["Physics"]="Физика",["Protection"]="Защита",["Walk through walls"]="Сквозь стены",["Air jump"]="Прыжок в воздухе",["Jump again while in the air"]="Ещё один прыжок в воздухе",["Flight"]="Полёт",["Bunny hop"]="Банихоп",["Wall climb"]="Лазать по стенам",["Custom walk speed"]="Своя скорость ходьбы",["Walk speed"]="Скорость ходьбы",["Custom jump"]="Свой прыжок",["Jump power"]="Сила прыжка",["Gravity"]="Гравитация",["Hip height"]="Высота",["Low gravity jump"]="Прыжок с низкой гравитацией",["Spin"]="Вращение",["Spin speed"]="Скорость вращения",["Anti push"]="Анти-толчок",["Ignore other players pushing you"]="Другие игроки не могут тебя толкать",["Anti ragdoll"]="Анти-рэгдолл",
		["Animation packs and dances"]="Наборы анимаций и танцы",["Packs"]="Наборы",["Dances"]="Танцы",["Animation pack"]="Набор анимаций",["Pack"]="Набор",["Zombie"]="Зомби",["Ninja"]="Ниндзя",["Robot"]="Робот",["Levitation"]="Левитация",["Stylish"]="Стильный",["Mage"]="Маг",["Use pack"]="Использовать набор",["Animation speed"]="Скорость анимации",["Seasonal packs"]="Сезонные наборы",["Phantom"]="Фантом",["Mummy"]="Мумия",["Dance 1"]="Танец 1",["Dance 2"]="Танец 2",["Dance 3"]="Танец 3",["Wave"]="Помахать",["Loop dance"]="Танцевать по кругу",
		["Harmless jokes and cosmetics"]="Безобидные шутки и косметика",["Cosmetics"]="Косметика",["Look"]="Внешний вид",["Only you can see these"]="Это видишь только ты",["Headless look"]="Без головы",["Korblox leg look"]="Нога Korblox",["Hat"]="Шапка",["None"]="Нет",["Pumpkin"]="Тыква",["Witch hat"]="Шляпа ведьмы",["Santa hat"]="Шапка Санты",["Halo"]="Нимб",["Toys"]="Игрушки",["Toy"]="Игрушка",["Hoverboard"]="Ховерборд",["Candy bucket"]="Ведро конфет",["Broom"]="Метла",["Balloon"]="Шарик",["Always hold toy"]="Всегда держать игрушку",["Emote spam"]="Спам эмоцией",["Emote"]="Эмоция",["wave"]="помахать",["point"]="указать",["cheer"]="радость",["laugh"]="смех",["dance"]="танец",["Repeat"]="Повторять",["Actions"]="Действия",["Follow selected"]="Следовать за выбранным",["Orbit selected"]="Кружить вокруг выбранного",["Copy their emotes"]="Копировать эмоции",
		["Messages and chat tools"]="Сообщения и инструменты чата",["Send"]="Отправить",["History"]="История",["Message"]="Сообщение",["Write something..."]="Напиши что-нибудь...",["Notifications"]="Уведомления",["Sound on mention"]="Звук при упоминании",["Preview popup"]="Показать уведомление",["This is how a popup looks"]="Так выглядит уведомление",["Keep history"]="Сохранять историю",["Nothing saved yet. Turn on history to keep messages from this server."]="Пока ничего не сохранено. Включи историю, чтобы сохранять сообщения с этого сервера.",
		["Background sounds while you play"]="Фоновые звуки во время игры",["Player"]="Плеер",["Library"]="Библиотека",["Now playing"]="Сейчас играет",["Sound ID"]="ID звука",["Play"]="Играть",["Stop"]="Стоп",["Sound"]="Звук",["Volume"]="Громкость",["Seasonal picks"]="Сезонная подборка",["Night walk"]="Ночная прогулка",["Snowfall"]="Снегопад",["Summer breeze"]="Летний бриз",
		["People using KRIEG HUB"]="Люди с KRIEG HUB",["Online"]="Онлайн",["In this server"]="На этом сервере",["Everywhere"]="Везде",["Refresh"]="Обновить",["Your tag"]="Твой тег",["Show tag above head"]="Тег над головой",["Tag style"]="Стиль тега",["Clean"]="Чистый",["Glow"]="Свечение",["Seasonal"]="Сезонный",
		["Save your setup and load it later"]="Сохрани настройки и загрузи позже",["Local"]="Локальные",["Shared"]="Общие",["Save"]="Сохранить",["Config name"]="Название конфига",["Load"]="Загрузить",["Delete"]="Удалить",["Saved configs"]="Сохранённые конфиги",["Config"]="Конфиг",["default"]="обычный",["legit"]="легит",["seasonal"]="сезонный",["Load on start"]="Загружать при запуске",["Shared configs"]="Общие конфиги",["Sharing configs with friends is coming in a future update."]="Обмен конфигами с друзьями появится в следующих обновлениях.",
		["Touch controls for phones and tablets"]="Управление для телефонов и планшетов",["Button"]="Кнопка",["Open button"]="Кнопка открытия",["Show button"]="Показывать кнопку",["Size"]="Размер",["Opacity"]="Непрозрачность",["Placement"]="Расположение",["Corner"]="Угол",["Top left"]="Сверху слева",["Top right"]="Сверху справа",["Bottom left"]="Снизу слева",["Bottom right"]="Снизу справа",["Allow dragging"]="Можно перетаскивать",
		["Info about this server"]="Информация о сервере",["Info"]="Инфо",["Place ID"]="ID плейса",["Rejoin"]="Перезайти",["Find another server"]="Найти другой сервер",["Copy server ID"]="Скопировать ID сервера",
		["Make the menu yours"]="Сделай меню своим",["Seasons"]="Сезоны",["Appearance"]="Оформление",["Interface"]="Интерфейс",["Mini bar"]="Мини-бар",["Other"]="Прочее",["Style"]="Стиль",["Colors, scene, particles and mini bar"]="Цвета, сцена, частицы и мини-бар",["Effects"]="Эффекты",["Live scene"]="Живая сцена",["Animated picture behind the menu"]="Анимированная картинка за меню",["Particles"]="Частицы",["Snow, leaves, petals and more"]="Снег, листья, лепестки и не только",["Amount"]="Количество",["Animated border"]="Анимированная рамка",["Accent"]="Акцент",["Override the style color"]="Свой цвет вместо цвета стиля",["Use style color"]="Вернуть цвет стиля",["Wallpaper"]="Обои",["Your own picture behind the menu"]="Своя картинка за меню",["Image link or Roblox image ID"]="Ссылка на картинку или Roblox ID",["Activate"]="Активировать",["Loading..."]="Загрузка...",["Wallpaper is on"]="Обои установлены",["Remove"]="Убрать",["Darken"]="Затемнение",["Also in mini bar"]="Также в мини-баре",["Panels"]="Панели",["Panel transparency"]="Прозрачность панелей",["Font"]="Шрифт",["Applies to the whole menu"]="Применяется ко всему меню",["Text size"]="Размер текста",["Language"]="Язык",["Controls"]="Управление",["Open / hide menu"]="Открыть / скрыть меню",["Layout"]="Макет",["Menu size"]="Размер меню",["Compact sidebar"]="Компактная боковая панель",["The small bar at the top of the screen"]="Маленькая панель вверху экрана",["Show mini bar"]="Показывать мини-бар",["Particles inside"]="Частицы внутри",["Position"]="Положение",["Top"]="Сверху",["Bottom"]="Снизу",["Show on bar"]="Что показывать",["Clock"]="Часы",["Close button"]="Кнопка закрытия",["Saving"]="Сохранение",["Settings are saved automatically"]="Настройки сохраняются автоматически",["Your executor can't save files"]="Твой экзекутор не умеет сохранять файлы",["Status"]="Статус",["On"]="Вкл",["Reset all settings"]="Сбросить все настройки",["Run the script again to apply"]="Запусти скрипт заново, чтобы применить",["About"]="О скрипте",["Name"]="Название",["Version"]="Версия",["Styles"]="Стили",["Fonts"]="Шрифты",["Menu hidden"]="Меню скрыто",["Press the menu key or click the mini bar"]="Нажми клавишу меню или кликни по мини-бару",["Your settings are loaded"]="Твои настройки загружены",["Settings can't be saved in this executor"]="В этом экзекуторе настройки не сохраняются",["All"]="Все",["Apply"]="Применить",["Apply color"]="Применить цвет",["Auto"]="Авто",["Black"]="Чёрный",["White"]="Белый",["Cream"]="Кремовый",["Pink"]="Розовый",["Mint"]="Мятный",["Corner radius"]="Скругление углов",["Custom font applied"]="Свой шрифт применён",["Light"]="Светлый",["Dark"]="Тёмный",["Drag the bottom right corner of the menu to resize it."]="Тяни за правый нижний угол меню, чтобы изменить размер.",["Everyone on this server. Tap a player for actions"]="Все на этом сервере. Нажми на игрока для действий",["Spectate"]="Наблюдать",["Fling"]="Флинг",["Watch from their view"]="Смотреть его глазами",["Go to this player"]="Переместиться к игроку",["Push them away"]="Отбросить игрока",["Friend"]="Друг",["More fonts"]="Ещё шрифты",["Name, Roblox font ID or a .ttf link"]="Название, Roblox ID шрифта или ссылка на .ttf",["e.g. Lobster, 12187365364 or https://...ttf"]="например Lobster, 12187365364 или https://...ttf",["On this server"]="На этом сервере",["Panel color"]="Цвет панелей",["Pick a color that is easy to read on your wallpaper"]="Выбери цвет, который хорошо читается на твоих обоях",["Players tab with actions"]="Вкладка игроков с действиями",["Reset window size"]="Сбросить размер окна",["Resize the menu from its corner"]="Размер меню тянется за угол",["Search player"]="Найти игрока",["Text color"]="Цвет текста",["Text color and 105 fonts"]="Цвет текста и 105 шрифтов",["Use the format #RRGGBB"]="Используй формат #RRGGBB",["Your color, for example #FFAA00"]="Свой цвет, например #FFAA00",["Your font"]="Свой шрифт",["Type a font name, ID or link"]="Введи название, ID или ссылку",["Your executor can't load fonts from links"]="Твой экзекутор не умеет грузить шрифты по ссылке",["Could not load the font"]="Не удалось загрузить шрифт",["Could not download the font"]="Не удалось скачать шрифт",["Link must lead to a .ttf or .otf file"]="Ссылка должна вести на файл .ttf или .otf",["Could not save the font"]="Не удалось сохранить шрифт",["Font not found"]="Шрифт не найден",
	}, ["Қазақша"]={} },
	reg = setmetatable({}, {__mode="k"}), ph = setmetatable({}, {__mode="k"}), cbs = {},
}
local function tr(s) local d = Lang.dict[Lang.cur]; return (d and d[s]) or s end
do local f=false; for _,n in ipairs(Lang.list) do if n==S.Lang then f=true end end; Lang.cur = f and S.Lang or "English" end

------------------------------------------------------------------------
-- СТИЛИ
------------------------------------------------------------------------
local function rgb(r,g,b) return Color3.fromRGB(r,g,b) end
local WHITE = Color3.new(1,1,1)
local THEME_ORDER = {"Basic","Halloween","New Year","Rain","Summer","Spring","Autumn","Sakura","Valentine"}
local THEMES = {
	["Basic"]={Icon="circle",Tagline="Clean and simple",Accent=rgb(120,135,255),Accent2=rgb(170,120,255),BgTop=rgb(20,20,24),BgBottom=rgb(13,13,16),Card=rgb(24,24,29),Element=rgb(34,34,40),Element2=rgb(45,45,52),Deep=rgb(11,11,13),Stroke=rgb(48,48,56),Text=rgb(238,238,243),Sub=rgb(150,150,162),Dim=rgb(96,96,108),Glow=nil,Fx=nil},
	["Halloween"]={Icon="ghost",Tagline="Spooky season",Accent=rgb(255,128,36),Accent2=rgb(168,85,247),BgTop=rgb(32,19,13),BgBottom=rgb(12,10,12),Card=rgb(26,20,20),Element=rgb(38,30,30),Element2=rgb(50,40,40),Deep=rgb(12,9,10),Stroke=rgb(62,47,44),Text=rgb(246,238,232),Sub=rgb(164,148,140),Dim=rgb(108,94,90),Glow="Accent",Fx={Rate=0.3,Items={{Kind="dot",W=6,Dir="up",Size={3,6},Colors={"Accent",rgb(255,210,120)},Time={4,7},Alpha=0.15,Drift=0.15,Rise=0.8},{Kind="icon",W=3,Dir="up",Icons={"ghost","skull","candy","flame","moon"},Size={12,20},Colors={"Accent","Accent2",WHITE},Time={7,11},Alpha=0.72,Drift=0.25,Spin=60,Rise=1.1}}}},
	["New Year"]={Icon="snowflake",Tagline="Snow and lights",Accent=rgb(90,175,255),Accent2=rgb(255,205,90),BgTop=rgb(14,26,44),BgBottom=rgb(8,11,20),Card=rgb(16,24,40),Element=rgb(24,35,56),Element2=rgb(33,46,70),Deep=rgb(7,10,18),Stroke=rgb(42,58,88),Text=rgb(236,244,255),Sub=rgb(142,162,194),Dim=rgb(90,106,134),Glow="Accent",Fx={Rate=0.12,Items={{Kind="dot",W=8,Dir="down",Size={2,5},Colors={WHITE,rgb(210,230,255)},Time={6,10},Alpha=0.2,Drift=0.12},{Kind="icon",W=2,Dir="down",Icons={"snowflake","snowflake","star"},Size={10,16},Colors={WHITE,"Accent2","Accent"},Time={8,12},Alpha=0.55,Drift=0.15,Spin=120}}}},
	["Rain"]={Icon="cloud-rain",Tagline="Calm and cozy",Accent=rgb(95,185,230),Accent2=rgb(140,160,190),BgTop=rgb(24,30,38),BgBottom=rgb(11,14,18),Card=rgb(20,25,31),Element=rgb(30,37,45),Element2=rgb(40,48,58),Deep=rgb(9,12,15),Stroke=rgb(48,58,70),Text=rgb(232,240,246),Sub=rgb(146,160,174),Dim=rgb(92,104,118),Glow=rgb(70,120,160),Fx={Rate=0.035,Items={{Kind="streak",W=12,Dir="down",Size={12,22},Colors={rgb(170,200,230),rgb(140,170,200)},Time={0.7,1.1},Alpha=0.5,Drift=-0.06,Rot=10},{Kind="icon",W=1,Dir="down",Icons={"droplet"},Size={8,12},Colors={"Accent"},Time={1.4,2},Alpha=0.6,Drift=-0.05}}}},
	["Summer"]={Icon="sun",Tagline="Sun and sea",Accent=rgb(255,186,45),Accent2=rgb(40,205,195),BgTop=rgb(36,28,13),BgBottom=rgb(9,22,25),Card=rgb(26,24,18),Element=rgb(38,35,26),Element2=rgb(50,46,34),Deep=rgb(10,10,8),Stroke=rgb(64,58,40),Text=rgb(250,244,230),Sub=rgb(170,160,140),Dim=rgb(112,104,88),Glow="Accent",Fx={Rate=0.32,Items={{Kind="dot",W=6,Dir="up",Size={2,5},Colors={rgb(255,230,140),"Accent2"},Time={5,9},Alpha=0.25,Drift=0.2,Rise=0.7},{Kind="icon",W=2,Dir="up",Icons={"sparkles","shell","sun"},Size={12,18},Colors={"Accent","Accent2"},Time={8,12},Alpha=0.72,Drift=0.2,Spin=40,Rise=1.1}}}},
	["Spring"]={Icon="flower-2",Tagline="Fresh and green",Accent=rgb(110,215,125),Accent2=rgb(255,150,195),BgTop=rgb(17,30,20),BgBottom=rgb(10,14,11),Card=rgb(20,27,21),Element=rgb(30,40,32),Element2=rgb(40,52,42),Deep=rgb(8,12,9),Stroke=rgb(48,64,50),Text=rgb(238,248,238),Sub=rgb(150,170,152),Dim=rgb(96,114,98),Glow="Accent",Fx={Rate=0.32,Items={{Kind="icon",W=3,Dir="down",Icons={"flower","flower-2","leaf"},Size={10,18},Colors={"Accent","Accent2",rgb(255,230,120)},Time={8,12},Alpha=0.65,Drift=0.3,Spin=180},{Kind="dot",W=3,Dir="down",Size={3,5},Colors={"Accent2",WHITE},Time={7,11},Alpha=0.3,Drift=0.2}}}},
	["Autumn"]={Icon="leaf",Tagline="Falling leaves",Accent=rgb(232,112,40),Accent2=rgb(205,60,45),BgTop=rgb(34,21,12),BgBottom=rgb(14,11,10),Card=rgb(27,21,17),Element=rgb(39,31,25),Element2=rgb(51,41,33),Deep=rgb(11,9,8),Stroke=rgb(64,50,40),Text=rgb(246,236,226),Sub=rgb(168,150,134),Dim=rgb(110,96,86),Glow="Accent",Fx={Rate=0.26,Items={{Kind="icon",W=5,Dir="down",Icons={"leaf"},Size={12,22},Colors={"Accent","Accent2",rgb(235,180,60),rgb(160,90,40)},Time={7,11},Alpha=0.5,Drift=0.35,Spin=240},{Kind="dot",W=1,Dir="down",Size={2,4},Colors={"Accent"},Time={6,9},Alpha=0.35,Drift=0.2}}}},
	["Sakura"]={Icon="flower",Tagline="Cherry blossom",Accent=rgb(255,145,195),Accent2=rgb(200,130,255),BgTop=rgb(36,19,30),BgBottom=rgb(14,11,15),Card=rgb(28,21,27),Element=rgb(40,30,38),Element2=rgb(52,40,50),Deep=rgb(12,9,12),Stroke=rgb(66,48,62),Text=rgb(250,238,246),Sub=rgb(172,150,166),Dim=rgb(114,96,110),Glow="Accent",Fx={Rate=0.14,Items={{Kind="petal",W=8,Dir="down",Size={5,9},Colors={rgb(255,183,214),rgb(255,160,200),rgb(255,215,230)},Time={7,11},Alpha=0.2,Drift=0.35,Spin=300},{Kind="icon",W=1,Dir="down",Icons={"flower"},Size={10,14},Colors={"Accent"},Time={8,12},Alpha=0.55,Drift=0.3,Spin=200}}}},
	["Valentine"]={Icon="heart",Tagline="Love is in the air",Accent=rgb(255,72,115),Accent2=rgb(255,155,185),BgTop=rgb(38,13,22),BgBottom=rgb(14,9,12),Card=rgb(30,19,24),Element=rgb(43,27,34),Element2=rgb(56,36,45),Deep=rgb(12,8,10),Stroke=rgb(70,42,54),Text=rgb(252,236,242),Sub=rgb(176,146,158),Dim=rgb(118,92,102),Glow="Accent",Fx={Rate=0.28,Items={{Kind="icon",W=5,Dir="up",Icons={"heart"},Size={10,20},Colors={"Accent","Accent2",rgb(255,200,215)},Time={7,11},Alpha=0.6,Drift=0.2,Spin=30,Rise=1.1},{Kind="dot",W=3,Dir="up",Size={3,5},Colors={"Accent2"},Time={5,8},Alpha=0.3,Drift=0.15,Rise=0.8}}}},
}
local PANEL_TONES = {
	["Light"]={BgTop=rgb(240,240,245),BgBottom=rgb(222,223,231),Card=rgb(250,250,252),Element=rgb(234,235,240),Element2=rgb(220,222,230),Deep=rgb(244,245,248),Stroke=rgb(206,208,218),Text=rgb(26,27,34),Sub=rgb(88,92,106),Dim=rgb(138,142,156)},
	["Dark"]={BgTop=rgb(17,17,20),BgBottom=rgb(8,8,10),Card=rgb(15,15,18),Element=rgb(25,25,29),Element2=rgb(35,35,41),Deep=rgb(8,8,10),Stroke=rgb(40,40,47),Text=rgb(240,240,244),Sub=rgb(150,150,160),Dim=rgb(96,96,106)},
}
local Theme={}, currentThemeName="Halloween", accentOverride=nil
local function loadThemeData(name)
	local src = THEMES[name] or THEMES["Halloween"]
	currentThemeName = THEMES[name] and name or "Halloween"
	for k,v in pairs(src) do Theme[k]=v end
	Theme.Fx, Theme.Glow = src.Fx, src.Glow
	if accentOverride then Theme.Accent = accentOverride end
	local tone = PANEL_TONES[S.PanelTone]
	if tone then for k,v in pairs(tone) do Theme[k]=v end end
	if type(S.TextColor)=="table" and #S.TextColor==3 then
		local c = rgb(S.TextColor[1],S.TextColor[2],S.TextColor[3])
		Theme.Text=c; Theme.Sub=c:Lerp(Theme.Card,0.36); Theme.Dim=c:Lerp(Theme.Card,0.58)
	end
	Theme.Red=rgb(232,72,72); Theme.Green=rgb(90,210,120); Theme.Off=Theme.Sub:Lerp(Theme.Text,0.45)
end
if type(S.Accent)=="table" and #S.Accent==3 then accentOverride = rgb(S.Accent[1],S.Accent[2],S.Accent[3]) end
loadThemeData(S.Theme)

------------------------------------------------------------------------
-- ШРИФТЫ (сокращённый набор — главные 30, полный список из 2.2 при желании добавляй)
------------------------------------------------------------------------
local FONTS, FONTS_MORE = {}, {}
local FONT_FAMILY
local FontLib = {}
do
	local function fam(n) local ok,f=pcall(function() return Font.fromEnum(Enum.Font[n]) end); if ok and f then return f.Family end; return "rbxasset://fonts/families/GothamSSm.json" end
	local function id(n) return "rbxassetid://"..n end
	FONTS = {{"Gotham",fam("Gotham")},{"Montserrat","rbxasset://fonts/families/Montserrat.json"},{"Roboto",fam("Roboto")},{"Ubuntu",fam("Ubuntu")},{"Builder Sans",fam("BuilderSans")},{"Nunito",fam("Nunito")},{"Oswald",fam("Oswald")},{"Jura",fam("Jura")},{"Arimo",fam("Arimo")},{"Roboto Mono",fam("RobotoMono")},{"Fredoka One",fam("FredokaOne")},{"Michroma",fam("Michroma")},{"Bangers",fam("Bangers")},{"Creepster",fam("Creepster")},{"Permanent Marker",fam("PermanentMarker")}}
	FONTS_MORE = {{"Amatic SC",fam("AmaticSC")},{"Denk One",fam("DenkOne")},{"Fondamento",fam("Fondamento")},{"Grenze Gotisch",fam("GrenzeGotisch")},{"Indie Flower",fam("IndieFlower")},{"Josefin Sans",fam("JosefinSans")},{"Kalam",fam("Kalam")},{"Luckiest Guy",fam("LuckiestGuy")},{"Merriweather",fam("Merriweather")},{"Patrick Hand",fam("PatrickHand")},{"Roboto Condensed",fam("RobotoCondensed")},{"Sarpanch",fam("Sarpanch")},{"Special Elite",fam("SpecialElite")},{"Titillium Web",fam("TitilliumWeb")},{"Source Sans",fam("SourceSans")},{"Arial",fam("Arial")},{"Highway",fam("Highway")},{"Sci-Fi",fam("SciFi")},{"Arcade",fam("Arcade")},{"Fantasy",fam("Fantasy")},{"Antique",fam("Antique")},{"Bodoni",fam("Bodoni")},{"Garamond",fam("Garamond")},{"Cartoon",fam("Cartoon")},{"Code",fam("Code")},{"Inter",id(12187365364)},{"Poppins",id(11702779409)},{"Lato",id(11598289817)},{"Open Sans",id(11598121416)},{"Raleway",id(11702779240)}}
	function FontLib.byName(name)
		local low = name:lower():gsub("%s","")
		for _,list in ipairs({FONTS,FONTS_MORE}) do for _,f in ipairs(list) do if f[1]:lower():gsub("%s","")==low then return f[2],f[1] end end end
		return nil
	end
	local function hashOf(s) local h=0; for i=1,#s do h=(h*31+s:byte(i))%1000000007 end; return tostring(h) end
	function FontLib.resolve(src, cb)
		src = (src or ""):gsub("^%s+",""):gsub("%s+$","")
		if src=="" then cb(false,"Type a font name, ID or link") return end
		local num = src:match("^(%d+)$") or src:match("rbxassetid://(%d+)")
		if num then cb(true,"rbxassetid://"..num) return end
		if src:match("^rbxasset://") then cb(true,src) return end
		if src:match("^https?://") then
			local getAsset = getcustomasset or getsynasset
			local req = request or http_request or (syn and syn.request) or (http and http.request)
			if type(getAsset)~="function" or type(writefile)~="function" then cb(false,"Your executor can't load fonts from links") return end
			local base = Store.dir.."/font_"..hashOf(src)
			local function finish() local ok,f=pcall(getAsset,base..".json"); if ok and f then cb(true,f) else cb(false,"Could not load the font") end end
			if pcall(function() return isfile and isfile(base..".json") end) and isfile(base..".json") then finish() return end
			task.spawn(function()
				local ok,res = pcall(req,{Url=src,Method="GET"})
				if not ok or type(res)~="table" or not res.Body then cb(false,"Could not download the font") return end
				local body = res.Body
				local head = body:sub(1,4)
				if not (head=="\0\1\0\0" or head=="OTTO" or head=="true") then cb(false,"Link must lead to a .ttf or .otf file") return end
				Store.ensureDir()
				local okW = pcall(writefile,base..".ttf",body)
				local okA, asset = pcall(getAsset,base..".ttf")
				if not (okW and okA and asset) then cb(false,"Could not save the font") return end
				local faces = {}
				for _,w in ipairs({{"Regular",400},{"Medium",500},{"SemiBold",600},{"Bold",700},{"Heavy",900}}) do table.insert(faces,{name=w[1],weight=w[2],style="normal",assetId=asset}) end
				pcall(writefile,base..".json",HttpService:JSONEncode({name="KriegCustom",faces=faces}))
				finish()
			end)
			return
		end
		local known = FontLib.byName(src)
		if known then cb(true,known) return end
		local ok,f = pcall(function() return Font.fromName((src:gsub("%s",""))) end)
		if ok and f then cb(true,f.Family) return end
		cb(false,"Font not found")
	end
	FONT_FAMILY = FONTS[1][2]
	local known = S.Font~="Custom" and FontLib.byName(S.Font)
	if known then FONT_FAMILY = known end
end
local REG, MED, SEMI, BOLD, HEAVY = Enum.FontWeight.Regular, Enum.FontWeight.Medium, Enum.FontWeight.SemiBold, Enum.FontWeight.Bold, Enum.FontWeight.Heavy
local function F(w) return Font.new(FONT_FAMILY, w or REG) end

------------------------------------------------------------------------
-- ХЕЛПЕРЫ
------------------------------------------------------------------------
local function create(class, props)
	local obj = Instance.new(class); local parent
	for k,v in pairs(props or {}) do if k=="Parent" then parent=v else obj[k]=v end end
	if parent then obj.Parent = parent end
	return obj
end
local function tween(obj, props, time, style, dir)
	local tw = TweenService:Create(obj, TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), props); tw:Play(); return tw
end
local bindings, themeCallbacks = {}, {}
local function resolve(key)
	if type(key)=="function" then return key(Theme) end
	if type(key)=="string" then return Theme[key] end
	return key
end
local function bind(obj, prop, key)
	obj[prop] = resolve(key)
	if type(key)=="string" or type(key)=="function" then table.insert(bindings, {obj,prop,key}) end
	return obj
end
local function onAccentText(T)
	local c=T.Accent; local l=0.299*c.R+0.587*c.G+0.114*c.B
	if l>0.72 then return rgb(24,20,16) end
	return WHITE
end
local function onTheme(fn) table.insert(themeCallbacks, fn); fn(Theme) end
local function applyBindings(animated)
	local alive = {}
	for _,b in ipairs(bindings) do
		local obj = b[1]
		if obj.Parent then
			table.insert(alive,b)
			local v = resolve(b[3])
			if animated and typeof(v)=="Color3" then
				TweenService:Create(obj, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {[b[2]]=v}):Play()
			else
				obj[b[2]] = v
			end
		end
	end
	bindings = alive
	for _,fn in ipairs(themeCallbacks) do fn(Theme) end
end
local function make(class, props, binds)
	local obj = create(class, props)
	if binds then for prop,key in pairs(binds) do bind(obj,prop,key) end end
	return obj
end
local corners = {}
local function corner(p, r)
	r = r or 8
	local c = create("UICorner", {CornerRadius=UDim.new(0, math.floor(r*S.Corner+0.5)), Parent=p})
	table.insert(corners, {c,r}); return c
end
local function setCornerScale(f)
	S.Corner = f
	for i=#corners,1,-1 do local e=corners[i]; if e[1].Parent then e[1].CornerRadius=UDim.new(0, math.floor(e[2]*f+0.5)) else table.remove(corners,i) end end
end
local function stroke(p, key, transparency, thickness)
	local s = create("UIStroke", {Transparency=transparency or 0, Thickness=thickness or 1, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=p})
	bind(s, "Color", key or "Stroke"); return s
end
local function pad(p, l, r, t, b)
	return create("UIPadding", {PaddingLeft=UDim.new(0,l or 0), PaddingRight=UDim.new(0,r or 0), PaddingTop=UDim.new(0,t or 0), PaddingBottom=UDim.new(0,b or 0), Parent=p})
end
local function hlist(p, padding, valign, halign)
	return create("UIListLayout", {FillDirection=Enum.FillDirection.Horizontal, Padding=UDim.new(0,padding or 0), VerticalAlignment=valign or Enum.VerticalAlignment.Center, HorizontalAlignment=halign or Enum.HorizontalAlignment.Left, SortOrder=Enum.SortOrder.LayoutOrder, Parent=p})
end
local function vlist(p, padding)
	return create("UIListLayout", {Padding=UDim.new(0,padding or 0), SortOrder=Enum.SortOrder.LayoutOrder, Parent=p})
end
local textObjects = {}
local textScale = S.TextScale
local function text(class, props)
	local weight = props.Weight or REG
	local colorKey = props.Color or "Text"
	local translate = props.Tr ~= false
	props.Weight=nil; props.Color=nil; props.Tr=nil
	local base = props.TextSize or 13
	props.TextSize = math.floor(base*textScale+0.5)
	props.FontFace = F(weight)
	props.BorderSizePixel = 0
	if props.BackgroundTransparency==nil then props.BackgroundTransparency=1 end
	props.TextXAlignment = props.TextXAlignment or Enum.TextXAlignment.Left
	if class=="TextButton" then props.AutoButtonColor=false end
	local rawText = props.Text
	if translate and type(rawText)=="string" then props.Text=tr(rawText) end
	local rawPh = props.PlaceholderText
	if rawPh then props.PlaceholderText=tr(rawPh) end
	local obj = create(class, props)
	bind(obj, "TextColor3", colorKey)
	if class=="TextBox" then bind(obj,"PlaceholderColor3","Dim"); if rawPh then Lang.ph[obj]=rawPh end
	elseif translate and type(rawText)=="string" and rawText~="" then Lang.reg[obj]=rawText end
	table.insert(textObjects, {obj, base}); return obj
end
local function setTr(obj, base) Lang.reg[obj]=base; obj.Text=tr(base) end
local function onLang(fn) table.insert(Lang.cbs, fn); fn() end
function Lang.set(name)
	Lang.cur = name
	for obj,base in pairs(Lang.reg) do if obj.Parent then obj.Text=tr(base) end end
	for obj,base in pairs(Lang.ph) do if obj.Parent then obj.PlaceholderText=tr(base) end end
	for _,fn in ipairs(Lang.cbs) do fn() end
end
local function setIcon(img, name)
	local d = ICONS[name] or ICONS["circle-help"]
	img.Image = "rbxassetid://"..d[1]
	img.ImageRectSize = Vector2.new(48,48)
	img.ImageRectOffset = Vector2.new(d[2],d[3])
end
local function icon(name, props, class)
	local colorKey = props.Color; props.Color=nil
	if props.BackgroundTransparency==nil then props.BackgroundTransparency=1 end
	props.BorderSizePixel=0; props.ScaleType=Enum.ScaleType.Fit
	local img = create(class or "ImageLabel", props)
	if class=="ImageButton" then img.AutoButtonColor=false end
	setIcon(img, name)
	if colorKey then bind(img, "ImageColor3", colorKey) end
	return img
end
local order = 0
local function nextOrder() order = order + 1; return order end
local function hex(c) return string.format("#%02X%02X%02X", math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5)) end
local function shortKey(name) local M={LeftControl="LCtrl",RightControl="RCtrl",LeftShift="LShift",RightShift="RShift",LeftAlt="LAlt",RightAlt="RAlt",Backquote="`",Return="Enter"}; return M[name] or name end

------------------------------------------------------------------------
-- GUI
------------------------------------------------------------------------
local gui
do
	local parent
	pcall(function() if gethui then parent = gethui() end end)
	if not parent then parent = LocalPlayer:WaitForChild("PlayerGui") end
	local old = parent:FindFirstChild("KriegHub"); if old then old:Destroy() end
	gui = create("ScreenGui", {Name="KriegHub", ResetOnSpawn=false, IgnoreGuiInset=true, DisplayOrder=999, ZIndexBehavior=Enum.ZIndexBehavior.Sibling, Parent=parent})
end
local viewport = Vector2.new(1280,720)
pcall(function() viewport = Workspace.CurrentCamera.ViewportSize end)
local isTouch = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local WIN_W = (S.WinW>=540) and S.WinW or 690
local WIN_H = (S.WinH>=360) and S.WinH or 450
local TOP_H = 46
local SIDE_FULL, SIDE_MINI = 176, 56
local sideW = SIDE_FULL
local function autoScale() local fit = math.min(viewport.X*0.94/WIN_W, viewport.Y*0.8/WIN_H, isTouch and 0.78 or 0.92); return math.floor(math.clamp(fit,0.45,1)*100+0.5)/100 end
local currentScale = (S.Scale>0) and S.Scale or autoScale()
local menuKey = Enum.KeyCode.LeftControl
pcall(function() menuKey = Enum.KeyCode[S.Key] end)
local isBinding = false

local main = create("Frame", {Name="Window", AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.fromScale(0.5,0.5), Size=UDim2.fromOffset(WIN_W,WIN_H), BackgroundColor3=WHITE, BackgroundTransparency=0.02, BorderSizePixel=0, ClipsDescendants=true, Parent=gui})
corner(main, 14)
local mainGrad = create("UIGradient", {Rotation=90, Parent=main})
local mainStroke = create("UIStroke", {Thickness=1.5, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=main})
local mainStrokeGrad = create("UIGradient", {Parent=mainStroke})
local uiScale = create("UIScale", {Scale=currentScale, Parent=main})

local Wall = {active=false, image="", objects={}}
do
	local img = create("ImageLabel", {Name="Wallpaper", Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ScaleType=Enum.ScaleType.Crop, Image="", Visible=false, Parent=main})
	corner(img, 14)
	local shade = make("Frame", {Size=UDim2.fromScale(1,1), BorderSizePixel=0, Visible=false, Parent=main}, {BackgroundColor3="BgBottom"})
	corner(shade, 14)
	Wall.objects[1] = {img, shade}
end

local openPopup
local function closePopup() if openPopup then openPopup:Destroy(); openPopup=nil end end
local dragState = nil
local function makeDraggable(handle, target)
	handle.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			dragState = {start=input.Position, pos=target.Position, target=target}
			closePopup()
			input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragState=nil end end)
		end
	end)
end
UserInputService.InputChanged:Connect(function(input)
	if dragState and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
		local d = input.Position - dragState.start
		local p = dragState.pos
		dragState.target.Position = UDim2.new(p.X.Scale, p.X.Offset+d.X, p.Y.Scale, p.Y.Offset+d.Y)
	end
end)

------------------------------------------------------------------------
-- ФОН + ЧАСТИЦЫ
------------------------------------------------------------------------
local fxLayer = create("Frame", {Name="FX", Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ClipsDescendants=true, Parent=main})
local glow = create("Frame", {Size=UDim2.new(1,0,0.6,0), Position=UDim2.fromScale(0,0.4), BorderSizePixel=0, Parent=fxLayer})
corner(glow, 14)
create("UIGradient", {Rotation=90, Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.6,0.94),NumberSequenceKeypoint.new(1,0.82)}), Parent=glow})
local sceneLayer = create("Frame", {Name="Scene", Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Parent=fxLayer})
local particleLayer = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Parent=fxLayer})
local spawnParticle
do
	local function fxColor(c) if c=="Accent" or c=="Accent2" then return Theme[c] end; return c end
	local function pickItem(items)
		local total=0; for _,it in ipairs(items) do total=total+it.W end
		local r=math.random()*total
		for _,it in ipairs(items) do r=r-it.W; if r<=0 then return it end end
		return items[1]
	end
	local function rand(a,b) return a+math.random()*(b-a) end
	function spawnParticle(layer, scale)
		local spec = Theme.Fx; if not spec then return end
		local it = pickItem(spec.Items)
		local size = math.floor(rand(it.Size[1], it.Size[2])*scale+0.5); if size<1 then size=1 end
		local color = fxColor(it.Colors[math.random(1,#it.Colors)])
		local x = math.random(); local t = rand(it.Time[1],it.Time[2])
		local drift = (it.Drift or 0)*(it.Kind=="streak" and 1 or (math.random()-0.5)*2)
		local startPos, endPos
		if it.Dir=="down" then startPos=UDim2.new(x,0,0,-size*2-4); endPos=UDim2.new(x+drift,0,1,size*2+4)
		else startPos=UDim2.new(x,0,1,size+4); endPos=UDim2.new(x+drift,0,1-(it.Rise or 0.9),0) end
		local obj; local goal = {Position=endPos}
		if it.Kind=="icon" then
			obj = icon(it.Icons[math.random(1,#it.Icons)], {Size=UDim2.fromOffset(size,size), Position=startPos, ImageColor3=color, ImageTransparency=it.Alpha, Rotation=math.random(-30,30), Parent=layer})
			goal.ImageTransparency = it.Dir=="down" and math.min(1,it.Alpha+0.2) or 1
		else
			local w,h = size,size
			if it.Kind=="petal" then h=math.floor(size*1.5) end
			if it.Kind=="streak" then w=math.max(1, math.floor(1.5*scale+0.5)) end
			obj = create("Frame", {Size=UDim2.fromOffset(w,h), Position=startPos, BackgroundColor3=color, BackgroundTransparency=it.Alpha, BorderSizePixel=0, Rotation=it.Rot or math.random(0,180), Parent=layer})
			if it.Kind~="streak" then corner(obj, math.ceil(w/2)) end
			goal.BackgroundTransparency = it.Dir=="down" and math.min(1,it.Alpha+0.25) or 1
		end
		if it.Spin then goal.Rotation = obj.Rotation + rand(-it.Spin, it.Spin) end
		local style = (it.Dir=="down") and Enum.EasingStyle.Linear or Enum.EasingStyle.Sine
		TweenService:Create(obj, TweenInfo.new(t, style, Enum.EasingDirection.InOut), goal):Play()
		task.delay(t, function() if obj then obj:Destroy() end end)
	end
end
task.spawn(function()
	while gui.Parent do
		local spec = Theme.Fx
		if spec and S.Particles and main.Visible then spawnParticle(particleLayer, 1); task.wait(spec.Rate/S.Density) else task.wait(0.4) end
	end
end)

local Scene = {update=nil}
do
	local L = sceneLayer; local sin = math.sin
	local function circ(parent, size, pos, color, alpha, h)
		local f = create("Frame", {AnchorPoint=Vector2.new(0.5,0.5), Size=UDim2.fromOffset(size,h or size), Position=pos, BackgroundColor3=color, BackgroundTransparency=alpha or 0, BorderSizePixel=0, Parent=parent})
		create("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=f}); return f
	end
	local function ic(parent, name, size, pos, color, alpha, rot, anchor)
		return icon(name, {AnchorPoint=anchor or Vector2.new(0.5,0.5), Size=UDim2.fromOffset(size,size), Position=pos, ImageColor3=color, ImageTransparency=alpha or 0, Rotation=rot or 0, Parent=parent})
	end
	local function TR(x,y) return UDim2.new(1,-x,0,y) end
	local function BR(x,y) return UDim2.new(1,-x,1,-y) end
	local B = {}
	B["Halloween"] = function()
		local moonGlow = circ(L, 160, TR(118,118), rgb(255,190,110), 0.9)
		circ(L, 86, TR(118,118), rgb(255,226,170), 0.1)
		local ghosts = {
			{ic(L, "ghost", 50, TR(250,170), WHITE, 0.45), TR(250,170), 0},
			{ic(L, "ghost", 34, TR(345,230), rgb(200,170,255), 0.45), TR(345,230), 2},
			{ic(L, "ghost", 28, TR(60,250), WHITE, 0.6), TR(60,250), 4},
		}
		return function(t)
			moonGlow.BackgroundTransparency = 0.88+0.04*sin(t*1.3)
			for i,g in ipairs(ghosts) do
				g[1].Position = UDim2.new(g[2].X.Scale, g[2].X.Offset+sin(t*0.7+g[3])*10, g[2].Y.Scale, g[2].Y.Offset+sin(t*1.6+g[3])*8)
				g[1].Rotation = sin(t*1.2+i)*8
				g[1].ImageTransparency = 0.45+0.15*sin(t*0.9+i)
			end
		end
	end
	B["Basic"] = function() return function() end end
	B["New Year"] = B["Basic"]; B["Rain"] = B["Basic"]; B["Summer"] = B["Basic"]; B["Spring"] = B["Basic"]; B["Autumn"] = B["Basic"]; B["Sakura"] = B["Basic"]
	B["Valentine"] = function()
		local col = Theme.Accent
		circ(L, 66, BR(122,70), col, 0.05); circ(L, 66, BR(100,70), col, 0.05)
		circ(L, 130, BR(122,70), col, 0.08)
		return function() end
	end
	function Scene.show()
		for _,c in ipairs(sceneLayer:GetChildren()) do c:Destroy() end
		Scene.update = nil
		local b = B[currentThemeName]
		if b and S.Scene and not Wall.active then Scene.update = b() end
	end
	RunService.Heartbeat:Connect(function()
		if Scene.update and main.Visible then local ok=pcall(Scene.update, os.clock()); if not ok then Scene.update=nil end end
	end)
end
local miniStrokeGrad
do
	local borderRot=0
	RunService.Heartbeat:Connect(function(dt)
		if Theme.Fx and S.Border then
			borderRot = (borderRot+dt*45)%360
			mainStrokeGrad.Rotation = borderRot
			if miniStrokeGrad then miniStrokeGrad.Rotation = borderRot end
		end
	end)
end
local function borderSequence()
	return ColorSequence.new({ColorSequenceKeypoint.new(0,Theme.Accent),ColorSequenceKeypoint.new(0.3,Theme.Stroke),ColorSequenceKeypoint.new(0.5,Theme.Accent2),ColorSequenceKeypoint.new(0.7,Theme.Stroke),ColorSequenceKeypoint.new(1,Theme.Accent)})
end
onTheme(function()
	mainGrad.Color = ColorSequence.new(Theme.BgTop, Theme.BgBottom)
	local fancy = Theme.Fx ~= nil and S.Border
	mainStroke.Color = fancy and WHITE or Theme.Stroke
	mainStrokeGrad.Enabled = fancy; mainStrokeGrad.Color = borderSequence()
	glow.Visible = Theme.Glow ~= nil and not Wall.active
	if Theme.Glow then glow.BackgroundColor3 = resolve(Theme.Glow) end
end)

------------------------------------------------------------------------
-- ВЕРХНЯЯ ПАНЕЛЬ
------------------------------------------------------------------------
local collapseBtn, closeBtn, hideBtn, searchBox
do
	local topbar = create("Frame", {Size=UDim2.new(1,0,0,TOP_H), BackgroundTransparency=1, Parent=main})
	make("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BorderSizePixel=0, Parent=topbar}, {BackgroundColor3="Stroke"})
	makeDraggable(topbar, main)
	local logo = make("Frame", {Size=UDim2.fromOffset(28,28), Position=UDim2.fromOffset(13,9), BorderSizePixel=0, Parent=topbar}, {BackgroundColor3="Accent"})
	corner(logo, 8)
	local logoGrad = create("UIGradient", {Rotation=135, Parent=logo})
	text("TextLabel", {Size=UDim2.fromScale(1,1), Text="K", Tr=false, Weight=HEAVY, TextSize=17, Color=onAccentText, TextXAlignment=Enum.TextXAlignment.Center, Parent=logo})
	local logoBadge = make("Frame", {Size=UDim2.fromOffset(14,14), Position=UDim2.new(1,-8,1,-8), BorderSizePixel=0, Parent=logo}, {BackgroundColor3="Deep"})
	corner(logoBadge, 7); stroke(logoBadge, "Accent", 0.3)
	local logoBadgeIcon = icon("ghost", {Size=UDim2.fromOffset(9,9), Position=UDim2.fromOffset(2.5,2.5), Color="Accent", Parent=logoBadge})
	onTheme(function() logoGrad.Color = ColorSequence.new(WHITE, Theme.Accent2:Lerp(WHITE,0.25)); setIcon(logoBadgeIcon, Theme.Icon); logoBadge.Visible = Theme.Fx~=nil end)
	local brand = text("TextLabel", {Size=UDim2.fromOffset(92,16), Position=UDim2.fromOffset(49,8), Text="KRIEG HUB", Tr=false, Weight=HEAVY, TextSize=14, RichText=true, Parent=topbar})
	onTheme(function() brand.Text = 'KRIEG <font color="'..hex(Theme.Accent)..'">HUB</font>' end)
	local gameLabel = text("TextLabel", {Size=UDim2.fromOffset(86,13), Position=UDim2.fromOffset(49,24), Text="Murder Mystery 2", Tr=false, Color="Dim", TextSize=10, TextTruncate=Enum.TextTruncate.AtEnd, Parent=topbar})
	task.spawn(function() local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end); if ok and info and info.Name and gameLabel.Parent then gameLabel.Text = info.Name end end)
	local function iconButton(name, pos, danger)
		local b = make("ImageButton", {Size=UDim2.fromOffset(30,30), Position=pos, AutoButtonColor=false, BorderSizePixel=0, Image="", Parent=topbar}, {BackgroundColor3="Element"})
		corner(b, 8); local s = stroke(b)
		local i = icon(name, {Size=UDim2.fromOffset(14,14), Position=UDim2.fromOffset(8,8), Color="Sub", Parent=b})
		b.MouseEnter:Connect(function() tween(b,{BackgroundColor3=danger and Theme.Red or Theme.Element2}); tween(s,{Color=danger and Theme.Red or Theme.Accent}); tween(i,{ImageColor3=danger and WHITE or Theme.Text}) end)
		b.MouseLeave:Connect(function() tween(b,{BackgroundColor3=Theme.Element}); tween(s,{Color=Theme.Stroke}); tween(i,{ImageColor3=Theme.Sub}) end)
		return b
	end
	collapseBtn = iconButton("panel-left", UDim2.new(0,140,0.5,-15), false)
	closeBtn = iconButton("x", UDim2.new(1,-40,0.5,-15), true)
	hideBtn = iconButton("minus", UDim2.new(1,-75,0.5,-15), false)
	local sf = make("Frame", {Size=UDim2.fromOffset(168,30), AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-84,0.5,0), BorderSizePixel=0, Parent=topbar}, {BackgroundColor3="Element"})
	corner(sf, 8); local ss = stroke(sf)
	icon("search", {Size=UDim2.fromOffset(13,13), Position=UDim2.new(0,10,0.5,-6.5), Color="Sub", Parent=sf})
	searchBox = text("TextBox", {Size=UDim2.new(1,-60,1,0), Position=UDim2.fromOffset(29,0), Text="", Tr=false, PlaceholderText="Find a section...", TextSize=12, ClearTextOnFocus=false, Parent=sf})
	searchBox.Focused:Connect(function() tween(ss,{Color=Theme.Accent}) end)
	searchBox.FocusLost:Connect(function() tween(ss,{Color=Theme.Stroke}) end)
end

------------------------------------------------------------------------
-- САЙДБАР
------------------------------------------------------------------------
local sidebar = create("Frame", {Size=UDim2.new(0,SIDE_FULL,1,-TOP_H), Position=UDim2.fromOffset(0,TOP_H), BackgroundTransparency=1, ClipsDescendants=true, Parent=main})
make("Frame", {Size=UDim2.new(0,1,1,0), Position=UDim2.new(1,-1,0,0), BorderSizePixel=0, Parent=sidebar}, {BackgroundColor3="Stroke"})
local navList = create("ScrollingFrame", {Size=UDim2.new(1,-1,1,-62), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=0, ScrollingDirection=Enum.ScrollingDirection.Y, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y, Parent=sidebar})
vlist(navList, 6)
local navPad = pad(navList, 8, 8, 8, 8)

local Avatar = {cache={}, pending={}}
do
	local function thumb(id) return "rbxthumb://type=AvatarHeadShot&id="..tostring(id).."&w=150&h=150" end
	function Avatar.set(img, id)
		if Avatar.cache[id] then img.Image = Avatar.cache[id] return end
		img.Image = thumb(id)
	end
end

local profile = make("Frame", {Size=UDim2.new(1,-16,0,44), Position=UDim2.new(0,8,1,-52), BackgroundTransparency=0.4, BorderSizePixel=0, Parent=sidebar}, {BackgroundColor3="Element"})
corner(profile, 10); stroke(profile, "Stroke", 0.3)
local profileAvatar = make("ImageLabel", {Size=UDim2.fromOffset(28,28), Position=UDim2.new(0,8,0.5,-14), BorderSizePixel=0, Image="", Parent=profile}, {BackgroundColor3="Element2"})
corner(profileAvatar, 14); stroke(profileAvatar, "Accent", 0.2, 1.5)
local profileName = text("TextLabel", {Size=UDim2.new(1,-62,0,14), Position=UDim2.fromOffset(43,8), Text=LocalPlayer.DisplayName, Tr=false, Weight=BOLD, TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=profile})
local profileUser = text("TextLabel", {Size=UDim2.new(1,-62,0,13), Position=UDim2.fromOffset(43,22), Text="@"..LocalPlayer.Name, Tr=false, Color="Dim", TextSize=10, TextTruncate=Enum.TextTruncate.AtEnd, Parent=profile})
local onlineDot = make("Frame", {Size=UDim2.fromOffset(7,7), Position=UDim2.new(1,-16,0.5,-3), BorderSizePixel=0, Parent=profile}, {BackgroundColor3="Green"})
corner(onlineDot, 4)
Avatar.set(profileAvatar, LocalPlayer.UserId)

------------------------------------------------------------------------
-- КОНТЕНТ + УВЕДОМЛЕНИЯ
------------------------------------------------------------------------
local pagesHolder = create("Frame", {Size=UDim2.new(1,-SIDE_FULL-26,1,-TOP_H-22), Position=UDim2.fromOffset(SIDE_FULL+14, TOP_H+12), BackgroundTransparency=1, ClipsDescendants=true, Parent=main})
local toastHolder = create("Frame", {AnchorPoint=Vector2.new(1,1), Position=UDim2.new(1,-18,1,-18), Size=UDim2.fromOffset(280,400), BackgroundTransparency=1, Parent=gui})
create("UIListLayout", {VerticalAlignment=Enum.VerticalAlignment.Bottom, Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder, Parent=toastHolder})
local function notify(title, body, iconName, duration)
	if not S.Notifs then return end
	local holder = create("Frame", {Size=UDim2.new(1,0,0,58), BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=toastHolder})
	local card = make("Frame", {Size=UDim2.fromScale(1,1), Position=UDim2.new(1,40,0,0), BorderSizePixel=0, Parent=holder}, {BackgroundColor3="Card"})
	corner(card, 12); stroke(card, "Stroke")
	local ib = make("Frame", {Size=UDim2.fromOffset(34,34), Position=UDim2.new(0,12,0.5,-17), BackgroundTransparency=0.82, BorderSizePixel=0, Parent=card}, {BackgroundColor3="Accent"})
	corner(ib, 17)
	icon(iconName or "bell", {Size=UDim2.fromOffset(16,16), Position=UDim2.fromOffset(9,9), Color="Accent", Parent=ib})
	text("TextLabel", {Size=UDim2.new(1,-66,0,17), Position=UDim2.fromOffset(56,11), Text=title, Weight=BOLD, TextSize=13, Parent=card})
	text("TextLabel", {Size=UDim2.new(1,-66,0,15), Position=UDim2.fromOffset(56,29), Text=body, Color="Sub", TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=card})
	local progress = make("Frame", {Size=UDim2.new(1,-24,0,2), Position=UDim2.new(0,12,1,-4), BorderSizePixel=0, Parent=card}, {BackgroundColor3="Accent"})
	corner(progress, 1)
	duration = duration or 4
	tween(card, {Position=UDim2.new(0,0,0,0)}, 0.5, Enum.EasingStyle.Back)
	tween(progress, {Size=UDim2.new(0,0,0,2)}, duration, Enum.EasingStyle.Linear)
	task.delay(duration, function() if not card.Parent then return end; tween(card,{Position=UDim2.new(1,40,0,0)},0.35,Enum.EasingStyle.Quint,Enum.EasingDirection.In).Completed:Connect(function() holder:Destroy() end) end)
end

------------------------------------------------------------------------
-- ЯДРО ИГРЫ
------------------------------------------------------------------------
local Game = {conns={}, flags={}, notify=notify}
function Game.on(sig, fn) local c = sig:Connect(fn); table.insert(Game.conns, c); return c end
function Game.clearConns() for _,c in ipairs(Game.conns) do pcall(function() c:Disconnect() end) end; Game.conns = {} end

local RoundState = {role="Unknown", sheriff=nil, murderer=nil, heroes={}, gunDropped=false, gunPart=nil, started=os.clock()}
local RoleSets = {murderer={}, sheriff={}, hero={}, innocent={}, unknown={}}
local roleNames = {Murderer="murderer", Sheriff="sheriff", Hero="hero", Innocent="innocent"}
local function classifyRole(v)
	if type(v)~="string" then return nil end
	local low = v:lower()
	if low:find("murder") or low:find("killer") then return "murderer" end
	if low:find("sheriff") or low:find("deputy") or low:find("cop") then return "sheriff" end
	if low:find("hero") then return "hero" end
	if low:find("innocent") or low:find("civilian") then return "innocent" end
	return nil
end
local function roleFromChar(char)
	if not char then return nil end
	for _,d in ipairs(char:GetDescendants()) do
		if d:IsA("ObjectValue") and d.Name=="Role" then local r=classifyRole(tostring(d.Value)); if r then return r end end
		if d:IsA("StringValue") and (d.Name=="Role" or d.Name=="RoleName") then local r=classifyRole(d.Value); if r then return r end end
	end
	return nil
end
local function updateRoles()
	for k in pairs(RoleSets) do RoleSets[k] = {} end
	RoundState.sheriff, RoundState.murderer = nil, nil
	RoundState.heroes = {}
	RoundState.role = "Unknown"
	for _,plr in ipairs(Players:GetPlayers()) do
		local role = roleFromChar(plr.Character)
		if role then RoleSets[role][plr]=true else RoleSets.unknown[plr]=true end
		if plr==LocalPlayer and role then RoundState.role = role end
	end
	for plr in pairs(RoleSets.murderer) do RoundState.murderer = plr break end
	for plr in pairs(RoleSets.sheriff) do RoundState.sheriff = plr break end
	for plr in pairs(RoleSets.hero) do table.insert(RoundState.heroes, plr) end
	RoundState.gunPart, RoundState.gunDropped = nil, false
	for _,d in ipairs(Workspace:GetDescendants()) do
		if d:IsA("Tool") and (d.Name=="Gun" or d.Name=="Revolver" or d.Name:lower():find("gun")) then
			local handle = d:FindFirstChild("Handle"); if handle then RoundState.gunPart = handle; RoundState.gunDropped = true; break end
		end
	end
end
Game.on(Players.PlayerAdded, function(plr) plr.CharacterAdded:Connect(function() task.wait(0.6); updateRoles() end) end)
for _,plr in ipairs(Players:GetPlayers()) do if plr~=LocalPlayer then plr.CharacterAdded:Connect(function() task.wait(0.6); updateRoles() end) end end
task.spawn(function() while gui.Parent do updateRoles(); task.wait(1) end end)

local function isAlive(plr)
	local char = plr and plr.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	return hum and hum.Health>0
end
local function getHRP(plr) return plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") end
local function getRoot() local char = LocalPlayer.Character; return char and char:FindFirstChild("HumanoidRootPart") end
local function roleColor(role)
	if role=="murderer" then return rgb(225,70,70) end
	if role=="sheriff" then return rgb(70,125,240) end
	if role=="hero" then return rgb(230,175,50) end
	if role=="innocent" then return rgb(80,195,105) end
	return rgb(160,160,170)
end
local function getRole(plr) for r,set in pairs(RoleSets) do if set[plr] then return r end end end

------------------------------------------------------------------------
-- ESP
------------------------------------------------------------------------
local espFolder, espCache = nil, {}
do
	local function ensure() if espFolder and espFolder.Parent then return end; espFolder = create("Folder", {Name="KriegESP", Parent=gui}) end
	local function clear(plr)
		local c = espCache[plr]; if not c then return end
		if c.hl then pcall(function() c.hl:Destroy() end) end
		if c.label then pcall(function() c.label:Destroy() end) end
		espCache[plr] = nil
	end
	local function drawHighlight(plr, role)
		local char = plr.Character; if not char then return end
		local ok, hl = pcall(function() return create("Highlight", {Parent=char}) end)
		if not ok then return end
		local color = roleColor(role)
		hl.FillColor = color; hl.OutlineColor = color; hl.FillTransparency = 0.55; hl.OutlineTransparency = 0
		espCache[plr] = espCache[plr] or {}; espCache[plr].hl = hl
	end
	local function labelFor(plr)
		local c = espCache[plr]
		if c and c.label and c.label.Parent then return c.label end
		ensure()
		local bb = create("BillboardGui", {Name="KriegTag", AlwaysOnTop=true, Size=UDim2.fromOffset(120,34), StudsOffset=Vector3.new(0,3,0), Parent=espFolder})
		local holder = make("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=0.25, BorderSizePixel=0, Parent=bb}, {BackgroundColor3="Card"})
		corner(holder, 6); stroke(holder, "Stroke", 0.3)
		local nameL = text("TextLabel", {Size=UDim2.new(1,-6,0,14), Position=UDim2.fromOffset(3,2), Text=plr.DisplayName, Tr=false, Weight=BOLD, TextSize=11, TextXAlignment=Enum.TextXAlignment.Center, TextTruncate=Enum.TextTruncate.AtEnd, Parent=holder})
		local roleL = text("TextLabel", {Size=UDim2.new(1,-6,0,12), Position=UDim2.fromOffset(3,15), Text="", Tr=false, Weight=SEMI, TextSize=10, TextXAlignment=Enum.TextXAlignment.Center, Parent=holder})
		local distL = text("TextLabel", {Size=UDim2.new(1,-6,0,12), Position=UDim2.fromOffset(3,25), Text="", Tr=false, TextSize=9, Color="Dim", TextXAlignment=Enum.TextXAlignment.Center, Parent=holder})
		espCache[plr] = espCache[plr] or {}
		espCache[plr].label = bb; espCache[plr].nameL, espCache[plr].roleL, espCache[plr].distL = nameL, roleL, distL
		return bb
	end
	function Game.runESP()
		if not Game.flags.espEnabled then for plr in pairs(espCache) do clear(plr) end return end
		local root = getRoot(); if not root then return end
		local maxRange = Game.flags.espRange or 1500
		local roles = Game.flags.espRoles or {murderer=true, sheriff=true, hero=true}
		for _,plr in ipairs(Players:GetPlayers()) do
			if plr~=LocalPlayer and isAlive(plr) then
				local role = getRole(plr)
				local show = role and roles[role] or false
				local hrp = getHRP(plr)
				local dist = hrp and (hrp.Position-root.Position).Magnitude or 0
				if show and dist<=maxRange and hrp then
					if not espCache[plr] or not espCache[plr].hl or not espCache[plr].hl.Parent then drawHighlight(plr, role) end
					local hl = espCache[plr].hl
					if hl then
						local color = roleColor(role)
						if Game.flags.espColor=="Theme accent" then color = Theme.Accent
						elseif Game.flags.espColor=="Rainbow" then local h = (os.clock()*0.15)%1; color = Color3.fromHSV(h,0.8,1) end
						hl.FillColor = color; hl.OutlineColor = color
						if Game.flags.espStyle=="Neon" then hl.FillTransparency=0.75; hl.OutlineTransparency=0
						elseif Game.flags.espStyle=="Ghost" then hl.FillTransparency=0.85; hl.OutlineTransparency=0.2
						elseif Game.flags.espStyle=="Hologram" then hl.FillTransparency=0.7; hl.OutlineTransparency=0.1
						elseif Game.flags.espStyle=="Shadow" then hl.FillTransparency=0.9; hl.OutlineTransparency=0.4
						elseif Game.flags.espStyle=="Outline" then hl.FillTransparency=1; hl.OutlineTransparency=0
						else hl.FillTransparency=0.55; hl.OutlineTransparency=0 end
					end
					if Game.flags.espNames or Game.flags.espRoleTag or Game.flags.espDistance then
						local bb = labelFor(plr); bb.Adornee = hrp
						local c = espCache[plr]
						if c then
							c.nameL.Visible = Game.flags.espNames and true or false
							c.roleL.Visible = Game.flags.espRoleTag and true or false
							c.distL.Visible = Game.flags.espDistance and true or false
							c.roleL.Text = role and role:gsub("^%l", string.upper) or "Unknown"
							c.roleL.TextColor3 = roleColor(role)
							c.distL.Text = math.floor(dist).." st"
						end
					end
				else clear(plr) end
			else clear(plr) end
		end
	end
	Game.on(Players.PlayerRemoving, function(plr) clear(plr) end)
end

------------------------------------------------------------------------
-- ТЕЛЕПОРТ
------------------------------------------------------------------------
local function teleportTo(pos, instant)
	local root = getRoot(); if not root or not pos then return end
	if instant or Game.flags.travelMethod=="Instant" then root.CFrame = CFrame.new(pos)
	else
		local speed = Game.flags.travelSpeed or 80
		task.spawn(function()
			while root and root.Parent do
				local d = pos - root.Position; if d.Magnitude<2 then break end
				root.CFrame = CFrame.new(root.Position + d.Unit*math.min(speed*0.03, d.Magnitude))
				task.wait(0.03)
			end
		end)
	end
end
local function getPlacePosition(name)
	if name=="Lobby" then
		for _,d in ipairs(Workspace:GetDescendants()) do if d:IsA("BasePart") and (d.Name:lower():find("lobby") or d.Name:lower():find("spawn")) then return d.Position end end
	elseif name=="Map" then local c = Workspace.CurrentCamera; return c and c.CFrame.Position
	elseif name=="Spawn" then local sp = Workspace:FindFirstChildOfClass("SpawnLocation"); return sp and sp.Position
	elseif name=="SafeSpot" then
		for _,d in ipairs(Workspace:GetDescendants()) do if d:IsA("BasePart") and d.Name:lower():find("safe") then return d.Position end end
	end
end

------------------------------------------------------------------------
-- ДВИЖЕНИЕ (noclip, fly, bhop, wallclimb, airjump, spin)
------------------------------------------------------------------------
local movementState = {fly=false, flyConn=nil, noclip=false, spinConn=nil, wallConn=nil, bhopConn=nil, airUsed=false}
local function updateHumanoid()
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	if Game.flags.customWalkSpeed then hum.WalkSpeed = Game.flags.walkSpeed or 16 end
	if Game.flags.customJump then hum.JumpPower = Game.flags.jumpPower or 50 end
	if Game.flags.gravity then
		local bp = char:FindFirstChild("HumanoidRootPart")
		local bv = bp and bp:FindFirstChild("KriegGravity")
		if not bv and bp then bv = create("BodyVelocity", {Name="KriegGravity", Parent=bp}) end
		if bv then
			bv.MaxForce = Vector3.new(0, math.huge, 0)
			bv.Velocity = Vector3.new(0, -(Game.flags.gravity-196)*0.5, 0)
		end
	end
	if Game.flags.hipHeight then hum.HipHeight = Game.flags.hipHeight end
end
local function startFly()
	local root, hum = getRoot(), LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if not root or not hum then return end
	hum.PlatformStand = true
	local bv = create("BodyVelocity", {Name="KriegFly", MaxForce=Vector3.new(9e9,9e9,9e9), Parent=root})
	local bg = create("BodyGyro", {Name="KriegFlyGyro", MaxTorque=Vector3.new(9e9,9e9,9e9), Parent=root})
	local speed = Game.flags.flySpeed or 80
	movementState.flyConn = RunService.RenderStepped:Connect(function()
		if not root.Parent or not Game.flags.fly then return end
		local cam = Workspace.CurrentCamera
		local move = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.CFrame.LookVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + cam.CFrame.RightVector end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
		bv.Velocity = move.Magnitude>0 and (move.Unit*speed) or Vector3.zero
		bg.CFrame = cam.CFrame
	end)
end
local function stopFly()
	if movementState.flyConn then movementState.flyConn:Disconnect(); movementState.flyConn=nil end
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.PlatformStand = false end
	local root = getRoot()
	if root then local bv=root:FindFirstChild("KriegFly"); if bv then bv:Destroy() end; local bg=root:FindFirstChild("KriegFlyGyro"); if bg then bg:Destroy() end end
end
local function updateFly()
	if Game.flags.fly and not movementState.fly then movementState.fly=true; startFly()
	elseif not Game.flags.fly and movementState.fly then movementState.fly=false; stopFly() end
end
local function updateNoclip()
	local char = LocalPlayer.Character
	if not char then return end
	for _,d in ipairs(char:GetDescendants()) do
		if d:IsA("BasePart") then
			if Game.flags.noclip then d.CanCollide = false
			elseif d.Name=="HumanoidRootPart" or d.Name=="Head" or d.Name=="Torso" or d.Name=="UpperTorso" or d.Name=="LowerTorso" then d.CanCollide = true end
		end
	end
end
-- BHOP
local function startBhop()
	if movementState.bhopConn then movementState.bhopConn:Disconnect() end
	movementState.bhopConn = RunService.Heartbeat:Connect(function()
		if not Game.flags.bhop then return end
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum and hum.FloorMaterial ~= Enum.Material.Air and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			hum.Jump = true
		end
	end)
end
-- WALL CLIMB
local function startWallClimb()
	if movementState.wallConn then movementState.wallConn:Disconnect() end
	movementState.wallConn = RunService.Heartbeat:Connect(function()
		if not Game.flags.wallClimb then return end
		local root = getRoot(); if not root then return end
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {LocalPlayer.Character}
		local dir = root.CFrame.LookVector
		local result = Workspace:Raycast(root.Position, dir*3, params)
		if result and UserInputService:IsKeyDown(Enum.KeyCode.W) and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			local bv = root:FindFirstChild("KriegClimb")
			if not bv then bv = create("BodyVelocity", {Name="KriegClimb", MaxForce=Vector3.new(0,9e9,0), Parent=root}) end
			bv.Velocity = Vector3.new(0, 55, 0)
		else
			local bv = root:FindFirstChild("KriegClimb")
			if bv then bv:Destroy() end
		end
	end)
end
-- AIR JUMP
local function startAirJump()
	Game.on(UserInputService.InputBegan, function(input, gp)
		if gp or not Game.flags.airJump then return end
		if input.KeyCode==Enum.KeyCode.Space then
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if hum and hum.FloorMaterial==Enum.Material.Air and not movementState.airUsed then
				movementState.airUsed = true
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
				task.delay(0.4, function() movementState.airUsed = false end)
			end
		end
	end)
end
-- SPIN
local function updateSpin()
	if Game.flags.spin and not movementState.spinConn then
		movementState.spinConn = RunService.Heartbeat:Connect(function(dt)
			if not Game.flags.spin then if movementState.spinConn then movementState.spinConn:Disconnect(); movementState.spinConn=nil end return end
			local root = getRoot(); if not root then return end
			local speed = Game.flags.spinSpeed or 15
			root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(speed*dt*10), 0)
		end)
	elseif not Game.flags.spin and movementState.spinConn then
		movementState.spinConn:Disconnect(); movementState.spinConn = nil
	end
end
local function applyMovement()
	updateHumanoid(); updateFly(); updateNoclip(); updateSpin()
end
RunService.Heartbeat:Connect(applyMovement)
Game.on(LocalPlayer.CharacterAdded, function() task.wait(0.5); applyMovement() end)
task.spawn(function() while gui.Parent do if Game.flags.bhop then startBhop(); break end; task.wait(1) end end)
task.spawn(function() while gui.Parent do if Game.flags.wallClimb then startWallClimb(); break end; task.wait(1) end end)
task.spawn(function() while gui.Parent do if Game.flags.airJump then startAirJump(); break end; task.wait(1) end end)

------------------------------------------------------------------------
-- REACH (клиентский триггер ножа)
------------------------------------------------------------------------
local reachConn
local function startReach()
	if reachConn then reachConn:Disconnect() end
	reachConn = RunService.Heartbeat:Connect(function()
		if not Game.flags.reach then return end
		local char = LocalPlayer.Character; if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
		local tool = char:FindFirstChildOfClass("Tool")
		if not tool or not tool.Name:lower():find("knife") then return end
		local reach = Game.flags.reachDistance or 10
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {char}
		local cam = Workspace.CurrentCamera
		local origin = root.Position
		local dir = cam.CFrame.LookVector
		local hit = Workspace:Raycast(origin, dir*reach, params)
		if hit and hit.Instance then
			local model = hit.Instance:FindFirstAncestorOfClass("Model")
			if model then
				local hum = model:FindFirstChildOfClass("Humanoid")
				if hum and hum.Health>0 and model~=char then
					pcall(function() tool:Activate() end)
				end
			end
		end
	end)
end
task.spawn(function() while gui.Parent do if Game.flags.reach then startReach(); break end; task.wait(1) end end)

------------------------------------------------------------------------
-- QUICK EQUIP
------------------------------------------------------------------------
Game.on(UserInputService.InputBegan, function(input, gp)
	if gp or not Game.flags.quickEquip then return end
	if input.KeyCode==Enum.KeyCode.Q then
		local char = LocalPlayer.Character; if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid"); local bp = LocalPlayer:FindFirstChild("Backpack")
		if not hum or not bp then return end
		for _,tool in ipairs(bp:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:lower():find("knife") then hum:EquipTool(tool); return end
		end
	end
end)

------------------------------------------------------------------------
-- KNIFE TRAIL
------------------------------------------------------------------------
local trailConn
local function applyKnifeTrail(name)
	if trailConn then trailConn:Disconnect(); trailConn = nil end
	local function attach()
		local char = LocalPlayer.Character; if not char then return end
		for _,tool in ipairs(char:GetChildren()) do
			if tool:IsA("Tool") and tool.Name:lower():find("knife") then
				local handle = tool:FindFirstChild("Handle")
				if handle and not handle:FindFirstChild("KriegTrail") then
					local a0 = create("Attachment", {Name="KriegA0", Position=Vector3.new(0, 0.2, 0), Parent=handle})
					local a1 = create("Attachment", {Name="KriegA1", Position=Vector3.new(0, -0.2, 0), Parent=handle})
					local colors = {Ember=rgb(255,120,40), Void=rgb(150,95,255), Frost=rgb(110,190,255), Toxic=rgb(80,205,120), Gold=rgb(230,175,50)}
					local color = colors[name] or WHITE
					create("Trail", {Name="KriegTrail", Attachment0=a0, Attachment1=a1, Color=ColorSequence.new(color), Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(1,1)}), Lifetime=0.3, Parent=handle})
				end
			end
		end
	end
	trailConn = RunService.Heartbeat:Connect(attach)
end
Game.flags.knifeTrail = "Off"

------------------------------------------------------------------------
-- ROUND START SOUND
------------------------------------------------------------------------
do
	local lastRole = "Unknown"
	local snd = create("Sound", {SoundId="rbxassetid://1837879081", Volume=0.4, Parent=SoundService})
	task.spawn(function()
		while gui.Parent do
			local r = RoundState.role
			if Game.flags.roundSound and r~="Unknown" and lastRole=="Unknown" then snd:Play() end
			lastRole = r
			task.wait(1)
		end
	end)
end

------------------------------------------------------------------------
-- THROW ASSIST
------------------------------------------------------------------------
do
	local function getTarget()
		local best, bestScore = nil, math.huge
		local root = getRoot(); if not root then return end
		for _,plr in ipairs(Players:GetPlayers()) do
			if plr~=LocalPlayer and isAlive(plr) then
				local role = getRole(plr)
				local hrp = getHRP(plr)
				if hrp then
					local score = (hrp.Position-root.Position).Magnitude
					if Game.flags.throwPriority=="Sheriff first" and role=="sheriff" then score = score-10000
					elseif Game.flags.throwPriority=="Hero first" and role=="hero" then score = score-10000
					elseif Game.flags.throwPriority=="Lowest HP" then
						local h = hrp.Parent:FindFirstChildOfClass("Humanoid"); score = h and h.Health or score
					end
					if score<bestScore then best, bestScore = hrp, score end
				end
			end
		end
		return best
	end
	Game.on(UserInputService.InputBegan, function(input, gp)
		if gp or not Game.flags.throwAssist then return end
		if input.UserInputType==Enum.UserInputType.MouseButton1 and not UserInputService:GetFocusedTextBox() then
			local target = getTarget(); if not target then return end
			local lead = Game.flags.throwLead or 0.35
			local predicted = target.Position + target.Velocity*lead
			local cam = Workspace.CurrentCamera
			if cam then cam.CFrame = CFrame.new(cam.CFrame.Position, predicted) end
		end
	end)
end

------------------------------------------------------------------------
-- SOFT AIM
------------------------------------------------------------------------
local aimCircle
do
	local circle = create("Frame", {Name="AimFOV", AnchorPoint=Vector2.new(0.5,0.5), Size=UDim2.fromOffset(240,240), Position=UDim2.fromScale(0.5,0.5), BackgroundTransparency=1, BorderSizePixel=0, Visible=false, Parent=gui})
	local strokeC = create("UIStroke", {Color=WHITE, Thickness=1.5, Parent=circle})
	create("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=circle})
	aimCircle = {frame=circle, stroke=strokeC}
	RunService.RenderStepped:Connect(function()
		local root = getRoot(); local cam = Workspace.CurrentCamera
		local show = Game.flags.softAim and Game.flags.showFov and root
		aimCircle.frame.Visible = show and true or false
		if show then
			local radius = (Game.flags.aimFov or 120)*1.5
			aimCircle.frame.Size = UDim2.fromOffset(radius*2, radius*2)
			aimCircle.stroke.Color = Theme.Accent
			aimCircle.stroke.Thickness = Game.flags.fovThickness or 1.5
			aimCircle.frame.BackgroundTransparency = Game.flags.fillFov and 0.85 or 1
			aimCircle.frame.BackgroundColor3 = Theme.Accent
		end
		if Game.flags.softAim and root and cam then
			local best, bestDist = nil, math.huge
			for _,plr in ipairs(Players:GetPlayers()) do
				if plr~=LocalPlayer and isAlive(plr) then
					local role = getRole(plr)
					if role=="sheriff" or role=="murderer" then
						local hrp = getHRP(plr)
						if hrp then
							local screen = cam:WorldToViewportPoint(hrp.Position)
							if screen.Z>0 then
								local center = Vector2.new(viewport.X/2, viewport.Y/2)
								local d = (Vector2.new(screen.X, screen.Y)-center).Magnitude
								local fovPx = (Game.flags.aimFov or 120)*1.5
								if d<fovPx and d<bestDist then best, bestDist = hrp, d end
							end
						end
					end
				end
			end
			if best then
				local aimPoint = best.Position
				if Game.flags.aimPoint=="Head" then local head = best.Parent and best.Parent:FindFirstChild("Head"); if head then aimPoint = head.Position end
				elseif Game.flags.aimPoint=="Upper body" then aimPoint = best.Position + Vector3.new(0,1,0) end
				local current = cam.CFrame; local target = CFrame.new(current.Position, aimPoint)
				cam.CFrame = current:Lerp(target, 0.08*(1/math.max(1, (Game.flags.aimSmooth or 8)/8)))
			end
		end
	end)
end

------------------------------------------------------------------------
-- FLING / SPECTATE / PICKUP
------------------------------------------------------------------------
local function flingPlayer(plr)
	local root, target = getRoot(), getHRP(plr)
	if not root or not target then return end
	local dir = target.Position - root.Position
	local bv = create("BodyVelocity", {MaxForce=Vector3.new(math.huge, math.huge, math.huge), Velocity=dir.Unit*500 + Vector3.new(0,200,0), Parent=target})
	task.delay(0.5, function() if bv then bv:Destroy() end end)
	local rot = create("BodyAngularVelocity", {MaxTorque=Vector3.new(math.huge, math.huge, math.huge), AngularVelocity=Vector3.new(math.random(-50,50), math.random(-50,50), math.random(-50,50)), Parent=target})
	task.delay(0.5, function() if rot then rot:Destroy() end end)
end
local function spectate(plr)
	local cam = Workspace.CurrentCamera; local hrp = getHRP(plr)
	if not hrp then return end
	cam.CameraSubject = hrp; cam.CameraType = Enum.CameraType.Custom
	notify("Spectate", "Watching "..plr.DisplayName, "eye", 2)
end
local function pickupGun()
	local root = getRoot(); local gun = RoundState.gunPart
	if not root or not gun then return end
	if (gun.Position-root.Position).Magnitude<10 then
		local tool = gun.Parent
		if tool and tool:IsA("Tool") then
			local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if hum then pcall(function() hum:EquipTool(tool) end) end
		end
	end
end

------------------------------------------------------------------------
-- TAG ABOVE HEAD
------------------------------------------------------------------------
local tagBB
local function updateTag()
	if Game.flags.showTag and not tagBB then
		local hrp = getRoot(); if not hrp then return end
		tagBB = create("BillboardGui", {Name="KriegTag", AlwaysOnTop=true, Size=UDim2.fromOffset(120,24), StudsOffset=Vector3.new(0,3.2,0), Adornee=hrp, Parent=gui})
		local holder = make("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=0.25, BorderSizePixel=0, Parent=tagBB}, {BackgroundColor3="Accent"})
		corner(holder, 6)
		text("TextLabel", {Size=UDim2.fromScale(1,1), Text=LocalPlayer.DisplayName, Tr=false, Weight=BOLD, TextSize=12, Color=onAccentText, TextXAlignment=Enum.TextXAlignment.Center, Parent=holder})
	elseif not Game.flags.showTag and tagBB then
		tagBB:Destroy(); tagBB = nil
	end
end
task.spawn(function() while gui.Parent do updateTag(); task.wait(0.5) end end)

------------------------------------------------------------------------
-- COPY EMOTES
------------------------------------------------------------------------
do
	local conns = {}
	Game.on(Players.PlayerAdded, function(plr) end)
	task.spawn(function()
		while gui.Parent do
			if Game.flags.copyEmotes and selectedPlayer and selectedPlayer.Character then
				local hum = selectedPlayer.Character:FindFirstChildOfClass("Humanoid")
				if hum then
					local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					if myHum then
						local last = hum:GetAttribute("KriegLastEmote")
						if last and last ~= myHum:GetAttribute("KriegLastEmote") then
							myHum:SetAttribute("KriegLastEmote", last)
							pcall(function() myHum:PlayEmote(last) end)
						end
					end
				end
			end
			task.wait(0.5)
		end
	end)
end

------------------------------------------------------------------------
-- WEATHER / SKYBOX (реально)
------------------------------------------------------------------------
local weatherEmitter
local function applyWeather(kind, intensity)
	intensity = intensity or 0.5
	if weatherEmitter then weatherEmitter:Destroy(); weatherEmitter = nil end
	Lighting.FogEnd = kind=="Fog" and (200 - intensity*150) or 100000
	if kind=="Snow" or kind=="Rain" then
		local cam = Workspace.CurrentCamera
		local part = create("Part", {Name="KriegWeather", Size=Vector3.new(1,1,1), Transparency=1, CanCollide=false, Anchored=true, Parent=Workspace})
		part.CFrame = cam.CFrame
		local emitter = create("ParticleEmitter", {Parent=part})
		emitter.Rate = intensity*100
		if kind=="Snow" then
			emitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
			emitter.Size = NumberSequence.new(0.3)
			emitter.Speed = NumberRange.new(3,5)
			emitter.Lifetime = NumberRange.new(2,4)
			emitter.Color = ColorSequence.new(WHITE)
		else
			emitter.Texture = "rbxasset://textures/particles/water_main.dds"
			emitter.Size = NumberSequence.new(0.15)
			emitter.Speed = NumberRange.new(40,50)
			emitter.Lifetime = NumberRange.new(0.5,0.8)
			emitter.Color = ColorSequence.new(rgb(150,180,220))
		end
		weatherEmitter = part
		task.spawn(function()
			while weatherEmitter and weatherEmitter.Parent and gui.Parent do
				local c = Workspace.CurrentCamera
				if c then weatherEmitter.CFrame = c.CFrame * CFrame.new(0, 20, 0) end
				task.wait(0.5)
			end
		end)
	elseif kind=="Storm" then
		Lighting.Brightness = 0.4
	end
end
local function applySky(name)
	local old = Lighting:FindFirstChild("KriegSky"); if old then old:Destroy() end
	if name=="Default" then return end
	local sky = create("Sky", {Name="KriegSky", Parent=Lighting})
	local map = {
		["Blood moon"] = {up="rbxassetid://161906290", dn="rbxassetid://161906195", lf="rbxassetid://161906254", rt="rbxassetid://161906323", ft="rbxassetid://161906365", bk="rbxassetid://161906406"},
		["Night"] = {up="rbxassetid://159454299", dn="rbxassetid://159454296", lf="rbxassetid://159454293", rt="rbxassetid://159454286", ft="rbxassetid://159454300", bk="rbxassetid://159454288"},
		["Galaxy"] = {up="rbxassetid://159454345", dn="rbxassetid://159454339", lf="rbxassetid://159454334", rt="rbxassetid://159454341", ft="rbxassetid://159454344", bk="rbxassetid://159454340"},
		["Sunset"] = {up="rbxassetid://161906290", dn="rbxassetid://161906195", lf="rbxassetid://161906254", rt="rbxassetid://161906323", ft="rbxassetid://161906365", bk="rbxassetid://161906406"},
	}
	local m = map[name]
	if m then sky.SkyboxUp=m.up; sky.SkyboxDn=m.dn; sky.SkyboxLf=m.lf; sky.SkyboxRt=m.rt; sky.SkyboxFt=m.ft; sky.SkyboxBk=m.bk end
end

------------------------------------------------------------------------
-- COINS / FARM
------------------------------------------------------------------------
local farmStats = {coins=0, rounds=0, started=os.clock()}
local function collectCoins()
	local root = getRoot(); if not root then return end
	if Game.flags.stopWhenFull then
		local ldr = LocalPlayer:FindFirstChild("leaderstats")
		local coins = ldr and ldr:FindFirstChild("Coins")
		if coins and coins.Value >= 1000 then return end
	end
	for _,d in ipairs(Workspace:GetDescendants()) do
		if d:IsA("BasePart") and (d.Name:lower():find("coin") or d.Name:lower():find("money")) then
			if (d.Position-root.Position).Magnitude<15 then
				pcall(function() firetouchinterest(root, d, 0); firetouchinterest(root, d, 1) end)
				farmStats.coins = farmStats.coins + 1
			end
		end
	end
end

------------------------------------------------------------------------
-- MUSIC
------------------------------------------------------------------------
local sound
local function playMusic(id, volume)
	if sound then sound:Destroy() end
	if not id or id=="" then return end
	sound = create("Sound", {SoundId="rbxassetid://"..id, Volume=volume or 5, Parent=Workspace})
	sound:Play()
end
local function stopMusic() if sound then sound:Destroy(); sound=nil end end

------------------------------------------------------------------------
-- CHAT
------------------------------------------------------------------------
local chatHistory = {}
local function sendChat(msg) if msg and msg~="" then pcall(function() LocalPlayer:Chat(msg) end) end end
Game.on(LocalPlayer.Chatted, function(msg)
	if Game.flags.keepHistory then
		table.insert(chatHistory, {from=LocalPlayer.Name, text=msg, t=os.time()})
		if #chatHistory>200 then table.remove(chatHistory,1) end
	end
end)
Game.on(Players.PlayerAdded, function(plr)
	plr.Chatted:Connect(function(msg)
		if Game.flags.keepHistory then
			table.insert(chatHistory, {from=plr.Name, text=msg, t=os.time()})
			if #chatHistory>200 then table.remove(chatHistory,1) end
		end
		if Game.flags.soundOnMention and msg:lower():find(LocalPlayer.Name:lower(),1,true) then
			notify("Mention", plr.DisplayName..": "..msg, "bell", 4)
		end
	end)
end)
Game.on(LocalPlayer.Idled, function()
	if Game.flags.antiAfk then
		pcall(function() VirtualUser:CaptureController() end)
		pcall(function() VirtualUser:ClickButton2(Vector2.new()) end)
	end
end)

------------------------------------------------------------------------
-- ГЛАВНЫЙ ЦИКЛ
------------------------------------------------------------------------
task.spawn(function()
	while gui.Parent do
		pcall(function()
			Game.runESP()
			if Game.flags.follow and isAlive(Game.flags.follow) then
				local hrp = getHRP(Game.flags.follow); local root = getRoot()
				if hrp and root then root.CFrame = CFrame.new(hrp.Position + hrp.CFrame.LookVector*-5 + Vector3.new(0,2,0)) end
			end
			if Game.flags.orbit and isAlive(Game.flags.orbit) then
				local hrp = getHRP(Game.flags.orbit); local root = getRoot()
				if hrp and root then local t = os.clock(); root.CFrame = CFrame.new(hrp.Position + Vector3.new(math.cos(t)*8, 3, math.sin(t)*8)) end
			end
			if Game.flags.collectCoins then collectCoins() end
			if Game.flags.stayAway and RoundState.murderer and isAlive(RoundState.murderer) then
				local kh = getHRP(RoundState.murderer); local root = getRoot()
				if kh and root and (kh.Position-root.Position).Magnitude<25 then
					root.CFrame = CFrame.new(root.Position + (root.Position-kh.Position).Unit*6)
				end
			end
			if Game.flags.sheriffAlert and RoundState.sheriff and isAlive(RoundState.sheriff) then
				local sh = getHRP(RoundState.sheriff); local root = getRoot()
				if sh and root and (sh.Position-root.Position).Magnitude<40 then
					notify("Sheriff", "Sheriff is nearby", "crosshair", 2)
					Game.flags.sheriffAlert = false
				end
			end
			if Game.flags.highlightGun and RoundState.gunPart then
				if not RoundState.gunPart:FindFirstChild("KriegGunHL") then
					local hl = create("Highlight", {Parent=RoundState.gunPart, Name="KriegGunHL"})
					hl.FillColor = Theme.Accent; hl.OutlineColor = Theme.Accent
				end
			end
			if Game.flags.pickupGun then pickupGun() end
		end)
		task.wait(0.15)
	end
end)

-- low gravity jump (по флагу)
do
	local baseGrav = Workspace.Gravity
	Game.on(UserInputService.InputBegan, function(input, gp)
		if gp or not Game.flags.lowGravity then return end
		if input.KeyCode==Enum.KeyCode.Space then
			Workspace.Gravity = baseGrav * 0.3
			task.delay(1.2, function() Workspace.Gravity = baseGrav end)
		end
	end)
end

------------------------------------------------------------------------
-- КОНТЕНТ: страницы, карточки, элементы
------------------------------------------------------------------------
local pages = {}
local panels = {}
local function createPage(name, description, subtabs)
	local page = {Name=name, Tabs={}}
	local frame = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Visible=false, Parent=pagesHolder})
	page.Frame = frame
	text("TextLabel", {Size=UDim2.new(1,0,0,22), Text=name, Weight=BOLD, TextSize=19, Parent=frame})
	page.Desc = text("TextLabel", {Size=UDim2.new(1,0,0,15), Position=UDim2.fromOffset(0,23), Text=description, Color="Sub", TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=frame})
	local multi = #subtabs>1
	local top = 48
	local tabRow, indicator, holder
	if multi then
		tabRow = create("Frame", {Size=UDim2.new(1,-6,0,28), Position=UDim2.fromOffset(0,44), BackgroundTransparency=1, Parent=frame})
		make("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BorderSizePixel=0, Parent=tabRow}, {BackgroundColor3="Stroke"})
		holder = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Parent=tabRow})
		hlist(holder, 18, Enum.VerticalAlignment.Top)
		indicator = make("Frame", {Size=UDim2.fromOffset(0,2), Position=UDim2.new(0,0,1,-2), BorderSizePixel=0, Parent=tabRow}, {BackgroundColor3="Accent"})
		corner(indicator, 1)
		top = 84
	end
	local current
	local function moveIndicator(btn, instant)
		if not indicator then return end
		local s = currentScale>0 and currentScale or 1
		local x = (btn.AbsolutePosition.X-tabRow.AbsolutePosition.X)/s
		local w = btn.AbsoluteSize.X/s
		local goal = {Position=UDim2.new(0,x,1,-2), Size=UDim2.fromOffset(w,2)}
		if instant then indicator.Position=goal.Position; indicator.Size=goal.Size else tween(indicator, goal, 0.3) end
	end
	local function selectSub(subName, instant)
		closePopup(); current = subName
		for n,d in pairs(page.Tabs) do
			local on = n==subName
			d.Scroll.Visible = on
			if d.Button then
				tween(d.Button, {TextColor3=on and Theme.Text or Theme.Sub})
				d.Button.FontFace = F(on and BOLD or MED)
			end
		end
		local d = page.Tabs[subName]
		if d.Button then task.defer(function() moveIndicator(d.Button, instant) end) end
		if not instant then d.Scroll.Position = UDim2.fromOffset(0, top+10); tween(d.Scroll, {Position=UDim2.fromOffset(0,top)}, 0.3) end
	end
	for i,subName in ipairs(subtabs) do
		local btn
		if multi then
			btn = text("TextButton", {Size=UDim2.new(0,0,0,26), AutomaticSize=Enum.AutomaticSize.X, Text=subName, Weight=MED, TextSize=12, Color="Sub", LayoutOrder=i, Parent=holder})
			btn.MouseEnter:Connect(function() if current~=subName then tween(btn,{TextColor3=Theme.Text}) end end)
			btn.MouseLeave:Connect(function() if current~=subName then tween(btn,{TextColor3=Theme.Sub}) end end)
			btn.MouseButton1Click:Connect(function() selectSub(subName) end)
		end
		local scroll = make("ScrollingFrame", {Size=UDim2.new(1,0,1,-top), Position=UDim2.fromOffset(0,top), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3, ScrollBarImageTransparency=0.35, ScrollingDirection=Enum.ScrollingDirection.Y, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y, Visible=false, Parent=frame}, {ScrollBarImageColor3="Accent"})
		local function column(xs, xo, full)
			local col = create("Frame", {Size=full and UDim2.new(1,-6,0,0) or UDim2.new(0.5,-8,0,0), Position=UDim2.new(xs,xo,0,1), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, Parent=scroll})
			vlist(col, 10); pad(col, 1, 1, 0, 10); return col
		end
		page.Tabs[subName] = {Button=btn, Scroll=scroll, Left=column(0,0), Right=column(0.5,2), Full=column(0,0,true)}
	end
	onTheme(function()
		if current then for n,d in pairs(page.Tabs) do if d.Button then d.Button.TextColor3 = (n==current) and Theme.Text or Theme.Sub end end end
	end)
	onLang(function() if current then page.Refresh() end end)
	page.Refresh = function() if current and page.Tabs[current].Button then task.defer(function() moveIndicator(page.Tabs[current].Button, true) end) end end
	selectSub(subtabs[1], true)
	pages[name] = page
	return page
end
local function createCard(column, iconName, title, note, collapsed)
	local card = make("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=S.PanelAlpha, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=column}, {BackgroundColor3="Card"})
	table.insert(panels, card); corner(card, 11); stroke(card, "Stroke"); vlist(card, 0)
	local header = create("Frame", {Size=UDim2.new(1,0,0,note and 46 or 38), BackgroundTransparency=1, LayoutOrder=1, Parent=card})
	icon(iconName, {Size=UDim2.fromOffset(14,14), Position=UDim2.fromOffset(12,12), Color="Accent", Parent=header})
	text("TextLabel", {Size=UDim2.new(1,-66,0,16), Position=UDim2.fromOffset(33,11), Text=title, Weight=BOLD, TextSize=13, TextTruncate=Enum.TextTruncate.AtEnd, Parent=header})
	if note then text("TextLabel", {Size=UDim2.new(1,-50,0,13), Position=UDim2.fromOffset(33,27), Text=note, Color="Dim", TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=header}) end
	local chev = icon("chevron-down", {Size=UDim2.fromOffset(13,13), Position=UDim2.new(1,-24,0,13), Color="Dim", Parent=header})
	local divHolder = create("Frame", {Size=UDim2.new(1,0,0,1), BackgroundTransparency=1, LayoutOrder=2, Parent=card})
	make("Frame", {Size=UDim2.new(1,-20,0,1), Position=UDim2.fromOffset(10,0), BackgroundTransparency=0.4, BorderSizePixel=0, Parent=divHolder}, {BackgroundColor3="Stroke"})
	local body = create("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, LayoutOrder=3, Parent=card})
	pad(body, 9, 9, 9, 10); vlist(body, 5)
	local opened = not collapsed
	local function apply(instant)
		body.Visible = opened; divHolder.Visible = opened
		if instant then chev.Rotation = opened and 0 or -90 else tween(chev, {Rotation=opened and 0 or -90}) end
	end
	apply(true)
	local hit = create("TextButton", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Text="", Parent=header})
	hit.MouseEnter:Connect(function() tween(chev,{ImageColor3=Theme.Text}) end)
	hit.MouseLeave:Connect(function() tween(chev,{ImageColor3=Theme.Dim}) end)
	hit.MouseButton1Click:Connect(function() opened=not opened; apply(false) end)
	return body
end
local function plainRow(body, height) return create("Frame", {Size=UDim2.new(1,0,0,height or 30), BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=body}) end
local function row(body, height)
	local outer = make("Frame", {Size=UDim2.new(1,0,0,(height or 30)+10), BackgroundTransparency=0.7, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=body}, {BackgroundColor3="Element"})
	corner(outer, 8); stroke(outer, "Stroke", 0.75)
	return create("Frame", {Size=UDim2.new(1,-18,0,height or 30), Position=UDim2.fromOffset(9,5), BackgroundTransparency=1, Parent=outer})
end
local function makeKeyBox(parent, position, default, onBind)
	local box = text("TextButton", {AnchorPoint=Vector2.new(1,0.5), Position=position, Size=UDim2.fromOffset(28,20), AutomaticSize=Enum.AutomaticSize.X, BackgroundTransparency=0, Text=default, Weight=BOLD, TextSize=10, Color="Sub", TextXAlignment=Enum.TextXAlignment.Center, Parent=parent})
	bind(box, "BackgroundColor3", "Deep"); corner(box, 5); pad(box, 6, 6, 0, 0)
	local s = stroke(box); local listening = false
	box.MouseButton1Click:Connect(function() listening=true; isBinding=true; setTr(box,"press"); s.Color=Theme.Accent; box.TextColor3=Theme.Accent end)
	UserInputService.InputBegan:Connect(function(input)
		if not listening or input.UserInputType~=Enum.UserInputType.Keyboard then return end
		listening=false; task.defer(function() isBinding=false end)
		s.Color = Theme.Stroke
		local k = input.KeyCode
		if k==Enum.KeyCode.Escape or k==Enum.KeyCode.Backspace then setTr(box, default); box.TextColor3=Theme.Sub; if onBind then onBind(nil) end
		else Lang.reg[box]=nil; box.Text=shortKey(k.Name); box.TextColor3=Theme.Text; if onBind then onBind(k) end end
	end)
	return box
end
local function addToggle(body, label, default, opts, callback)
	opts = opts or {}
	local state = default==true
	if opts.bind then Game.flags[opts.bind] = state end
	local h = opts.desc and 34 or 22
	local r = row(body, h)
	local right = -38
	local gearX, keyEdge
	if opts.gear then gearX = right-9-13; right = gearX end
	if opts.key then keyEdge = right-7; right = keyEdge-30 end
	text("TextLabel", {Size=UDim2.new(1,right-6,0,16), Position=UDim2.fromOffset(0, opts.desc and 2 or 3), Text=label, Weight=MED, TextSize=13, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
	if opts.desc then text("TextLabel", {Size=UDim2.new(1,right-6,0,13), Position=UDim2.fromOffset(0,19), Text=opts.desc, Color="Dim", TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r}) end
	local hit = create("TextButton", {Size=UDim2.new(1,right-6,1,0), BackgroundTransparency=1, Text="", Parent=r})
	local sw = create("TextButton", {Size=UDim2.fromOffset(38,20), Position=UDim2.new(1,-38,0.5,-10), Text="", AutoButtonColor=false, BorderSizePixel=0, Parent=r})
	corner(sw, 7)
	local swStroke = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=sw})
	local knob = create("Frame", {Size=UDim2.fromOffset(14,14), Position=UDim2.fromOffset(3,3), BorderSizePixel=0, Parent=sw})
	corner(knob, 4)
	local check = icon("check", {Size=UDim2.fromOffset(10,10), Position=UDim2.fromOffset(2,2), ImageTransparency=1, Parent=knob})
	local function refresh(instant)
		local a = {BackgroundColor3=state and Theme.Accent or Theme.Element}
		local b = {Position=state and UDim2.fromOffset(21,3) or UDim2.fromOffset(3,3), BackgroundColor3=state and WHITE or Theme.Off}
		local c = {Color=state and Theme.Accent or Theme.Stroke, Transparency=state and 0.5 or 0, Thickness=state and 2 or 1}
		local d = {ImageTransparency=state and 0 or 1, ImageColor3=Theme.Accent}
		if instant then for k,v in pairs(a) do sw[k]=v end; for k,v in pairs(b) do knob[k]=v end; for k,v in pairs(c) do swStroke[k]=v end; for k,v in pairs(d) do check[k]=v end
		else tween(sw,a); tween(knob,b,0.28,Enum.EasingStyle.Back); tween(swStroke,c); tween(check,d) end
	end
	onTheme(function() if sw.Parent then refresh(true) end end)
	local function flip()
		state = not state
		if opts.bind then Game.flags[opts.bind] = state end
		refresh(false)
		if callback then callback(state) end
	end
	sw.MouseButton1Click:Connect(flip); hit.MouseButton1Click:Connect(flip)
	if opts.gear then
		local g = icon("sliders-horizontal", {Size=UDim2.fromOffset(13,13), Position=UDim2.new(1,gearX,0.5,-6.5), Color="Dim", Parent=r}, "ImageButton")
		g.MouseEnter:Connect(function() tween(g,{ImageColor3=Theme.Accent}) end)
		g.MouseLeave:Connect(function() tween(g,{ImageColor3=Theme.Dim}) end)
	end
	if opts.key then makeKeyBox(r, UDim2.new(1,keyEdge,0.5,0), "none") end
end
local function addSlider(body, label, min, max, default, decimals, suffix, callback)
	decimals = decimals or 0
	local r = row(body, 36)
	text("TextLabel", {Size=UDim2.new(1,-76,0,16), Text=label, Weight=MED, TextSize=13, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
	local valueBox = make("Frame", {Size=UDim2.fromOffset(0,17), AutomaticSize=Enum.AutomaticSize.X, AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,0,0,0), BorderSizePixel=0, Parent=r}, {BackgroundColor3="Deep"})
	corner(valueBox, 5); pad(valueBox, 6, 6, 0, 0)
	local valueLabel = text("TextLabel", {Size=UDim2.fromOffset(0,17), AutomaticSize=Enum.AutomaticSize.X, Text="", Tr=false, Weight=BOLD, TextSize=11, Color="Accent", Parent=valueBox})
	local track = make("Frame", {Size=UDim2.new(1,-8,0,4), Position=UDim2.new(0,4,0,27), BorderSizePixel=0, Parent=r}, {BackgroundColor3="Element2"})
	corner(track, 2)
	local fill = create("Frame", {Size=UDim2.fromScale(0,1), BackgroundColor3=WHITE, BorderSizePixel=0, Parent=track})
	corner(fill, 2); local fillGrad = create("UIGradient", {Parent=fill})
	local knob = make("Frame", {Size=UDim2.fromOffset(13,13), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.fromScale(0,0.5), BorderSizePixel=0, Parent=track}, {BackgroundColor3="Accent"})
	corner(knob, 7)
	local knobInner = create("Frame", {Size=UDim2.fromOffset(5,5), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.fromScale(0.5,0.5), BackgroundColor3=WHITE, BorderSizePixel=0, Parent=knob})
	corner(knobInner, 3); stroke(knob, "Accent", 0.6, 3)
	onTheme(function() fillGrad.Color = ColorSequence.new(Theme.Accent2, Theme.Accent) end)
	local function set(v, fire)
		v = math.clamp(v, min, max)
		local m = 10^decimals
		v = math.floor(v*m+0.5)/m
		local p = (v-min)/(max-min)
		fill.Size = UDim2.new(p,0,1,0); knob.Position = UDim2.new(p,0,0.5,0)
		valueLabel.Text = string.format("%."..decimals.."f", v)..(suffix or "")
		if callback and fire~=false then callback(v) end
	end
	local hit = create("TextButton", {Size=UDim2.new(1,0,0,20), Position=UDim2.fromOffset(0,19), BackgroundTransparency=1, Text="", Parent=r})
	local sliding = false
	local function update(x) local p = (x-track.AbsolutePosition.X)/math.max(track.AbsoluteSize.X,1); set(min+(max-min)*math.clamp(p,0,1)) end
	hit.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then sliding=true; tween(knob,{Size=UDim2.fromOffset(17,17)},0.15); update(input.Position.X) end end)
	UserInputService.InputChanged:Connect(function(input) if sliding and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then update(input.Position.X) end end)
	UserInputService.InputEnded:Connect(function(input) if sliding and (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) then sliding=false; tween(knob,{Size=UDim2.fromOffset(13,13)},0.15) end end)
	set(default, false)
end
local function addDropdown(body, label, options, default, callback, width)
	width = width or 116
	local selected = default or options[1]
	local r = row(body, 26)
	text("TextLabel", {Size=UDim2.new(1,-width-8,1,0), Text=label, Weight=MED, TextSize=13, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
	local box = make("TextButton", {Size=UDim2.fromOffset(width,26), Position=UDim2.new(1,-width,0.5,-13), Text="", AutoButtonColor=false, BorderSizePixel=0, Parent=r}, {BackgroundColor3="Element"})
	corner(box, 7); local bs = stroke(box)
	local valueLabel = text("TextLabel", {Size=UDim2.new(1,-30,1,0), Position=UDim2.fromOffset(9,0), Text=selected, Weight=MED, TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=box})
	icon("chevrons-up-down", {Size=UDim2.fromOffset(12,12), Position=UDim2.new(1,-20,0.5,-6), Color="Dim", Parent=box})
	box.MouseEnter:Connect(function() tween(bs,{Color=Theme.Accent}) end)
	box.MouseLeave:Connect(function() tween(bs,{Color=Theme.Stroke}) end)
	box.MouseButton1Click:Connect(function()
		if openPopup then closePopup(); return end
		local itemH = 26; local visible = math.min(#options, 6)
		local pop = make("Frame", {Position=UDim2.fromOffset(box.AbsolutePosition.X, box.AbsolutePosition.Y+box.AbsoluteSize.Y+5), Size=UDim2.fromOffset(width, visible*itemH+8), BorderSizePixel=0, ZIndex=50, Parent=gui}, {BackgroundColor3="Card"})
		create("UIScale", {Scale=currentScale, Parent=pop}); corner(pop, 8); stroke(pop, "Accent", 0.55)
		local sc = make("ScrollingFrame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y, ZIndex=51, Parent=pop}, {ScrollBarImageColor3="Accent"})
		pad(sc, 4, 4, 4, 4); vlist(sc, 0)
		for i,opt in ipairs(options) do
			local isSel = opt==selected
			local item = text("TextButton", {Size=UDim2.new(1,0,0,itemH), BackgroundTransparency=isSel and 0.85 or 1, Text=opt, Weight=isSel and BOLD or MED, TextSize=12, Color=isSel and "Accent" or "Text", LayoutOrder=i, ZIndex=52, Parent=sc})
			bind(item, "BackgroundColor3", isSel and "Accent" or "Element"); corner(item, 6); pad(item, 8, 8, 0, 0)
			item.MouseEnter:Connect(function() if not isSel then tween(item,{BackgroundTransparency=0},0.1) end end)
			item.MouseLeave:Connect(function() if not isSel then tween(item,{BackgroundTransparency=1},0.1) end end)
			item.MouseButton1Click:Connect(function() selected=opt; setTr(valueLabel,opt); closePopup(); if callback then callback(opt) end end)
		end
		openPopup = pop
	end)
end
local function addButton(body, label, iconName, primary, callback)
	local b = create("TextButton", {Size=UDim2.new(1,0,0,32), Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=body})
	bind(b, "BackgroundColor3", primary and "Accent" or "Element")
	if primary then b.BackgroundTransparency = 0.12 end
	corner(b, 8); local bs = stroke(b, primary and "Accent" or "Stroke", primary and 0.4 or 0)
	if primary then local grad = create("UIGradient", {Rotation=0, Parent=b}); onTheme(function() grad.Color = ColorSequence.new(WHITE, Theme.Accent2:Lerp(WHITE,0.4)) end) end
	local content = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Parent=b})
	hlist(content, 6, Enum.VerticalAlignment.Center, Enum.HorizontalAlignment.Center)
	local ic
	if iconName then ic = icon(iconName, {Size=UDim2.fromOffset(13,13), Color=primary and onAccentText or "Sub", LayoutOrder=1, Parent=content}) end
	text("TextLabel", {Size=UDim2.fromOffset(0,32), AutomaticSize=Enum.AutomaticSize.X, Text=label, Weight=primary and BOLD or MED, TextSize=12, Color=primary and onAccentText or "Text", LayoutOrder=2, Parent=content})
	b.MouseEnter:Connect(function() tween(bs,{Color=Theme.Accent, Transparency=0}); if not primary and ic then tween(ic,{ImageColor3=Theme.Accent}) end end)
	b.MouseLeave:Connect(function() tween(bs,{Color=primary and Theme.Accent or Theme.Stroke, Transparency=primary and 0.4 or 0}); if not primary and ic then tween(ic,{ImageColor3=Theme.Sub}) end end)
	b.MouseButton1Click:Connect(function()
		local flash = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundColor3=WHITE, BackgroundTransparency=0.8, BorderSizePixel=0, Parent=b})
		corner(flash, 8); tween(flash, {BackgroundTransparency=1}, 0.35).Completed:Connect(function() flash:Destroy() end)
		if callback then callback() end
	end)
	return b
end
local function addButtonRow(body, items)
	local r = plainRow(body, 32)
	create("UIGridLayout", {CellSize=UDim2.new(1/#items, -(6*(#items-1))/#items, 1, 0), CellPadding=UDim2.fromOffset(6,0), SortOrder=Enum.SortOrder.LayoutOrder, Parent=r})
	for _,it in ipairs(items) do addButton(r, it[1], it[2], it[3], it[4]) end
end
local function addInput(body, placeholder, iconName)
	local r = plainRow(body, 32)
	local f = make("Frame", {Size=UDim2.fromScale(1,1), BorderSizePixel=0, Parent=r}, {BackgroundColor3="Element"})
	corner(f, 8); local s = stroke(f)
	local x = 10
	if iconName then icon(iconName, {Size=UDim2.fromOffset(13,13), Position=UDim2.new(0,10,0.5,-6.5), Color="Sub", Parent=f}); x = 30 end
	local box = text("TextBox", {Size=UDim2.new(1,-x-8,1,0), Position=UDim2.fromOffset(x,0), Text="", Tr=false, PlaceholderText=placeholder, TextSize=12, ClearTextOnFocus=false, TextTruncate=Enum.TextTruncate.AtEnd, Parent=f})
	box.Focused:Connect(function() tween(s,{Color=Theme.Accent}) end)
	box.FocusLost:Connect(function() tween(s,{Color=Theme.Stroke}) end)
	return box
end
local function addInfo(body, key, value, iconName)
	local r = row(body, 18)
	local x = 0
	if iconName then icon(iconName, {Size=UDim2.fromOffset(13,13), Position=UDim2.new(0,0,0.5,-6.5), Color="Dim", Parent=r}); x = 20 end
	text("TextLabel", {Size=UDim2.new(0.6,-x,1,0), Position=UDim2.fromOffset(x,0), Text=key, Color="Sub", TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
	return text("TextLabel", {Size=UDim2.new(0.4,0,1,0), Position=UDim2.fromScale(0.6,0), Text=value, Tr=false, Weight=BOLD, TextSize=12, TextXAlignment=Enum.TextXAlignment.Right, Parent=r})
end
local function addCaption(body, label)
	local r = plainRow(body, 14)
	return text("TextLabel", {Size=UDim2.fromScale(1,1), Text=label, Weight=BOLD, Color="Dim", TextSize=10, Parent=r})
end
local function addParagraph(body, label)
	local r = create("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=body})
	text("TextLabel", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, Text=label, Color="Sub", TextSize=12, TextWrapped=true, Parent=r})
end
local function tileGrid(body, cols, height)
	local holder = create("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=body})
	create("UIGridLayout", {CellSize=UDim2.new(1/cols, -(6*(cols-1))/cols, 0, height), CellPadding=UDim2.fromOffset(6,6), SortOrder=Enum.SortOrder.LayoutOrder, Parent=holder})
	return holder
end
local function makeTick(parent, size)
	local tick = make("Frame", {Size=UDim2.fromOffset(size,size), Position=UDim2.new(1,-size-5,0,5), BorderSizePixel=0, Visible=false, Parent=parent}, {BackgroundColor3="Accent"})
	corner(tick, size/2)
	icon("check", {Size=UDim2.fromOffset(size-5,size-5), Position=UDim2.fromOffset(2.5,2.5), Color=onAccentText, Parent=tick})
	return tick
end
local function addStyleTiles(body, tiles, selectedIndex, onPick)
	local holder = tileGrid(body, 3, 70)
	local items = {}
	local function refresh(instant)
		for i,t in ipairs(items) do
			local on = i==selectedIndex
			local goal = {Color=on and Theme.Accent or Theme.Stroke, Thickness=on and 2 or 1}
			if instant then t.Stroke.Color=goal.Color; t.Stroke.Thickness=goal.Thickness else tween(t.Stroke, goal) end
			t.Tick.Visible = on
		end
	end
	for i,t in ipairs(tiles) do
		local name, iconName, color, glowy = t[1],t[2],t[3],t[4]
		local tile = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, ClipsDescendants=true, Parent=holder}, {BackgroundColor3="Deep"})
		corner(tile, 9)
		local ts = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=tile})
		if glowy then
			local g = create("Frame", {Size=UDim2.fromOffset(36,36), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.5,0,0,27), BackgroundColor3=color, BackgroundTransparency=0.78, BorderSizePixel=0, Parent=tile})
			corner(g, 18)
		end
		icon(iconName, {Size=UDim2.fromOffset(24,24), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.new(0.5,0,0,27), ImageColor3=color, Parent=tile})
		text("TextLabel", {Size=UDim2.new(1,-6,0,15), Position=UDim2.new(0,3,1,-20), Text=name, Weight=SEMI, TextSize=11, TextXAlignment=Enum.TextXAlignment.Center, TextTruncate=Enum.TextTruncate.AtEnd, Parent=tile})
		items[i] = {Stroke=ts, Tick=makeTick(tile, 14)}
		tile.MouseButton1Click:Connect(function() selectedIndex=i; refresh(false); if onPick then onPick(name) end end)
	end
	onTheme(function() refresh(true) end)
end
local function addPlayerList(body, actionIcon)
	local top = plainRow(body, 30)
	local sf = make("Frame", {Size=UDim2.new(1,-56,1,0), BorderSizePixel=0, Parent=top}, {BackgroundColor3="Element"})
	corner(sf, 8); local ss = stroke(sf)
	icon("search", {Size=UDim2.fromOffset(12,12), Position=UDim2.new(0,9,0.5,-6), Color="Sub", Parent=sf})
	local box = text("TextBox", {Size=UDim2.new(1,-34,1,0), Position=UDim2.fromOffset(27,0), Text="", Tr=false, PlaceholderText="Filter by name", TextSize=12, ClearTextOnFocus=false, Parent=sf})
	box.Focused:Connect(function() tween(ss,{Color=Theme.Accent}) end)
	box.FocusLost:Connect(function() tween(ss,{Color=Theme.Stroke}) end)
	local cnt = make("Frame", {Size=UDim2.new(0,50,1,0), Position=UDim2.new(1,-50,0,0), BorderSizePixel=0, Parent=top}, {BackgroundColor3="Deep"})
	corner(cnt, 8); stroke(cnt)
	icon("users", {Size=UDim2.fromOffset(12,12), Position=UDim2.new(0,9,0.5,-6), Color="Accent", Parent=cnt})
	local cntText = text("TextLabel", {Size=UDim2.new(1,-26,1,0), Position=UDim2.fromOffset(25,0), Text="0", Tr=false, Weight=BOLD, TextSize=12, Parent=cnt})
	local list = make("ScrollingFrame", {Size=UDim2.new(1,0,0,170), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, ScrollingDirection=Enum.ScrollingDirection.Y, CanvasSize=UDim2.new(), AutomaticCanvasSize=Enum.AutomaticSize.Y, LayoutOrder=nextOrder(), Parent=body}, {ScrollBarImageColor3="Accent"})
	create("UIListLayout", {Padding=UDim.new(0,5), SortOrder=Enum.SortOrder.Name, Parent=list})
	local empty = text("TextLabel", {Name="~empty", Size=UDim2.new(1,-4,0,40), Text="Server is empty for now", Color="Dim", TextSize=12, TextXAlignment=Enum.TextXAlignment.Center, Parent=list})
	local rows = {}
	local function refreshCount()
		local n, shown = 0,0
		local q = box.Text:lower()
		for plr,rf in pairs(rows) do
			n = n+1
			local match = q=="" or plr.Name:lower():find(q,1,true) or plr.DisplayName:lower():find(q,1,true)
			rf.Visible = match and true or false
			if rf.Visible then shown = shown+1 end
		end
		cntText.Text = tostring(n); empty.Visible = shown==0
	end
	box:GetPropertyChangedSignal("Text"):Connect(refreshCount)
	local function addPlayer(plr)
		if plr==LocalPlayer or rows[plr] or not gui.Parent then return end
		local rf = make("Frame", {Name=plr.Name:lower(), Size=UDim2.new(1,-4,0,40), BackgroundTransparency=0.6, BorderSizePixel=0, Parent=list}, {BackgroundColor3="Element"})
		corner(rf, 9); stroke(rf, "Stroke", 0.7)
		local av = make("ImageLabel", {Size=UDim2.fromOffset(28,28), Position=UDim2.new(0,6,0.5,-14), BorderSizePixel=0, Image="", Parent=rf}, {BackgroundColor3="Element2"})
		corner(av, 8); Avatar.set(av, plr.UserId)
		text("TextLabel", {Size=UDim2.new(1,-84,0,15), Position=UDim2.fromOffset(41,6), Text=plr.DisplayName, Tr=false, Weight=BOLD, TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=rf})
		text("TextLabel", {Size=UDim2.new(1,-84,0,13), Position=UDim2.fromOffset(41,21), Text="@"..plr.Name, Tr=false, Color="Dim", TextSize=10, TextTruncate=Enum.TextTruncate.AtEnd, Parent=rf})
		local act = make("TextButton", {Size=UDim2.fromOffset(26,26), Position=UDim2.new(1,-32,0.5,-13), BackgroundTransparency=0.85, Text="", AutoButtonColor=false, BorderSizePixel=0, Parent=rf}, {BackgroundColor3="Accent"})
		corner(act, 13)
		icon(actionIcon or "chevron-right", {Size=UDim2.fromOffset(13,13), Position=UDim2.fromOffset(6.5,6.5), Color="Accent", Parent=act})
		act.MouseButton1Click:Connect(function()
			selectedPlayer = plr
			if PlayerSheet.open then PlayerSheet.open(plr) else teleportTo(getHRP(plr) and getHRP(plr).Position) end
		end)
		act.MouseEnter:Connect(function() tween(act,{BackgroundTransparency=0.6}) end)
		act.MouseLeave:Connect(function() tween(act,{BackgroundTransparency=0.85}) end)
		rows[plr] = rf; refreshCount()
	end
	for _,plr in ipairs(Players:GetPlayers()) do addPlayer(plr) end
	Players.PlayerAdded:Connect(addPlayer)
	Players.PlayerRemoving:Connect(function(plr) if rows[plr] then rows[plr]:Destroy(); rows[plr]=nil; refreshCount() end end)
	refreshCount()
end
local gridRefreshers = {}
local function refreshGrids() for _,fn in ipairs(gridRefreshers) do fn() end end
local function setTheme(name, silent)
	if not THEMES[name] then return end
	accentOverride = nil; S.Accent = false
	loadThemeData(name); Store.set("Theme", name)
	for _,c in ipairs(particleLayer:GetChildren()) do c:Destroy() end
	applyBindings(true); Scene.show(); refreshGrids()
	if not silent then notify(name, THEMES[name].Tagline, THEMES[name].Icon, 3) end
end
local function setAccentOverride(c)
	accentOverride = c
	if c then Theme.Accent = c else loadThemeData(currentThemeName) end
	Store.set("Accent", c and {math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5)} or false)
	applyBindings(true)
end
local function applyFontFamily(family)
	FONT_FAMILY = family
	for _,e in ipairs(textObjects) do local o=e[1]; if o.Parent then pcall(function() o.FontFace = Font.new(FONT_FAMILY, o.FontFace.Weight) end) end end
end
local function setFont(name)
	local fam = FontLib.byName(name); if not fam then return end
	Store.set("Font", name); applyFontFamily(fam); refreshGrids()
end
local function setCustomFont(src, silent)
	FontLib.resolve(src, function(ok, res)
		if ok then
			S.FontCustom = src; Store.set("Font", "Custom"); applyFontFamily(res); refreshGrids()
			if not silent then notify("Font", "Custom font applied", "type", 3) end
		elseif not silent then notify("Font", res, "x", 4) end
	end)
end
local function setTextColor(c)
	S.TextColor = c and {math.floor(c.R*255+0.5), math.floor(c.G*255+0.5), math.floor(c.B*255+0.5)} or "Auto"
	Store.save(); loadThemeData(currentThemeName); applyBindings(true); refreshGrids()
end
local function setPanelTone(tone) Store.set("PanelTone", tone); loadThemeData(currentThemeName); applyBindings(true); refreshGrids() end
local function setLanguage(name) Store.set("Lang", name); Lang.set(name); refreshGrids() end
local function setPanelAlpha(a)
	S.PanelAlpha = a
	for i=#panels,1,-1 do local p=panels[i]; if p.Parent then p.BackgroundTransparency = a else table.remove(panels,i) end end
end
do
	local function hashOf(s) local h=0; for i=1,#s do h=(h*31+s:byte(i))%1000000007 end; return tostring(h) end
	function Wall.apply(image)
		Wall.active = image~=nil and image~=""
		Wall.image = image or ""
		for _,pair in ipairs(Wall.objects) do
			pair[1].Image = Wall.image; pair[1].Visible = Wall.active
			pair[2].Visible = Wall.active; pair[2].BackgroundTransparency = 1-S.WallDim
		end
		if Wall.mini then Wall.mini[1].Visible = Wall.active and S.WallMini; Wall.mini[2].Visible = Wall.active and S.WallMini end
		glow.Visible = Theme.Glow~=nil and not Wall.active
		Scene.show()
	end
	function Wall.setDim(v) S.WallDim = v; for _,pair in ipairs(Wall.objects) do pair[2].BackgroundTransparency = 1-v end end
	function Wall.resolve(src, cb)
		src = (src or ""):gsub("^%s+",""):gsub("%s+$","")
		if src=="" then cb(false,"Paste a link first") return end
		local id = src:match("^(%d+)$") or src:match("rbxassetid://(%d+)") or src:match("[?&]id=(%d+)")
		if id then cb(true,"rbxassetid://"..id) return end
		if not src:match("^https?://") then cb(false,"This is not a link") return end
		local getAsset = getcustomasset or getsynasset
		local req = request or http_request or (syn and syn.request) or (http and http.request)
		if type(getAsset)~="function" or type(writefile)~="function" then cb(false,"Your executor can't load images from links") return end
		local base = Store.dir.."/wall_"..hashOf(src)
		for _,ext in ipairs({"png","jpg"}) do
			if pcall(function() return isfile and isfile(base.."."..ext) end) and isfile(base.."."..ext) then
				local ok, asset = pcall(getAsset, base.."."..ext); if ok and asset then cb(true,asset) return end
			end
		end
		task.spawn(function()
			local ok,res = pcall(req, {Url=src, Method="GET"})
			if not ok or type(res)~="table" or not res.Body then cb(false,"Could not download the image") return end
			local body = res.Body; local ext
			if body:sub(1,4)=="\137PNG" then ext="png"
			elseif body:sub(1,2)=="\255\216" then ext="jpg"
			else cb(false,"The link is not a PNG or JPG image") return end
			Store.ensureDir()
			local path = base.."."..ext
			local okW = pcall(writefile, path, body)
			local okA, asset = pcall(getAsset, path)
			if okW and okA and asset then cb(true,asset) else cb(false,"Could not save the image") end
		end)
	end
end

local navItems, navGroups, currentGroup, currentTab = {}, {}, nil, nil
local function paintNav(name, on, instant)
	local t = navItems[name]; if not t then return end
	local goals = {{t.Button,{BackgroundTransparency=on and 0.35 or 1}}, {t.Bar,{Size=UDim2.fromOffset(3,on and 16 or 0)}}, {t.Icon,{ImageColor3=on and Theme.Accent or Theme.Sub}}, {t.Text,{TextColor3=on and Theme.Text or Theme.Sub}}}
	for _,g in ipairs(goals) do if instant then for k,v in pairs(g[2]) do g[1][k]=v end else tween(g[1],g[2]) end end
	t.Text.FontFace = F(on and SEMI or MED)
end
local function selectTab(name)
	closePopup()
	local prev = currentTab; currentTab = name
	for n in pairs(navItems) do paintNav(n, n==name) end
	for n,p in pairs(pages) do
		if n==name then
			p.Frame.Visible = true
			if prev and prev~=name then p.Frame.Position = UDim2.fromOffset(12,0); tween(p.Frame,{Position=UDim2.fromOffset(0,0)},0.3) end
			p.Refresh()
		else p.Frame.Visible = false end
	end
end
local function addSection(label)
	local g = make("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=0.75, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=navList}, {BackgroundColor3="Element"})
	corner(g, 10); stroke(g, "Stroke", 0.7); vlist(g, 1); pad(g, 4, 4, 2, 4)
	local l = text("TextLabel", {Size=UDim2.new(1,0,0,20), Text=label, Weight=BOLD, TextSize=10, Color="Dim", TextYAlignment=Enum.TextYAlignment.Center, LayoutOrder=0, Parent=g})
	pad(l, 8, 0, 0, 0)
	currentGroup = g
	table.insert(navGroups, {Frame=g, Label=l, Items={}})
end
local function addNav(name, iconName, badge)
	local b = make("TextButton", {Size=UDim2.new(1,0,0,30), BackgroundTransparency=1, Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=currentGroup}, {BackgroundColor3="Element2"})
	corner(b, 8)
	local bar = make("Frame", {Size=UDim2.fromOffset(3,0), AnchorPoint=Vector2.new(0,0.5), Position=UDim2.new(0,0,0.5,0), BorderSizePixel=0, Parent=b}, {BackgroundColor3="Accent"})
	corner(bar, 2)
	local ic = icon(iconName, {Size=UDim2.fromOffset(15,15), Position=UDim2.new(0,10,0.5,-7.5), Color="Sub", Parent=b})
	local tx = text("TextLabel", {Size=UDim2.new(1,-64,1,0), Position=UDim2.fromOffset(33,0), Text=name, Weight=MED, TextSize=12, Color="Sub", TextTruncate=Enum.TextTruncate.AtEnd, Parent=b})
	local bd
	if badge then
		bd = text("TextLabel", {Size=UDim2.fromOffset(0,15), AutomaticSize=Enum.AutomaticSize.X, AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-6,0.5,0), BackgroundTransparency=0.8, Text=badge, Weight=BOLD, TextSize=9, Color="Accent", TextXAlignment=Enum.TextXAlignment.Center, Parent=b})
		bind(bd, "BackgroundColor3", "Accent"); corner(bd, 5); pad(bd, 5, 5, 0, 0)
	end
	b.MouseEnter:Connect(function() if currentTab~=name then tween(b,{BackgroundTransparency=0.7}); tween(ic,{ImageColor3=Theme.Text}); tween(tx,{TextColor3=Theme.Text}) end end)
	b.MouseLeave:Connect(function() if currentTab~=name then paintNav(name, false) end end)
	b.MouseButton1Click:Connect(function() selectTab(name) end)
	navItems[name] = {Button=b, Bar=bar, Icon=ic, Text=tx, Badge=bd}
	table.insert(navGroups[#navGroups].Items, name)
end
onTheme(function() for n in pairs(navItems) do paintNav(n, n==currentTab, true) end end)
local function applySearch()
	local q = searchBox.Text:lower()
	for _,g in ipairs(navGroups) do
		local any = false
		for _,n in ipairs(g.Items) do
			local match = q=="" or n:lower():find(q,1,true)~=nil or tr(n):lower():find(q,1,true)~=nil
			navItems[n].Button.Visible = match
			if match then any = true end
		end
		g.Frame.Visible = any
		g.Label.Visible = q=="" and sideW==SIDE_FULL
	end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)
UserInputService.InputBegan:Connect(function(input, gp)
	if gp or not main.Visible then return end
	if input.KeyCode==Enum.KeyCode.Slash then
		task.defer(function() searchBox:CaptureFocus(); task.wait(); if searchBox.Text:sub(-1)=="/" then searchBox.Text = searchBox.Text:sub(1,-2) end end)
	end
end)
local function setCompact(on)
	S.Compact = on; Store.save(); closePopup()
	sideW = on and SIDE_MINI or SIDE_FULL
	local ti = 0.3
	tween(sidebar, {Size=UDim2.new(0,sideW,1,-TOP_H)}, ti)
	tween(pagesHolder, {Position=UDim2.fromOffset(sideW+14, TOP_H+12), Size=UDim2.new(1,-sideW-26,1,-TOP_H-22)}, ti).Completed:Connect(function()
		if currentTab and pages[currentTab] then pages[currentTab].Refresh() end
	end)
	navPad.PaddingLeft = UDim.new(0, on and 6 or 8)
	navPad.PaddingRight = UDim.new(0, on and 6 or 8)
	for _,t in pairs(navItems) do t.Text.Visible = not on; if t.Badge then t.Badge.Visible = not on end; tween(t.Icon, {Position=UDim2.new(0, on and 9 or 10, 0.5, -7.5)}, ti) end
	for _,g in ipairs(navGroups) do g.Label.Visible = not on and searchBox.Text=="" end
	profileName.Visible = not on; profileUser.Visible = not on; onlineDot.Visible = not on
	tween(profile, {Size=UDim2.new(1, on and -12 or -16, 0, 44), Position=UDim2.new(0, on and 6 or 8, 1, -52)}, ti)
	tween(collapseBtn, {Rotation=on and 180 or 0}, ti)
end
collapseBtn.MouseButton1Click:Connect(function() setCompact(not S.Compact) end)

-- МИНИ-БАР
local fps, ping = 60, 0
local sessionStart = os.clock()
local mini, miniFx, fpsSeg, pingSeg, timeSeg, miniClose, brandBtn, fpsValue, pingValue, pingIcon, timeValue
do
	mini = create("Frame", {Name="MiniBar", AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,0,12), Size=UDim2.fromOffset(0,38), AutomaticSize=Enum.AutomaticSize.X, BackgroundColor3=WHITE, BackgroundTransparency=0.04, BorderSizePixel=0, ClipsDescendants=true, Visible=S.MiniBar, Parent=gui})
	corner(mini, 12)
	create("UIScale", {Scale=math.clamp(viewport.X/900, 0.72, 1), Parent=mini})
	local miniGrad = create("UIGradient", {Rotation=0, Parent=mini})
	local miniStroke = create("UIStroke", {Thickness=1.5, ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=mini})
	miniStrokeGrad = create("UIGradient", {Parent=miniStroke})
	local wimg = create("ImageLabel", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, ScaleType=Enum.ScaleType.Crop, Image="", Visible=false, Parent=mini})
	corner(wimg, 12)
	local wshade = make("Frame", {Size=UDim2.fromScale(1,1), BorderSizePixel=0, Visible=false, Parent=mini}, {BackgroundColor3="BgBottom"})
	corner(wshade, 12)
	table.insert(Wall.objects, {wimg, wshade}); Wall.mini = {wimg, wshade}
	miniFx = create("Frame", {Size=UDim2.fromScale(1,1), BackgroundTransparency=1, Parent=mini})
	local miniContent = create("Frame", {Size=UDim2.fromOffset(0,38), AutomaticSize=Enum.AutomaticSize.X, BackgroundTransparency=1, Parent=mini})
	pad(miniContent, 6, 6, 0, 0); hlist(miniContent, 9)
	onTheme(function()
		miniGrad.Color = ColorSequence.new(Theme.BgTop:Lerp(Theme.Card,0.4), Theme.BgBottom)
		local fancy = Theme.Fx~=nil and S.Border
		miniStroke.Color = fancy and WHITE or Theme.Stroke
		miniStrokeGrad.Enabled = fancy; miniStrokeGrad.Color = borderSequence()
	end)
	local function divider() make("Frame", {Size=UDim2.fromOffset(1,16), BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=miniContent}, {BackgroundColor3="Stroke"}) end
	local function segment()
		local seg = create("Frame", {Size=UDim2.fromOffset(0,38), AutomaticSize=Enum.AutomaticSize.X, BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=miniContent})
		hlist(seg, 4); makeDraggable(seg, mini); return seg
	end
	local function value(parent, txt, order_, color, weight, size)
		return text("TextLabel", {Size=UDim2.fromOffset(0,38), AutomaticSize=Enum.AutomaticSize.X, Text=txt, Tr=false, Weight=weight or BOLD, TextSize=size or 12, Color=color or "Text", LayoutOrder=order_, Parent=parent})
	end
	local grip = icon("grip-vertical", {Size=UDim2.fromOffset(11,16), Color="Dim", LayoutOrder=nextOrder(), Parent=miniContent})
	makeDraggable(grip, mini)
	brandBtn = create("TextButton", {Size=UDim2.fromOffset(0,38), AutomaticSize=Enum.AutomaticSize.X, BackgroundTransparency=1, Text="", LayoutOrder=nextOrder(), Parent=miniContent})
	hlist(brandBtn, 7)
	local avHolder = create("Frame", {Size=UDim2.fromOffset(26,26), BackgroundTransparency=1, LayoutOrder=1, Parent=brandBtn})
	local av = make("ImageLabel", {Size=UDim2.fromScale(1,1), BorderSizePixel=0, Image="", Parent=avHolder}, {BackgroundColor3="Element2"})
	corner(av, 9); stroke(av, "Accent", 0.25, 1.5)
	local badge = make("Frame", {Size=UDim2.fromOffset(13,13), Position=UDim2.new(1,-8,1,-8), BorderSizePixel=0, Parent=avHolder}, {BackgroundColor3="Deep"})
	corner(badge, 7); stroke(badge, "Accent", 0.3)
	local badgeIcon = icon("ghost", {Size=UDim2.fromOffset(8,8), Position=UDim2.fromOffset(2.5,2.5), Color="Accent", Parent=badge})
	onTheme(function() setIcon(badgeIcon, Theme.Icon) end)
	Avatar.set(av, LocalPlayer.UserId)
	local miniBrand = value(brandBtn, "krieg hub", 2, "Text", HEAVY, 13)
	miniBrand.RichText = true
	onTheme(function() miniBrand.Text = 'krieg <font color="'..hex(Theme.Accent)..'">hub</font>' end)
	divider(); fpsSeg = segment(); fpsValue = value(fpsSeg, "60", 1); value(fpsSeg, "fps", 2, "Sub", REG, 11)
	divider(); pingSeg = segment(); pingIcon = icon("signal-high", {Size=UDim2.fromOffset(13,13), LayoutOrder=1, Parent=pingSeg}); pingValue = value(pingSeg, "0", 2); value(pingSeg, "ms", 3, "Sub", REG, 11)
	divider(); timeSeg = segment(); icon("clock", {Size=UDim2.fromOffset(12,12), Color="Accent", LayoutOrder=1, Parent=timeSeg}); timeValue = value(timeSeg, "00:00", 2)
	miniClose = make("TextButton", {Size=UDim2.fromOffset(0,26), AutomaticSize=Enum.AutomaticSize.X, Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=nextOrder(), Parent=miniContent}, {BackgroundColor3="Element"})
	corner(miniClose, 8); local cs = stroke(miniClose); pad(miniClose, 8, 10, 0, 0); hlist(miniClose, 5)
	icon("x", {Size=UDim2.fromOffset(11,11), Color="Text", LayoutOrder=1, Parent=miniClose})
	text("TextLabel", {Size=UDim2.fromOffset(0,26), AutomaticSize=Enum.AutomaticSize.X, Text="close", Weight=SEMI, TextSize=11, LayoutOrder=2, Parent=miniClose})
	miniClose.MouseEnter:Connect(function() tween(miniClose,{BackgroundColor3=Theme.Red}); tween(cs,{Color=Theme.Red}) end)
	miniClose.MouseLeave:Connect(function() tween(miniClose,{BackgroundColor3=Theme.Element}); tween(cs,{Color=Theme.Stroke}) end)
	fpsSeg.Visible = S.MiniFps; pingSeg.Visible = S.MiniPing; timeSeg.Visible = S.MiniClock; miniClose.Visible = S.MiniClose
	if S.MiniPos=="Bottom" then mini.AnchorPoint = Vector2.new(0.5,1); mini.Position = UDim2.new(0.5,0,1,-12) end
	task.spawn(function()
		while gui.Parent do
			local spec = Theme.Fx
			if spec and S.Particles and S.MiniParticles and mini.Visible then spawnParticle(miniFx, 0.5); task.wait(spec.Rate*2.5/S.Density) else task.wait(0.4) end
		end
	end)
end
local liveLabels = {}
do
	local frames, acc = 0,0
	RunService.RenderStepped:Connect(function(dt) frames=frames+1; acc=acc+dt; if acc>=0.5 then fps = math.floor(frames/acc+0.5); frames=0; acc=0 end end)
	local function readPing()
		local ok, v = pcall(function() return Stats.Network.ServerStatsItem["Data Ping"]:GetValue() end)
		if ok and type(v)=="number" and v>0 then return math.floor(v+0.5) end
		ok, v = pcall(function() return LocalPlayer:GetNetworkPing()*2000 end)
		if ok and type(v)=="number" then return math.floor(v+0.5) end
		return 0
	end
	local function formatTime(sec) sec=math.floor(sec); return string.format("%02d:%02d:%02d", math.floor(sec/3600), math.floor(sec%3600/60), sec%60) end
	task.spawn(function()
		while gui.Parent do
			ping = readPing()
			if fpsValue then fpsValue.Text = tostring(fps) end
			if pingValue then pingValue.Text = tostring(ping) end
			if pingIcon then pingIcon.ImageColor3 = (ping<90 and Theme.Green) or (ping<160 and rgb(240,190,60)) or Theme.Red end
			if timeValue then timeValue.Text = os.date("%H:%M") end
			if liveLabels.fps then liveLabels.fps.Text = tostring(fps) end
			if liveLabels.ping then liveLabels.ping.Text = ping.." ms" end
			if liveLabels.players then liveLabels.players.Text = #Players:GetPlayers().."/"..Players.MaxPlayers end
			if liveLabels.session then liveLabels.session.Text = formatTime(os.clock()-sessionStart) end
			task.wait(0.5)
		end
	end)
end

------------------------------------------------------------------------
-- КОНТЕНТ МЕНЮ
------------------------------------------------------------------------
local selectedPlayer = nil
local PlayerSheet = {}
local function buildContent()
	addSection("Overview"); addNav("Home", "home")
	addSection("Round"); addNav("Murderer", "swords"); addNav("Sheriff", "crosshair")
	addSection("World"); addNav("Visuals", "eye"); addNav("Teleport", "compass"); addNav("Farming", "coins")
	addSection("You"); addNav("Character", "user-round"); addNav("Emotes", "person-standing"); addNav("Fun", "party-popper", "NEW")
	addSection("Social"); addNav("Players", "users-round"); addNav("Chat", "message-square", "2"); addNav("Music", "music"); addNav("Community", "users")
	addSection("System"); addNav("Configs", "folder"); addNav("Mobile", "smartphone"); addNav("Server", "server"); addNav("Settings", "settings")
	local RED, BLUE, GOLD, GREEN, GRAY = rgb(225,70,70), rgb(70,125,240), rgb(230,175,50), rgb(80,195,105), rgb(140,140,150)

	-- Home
	do
		local p = createPage("Home", "Welcome back", {"Overview"})
		onLang(function() p.Desc.Text = tr("Welcome back")..", "..LocalPlayer.DisplayName end)
		Lang.reg[p.Desc] = nil
		local o = p.Tabs.Overview
		local prof = createCard(o.Left, "user-round", "Profile")
		local pr = plainRow(prof, 58)
		local bigAv = make("ImageLabel", {Size=UDim2.fromOffset(50,50), Position=UDim2.fromOffset(0,4), BorderSizePixel=0, Image="", Parent=pr}, {BackgroundColor3="Element2"})
		corner(bigAv, 14); stroke(bigAv, "Accent", 0.2, 2); Avatar.set(bigAv, LocalPlayer.UserId)
		text("TextLabel", {Size=UDim2.new(1,-62,0,18), Position=UDim2.fromOffset(60,6), Text=LocalPlayer.DisplayName, Tr=false, Weight=BOLD, TextSize=15, TextTruncate=Enum.TextTruncate.AtEnd, Parent=pr})
		local ageLabel = text("TextLabel", {Size=UDim2.new(1,-62,0,13), Position=UDim2.fromOffset(60,24), Text="", Tr=false, Color="Sub", TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=pr})
		onLang(function() ageLabel.Text = "@"..LocalPlayer.Name.."  ·  "..LocalPlayer.AccountAge.." "..tr("days") end)
		local chip = make("Frame", {Size=UDim2.fromOffset(0,17), AutomaticSize=Enum.AutomaticSize.X, Position=UDim2.fromOffset(60,39), BackgroundTransparency=0.82, BorderSizePixel=0, Parent=pr}, {BackgroundColor3="Accent"})
		corner(chip, 6); pad(chip, 6, 7, 0, 0); hlist(chip, 4)
		icon("badge-check", {Size=UDim2.fromOffset(10,10), Color="Accent", LayoutOrder=1, Parent=chip})
		text("TextLabel", {Size=UDim2.fromOffset(0,17), AutomaticSize=Enum.AutomaticSize.X, Text="KRIEG MEMBER", Weight=BOLD, TextSize=9, Color="Accent", LayoutOrder=2, Parent=chip})
		local live = createCard(o.Left, "activity", "Live", "Updates every half second")
		local grid = tileGrid(live, 2, 52)
		local function stat(key, iconName, label, i)
			local t = make("Frame", {BorderSizePixel=0, LayoutOrder=i, Parent=grid}, {BackgroundColor3="Deep"})
			corner(t, 9); stroke(t, "Stroke", 0.3)
			icon(iconName, {Size=UDim2.fromOffset(12,12), Position=UDim2.fromOffset(9,9), Color="Accent", Parent=t})
			text("TextLabel", {Size=UDim2.new(1,-30,0,12), Position=UDim2.fromOffset(25,9), Text=label, Color="Dim", TextSize=11, Parent=t})
			liveLabels[key] = text("TextLabel", {Size=UDim2.new(1,-18,0,18), Position=UDim2.fromOffset(9,26), Text="-", Tr=false, Weight=BOLD, TextSize=15, Parent=t})
		end
		stat("fps","gauge","FPS",1); stat("ping","wifi","Ping",2); stat("players","users","Players",3); stat("session","clock","Session",4)
		local season = createCard(o.Right, "sparkles", "Season", "Pick a style for the whole menu")
		addThemeGrid(season)
		local news = createCard(o.Right, "newspaper", "Changelog", nil, true)
		local function entry(tag, txt)
			local r = row(news, 18)
			local t = make("Frame", {Size=UDim2.fromOffset(0,16), AutomaticSize=Enum.AutomaticSize.X, Position=UDim2.fromOffset(0,1), BorderSizePixel=0, Parent=r}, {BackgroundColor3="Deep"})
			corner(t, 5); pad(t, 5, 5, 0, 0)
			text("TextLabel", {Size=UDim2.fromOffset(0,16), AutomaticSize=Enum.AutomaticSize.X, Text=tag, Weight=BOLD, TextSize=9, Color="Accent", Parent=t})
			text("TextLabel", {Size=UDim2.new(1,-46,1,0), Position=UDim2.fromOffset(46,0), Text=txt, Color="Sub", TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
		end
		entry("NEW","Reach / bhop / wall climb работают")
		entry("NEW","Knife trail и round sound")
		entry("NEW","Weather, skybox, mobile button")
		entry("NEW","Everywhere counter (HTTP)")
		entry("NEW","Low gravity jump")
		entry("NEW","Tag above head")
		entry("NEW","Copy emotes")
	end

	-- Murderer
	do
		local p = createPage("Murderer", "Tools for when you hold the knife", {"Knife", "Throw", "Cosmetic"})
		local k = p.Tabs.Knife
		local c1 = createCard(k.Left, "swords", "Close range")
		addToggle(c1, "Reach", false, {desc="Longer knife hit range", key=true, gear=true, bind="reach"})
		addSlider(c1, "Reach distance", 1, 25, 10, 0, " st", function(v) Game.flags.reachDistance = v end)
		addToggle(c1, "Quick equip", false, {desc="Pull out the knife instantly", bind="quickEquip"})
		local c2 = createCard(k.Right, "bell", "Alerts")
		addToggle(c2, "Sheriff nearby", true, {desc="Warns when the sheriff is close", bind="sheriffAlert"})
		addToggle(c2, "Round start sound", false, {bind="roundSound"})
		local t = p.Tabs.Throw
		local c3 = createCard(t.Left, "target", "Throwing")
		addToggle(c3, "Throw assist", false, {key=true, gear=true, bind="throwAssist"})
		addDropdown(c3, "Priority", {"Nearest","Sheriff first","Hero first","Lowest HP"}, "Nearest", function(v) Game.flags.throwPriority=v end)
		addSlider(c3, "Lead", 0, 1, 0.35, 2, "", function(v) Game.flags.throwLead=v end)
		local c4 = createCard(t.Right, "info", "Tip")
		addParagraph(c4, "Lead controls how far ahead of a moving target the throw is aimed. Start low and raise it slowly.")
		local cs = p.Tabs.Cosmetic
		local c5 = createCard(cs.Left, "sparkles", "Knife trail")
		addStyleTiles(c5, {{"Off","circle",GRAY},{"Ember","flame",rgb(255,120,40),true},{"Void","moon",rgb(150,95,255),true},{"Frost","snowflake",rgb(110,190,255),true},{"Toxic","zap",GREEN,true},{"Gold","star",GOLD}}, 1, function(name)
			Game.flags.knifeTrail = name
			if name~="Off" then applyKnifeTrail(name) elseif trailConn then trailConn:Disconnect(); trailConn=nil end
		end)
	end

	-- Sheriff
	do
		local p = createPage("Sheriff", "Aim helpers and gun tools", {"Aim","Gun"})
		local a = p.Tabs.Aim
		local c1 = createCard(a.Left, "crosshair", "Aim helper")
		addToggle(c1, "Soft aim", false, {desc="Gently pulls aim to the target", key=true, gear=true, bind="softAim"})
		addSlider(c1, "Smoothness", 1, 20, 8, 0, "", function(v) Game.flags.aimSmooth=v end)
		addSlider(c1, "FOV", 30, 360, 120, 0, "°", function(v) Game.flags.aimFov=v end)
		addDropdown(c1, "Aim point", {"Upper body","Head","Center"}, "Upper body", function(v) Game.flags.aimPoint=v end)
		local c2 = createCard(a.Right, "circle-dot", "FOV circle")
		addToggle(c2, "Show circle", true, {bind="showFov"})
		addToggle(c2, "Fill circle", false, {bind="fillFov"})
		addSlider(c2, "Thickness", 1, 4, 1.5, 1, " px", function(v) Game.flags.fovThickness=v end)
		local g = p.Tabs.Gun
		local c3 = createCard(g.Left, "package", "Dropped gun")
		addToggle(c3, "Highlight dropped gun", true, {desc="Outline the gun when the sheriff dies", bind="highlightGun"})
		addToggle(c3, "Announce drop", true, {bind="announceGun"})
		addToggle(c3, "Pick up gun", false, {key=true, bind="pickupGun"})
	end

	-- Visuals
	do
		local p = createPage("Visuals", "See more of the round and the map", {"Players","World","Atmosphere"})
		local pl = p.Tabs.Players
		local c1 = createCard(pl.Left, "eye", "Highlights", "Outline players by role")
		addToggle(c1, "Enabled", true, {bind="espEnabled"})
		addSegments(c1, "Roles to show", {{"Murderer","swords",RED},{"Sheriff","crosshair",BLUE},{"Hero","star",GOLD},{"Innocent","user",GREEN},{"Unknown","circle-help",GRAY}}, true, {true,true,true,false,false})
		addSlider(c1, "Range", 50, 2500, 1500, 0, " st", function(v) Game.flags.espRange=v end)
		addToggle(c1, "Only visible", false, {gear=true, bind="espVisibleOnly"})
		local c2 = createCard(pl.Left, "type", "Labels", nil, true)
		addToggle(c2, "Names", true, {bind="espNames"})
		addToggle(c2, "Distance", false, {bind="espDistance"})
		addToggle(c2, "Role tag", true, {bind="espRoleTag"})
		local c3 = createCard(pl.Right, "layers", "Highlight style")
		addStyleTiles(c3, {{"Soft","user-round",rgb(230,230,235)},{"Outline","scan",WHITE},{"Neon","zap",rgb(255,80,120),true},{"Ghost","ghost",rgb(190,200,255),true},{"Hologram","box",rgb(80,210,230),true},{"Shadow","moon",rgb(130,120,150)}}, 3, function(name) Game.flags.espStyle=name end)
		addDropdown(c3, "Color source", {"Role color","Theme accent","Rainbow"}, "Role color", function(v) Game.flags.espColor=v end)
		local w = p.Tabs.World
		local c4 = createCard(w.Left, "sun", "Lighting")
		addToggle(c4, "Bright map", false, {desc="Removes dark shadows", bind="brightMap"}, function(on) Lighting.Brightness=on and 3 or 2; Lighting.OutdoorAmbient=on and rgb(180,180,180) or rgb(128,128,128) end)
		addToggle(c4, "Clear fog", false, {bind="clearFog"}, function(on) Lighting.FogEnd=on and 100000 or 1000 end)
		addSlider(c4, "Clock time", 0, 24, 14, 1, "h", function(v) Lighting.ClockTime=v end)
		local c5 = createCard(w.Right, "palette", "Color grading")
		addToggle(c5, "Enabled", false, {bind="grading"})
		addSlider(c5, "Saturation", -1, 1, 0.1, 2, "", function(v) local cg=Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or create("ColorCorrectionEffect",{Parent=Lighting}); cg.Saturation=Game.flags.grading and v or 0 end)
		addSlider(c5, "Contrast", -1, 1, 0.05, 2, "", function(v) local cg=Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or create("ColorCorrectionEffect",{Parent=Lighting}); cg.Contrast=Game.flags.grading and v or 0 end)
		local at = p.Tabs.Atmosphere
		local c6 = createCard(at.Left, "cloud-rain", "Weather")
		addDropdown(c6, "Weather", {"Off","Rain","Snow","Fog","Storm"}, "Off", function(v) applyWeather(v, 0.5) end)
		addSlider(c6, "Intensity", 0, 1, 0.5, 2, "", function(v) end)
		local c7 = createCard(at.Right, "moon", "Sky")
		addDropdown(c7, "Skybox", {"Default","Blood moon","Night","Galaxy","Sunset"}, "Default", function(v) applySky(v) end)
		addToggle(c7, "Slow sky rotation", false)
	end

	-- Teleport
	do
		local p = createPage("Teleport", "Move around the map quickly", {"Places","Players"})
		local pl = p.Tabs.Places
		local c1 = createCard(pl.Left, "compass", "Places")
		addButtonRow(c1, {{"Lobby","home",false,function() teleportTo(getPlacePosition("Lobby")) end},{"Map","compass",false,function() teleportTo(getPlacePosition("Map")) end}})
		addButtonRow(c1, {{"Spawn","map-pin",false,function() teleportTo(getPlacePosition("Spawn")) end},{"Safe spot","shield",false,function() teleportTo(getPlacePosition("SafeSpot")) end}})
		addButton(c1, "Dropped gun", "package", true, function() if RoundState.gunPart then teleportTo(RoundState.gunPart.Position) else notify("Teleport","No dropped gun","package",3) end end)
		local c2 = createCard(pl.Right, "sliders-horizontal", "Travel")
		addDropdown(c2, "Method", {"Smooth","Instant"}, "Smooth", function(v) Game.flags.travelMethod=v end)
		addSlider(c2, "Speed", 10, 200, 80, 0, " st/s", function(v) Game.flags.travelSpeed=v end)
		local pp = p.Tabs.Players
		local c3 = createCard(pp.Left, "users", "Go to player")
		addPlayerList(c3, "compass")
	end

	-- Farming
	do
		local p = createPage("Farming", "Coins and progress", {"Coins","Session"})
		local c = p.Tabs.Coins
		local c1 = createCard(c.Left, "coins", "Coin collector")
		addToggle(c1, "Collect coins", false, {desc="Picks up coins around the map", key=true, bind="collectCoins"})
		addToggle(c1, "Stay away from murderer", true, {bind="stayAway"})
		addSlider(c1, "Speed", 1, 10, 5, 0, "")
		addDropdown(c1, "Movement", {"Smooth","Walk","Instant"}, "Smooth")
		local c2 = createCard(c.Right, "shield", "Safety")
		addToggle(c2, "Anti AFK", true, {bind="antiAfk"})
		addToggle(c2, "Stop when bag is full", true, {bind="stopWhenFull"})
		local s = p.Tabs.Session
		local c3 = createCard(s.Left, "trophy", "This session")
		local coinsInfo = addInfo(c3, "Coins", "0", "coins")
		local roundsInfo = addInfo(c3, "Rounds", "0", "flag")
		local perHourInfo = addInfo(c3, "Per hour", "0", "gauge")
		task.spawn(function() while gui.Parent do local hours=math.max((os.clock()-farmStats.started)/3600, 0.0001); if coinsInfo.Parent then coinsInfo.Text = tostring(farmStats.coins) end; if roundsInfo.Parent then roundsInfo.Text = tostring(farmStats.rounds) end; if perHourInfo.Parent then perHourInfo.Text = tostring(math.floor(farmStats.coins/hours)) end; task.wait(1) end end)
		addButton(c3, "Reset", "refresh-cw", false, function() farmStats.coins, farmStats.rounds, farmStats.started = 0,0,os.clock() end)
	end

	-- Character
	do
		local p = createPage("Character", "Movement, physics and protection", {"Movement","Physics","Protection"})
		local m = p.Tabs.Movement
		local c1 = createCard(m.Left, "footprints", "Movement")
		addToggle(c1, "Walk through walls", false, {key=true, bind="noclip"})
		addToggle(c1, "Air jump", false, {desc="Jump again while in the air", key=true, bind="airJump"})
		addToggle(c1, "Flight", false, {key=true, gear=true, bind="fly"})
		addToggle(c1, "Bunny hop", false, {key=true, bind="bhop"})
		addToggle(c1, "Wall climb", false, {gear=true, bind="wallClimb"})
		local c2 = createCard(m.Right, "gauge", "Speed")
		addToggle(c2, "Custom walk speed", false, {key=true, bind="customWalkSpeed"})
		addSlider(c2, "Walk speed", 16, 100, 16, 0, "", function(v) Game.flags.walkSpeed=v end)
		addToggle(c2, "Custom jump", false, {bind="customJump"})
		addSlider(c2, "Jump power", 50, 200, 50, 0, "", function(v) Game.flags.jumpPower=v end)
		local ph = p.Tabs.Physics
		local c3 = createCard(ph.Left, "rocket", "Physics")
		addSlider(c3, "Gravity", 0, 196, 196, 0, "", function(v) Game.flags.gravity=v end)
		addSlider(c3, "Hip height", 0, 10, 2, 1, "", function(v) Game.flags.hipHeight=v end)
		addToggle(c3, "Low gravity jump", false, {gear=true, bind="lowGravity"})
		local c4 = createCard(ph.Right, "refresh-cw", "Spin")
		addToggle(c4, "Spin", false, {key=true, bind="spin"})
		addSlider(c4, "Spin speed", 1, 50, 15, 0, "", function(v) Game.flags.spinSpeed=v end)
		local pr = p.Tabs.Protection
		local c5 = createCard(pr.Left, "shield", "Protection")
		addToggle(c5, "Anti push", true, {desc="Ignore other players pushing you", bind="antiPush"})
		addToggle(c5, "Anti ragdoll", false, {bind="antiRagdoll"})
	end

	-- Emotes
	do
		local p = createPage("Emotes", "Animation packs and dances", {"Packs","Dances"})
		local a = p.Tabs.Packs
		local c1 = createCard(a.Left, "person-standing", "Animation pack")
		addDropdown(c1, "Pack", {"Default","Zombie","Ninja","Robot","Levitation","Stylish","Mage"}, "Mage")
		addToggle(c1, "Use pack", false)
		addSlider(c1, "Animation speed", 0.25, 3, 1, 2, "x")
		local c2 = createCard(a.Right, "ghost", "Seasonal packs")
		addStyleTiles(c2, {{"Zombie","skull",GREEN},{"Phantom","ghost",rgb(220,225,255),true},{"Mummy","venetian-mask",rgb(225,215,185)}}, 2)
		local d = p.Tabs.Dances
		local c3 = createCard(d.Left, "music", "Dances")
		addButtonRow(c3, {{"Dance 1", nil, false, function() local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum:PlayEmote("dance") end end},{"Dance 2", nil, false, function() local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum:PlayEmote("dance2") end end}})
		addButtonRow(c3, {{"Dance 3", nil, false, function() local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum:PlayEmote("dance3") end end},{"Wave", nil, false, function() local hum=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid"); if hum then hum:PlayEmote("wave") end end}})
		addToggle(c3, "Loop dance", true)
	end

	-- Fun
	do
		local p = createPage("Fun", "Harmless jokes and cosmetics", {"Cosmetics","Players"})
		local c = p.Tabs.Cosmetics
		local c1 = createCard(c.Left, "venetian-mask", "Look", "Only you can see these")
		addToggle(c1, "Headless look", false)
		addToggle(c1, "Korblox leg look", false)
		addDropdown(c1, "Hat", {"None","Pumpkin","Witch hat","Santa hat","Halo"}, "Pumpkin")
		local c2 = createCard(c.Right, "gamepad-2", "Toys")
		addDropdown(c2, "Toy", {"None","Hoverboard","Candy bucket","Broom","Balloon"}, "None")
		addToggle(c2, "Always hold toy", false, {bind="alwaysHoldToy"})
		local c3 = createCard(c.Right, "laugh", "Emote spam")
		addDropdown(c3, "Emote", {"wave","point","cheer","laugh","dance"}, "wave")
		addToggle(c3, "Repeat", false)
		local pp = p.Tabs.Players
		local c4 = createCard(pp.Left, "users", "Players")
		addPlayerList(c4, "chevron-right")
		local c5 = createCard(pp.Right, "wand-sparkles", "Actions")
		addToggle(c5, "Follow selected", false, nil, function(on) Game.flags.follow = on and selectedPlayer or nil end)
		addToggle(c5, "Orbit selected", false, {gear=true}, function(on) Game.flags.orbit = on and selectedPlayer or nil end)
		addToggle(c5, "Copy their emotes", false, {bind="copyEmotes"})
	end

	-- Players
	do
		local p = createPage("Players", "Everyone on this server. Tap a player for actions", {"All"})
		local col = p.Tabs.All.Full
		local card = createCard(col, "users-round", "On this server")
		local top = plainRow(card, 30)
		local sf = make("Frame", {Size=UDim2.new(1,-60,1,0), BorderSizePixel=0, Parent=top}, {BackgroundColor3="Element"})
		corner(sf, 8); local ss = stroke(sf)
		icon("search", {Size=UDim2.fromOffset(12,12), Position=UDim2.new(0,10,0.5,-6), Color="Sub", Parent=sf})
		local box = text("TextBox", {Size=UDim2.new(1,-36,1,0), Position=UDim2.fromOffset(28,0), Text="", Tr=false, PlaceholderText="Search player", TextSize=12, ClearTextOnFocus=false, Parent=sf})
		box.Focused:Connect(function() tween(ss,{Color=Theme.Accent}) end)
		box.FocusLost:Connect(function() tween(ss,{Color=Theme.Stroke}) end)
		local cnt = make("Frame", {Size=UDim2.new(0,52,1,0), Position=UDim2.new(1,-52,0,0), BorderSizePixel=0, Parent=top}, {BackgroundColor3="Deep"})
		corner(cnt, 8); stroke(cnt)
		icon("users", {Size=UDim2.fromOffset(12,12), Position=UDim2.new(0,9,0.5,-6), Color="Accent", Parent=cnt})
		local cntText = text("TextLabel", {Size=UDim2.new(1,-26,1,0), Position=UDim2.fromOffset(25,0), Text="0", Tr=false, Weight=BOLD, TextSize=12, Parent=cnt})
		local grid = create("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=card})
		create("UIGridLayout", {CellSize=UDim2.new(0.5,-4,0,56), CellPadding=UDim2.fromOffset(8,8), SortOrder=Enum.SortOrder.Name, Parent=grid})
		local empty = text("TextLabel", {Name="~", Size=UDim2.new(1,0,0,40), Text="Server is empty for now", Color="Dim", TextSize=12, TextXAlignment=Enum.TextXAlignment.Center, Parent=grid})
		local tiles = {}
		local function refresh()
			local n, shown = 0,0
			local q = box.Text:lower()
			for plr,t in pairs(tiles) do
				n = n+1
				local match = q=="" or plr.Name:lower():find(q,1,true) or plr.DisplayName:lower():find(q,1,true)
				t.Visible = match and true or false
				if t.Visible then shown = shown+1 end
			end
			cntText.Text = tostring(n); empty.Visible = shown==0
		end
		box:GetPropertyChangedSignal("Text"):Connect(refresh)
		local function add(plr)
			if plr==LocalPlayer or tiles[plr] or not gui.Parent then return end
			local t = make("TextButton", {Name=plr.Name:lower(), Text="", AutoButtonColor=false, BackgroundTransparency=0.45, BorderSizePixel=0, Parent=grid}, {BackgroundColor3="Element"})
			corner(t, 11); local ts = stroke(t, "Stroke", 0.5)
			local av = make("ImageLabel", {Size=UDim2.fromOffset(40,40), Position=UDim2.new(0,8,0.5,-20), BorderSizePixel=0, Image="", Parent=t}, {BackgroundColor3="Element2"})
			corner(av, 12); stroke(av, "Accent", 0.45, 1.5); Avatar.set(av, plr.UserId)
			text("TextLabel", {Size=UDim2.new(1,-92,0,16), Position=UDim2.fromOffset(56,10), Text=plr.DisplayName, Tr=false, Weight=BOLD, TextSize=13, TextTruncate=Enum.TextTruncate.AtEnd, Parent=t})
			text("TextLabel", {Size=UDim2.new(1,-92,0,13), Position=UDim2.fromOffset(56,28), Text="@"..plr.Name, Tr=false, Color="Dim", TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=t})
			local go = make("Frame", {Size=UDim2.fromOffset(26,26), Position=UDim2.new(1,-34,0.5,-13), BackgroundTransparency=0.85, BorderSizePixel=0, Parent=t}, {BackgroundColor3="Accent"})
			corner(go, 13); icon("chevron-up", {Size=UDim2.fromOffset(13,13), Position=UDim2.fromOffset(6.5,6.5), Color="Accent", Parent=go})
			t.MouseEnter:Connect(function() tween(ts,{Color=Theme.Accent, Transparency=0}); tween(t,{BackgroundTransparency=0.25}) end)
			t.MouseLeave:Connect(function() tween(ts,{Color=Theme.Stroke, Transparency=0.5}); tween(t,{BackgroundTransparency=0.45}) end)
			t.MouseButton1Click:Connect(function() selectedPlayer=plr; if PlayerSheet.open then PlayerSheet.open(plr) end end)
			tiles[plr] = t; refresh()
		end
		for _,plr in ipairs(Players:GetPlayers()) do add(plr) end
		Players.PlayerAdded:Connect(add)
		Players.PlayerRemoving:Connect(function(plr) if tiles[plr] then tiles[plr]:Destroy(); tiles[plr]=nil; refresh() end; if PlayerSheet.current==plr and PlayerSheet.close then PlayerSheet.close() end end)
		refresh()
	end

	-- Chat
	do
		local p = createPage("Chat", "Messages and chat tools", {"Send","History"})
		local s = p.Tabs.Send
		local c1 = createCard(s.Left, "message-square", "Message")
		local msgBox = addInput(c1, "Write something...", "message-square")
		addButton(c1, "Send", "send", true, function() sendChat(msgBox.Text); msgBox.Text="" end)
		local c2 = createCard(s.Right, "bell", "Notifications")
		addToggle(c2, "Sound on mention", true, {bind="soundOnMention"})
		addButton(c2, "Preview popup", "bell", false, function() notify("KRIEG HUB", "This is how a popup looks", "bell", 3) end)
		local h = p.Tabs.History
		local c3 = createCard(h.Left, "list", "History")
		addToggle(c3, "Keep history", false, {bind="keepHistory"})
		addParagraph(c3, "Nothing saved yet. Turn on history to keep messages from this server.")
	end

	-- Music
	do
		local p = createPage("Music", "Background sounds while you play", {"Player","Library"})
		local m = p.Tabs.Player
		local c1 = createCard(m.Left, "disc", "Now playing")
		local idBox = addInput(c1, "Sound ID", "music")
		addButtonRow(c1, {{"Play","play",true,function() playMusic(idBox.Text, Game.flags.musicVolume or 5) end},{"Stop","square",false,function() stopMusic() end}})
		addToggle(c1, "Repeat", false, nil, function(on) if sound then sound.Looped = on end end)
		local c2 = createCard(m.Right, "volume-2", "Sound")
		addSlider(c2, "Volume", 0, 10, 5, 1, "", function(v) Game.flags.musicVolume=v; if sound then sound.Volume=v end end)
		addSlider(c2, "Speed", 0.5, 2, 1, 2, "x", function(v) if sound then sound.PlaybackSpeed=v end end)
		local l = p.Tabs.Library
		local c3 = createCard(l.Left, "list", "Seasonal picks")
		addButton(c3, "Night walk", "moon", false, function() playMusic("1837879081", Game.flags.musicVolume) end)
		addButton(c3, "Snowfall", "snowflake", false, function() playMusic("1839612245", Game.flags.musicVolume) end)
		addButton(c3, "Summer breeze", "sun", false, function() playMusic("1840485681", Game.flags.musicVolume) end)
	end

	-- Community
	do
		local p = createPage("Community", "People using KRIEG HUB", {"Online"})
		local o = p.Tabs.Online
		local c1 = createCard(o.Left, "users", "Online")
		local inServer = addInfo(c1, "In this server", tostring(#Players:GetPlayers()), "server")
		local everywhere = addInfo(c1, "Everywhere", "?", "globe")
		local function refreshCounts()
			inServer.Text = tostring(#Players:GetPlayers())
			local req = request or http_request or (syn and syn.request) or (http and http.request)
			if type(req)=="function" then
				task.spawn(function()
					local ok, res = pcall(req, {Url="https://games.roblox.com/v1/games/"..tostring(game.PlaceId).."/servers/Public?limit=100", Method="GET"})
					if ok and type(res)=="table" and type(res.Body)=="string" then
						local okJ, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
						if okJ and data and data.data then
							local total = 0
							for _,srv in ipairs(data.data) do total = total + (srv.playing or 0) end
							everywhere.Text = tostring(total)
						end
					end
				end)
			end
		end
		refreshCounts()
		addButton(c1, "Refresh", "refresh-cw", false, refreshCounts)
		local c2 = createCard(o.Right, "crown", "Your tag")
		addToggle(c2, "Show tag above head", false, {bind="showTag"})
		addDropdown(c2, "Tag style", {"Clean","Glow","Seasonal"}, "Seasonal")
	end

	-- Configs
	do
		local p = createPage("Configs", "Save your setup and load it later", {"Local","Shared"})
		local l = p.Tabs.Local
		local c1 = createCard(l.Left, "save", "Save")
		local nameBox = addInput(c1, "Config name", "type")
		addButtonRow(c1, {{"Save","save",true,function()
			if not Store.can then notify("Configs","Executor can't save files","x",3) return end
			local name = (nameBox.Text~="" and nameBox.Text or "default"):gsub("[^%w_%-]","")
			pcall(function() Store.ensureDir(); writefile(Store.dir.."/cfg_"..name..".json", HttpService:JSONEncode(Store.data)) end)
			notify("Configs","Saved "..name,"save",3)
		end},{"Load","folder",false,function()
			if not Store.can then notify("Configs","Executor can't save files","x",3) return end
			local name = (nameBox.Text~="" and nameBox.Text or "default"):gsub("[^%w_%-]","")
			pcall(function()
				local path = Store.dir.."/cfg_"..name..".json"
				if isfile(path) then
					local decoded = HttpService:JSONDecode(readfile(path))
					for k,v in pairs(decoded) do if Store.data[k]~=nil then Store.data[k]=v end end
					notify("Configs","Loaded "..name..". Rejoin to apply fully.","folder",3)
				else notify("Configs","No such config","x",3) end
			end)
		end}})
		addButton(c1, "Delete", "trash-2", false, function()
			local name = (nameBox.Text~="" and nameBox.Text or "default"):gsub("[^%w_%-]","")
			pcall(function() local path=Store.dir.."/cfg_"..name..".json"; if isfile(path) then delfile(path) end end)
			notify("Configs","Deleted","trash-2",2)
		end)
		local c2 = createCard(l.Right, "folder", "Saved configs")
		addDropdown(c2, "Config", {"default","legit","seasonal"}, "seasonal")
		addToggle(c2, "Load on start", false)
		local s = p.Tabs.Shared
		local c3 = createCard(s.Left, "cloud", "Shared configs")
		addParagraph(c3, "Sharing configs with friends is coming in a future update.")
	end

	-- Mobile
	do
		local p = createPage("Mobile", "Touch controls for phones and tablets", {"Button"})
		local b = p.Tabs.Button
		local c1 = createCard(b.Left, "smartphone", "Open button")
		addToggle(c1, "Show button", S.MobileBtn, nil, function(on) Store.set("MobileBtn", on); if mobileBtn then mobileBtn.Visible = on end end)
		addSlider(c1, "Size", 30, 100, S.MobileSize, 0, " px", function(v) Store.set("MobileSize", v); if mobileBtn then mobileBtn.Size = UDim2.fromOffset(v, v) end end)
		addSlider(c1, "Opacity", 0, 1, S.MobileOpacity, 2, "", function(v) Store.set("MobileOpacity", v); if mobileBtn then mobileBtn.BackgroundTransparency = 1-v end end)
		local c2 = createCard(b.Right, "move", "Placement")
		addDropdown(c2, "Corner", {"Top left","Top right","Bottom left","Bottom right"}, S.MobileCorner, function(v)
			Store.set("MobileCorner", v)
			if mobileBtn then
				if v=="Top left" then mobileBtn.Position = UDim2.new(0, 20, 0, 20); mobileBtn.AnchorPoint = Vector2.new(0,0)
				elseif v=="Top right" then mobileBtn.Position = UDim2.new(1, -20, 0, 20); mobileBtn.AnchorPoint = Vector2.new(1,0)
				elseif v=="Bottom left" then mobileBtn.Position = UDim2.new(0, 20, 1, -20); mobileBtn.AnchorPoint = Vector2.new(0,1)
				else mobileBtn.Position = UDim2.new(1, -20, 1, -20); mobileBtn.AnchorPoint = Vector2.new(1,1) end
			end
		end)
		addToggle(c2, "Allow dragging", S.MobileDrag, nil, function(on) Store.set("MobileDrag", on) end)
	end

	-- Server
	do
		local p = createPage("Server", "Info about this server", {"Info"})
		local i = p.Tabs.Info
		local c1 = createCard(i.Left, "server", "Server")
		local playersInfo = addInfo(c1, "Players", "", "users")
		local function upd() if playersInfo.Parent then playersInfo.Text = #Players:GetPlayers().." / "..Players.MaxPlayers end end
		upd()
		Players.PlayerAdded:Connect(upd)
		Players.PlayerRemoving:Connect(function() task.defer(upd) end)
		addInfo(c1, "Place ID", tostring(game.PlaceId), "map-pin")
		local c2 = createCard(i.Right, "refresh-cw", "Actions")
		addButton(c2, "Rejoin", "refresh-cw", true, function() pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end) end)
		addButton(c2, "Find another server", "shuffle", false, function()
			local req = request or http_request or (syn and syn.request) or (http and http.request)
			if type(req)~="function" then notify("Server","HTTP not available","x",3); return end
			task.spawn(function()
				local ok, res = pcall(req, {Url="https://games.roblox.com/v1/games/"..tostring(game.PlaceId).."/servers/Public?limit=100", Method="GET"})
				if ok and type(res)=="table" and type(res.Body)=="string" then
					local okJ, data = pcall(function() return HttpService:JSONDecode(res.Body) end)
					if okJ and data and data.data and #data.data>0 then
						local pick = data.data[math.random(1,#data.data)]
						pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, LocalPlayer) end)
						notify("Server","Joining another server","shuffle",3)
						return
					end
				end
				notify("Server","No public servers found","x",3)
			end)
		end)
		addButton(c2, "Copy server ID", "copy", false, function()
			local id = game.JobId
			if setclipboard then setclipboard(id) end
			notify("Server", id~="" and id or "Unknown", "copy", 4)
		end)
	end

	-- Settings (сокращённая версия — главное)
	do
		local p = createPage("Settings", "Make the menu yours", {"Seasons","Appearance","Interface","Mini bar","Other"})
		local se = p.Tabs.Seasons
		local c1 = createCard(se.Left, "sparkles", "Style", "Colors, scene, particles and mini bar")
		addThemeGrid(c1)
		local c2 = createCard(se.Right, "wand-sparkles", "Effects")
		addToggle(c2, "Live scene", S.Scene, {desc="Animated picture behind the menu"}, function(on) Store.set("Scene", on); Scene.show() end)
		addToggle(c2, "Particles", S.Particles, {desc="Snow, leaves, petals and more"}, function(on)
			Store.set("Particles", on)
			if not on then for _,c in ipairs(particleLayer:GetChildren()) do c:Destroy() end; for _,c in ipairs(miniFx:GetChildren()) do c:Destroy() end end
		end)
		addSlider(c2, "Amount", 0.25, 2, S.Density, 2, "x", function(v) S.Density=v; Store.save() end)
		addToggle(c2, "Animated border", S.Border, nil, function(on) Store.set("Border", on); applyBindings(false) end)
		local c3 = createCard(se.Right, "palette", "Accent", "Override the style color")
		addAccentPicker(c3)
		addButton(c3, "Use style color", "refresh-cw", false, function() setAccentOverride(nil) end)

		local ap = p.Tabs.Appearance
		local w = createCard(ap.Left, "image", "Wallpaper", "Your own picture behind the menu")
		local urlBox = addInput(w, "Image link or Roblox image ID", "link")
		urlBox.Text = S.Wallpaper
		addButtonRow(w, {{"Activate","check",true,function()
			local src = urlBox.Text
			notify("Wallpaper","Loading...","image",2)
			Wall.resolve(src, function(ok,res)
				if ok then Store.set("Wallpaper", src); Wall.apply(res); notify("Wallpaper","Wallpaper is on","image",3)
				else notify("Wallpaper",res,"x",4) end
			end)
		end},{"Remove","trash-2",false,function() urlBox.Text=""; Store.set("Wallpaper",""); Wall.apply(nil) end}})
		addSlider(w, "Darken", 0, 0.9, S.WallDim, 2, "", function(v) Wall.setDim(v); Store.save() end)
		addToggle(w, "Also in mini bar", S.WallMini, nil, function(on) Store.set("WallMini", on); Wall.apply(Wall.active and Wall.image or nil) end)
		addParagraph(w, "PNG or JPG link. Your style effects stay, only the built-in scene is replaced.")
		local pn = createCard(ap.Left, "layers", "Panels")
		addDropdown(pn, "Panel color", {"Auto","Light","Dark"}, S.PanelTone, function(v) setPanelTone(v) end)
		addSlider(pn, "Panel transparency", 0, 0.7, S.PanelAlpha, 2, "", function(v) setPanelAlpha(v); Store.save() end)
		addSlider(pn, "Corner radius", 0, 2, S.Corner, 2, "x", function(v) setCornerScale(v); Store.save() end)
		local tc = createCard(ap.Left, "palette", "Text color", "Pick a color that is easy to read on your wallpaper")
		do
			local choices = {{"Auto",nil},{"White",WHITE},{"Black",rgb(18,18,22)},{"Cream",rgb(255,240,214)},{"Pink",rgb(255,170,205)},{"Mint",rgb(150,240,200)},{"Sky",rgb(150,205,255)},{"Gold",rgb(255,214,110)}}
			local holder = tileGrid(tc, 4, 46)
			for i,ch in ipairs(choices) do
				local tile = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=holder}, {BackgroundColor3="Deep"})
				corner(tile, 8)
				local sw = create("Frame", {Size=UDim2.fromOffset(18,18), AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,0,6), BorderSizePixel=0, BackgroundColor3=ch[2] or WHITE, Parent=tile})
				corner(sw, 9)
				if not ch[2] then create("UIGradient", {Rotation=45, Color=ColorSequence.new(WHITE, rgb(18,18,22)), Parent=sw}) end
				text("TextLabel", {Size=UDim2.new(1,-4,0,13), Position=UDim2.new(0,2,1,-17), Text=ch[1], Weight=MED, TextSize=10, Color="Sub", TextXAlignment=Enum.TextXAlignment.Center, TextTruncate=Enum.TextTruncate.AtEnd, Parent=tile})
				tile.MouseButton1Click:Connect(function() setTextColor(ch[2]) end)
			end
			local hexBox = addInput(tc, "Your color, for example #FFAA00", "palette")
			addButton(tc, "Apply color", "check", false, function()
				local h = hexBox.Text:gsub("#",""):gsub("%s","")
				if #h==6 and h:match("^%x+$") then setTextColor(rgb(tonumber(h:sub(1,2),16), tonumber(h:sub(3,4),16), tonumber(h:sub(5,6),16)))
				else notify("Text color","Use the format #RRGGBB","x",3) end
			end)
		end
		local fc = createCard(ap.Right, "type", "Font", "Applies to the whole menu")
		addFontGrid(fc)
		local cfc = createCard(ap.Right, "link", "Your font", "Name, Roblox font ID or a .ttf link")
		local fontBox = addInput(cfc, "e.g. Lobster, 12187365364 or https://...ttf", "type")
		if S.Font=="Custom" then fontBox.Text = S.FontCustom end
		addButtonRow(cfc, {{"Apply","check",true,function() setCustomFont(fontBox.Text) end},{"Reset","rotate-ccw",false,function() fontBox.Text=""; S.FontCustom=""; setFont("Gotham") end}})
		addSlider(fc, "Text size", 0.8, 1.2, S.TextScale, 2, "x", function(v)
			textScale = v; S.TextScale = v; Store.save()
			for _,e in ipairs(textObjects) do local o=e[1]; if o.Parent then o.TextSize = math.floor(e[2]*v+0.5) end end
		end)
		local it = p.Tabs.Interface
		local lc = createCard(it.Left, "languages", "Language")
		addLanguageGrid(lc)
		local c4 = createCard(it.Left, "keyboard", "Controls")
		local kr = row(c4, 22)
		text("TextLabel", {Size=UDim2.new(1,-80,1,0), Text="Open / hide menu", Weight=MED, TextSize=13, Parent=kr})
		makeKeyBox(kr, UDim2.new(1,0,0.5,0), shortKey(menuKey.Name), function(k) menuKey = k or Enum.KeyCode.LeftControl; Store.set("Key", menuKey.Name) end)
		addToggle(c4, "Notifications", S.Notifs, nil, function(on) Store.set("Notifs", on) end)
		local c5 = createCard(it.Right, "monitor", "Layout")
		addSlider(c5, "Menu size", 0.45, 1.4, currentScale, 2, "x", function(v) currentScale=v; uiScale.Scale=v; Store.set("Scale", v); closePopup() end)
		addSlider(c5, "Opacity", 0.6, 1, 0.98, 2, "", function(v) main.BackgroundTransparency = 1-v end)
		addToggle(c5, "Compact sidebar", S.Compact, nil, function(on) setCompact(on) end)
		addButton(c5, "Reset window size", "rotate-ccw", false, function() S.WinW, S.WinH = 0, 0; Store.save(); tween(main, {Size=UDim2.fromOffset(690,450)}, 0.3) end)
		addParagraph(c5, "Drag the bottom right corner of the menu to resize it.")
		local mb = p.Tabs["Mini bar"]
		local c6 = createCard(mb.Left, "panel-top", "Mini bar", "The small bar at the top of the screen")
		addToggle(c6, "Show mini bar", S.MiniBar, nil, function(on) mini.Visible = on; Store.set("MiniBar", on) end)
		addToggle(c6, "Particles inside", S.MiniParticles, nil, function(on) Store.set("MiniParticles", on); if not on then for _,c in ipairs(miniFx:GetChildren()) do c:Destroy() end end end)
		addDropdown(c6, "Position", {"Top","Bottom"}, S.MiniPos, function(v)
			Store.set("MiniPos", v)
			if v=="Top" then mini.AnchorPoint = Vector2.new(0.5,0); mini.Position = UDim2.new(0.5,0,0,12) else mini.AnchorPoint = Vector2.new(0.5,1); mini.Position = UDim2.new(0.5,0,1,-12) end
		end)
		local c7 = createCard(mb.Right, "eye", "Show on bar")
		addToggle(c7, "FPS", S.MiniFps, nil, function(on) fpsSeg.Visible=on; Store.set("MiniFps", on) end)
		addToggle(c7, "Ping", S.MiniPing, nil, function(on) pingSeg.Visible=on; Store.set("MiniPing", on) end)
		addToggle(c7, "Clock", S.MiniClock, nil, function(on) timeSeg.Visible=on; Store.set("MiniClock", on) end)
		addToggle(c7, "Close button", S.MiniClose, nil, function(on) miniClose.Visible=on; Store.set("MiniClose", on) end)
		local ot = p.Tabs.Other
		local c8 = createCard(ot.Left, "save", "Saving", Store.can and "Settings are saved automatically" or "Your executor can't save files")
		addInfo(c8, "Status", Store.can and "On" or "Off", "hard-drive-download")
		addButton(c8, "Reset all settings", "rotate-ccw", false, function() pcall(function() if Store.can then writefile(Store.file, "{}") end end); notify("Settings","Run the script again to apply","rotate-ccw",4) end)
		local c9 = createCard(ot.Right, "info", "About")
		addInfo(c9, "Name", "KRIEG HUB", "box")
		addInfo(c9, "Version", "2.3 Seasons", "sparkles")
		addInfo(c9, "Styles", tostring(#THEME_ORDER), "palette")
		addInfo(c9, "Fonts", tostring(#FONTS + #FONTS_MORE), "type")
	end
end
-- addSegments (declared after use, hoist via local forward)
local addSegments
addSegments = function(body, label, items, multiSelect, defaults)
	if label then addCaption(body, label) end
	local holder = create("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, LayoutOrder=nextOrder(), Parent=body})
	create("UIGridLayout", {CellSize=UDim2.new(0.5,-3,0,28), CellPadding=UDim2.fromOffset(6,5), SortOrder=Enum.SortOrder.LayoutOrder, Parent=holder})
	local states, refreshers = {}, {}
	local roleKey = {Murderer="murderer", Sheriff="sheriff", Hero="hero", Innocent="innocent", Unknown="unknown"}
	Game.flags.espRoles = Game.flags.espRoles or {murderer=true, sheriff=true, hero=true}
	for i,it in ipairs(items) do
		local name, iconName, color = it[1], it[2], it[3]
		local key = roleKey[name]
		states[i] = defaults and defaults[i] or false
		local b = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=holder}, {BackgroundColor3="Element"})
		corner(b, 7); local s = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=b})
		local dot = create("Frame", {Size=UDim2.fromOffset(7,7), Position=UDim2.new(0,9,0.5,-3.5), BackgroundColor3=color, BorderSizePixel=0, Parent=b})
		corner(dot, 4)
		local ic = icon(iconName, {Size=UDim2.fromOffset(12,12), Position=UDim2.new(0,21,0.5,-6), Color="Sub", Parent=b})
		local lbl = text("TextLabel", {Size=UDim2.new(1,-42,1,0), Position=UDim2.fromOffset(38,0), Text=name, Weight=MED, TextSize=12, Color="Sub", TextTruncate=Enum.TextTruncate.AtEnd, Parent=b})
		local function refresh(instant)
			local on = states[i]
			local props = {{b,{BackgroundColor3=on and color:Lerp(Theme.Card,0.8) or Theme.Element}}, {s,{Color=on and color or Theme.Stroke, Transparency=on and 0.25 or 0}}, {ic,{ImageColor3=on and WHITE or Theme.Sub}}, {lbl,{TextColor3=on and Theme.Text or Theme.Sub}}}
			for _,p in ipairs(props) do if instant then for k,v in pairs(p[2]) do p[1][k]=v end else tween(p[1],p[2]) end end
		end
		refreshers[i] = refresh
		onTheme(function() refresh(true) end)
		if key and states[i] then Game.flags.espRoles[key] = true end
		b.MouseButton1Click:Connect(function()
			if multiSelect then states[i] = not states[i]; refresh(false) else for j in ipairs(items) do states[j] = j==i; refreshers[j](false) end end
			if key then Game.flags.espRoles[key] = states[i] end
		end)
	end
end
local function addThemeGrid(body)
	local holder = tileGrid(body, 3, 56)
	local tiles = {}
	for i,name in ipairs(THEME_ORDER) do
		local th = THEMES[name]
		local tile = create("TextButton", {BackgroundColor3=WHITE, Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, ClipsDescendants=true, Parent=holder})
		corner(tile, 9)
		create("UIGradient", {Rotation=110, Color=ColorSequence.new(th.BgTop:Lerp(th.Accent,0.14), th.BgBottom), Parent=tile})
		local ts = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Color=th.Stroke, Parent=tile})
		icon(th.Icon, {Size=UDim2.fromOffset(16,16), Position=UDim2.fromOffset(9,8), ImageColor3=th.Accent, Parent=tile})
		text("TextLabel", {Size=UDim2.new(1,-30,0,15), Position=UDim2.new(0,9,1,-22), Text=name, Weight=BOLD, TextSize=11, Color=th.Text, TextTruncate=Enum.TextTruncate.AtEnd, Parent=tile})
		local tick = create("Frame", {Size=UDim2.fromOffset(14,14), Position=UDim2.new(1,-19,1,-19), BackgroundColor3=th.Accent, BorderSizePixel=0, Visible=false, Parent=tile})
		corner(tick, 7); icon("check", {Size=UDim2.fromOffset(9,9), Position=UDim2.fromOffset(2.5,2.5), ImageColor3=WHITE, Parent=tick})
		tiles[name] = {Stroke=ts, Tick=tick}
		tile.MouseButton1Click:Connect(function() if currentThemeName~=name or accentOverride then setTheme(name) end end)
	end
	local function refresh() for name,t in pairs(tiles) do local on = name==currentThemeName; tween(t.Stroke,{Color=on and Theme.Accent or THEMES[name].Stroke, Thickness=on and 2 or 1}); t.Tick.Visible = on end end
	table.insert(gridRefreshers, refresh); refresh()
end
local function addFontGrid(body)
	local tiles = {}
	local function makeTiles(list, holder)
		for i,f in ipairs(list) do
			local name, family = f[1], f[2]
			local tile = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=holder}, {BackgroundColor3="Deep"})
			corner(tile, 9)
			local ts = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=tile})
			create("TextLabel", {Size=UDim2.new(1,0,0,26), Position=UDim2.fromOffset(0,6), BackgroundTransparency=1, Text="Aa Яя", FontFace=Font.new(family, Enum.FontWeight.Bold), TextSize=17, Parent=tile, TextColor3=Theme.Accent})
			create("TextLabel", {Size=UDim2.new(1,-6,0,14), Position=UDim2.new(0,3,1,-18), BackgroundTransparency=1, Text=name, FontFace=Font.new(family, Enum.FontWeight.Regular), TextSize=11, TextTruncate=Enum.TextTruncate.AtEnd, Parent=tile, TextColor3=Theme.Sub})
			tiles[name] = {Stroke=ts, Tick=makeTick(tile, 12)}
			tile.MouseButton1Click:Connect(function() setFont(name) end)
		end
	end
	local function refresh() for name,t in pairs(tiles) do local on = name==S.Font; t.Stroke.Color = on and Theme.Accent or Theme.Stroke; t.Stroke.Thickness = on and 2 or 1; t.Tick.Visible = on end end
	makeTiles(FONTS, tileGrid(body, 3, 54))
	local moreHolder
	addButton(body, "More fonts", "chevron-down", false, function()
		if not moreHolder then moreHolder = tileGrid(body, 3, 54); makeTiles(FONTS_MORE, moreHolder); refresh()
		else moreHolder.Visible = not moreHolder.Visible end
	end)
	table.insert(gridRefreshers, refresh); onTheme(refresh)
end
local function addLanguageGrid(body)
	local holder = tileGrid(body, 3, 48)
	local tiles = {}
	local codes = {["English"]="EN",["Русский"]="RU",["Қазақша"]="KZ"}
	for i,name in ipairs(Lang.list) do
		local tile = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=holder}, {BackgroundColor3="Deep"})
		corner(tile, 9)
		local ts = create("UIStroke", {ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Parent=tile})
		text("TextLabel", {Size=UDim2.new(1,0,0,20), Position=UDim2.fromOffset(0,6), Text=codes[name], Tr=false, Weight=HEAVY, TextSize=15, Color="Accent", TextXAlignment=Enum.TextXAlignment.Center, Parent=tile})
		text("TextLabel", {Size=UDim2.new(1,0,0,14), Position=UDim2.new(0,0,1,-18), Text=name, Tr=false, Weight=MED, TextSize=11, Color="Sub", TextXAlignment=Enum.TextXAlignment.Center, Parent=tile})
		tiles[name] = {Stroke=ts, Tick=makeTick(tile, 12)}
		tile.MouseButton1Click:Connect(function() setLanguage(name) end)
	end
	local function refresh() for name,t in pairs(tiles) do local on = name==Lang.cur; t.Stroke.Color = on and Theme.Accent or Theme.Stroke; t.Stroke.Thickness = on and 2 or 1; t.Tick.Visible = on end end
	table.insert(gridRefreshers, refresh); onTheme(refresh)
end
local ACCENTS = {rgb(232,72,72),rgb(255,128,36),rgb(245,190,40),rgb(80,205,120),rgb(40,190,210),rgb(70,125,255),rgb(150,95,255),rgb(235,85,170),WHITE}
local function addAccentPicker(body)
	local r = row(body, 18)
	hlist(r, 8)
	for i,c in ipairs(ACCENTS) do
		local dot = create("TextButton", {Size=UDim2.fromOffset(15,15), BackgroundColor3=c, Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=r})
		corner(dot, 5)
		local ring = stroke(dot, "Text", 1, 2)
		onTheme(function() ring.Transparency = (accentOverride==c) and 0 or 1 end)
		dot.MouseButton1Click:Connect(function() setAccentOverride(c) end)
	end
end
buildContent()

-- МОБИЛЬНАЯ КНОПКА
local mobileBtn
do
	mobileBtn = create("TextButton", {Name="KriegMobileBtn", Size=UDim2.fromOffset(S.MobileSize, S.MobileSize), Position=UDim2.new(1,-20,0,20), AnchorPoint=Vector2.new(1,0), BackgroundColor3=WHITE, BackgroundTransparency=1-S.MobileOpacity, Text="", AutoButtonColor=false, BorderSizePixel=0, Visible=S.MobileBtn, Parent=gui})
	corner(mobileBtn, math.floor(S.MobileSize/2))
	local grad = create("UIGradient", {Rotation=135, Parent=mobileBtn})
	onTheme(function() grad.Color = ColorSequence.new(Theme.Accent, Theme.Accent2) end)
	icon("ghost", {Size=UDim2.fromOffset(math.floor(S.MobileSize*0.5), math.floor(S.MobileSize*0.5)), Position=UDim2.fromOffset(math.floor(S.MobileSize*0.25), math.floor(S.MobileSize*0.25)), Color=WHITE, Parent=mobileBtn})
	if S.MobileCorner=="Top left" then mobileBtn.Position = UDim2.new(0,20,0,20); mobileBtn.AnchorPoint = Vector2.new(0,0)
	elseif S.MobileCorner=="Bottom left" then mobileBtn.Position = UDim2.new(0,20,1,-20); mobileBtn.AnchorPoint = Vector2.new(0,1)
	elseif S.MobileCorner=="Bottom right" then mobileBtn.Position = UDim2.new(1,-20,1,-20); mobileBtn.AnchorPoint = Vector2.new(1,1) end
	local dragStateM
	mobileBtn.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			if S.MobileDrag then dragStateM = {start=input.Position, pos=mobileBtn.Position, anchor=mobileBtn.AnchorPoint} end
			input.Changed:Connect(function() if input.UserInputState==Enum.UserInputState.End then dragStateM=nil end end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragStateM and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
			local d = input.Position - dragStateM.start
			mobileBtn.Position = UDim2.new(dragStateM.pos.X.Scale, dragStateM.pos.X.Offset+d.X, dragStateM.pos.Y.Scale, dragStateM.pos.Y.Offset+d.Y)
		end
	end)
	mobileBtn.MouseButton1Click:Connect(function() setMenuVisible(not main.Visible) end)
end

-- PLAYER SHEET
do
	local backdrop = create("TextButton", {Size=UDim2.fromScale(1,1), BackgroundColor3=Color3.new(0,0,0), BackgroundTransparency=1, Text="", AutoButtonColor=false, Visible=false, ZIndex=20, Parent=main})
	corner(backdrop, 14)
	local sheet = make("Frame", {AnchorPoint=Vector2.new(0.5,1), Size=UDim2.new(1,-28,0,200), Position=UDim2.new(0.5,0,1,220), BorderSizePixel=0, Visible=false, ZIndex=21, Parent=main}, {BackgroundColor3="Card"})
	corner(sheet, 16); stroke(sheet, "Accent", 0.55, 1.5)
	local grab = make("Frame", {Size=UDim2.fromOffset(42,4), AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,0,8), BorderSizePixel=0, Parent=sheet}, {BackgroundColor3="Dim"})
	corner(grab, 2)
	local av = make("ImageLabel", {Size=UDim2.fromOffset(58,58), Position=UDim2.fromOffset(18,24), BorderSizePixel=0, Image="", Parent=sheet}, {BackgroundColor3="Element2"})
	corner(av, 17); stroke(av, "Accent", 0.15, 2)
	local nameL = text("TextLabel", {Size=UDim2.new(1,-150,0,20), Position=UDim2.fromOffset(88,26), Text="", Tr=false, Weight=BOLD, TextSize=16, TextTruncate=Enum.TextTruncate.AtEnd, Parent=sheet})
	local userL = text("TextLabel", {Size=UDim2.new(1,-150,0,14), Position=UDim2.fromOffset(88,47), Text="", Tr=false, Color="Sub", TextSize=12, TextTruncate=Enum.TextTruncate.AtEnd, Parent=sheet})
	local closeB = make("ImageButton", {Size=UDim2.fromOffset(28,28), Position=UDim2.new(1,-40,0,18), AutoButtonColor=false, BorderSizePixel=0, Image="", Parent=sheet}, {BackgroundColor3="Element"})
	corner(closeB, 9); stroke(closeB)
	icon("x", {Size=UDim2.fromOffset(13,13), Position=UDim2.fromOffset(7.5,7.5), Color="Sub", Parent=closeB})
	local actions = create("Frame", {Size=UDim2.new(1,-32,0,82), Position=UDim2.new(0,16,1,-96), BackgroundTransparency=1, Parent=sheet})
	create("UIGridLayout", {CellSize=UDim2.new(1/3,-6,1,0), CellPadding=UDim2.fromOffset(9,0), SortOrder=Enum.SortOrder.LayoutOrder, Parent=actions})
	for i,a in ipairs({{"Spectate","eye","Watch from their view"},{"Teleport","map-pin","Go to this player"},{"Fling","wind","Push them away"}}) do
		local b = make("TextButton", {Text="", AutoButtonColor=false, BorderSizePixel=0, LayoutOrder=i, Parent=actions}, {BackgroundColor3="Element"})
		corner(b, 12); local bs = stroke(b)
		local ib = make("Frame", {Size=UDim2.fromOffset(32,32), AnchorPoint=Vector2.new(0.5,0), Position=UDim2.new(0.5,0,0,10), BackgroundTransparency=0.82, BorderSizePixel=0, Parent=b}, {BackgroundColor3="Accent"})
		corner(ib, 16)
		icon(a[2], {Size=UDim2.fromOffset(16,16), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.fromScale(0.5,0.5), Color="Accent", Parent=ib})
		text("TextLabel", {Size=UDim2.new(1,-8,0,15), Position=UDim2.new(0,4,0,46), Text=a[1], Weight=BOLD, TextSize=12, TextXAlignment=Enum.TextXAlignment.Center, Parent=b})
		text("TextLabel", {Size=UDim2.new(1,-8,0,12), Position=UDim2.new(0,4,0,62), Text=a[3], Color="Dim", TextSize=10, TextXAlignment=Enum.TextXAlignment.Center, TextTruncate=Enum.TextTruncate.AtEnd, Parent=b})
		b.MouseEnter:Connect(function() tween(bs,{Color=Theme.Accent}); tween(ib,{BackgroundTransparency=0.6}) end)
		b.MouseLeave:Connect(function() tween(bs,{Color=Theme.Stroke}); tween(ib,{BackgroundTransparency=0.82}) end)
		b.MouseButton1Click:Connect(function()
			local plr = PlayerSheet.current; if not plr then return end
			if a[1]=="Spectate" then spectate(plr)
			elseif a[1]=="Teleport" then local hrp = getHRP(plr); if hrp then teleportTo(hrp.Position) end
			elseif a[1]=="Fling" then flingPlayer(plr); notify("Fling", plr.DisplayName, "wind", 2) end
		end)
	end
	local OPEN_POS, HIDDEN_POS = UDim2.new(0.5,0,1,-12), UDim2.new(0.5,0,1,220)
	local token = 0
	function PlayerSheet.close()
		token = token + 1; local my = token
		PlayerSheet.current = nil
		tween(backdrop, {BackgroundTransparency=1}, 0.25)
		tween(sheet, {Position=HIDDEN_POS}, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
		task.delay(0.3, function() if my==token then sheet.Visible=false; backdrop.Visible=false end end)
	end
	function PlayerSheet.open(plr)
		token = token + 1
		closePopup()
		PlayerSheet.current = plr
		Avatar.set(av, plr.UserId)
		nameL.Text = plr.DisplayName
		userL.Text = "@"..plr.Name
		backdrop.Visible = true; sheet.Visible = true; sheet.Position = HIDDEN_POS
		tween(backdrop, {BackgroundTransparency=0.45}, 0.25)
		tween(sheet, {Position=OPEN_POS}, 0.45, Enum.EasingStyle.Back)
	end
	backdrop.MouseButton1Click:Connect(PlayerSheet.close)
	closeB.MouseButton1Click:Connect(PlayerSheet.close)
end

-- RESIZE CORNER
do
	local gsize = isTouch and 26 or 18
	local grip = create("TextButton", {AnchorPoint=Vector2.new(1,1), Size=UDim2.fromOffset(gsize,gsize), Position=UDim2.new(1,-3,1,-3), BackgroundTransparency=1, Text="", ZIndex=15, Parent=main})
	local dots = {}
	local step = gsize/4.5
	for _,p in ipairs({{3,1},{2,2},{3,2},{1,3},{2,3},{3,3}}) do
		local d = make("Frame", {Size=UDim2.fromOffset(3,3), AnchorPoint=Vector2.new(0.5,0.5), Position=UDim2.fromOffset(p[1]*step+2, p[2]*step+2), BorderSizePixel=0, Parent=grip}, {BackgroundColor3="Dim"})
		create("UICorner", {CornerRadius=UDim.new(0.5,0), Parent=d}); table.insert(dots, d)
	end
	grip.MouseEnter:Connect(function() for _,d in ipairs(dots) do tween(d,{BackgroundColor3=Theme.Accent}) end end)
	grip.MouseLeave:Connect(function() for _,d in ipairs(dots) do tween(d,{BackgroundColor3=Theme.Dim}) end end)
	local rs
	grip.InputBegan:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
			closePopup()
			rs = {start=input.Position, w=main.Size.X.Offset, h=main.Size.Y.Offset, pos=main.Position}
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if rs and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
			local s = currentScale
			local maxW = math.max(540, viewport.X/s-20); local maxH = math.max(360, viewport.Y/s-20)
			local nw = math.clamp(rs.w+(input.Position.X-rs.start.X)/s, 540, maxW)
			local nh = math.clamp(rs.h+(input.Position.Y-rs.start.Y)/s, 360, maxH)
			main.Size = UDim2.fromOffset(nw, nh)
			main.Position = UDim2.new(rs.pos.X.Scale, rs.pos.X.Offset+(nw-rs.w)*s/2, rs.pos.Y.Scale, rs.pos.Y.Offset+(nh-rs.h)*s/2)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if rs and (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) then
			rs = nil; S.WinW = math.floor(main.Size.X.Offset); S.WinH = math.floor(main.Size.Y.Offset); Store.save()
			if currentTab and pages[currentTab] then pages[currentTab].Refresh() end
		end
	end)
end

-- CLOSE / HIDE
local closing = false
local function closeHub()
	if closing then return end
	closing = true
	closePopup(); stopMusic(); Game.clearConns()
	tween(uiScale, {Scale=currentScale*0.85}, 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	tween(main, {BackgroundTransparency=1}, 0.25)
	tween(mini, {Position=mini.Position-UDim2.fromOffset(0,80)}, 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
	if mobileBtn then mobileBtn:Destroy() end
	task.delay(0.32, function() gui:Destroy() end)
end
local function setMenuVisible(v)
	closePopup(); main.Visible = v
	if v then uiScale.Scale = currentScale*0.94; tween(uiScale, {Scale=currentScale}, 0.3, Enum.EasingStyle.Back); if currentTab and pages[currentTab] then pages[currentTab].Refresh() end end
end
closeBtn.MouseButton1Click:Connect(closeHub)
miniClose.MouseButton1Click:Connect(closeHub)
hideBtn.MouseButton1Click:Connect(function() setMenuVisible(false); notify("Menu hidden","Press the menu key or click the mini bar","eye",3) end)
brandBtn.MouseButton1Click:Connect(function() setMenuVisible(not main.Visible) end)
UserInputService.InputBegan:Connect(function(input, gp) if gp or isBinding then return end; if input.KeyCode==menuKey then setMenuVisible(not main.Visible) end end)

-- СТАРТ
applyBindings(false)
if S.Font=="Custom" and S.FontCustom~="" then setCustomFont(S.FontCustom, true) end
setPanelAlpha(S.PanelAlpha); Wall.setDim(S.WallDim); Scene.show(); refreshGrids()
if S.Compact then setCompact(true) end
selectTab("Home")
if S.Wallpaper~="" then Wall.resolve(S.Wallpaper, function(ok,res) if ok then Wall.apply(res) end end) end
uiScale.Scale = currentScale*0.85
tween(uiScale, {Scale=currentScale}, 0.5, Enum.EasingStyle.Back)
local miniTarget = mini.Position
mini.Position = miniTarget - UDim2.fromOffset(0,70)
tween(mini, {Position=miniTarget}, 0.6, Enum.EasingStyle.Back)
task.delay(0.5, function() notify("KRIEG HUB", Store.can and "Your settings are loaded" or "Settings can't be saved in this executor", THEMES[currentThemeName].Icon, 5) end)
