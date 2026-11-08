-- Lueur：简体中文文本
-- Lueur 显示的中文。简体中文（zhCN）客户端会自动用它；其他语言没有的条目回退显示英文。
--
-- 简体中文汉化：骑人知福-正直
--
-- 版权与来源（详见插件根目录 NOTICE.md 与 LICENSE）：
--   原始插件 Lueur 的作者是 Armytille（https://www.curseforge.com/wow/addons/lueur）。
--   截至官方 1.4.0，上游未声明任何许可证（CurseForge 的 license 字段为空、官方包内
--   无 LICENSE 也无 README）；因此本文件不替他认定许可，原插件权利仍归作者。
--   本简体中文文件不是从零原创翻译：它基于 NGA 论坛流传的 Lueur 0.7.0 简体中文版
--   （Lueur-0.7.0-zhCN.zip）整理而来，再对照官方 1.4.0 的 Locales/enUS.lua 增补与改写。
--   逐键实测：本文件可逐键比对的字符串 290 条中，与 NGA 版同名的键 165 个，
--   其中 97 个取值逐字相同，68 个经过改写，另有 125 条为 NGA 版所无、本次新增。
--   因此中文译文的署名权首先归于 NGA 原译者，本版只对新增与改写部分负责。
--   NGA 原译者昵称无法考证：原包无署名文件，zip 注释为空、toc 无 Author 字段、
--   全部 lua 内无「作者/译者/汉化/翻译」字样。故记为
--   「NGA 论坛 Lueur 汉化作者（昵称无法考证）」，不要标注为本站原创。
--
-- 格式占位符（%s、%d、%d%% 等）与原文一一对应，请勿改动其数量与顺序，否则游戏内显示会出错。

local _, ns = ...

local L = {}
ns.LOCALES.zhCN = L

---------------------------------------------------------------------------
-- 通用
---------------------------------------------------------------------------

L.LANGUAGE_NAME = "简体中文"   -- 本语言的自称：菜单以此名称列出它
L.PREFIX = "|cffffd200Lueur|r："
L.YES = "是"
L.NO = "否"
L.SETTING = "%s：%s"          -- 一项设置及其取值
L.FORMAT_PERCENT = "%d%%"
L.FORMAT_RANGE = "%d 码"
L.CONFIRM = "确认？"          -- 等待再次点击的按钮上

-- 中文命令词 -> 命令的英文名称。英文名称各处通用。
L.COMMANDS = {
	["小地图"] = "minimap", ["开"] = "on", ["关"] = "off",
	["预览"] = "preview", ["效果"] = "effect", ["颜色"] = "color", ["共享"] = "shared",
	["大小"] = "size", ["强度"] = "intensity", ["偏移"] = "offset", ["文字"] = "text",
	["字体"] = "font", ["淡出"] = "fade", ["名称"] = "name", ["图标"] = "icon",
	["战斗"] = "combat", ["地下城"] = "instance", ["不可用"] = "unavailable", ["专业"] = "profession",
	["忽略"] = "ignore", ["专属"] = "exclusive", ["轮廓"] = "silhouette",
	["范围"] = "range", ["方向"] = "arc", ["按键"] = "key",
	["资源"] = "nodes", ["交替"] = "switch", ["扫描"] = "scan",
	["语言"] = "language", ["调试"] = "debug", ["目标"] = "objectives",
	["状态"] = "status", ["帮助"] = "help",
	["矿石"] = "ore", ["草药"] = "herb", ["任务"] = "quest",
	["宝箱"] = "chest", ["鱼漂"] = "bobber", ["其他"] = "other",
	["默认"] = "default", ["无"] = "none", ["列表"] = "list", ["清空"] = "clear",
	["显示"] = "show", ["自动"] = "auto",
}

---------------------------------------------------------------------------
-- 类别、状态、效果
---------------------------------------------------------------------------

L.CATEGORY_ORE = "矿石"
L.CATEGORY_ORE_TIP = "矿脉与矿点。"
L.CATEGORY_HERB = "草药"
L.CATEGORY_HERB_TIP = "可采集的植物。"
L.CATEGORY_QUEST = "任务"
L.CATEGORY_QUEST_TIP = "与你当前某个任务相关的物体。"
L.CATEGORY_CHEST = "宝箱"
L.CATEGORY_CHEST_TIP = "宝箱、木箱以及其他可以拾取的容器。"
L.CATEGORY_BOBBER = "鱼漂"
L.CATEGORY_BOBBER_TIP = "你钓鱼线上的浮标。"
L.CATEGORY_OTHER = "其他物体"
L.CATEGORY_OTHER_TIP = "日常物体：门、邮箱、拉杆……"

-- 诊断语句中物体的类别
L.NAME_ORE = "矿石"
L.NAME_HERB = "草药"
L.NAME_QUEST = "任务"
L.NAME_CHEST = "宝箱"
L.NAME_BOBBER = "鱼漂"
L.NAME_OTHER = "其他"
L.NAME_NONE = "无"

-- 预览窗口为每个类别展示的物体
L.SAMPLE_ORE = "铜矿脉"
L.SAMPLE_HERB = "宁神花"
L.SAMPLE_QUEST = "补给箱"
L.SAMPLE_CHEST = "破损的箱子"
L.SAMPLE_BOBBER = "鱼漂"
L.SAMPLE_OTHER = "邮箱"

L.STATE_FAR = "超出范围"
L.STATE_READY = "在范围内"
L.STATE_LOCKED = "不可用"

L.EFFECT_AURA = "光环"
L.EFFECT_AURA_TIP = "一圈光晕，带细环、彗星与萤火。"
L.EFFECT_RETICLE = "准星"
L.EFFECT_RETICLE_TIP = "清晰的圆环与彗星，覆在较淡的光晕之上。"
L.EFFECT_SUBTLE = "柔和"
L.EFFECT_SUBTLE_TIP = "柔和的光晕，没有圆环与彗星。"
L.EFFECT_SIGIL = "符印"
L.EFFECT_SIGIL_TIP = "一圈符文绕物体缓缓转动。"
L.EFFECT_BRACKETS = "四角框"
L.EFFECT_BRACKETS_TIP = "四只角框住物体，进入范围后锁定。"
L.EFFECT_BEAM = "光柱"
L.EFFECT_BEAM_TIP = "一道光柱自物体升起，火花沿柱上飘。"
L.EFFECT_BEACON = "信标"
L.EFFECT_BEACON_TIP = "一枚水晶悬在物体上方，由一缕光与它相连。"
L.EFFECT_ORBIT = "环绕"
L.EFFECT_ORBIT_TIP = "幽光绕着物体盘旋，拖出光尾。"
L.EFFECT_RIPPLE = "涟漪"
L.EFFECT_RIPPLE_TIP = "涟漪在物体周围的地面扩散。"
L.EFFECT_SPARKLE = "闪光"
L.EFFECT_SPARKLE_TIP = "微光在物体四周闪烁，完全没有圆环。"

---------------------------------------------------------------------------
-- 菜单
---------------------------------------------------------------------------

L.HEADER_SILHOUETTE = "轮廓"
L.HEADER_OBJECTS = "高亮的物体"
L.HEADER_HIDE = "隐藏效果"
L.HEADER_DETECTION = "检测"
L.HEADER_GENERAL = "通用"
L.SETTINGS = "设置"

L.SCOPE_ALL = "全部"
L.SCOPE_ALL_TIP = "你设置的值会应用到所有类别。原本为该类别单独设过这一项的，会丢掉那个值。"
L.SCOPE_ONE_TIP = "你设置的值只应用到该类别，其他类别怎么改都不影响它。"
L.EFFECT = "效果"
L.EFFECT_TIP = "光的形状。"
L.LOOK_OF_ALL = "所有物体的外观"
L.LOOK_OF = "外观：%s"
L.OF_CATEGORY = "%s（%s）"     -- 一项设置，以及它刚刚变更所针对的类别
L.SHARED = "与所有物体相同"
L.SHARED_TIP = "去掉该类别自己的效果与外观，让它回到「所有物体」的那一套。"

L.SIZE = "大小"
L.SIZE_TIP = "效果有多大。"
L.INTENSITY = "强度"
L.INTENSITY_TIP = "效果有多亮。"
L.OFFSET = "垂直偏移"
L.OFFSET_TIP = "把效果相对物体姓名板上下移动。预览窗口会显示它落在哪里。"
L.FADE = "随姓名板淡出"
L.FADE_TIP = "效果随物体的姓名板一同淡出，例如被场景遮住时。"

L.SILHOUETTE = "从我的角色身后穿过"
L.SILHOUETTE_TIP = "效果沿你的角色轮廓被裁掉，看起来是从你身后穿过，而不是盖在你身上。"
L.ZONE_SIZE = "裁切范围大小"
L.ZONE_SIZE_TIP = "效果咬进你的角色就调大，效果离角色太远就调小。每个角色各自保存自己的值。"
L.ZONE_HEIGHT = "裁切范围高度"
L.ZONE_HEIGHT_TIP = "把裁切范围上下移动。每个角色各自保存自己的值。"
L.ZONE_SHOW = "显示裁切范围"
L.ZONE_SHOW_TIP = "用红色描出裁切范围：它应当贴合你的角色。关闭本窗口后消失。"

L.SHOW_NAME = "显示名称"
L.SHOW_NAME_TIP = "在物体上方写出它的名称，替换游戏自己写的那一个。"
L.SHOW_ICON = "显示图标"
L.SHOW_ICON_TIP = "在物体上方显示它的交互图标，替换游戏自己画的那一个。"
L.TEXT_SIZE = "文字大小"
L.TEXT_SIZE_TIP = "物体上方名称的大小，以游戏自身文字为 100%。"
L.FONT = "字体"
L.FONT_TIP = "物体上方名称所用的字体。"
L.FONT_GAME = "游戏字体"
L.COLOR = "颜色"
L.COLOR_TIP = "这些物体上效果的颜色。"
L.TIP_COLOR_SET = "左键：选择颜色"
L.TIP_COLOR_RESET = "右键：恢复原色"
L.IGNORED = "已忽略的物体：%d"
L.IGNORED_TIP = "无论属于哪个类别都不会有效果的物体。/lueur ignore list 列出它们，/lueur ignore clear 全部遗忘。"
L.IGNORE_TARGET = "忽略目标"
L.IGNORE_TARGET_TIP = "忽略你此刻正对着的物体，或者取消对它的忽略。"

L.HIDE_COMBAT = "战斗中"
L.HIDE_COMBAT_TIP = "你处于战斗状态时不显示效果。"
L.HIDE_INSTANCE = "副本中"
L.HIDE_INSTANCE_TIP = "在地下城、团队副本和战场中不显示效果。"
L.HIDE_LOCKED = "我不能使用的物体上"
L.HIDE_LOCKED_TIP = "游戏暂时拒绝的物体上，效果熄灭：技能不够、物体上锁……游戏只在你进入范围内时才会说明原因。"
L.HIDE_UNTRAINED = "没有专业时的草药与矿石"
L.HIDE_UNTRAINED_TIP = "角色没学草药学时不显示草药效果，没学采矿时不显示矿石效果。"

L.RANGE = "范围"
L.RANGE_TIP = "游戏可以选取物体并高亮它的最远距离。"
L.DIRECTION = "方向"
L.DIRECTION_TIP = "游戏朝哪个方向寻找要选取的物体。"
L.ARC_0 = "正前方"
L.ARC_0_TIP = "只有正对着你的物体。"
L.ARC_1 = "前方"
L.ARC_1_TIP = "你前方的任何物体。"
L.ARC_2 = "全方位"
L.ARC_2_TIP = "各个方向，包括你的背后。"
L.EXCLUSIVE = "只显示被高亮的目标"
L.EXCLUSIVE_TIP = "游戏不再标出得不到效果的那些交互目标：NPC、邮箱……不勾选时，它会为每一个都显示名称和图标。"

L.KEY = "交互按键"
L.KEY_TIP = "高亮物体进入范围后，用来拾取、采集或使用它的按键。这是游戏自身的交互键：对 NPC 同样有效，也可以在游戏的按键设置里改。"
L.KEY_NONE = "未绑定"
L.KEY_LISTEN = "请按一个键"
L.KEY_LISTEN_TIP = "按下要用的键、鼠标按钮或滚轮方向。Esc 取消。"
L.KEY_TAKEN = "%s 已经用于「%s」。再按一次就把它改成交互键，或者按别的键。"
L.TIP_KEY_SET = "左键：选择按键"
L.TIP_KEY_CLEAR = "右键：移除按键"

L.LANGUAGE = "语言"
L.LANGUAGE_TIP = "Lueur 的文字与命令使用的语言。"
L.LANGUAGE_AUTO = "自动"
L.LANGUAGE_AUTO_TIP = "跟随游戏的语言。"

L.ENABLE = "启用 Lueur"
L.ENABLE_TIP = "禁用时，Lueur 把你原本的选取设置交还给游戏。"
L.MINIMAP = "小地图按钮"
L.MINIMAP_TIP = "在小地图边缘显示 Lueur 的按钮。"
L.DEBUG = "聊天栏诊断"
L.DEBUG_TIP = "在聊天窗口里描述每一个被选中的物体，以及 Lueur 对它的判断。"

-- 小地图页面
L.NODES_PAGE = "小地图上的草药与矿石"
L.HEADER_NODES = "小地图图标"
L.HEADER_SWITCH = "两种采集专业"
L.NODE_HERBS = "草药图标"
L.NODE_HERBS_TIP = "你的追踪放到小地图上的每一株草药，都显示成该草药自己的图标，而不是一个普通圆点。"
L.NODE_ORE = "矿石图标"
L.NODE_ORE_TIP = "你的追踪放到小地图上的每一个矿脉，都显示成它那种矿石的图标，而不是一个普通圆点。"
L.NODE_SIZE = "图标大小"
L.NODE_SIZE_TIP = "小地图上这些图标有多大。"
L.NODE_SWITCH = "两种追踪交替开启"
L.NODE_SWITCH_TIP = "游戏只显示寻找草药或寻找矿石其中一种的圆点，从不两种同时显示。每当你走够一段距离，Lueur 就会把另一种打开，并在小地图上保留两者的图标。每个角色各自保存自己的设置。"
L.NODE_SWITCH_YARDS = "两次切换之间的距离"
L.NODE_SWITCH_YARDS_TIP = "你走多远之后，Lueur 才会把另一种追踪打开。"

L.PREVIEW = "预览"
L.PREVIEW_STOP = "关闭预览"
L.PREVIEW_TIP = "打开一个窗口，在一个 3D 物体上展示效果的各种状态。在这里更改的设置会立刻作用到它身上。"
L.PREVIEW_NO_MODEL = "此客户端没有可用的 3D 模型"
L.PREVIEW_HINT = "拖动：旋转  ·  右键拖动：平移  ·  滚轮：缩放"
L.DEFAULTS = "默认值"
L.DEFAULTS_TIP = "把效果与检测的设置恢复为初始值。第二次点击确认。"
L.FOOTER = "Lueur %s  ·  /lueur help：全部命令"

L.OPTIONS_NOTE = "在你靠近时让矿脉、草药、任务物体与宝箱发出光亮。"
L.OPTIONS_OPEN = "打开 Lueur 的设置"

L.TIP_ENABLED = "已启用"
L.TIP_DISABLED = "已禁用"
L.TIP_LEFT_CLICK = "左键：打开设置"
L.TIP_RIGHT_CLICK = "右键：启用或禁用"
L.TIP_DRAG = "拖动：移动此按钮"

---------------------------------------------------------------------------
-- 命令消息
---------------------------------------------------------------------------

L.MSG_ENABLED = "已启用。"
L.MSG_DISABLED = "已禁用，你原本的设置已经恢复。"
L.MSG_RESTART = "请完全重启游戏，以完成 Lueur 的更新。"
L.MSG_EXCLUSIVE_ON = "游戏不再标出得不到效果的目标。"
L.MSG_EXCLUSIVE_OFF = "游戏会为每一个交互目标显示名称与图标（NPC、世界物体……）。"
L.MSG_SILHOUETTE_ON = "效果从你的角色身后穿过。"
L.MSG_SILHOUETTE_OFF = "效果盖在你的角色身上。"
L.MSG_CUTOUT_UNAVAILABLE = "裁切不可用：%s。"
L.MSG_ZONE_SHOWN = "裁切范围已用红色描出：它应当贴合你的角色。"
L.MSG_ZONE_HIDDEN = "裁切范围描边已隐藏。"
L.MSG_SILHOUETTE_VALUES = "轮廓：大小 %d%%，高度 %d%%"
L.MSG_SILHOUETTE_USAGE = "用法：/lueur silhouette | show | <大小 {bodyScale}> [高度 {bodyShift}]"
L.MSG_EFFECTS = "可用的效果：%s（当前：%s）"
L.MSG_FONTS = "可用的字体：%s（当前：%s）"
L.MSG_COLOR = "%s：颜色 %s"
L.MSG_NO_PICKER = "此客户端没有取色器：请键入 /lueur color <类别> <rrggbb>。"
L.MSG_SHARED = "%s：已回到「所有物体」的效果与外观。"
L.MSG_HIDE_COMBAT = "战斗中隐藏效果：%s"
L.MSG_HIDE_INSTANCE = "副本中隐藏效果：%s"
L.MSG_HIDE_LOCKED = "在你不能使用的物体上隐藏效果：%s"
L.MSG_HIDE_UNTRAINED = "在没有专业时的草药与矿石上隐藏效果：%s"
L.MSG_IGNORED = "%s 将不再有效果。"
L.MSG_UNIGNORED = "%s 不再被忽略。"
L.MSG_IGNORE_NO_TARGET = "你面前没有可以忽略的物体。"
L.MSG_IGNORE_LIST = "已忽略的物体：%s"
L.MSG_IGNORE_EMPTY = "没有忽略任何物体。"
L.MSG_RANGE = "范围：%d 码"
L.MSG_RANGE_COMBAT = "范围：%d 码，离开战斗后生效。"
L.MSG_RANGE_CLIENT = "范围：请求 %d 码，客户端保留了 %s。"
L.MSG_KEY_COMBAT = "战斗中无法更改按键绑定。"
L.MSG_KEY_REFUSED = "游戏拒绝了按键「%s」。"
L.MSG_KEY_REPLACED = "%s 不再触发「%s」。"
L.MSG_NODES_UNAVAILABLE = "小地图图标不可用：%s。"

L.FAIL_NO_MASK = "此客户端不支持遮罩"
L.FAIL_MASK_TEXTURE = "找不到遮罩纹理（请完全重启游戏）"
L.FAIL_MASK_REFUSED = "客户端拒绝了遮罩"
L.FAIL_NO_SCAN = "此客户端不允许插件读取小地图上的圆点"
L.FAIL_SCAN_ERROR = "游戏拒绝了小地图扫描（/lueur scan 会说明原因）"

L.STATUS_CLIENT = "客户端 %s（%s），语言 %s；Lueur 的文字：%s。当前生效的数值："
L.STATUS_CVAR_UNKNOWN = "此客户端不认识"
L.STATUS_CVAR_DEFAULT = "（默认 %s）"
L.STATUS_EXPECTED = "Lueur 期望：范围 %d，方向 %d"
L.STATUS_GATE = "只标出被高亮的目标：%s | 此刻的原生显示：%s"
L.GATE_OPEN = "开启"
L.GATE_CLOSED = "关闭"
L.STATUS_SILHOUETTE = "效果在角色身后：%s"
L.STATUS_UNAVAILABLE = "不可用，%s"
L.STATUS_DIRECT = "直接从「softinteract」读到目标：%s"
L.STATUS_NOT_YET = "尚未观察到"
L.STATUS_RANGE_API = "交互范围可读取：%s"
L.STATUS_LINE = "钓线已抛出：%s | 引导中的施法：%s"
L.STATUS_NODES = "小地图图标：%s"
L.STATUS_NODES_SHOWN = "草药 %s，矿石 %s，追踪交替 %s"
L.STATUS_HIDE = "战斗中隐藏：%s | 副本中：%s | 不可用物体上：%s | 此刻暂停：%s"
L.STATUS_TRAINED = "没有专业时不作用于草药与矿石：%s | 草药学：%s，采矿：%s"
L.STATUS_OBJECTS = "此角色显示的类别：%s | 已忽略的物体：%d"
L.STATUS_OWN = "有独立设置的类别：%s"
L.STATUS_EFFECT = "效果：%s | 纹理：%s"
L.STATUS_KEY = "交互按键：%s"
L.TEXTURES_PENDING = "尚未加载"
L.TEXTURES_MISSING = "缺失，已显示替代效果（请完全重启游戏）"
L.TEXTURES_LOADED = "已加载"

L.OBJECTIVES_HEADER = "%d 个进行中的任务目标："
L.OBJECTIVES_NOT_ITEM = "  （不是物体：只与完整名称比较）"
L.OBJECTIVES_LEARNED = "从提示信息学到：%s（%s）"

-- /lueur scan
L.SCAN_HEADER = "小地图扫描：%s"
L.SCAN_READY = "可用"
L.SCAN_TRACKING = "采集追踪：%s"
L.SCAN_SKILL = "读到的技能：草药学 %s，采矿 %s"
L.SCAN_VIEW = "小地图半径：%s 码 | 随你旋转：%s | 地图上的位置已知：%s | 圆点在 %s 单位内响应"
L.SCAN_TWICE = "两个圆点重叠处名称写了两遍：%s"
L.SCAN_PLACED = "图标：%d 个精确放置，%d 个在簇中，%d 个粗略，%d 个沿用已关闭的追踪，%d 个未再找到 | 上次扫描：%d 个点，耗时 %.2f 秒，细看了 %d 个簇"
L.SCAN_NODE = "%s：%s，在 %s 单位内响应，位于距小地图中心 (%+.0f, %+.0f) 处"
L.SCAN_HOW_EXACT = "精确放置"
L.SCAN_HOW_CLUSTER = "在簇中"
L.SCAN_HOW_ROUGH = "粗略"
L.SCAN_HOW_HELD = "沿用已关闭的追踪"
L.SCAN_HOW_MISSED = "未再找到"
L.SCAN_FOUND = "上次扫描读到 %d 个名称，%d 个图标："
L.SCAN_NOT_NODE = "既不是 Lueur 认识的草药，也不是矿脉"
L.SCAN_NEEDS = "，需要 %d"
L.SCAN_CAVE = "，位于洞穴内"
L.SCAN_VIGNETTES = "游戏列出的场景标记：%s"
L.SCAN_DATA = "指针下圆点的数据（其文本之外的）：%s"
L.SCAN_POINTER = "指针下：%s"
L.SCAN_ZONE = "游戏在指针周围命名 %s 的区域，试了 %s：%d 个点，%d × %d 个单位，中心在距指针 (%+.1f, %+.1f) 处，有 %d 个点上的名称写了两遍"
L.SCAN_ZONE_COLUMNS = "逐列"
L.SCAN_ZONE_ROWS = "逐行"
L.SCAN_ZONE_LINES = "它自上而下的各行（高度：左..右）：%s"
L.SCAN_NOTHING = "什么都没有（把指针放到小地图的一个圆点上，再输入一次命令）"

---------------------------------------------------------------------------
-- 诊断（/lueur debug）
---------------------------------------------------------------------------

L.DEBUG_NO_TARGET = "已经没有交互目标"
L.DEBUG_PAUSED = "已暂停（战斗或副本中）"
L.DEBUG_LINE_OUT = "钓线抛出：请求 %d 码，客户端保留了 %s"
L.DEBUG_LINE_IN = "钓线收回：请求 %d 码，客户端保留了 %s"
L.DEBUG_IGNORED = "%s 已忽略（不是世界物体）"
L.DEBUG_SKIPPED = "%s 已忽略（在你忽略列表里）"
L.DEBUG_HIDDEN = "%s → %s，无效果（类别被隐藏或未知）"
L.DEBUG_UNTRAINED = "%s → %s，无效果（此角色没有对应的专业）"
L.DEBUG_NO_PLATE = "%s → %s，已检测到但没有姓名板：无法显示效果"
L.DEBUG_SHOWN = "%s → %s，%s"
L.DEBUG_CURSOR = "光标：%s"
L.DEBUG_VIA = "目标：%s"
L.VIA_DIRECT = "直接"
L.VIA_SWEEP = "扫描"
L.DEBUG_RANGE = "在交互范围内：%s"
L.DEBUG_OBJECT = "物体编号：%s"
L.DEBUG_FISHING = "钓鱼：%s"
L.DEBUG_QUEST = "与任务相关：%s"
L.DEBUG_MATCH = "与目标建立关联的方式：%s（%d 个进行中的目标）"
L.MATCH_NONE = "无"
L.MATCH_CURSOR = "无，它的光标已经说明了它是什么"
L.MATCH_TOOLTIP = "它的提示信息"
L.MATCH_NAME = "它的名称"
L.MATCH_WORD = "「%s」这个词"
L.MATCH_LOOT = "它此前被拾取过的战利品"
L.DEBUG_CHEST = "被认作容器的方式：%s"
L.DEBUG_SECRET = "隐藏身份：%s"
L.DEBUG_BEHIND = "在镜头后方：%s"

---------------------------------------------------------------------------
-- 帮助（/lueur help）。{设置} 为其取值范围；{设置=} 为其默认值
---------------------------------------------------------------------------

L.HELP_HEADER = "命令（每个命令都能用中文，如 /lueur 开、/lueur 范围 15）："
L.HELP = {
	"/lueur — 打开或关闭设置窗口（等同于点击小地图按钮）",
	"/lueur minimap — 显示或隐藏小地图按钮",
	"/lueur on | off — 启用或禁用 Lueur（off 会恢复你原本的设置）",
	"/lueur preview — 打开或关闭预览窗口，在一个 3D 物体上展示效果",
	"/lueur effect [类别] <名称> — 把该效果给所有类别，或只给其中一个（ore 矿石、herb 草药、quest 任务、chest 宝箱、bobber 鱼漂、other 其他）；不带名称则列出全部",
	"/lueur color <类别> <rrggbb> | default — 某类别效果的颜色；不带颜色则显示当前颜色",
	"/lueur shared <类别> — 让某类别回到「所有物体」的效果与外观",
	"/lueur size [类别] <{size}> — 效果大小（默认 {size=}）",
	"/lueur intensity [类别] <{intensity}> — 效果亮度，单位 %（默认 {intensity=}）",
	"/lueur offset [类别] <{offsetY}> — 效果的垂直偏移（默认 {offsetY=}）",
	"/lueur fade [类别] — 效果是否随姓名板淡出（物体被场景遮住时）",
	"/lueur name | icon [类别] — 是否在物体上方显示其名称或图标；text [类别] <{textSize}> 设置名称大小，单位 %（默认 {textSize=}）",
	"/lueur font [类别] <名称> | default — 物体名称的字体；不带名称则列出可用字体",
	"/lueur silhouette [类别] — 效果是从你的角色身后穿过，还是盖在角色身上",
	"/lueur silhouette show | <大小 %> [高度 %] — 显示并调整裁切范围",
	"/lueur range <{range}> — 游戏选取物体的最远距离，单位码。上限就是 15 码：再远客户端就不再选中物体，光晕不会亮（默认 {range=}）",
	"/lueur arc <{arc}> — 0 正前方，1 前方，2 全方位（默认 {arc=}）",
	"/lueur exclusive — 游戏是否只标出得到效果的目标",
	"/lueur combat | instance | unavailable | profession — 是否在战斗中、副本中、你不能使用的物体上、没有专业的草药与矿石上隐藏效果",
	"/lueur key <按键> | none — 绑定拾取高亮物体的按键（F、SHIFT-E、BUTTON4……）；不带按键则显示当前按键",
	"/lueur ore | herb | quest | chest | bobber | other — 为此角色显示或隐藏某个类别",
	"/lueur nodes [ore | herb] — 显示或隐藏小地图上的草药与矿脉图标；nodes size <{nodeSize}> 设置它们的大小（默认 {nodeSize=}）",
	"/lueur switch [<{nodeSwitchYards}>] — 两种采集专业都在时：随移动交替开启寻找草药与寻找矿石；给个数字则设置切换的距离，单位码（默认 {nodeSwitchYards=}）",
	"/lueur scan — 显示上次小地图扫描读到了什么，以及 Lueur 由此得出了什么",
	"/lueur ignore — 忽略你正对着的物体，或取消对它的忽略；另有 ignore list、ignore clear、ignore <名称>",
	"/lueur language <auto | de | en | es | fr | ru | zh> — Lueur 的文字与命令所用的语言",
	"/lueur debug — 描述每个被选中的物体，以及 Lueur 对它的判断",
	"/lueur objectives — 列出用来与物体名称比较的任务目标",
	"/lueur status — 显示客户端实际应用的数值",
	"/lueur help — 显示这份列表",
}
