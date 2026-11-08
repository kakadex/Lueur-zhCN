# How to apply this to your Lueur 1.4.0

One file is new (`Locales/zhCN.lua`), seven are edited (5 locale files, `Lueur.toc`,
`Nodes.lua`) — 22 changed lines in total. Nothing else changes.

## 0. Apply the diff

```
git -c core.autocrlf=false apply patch/Lueur-1.4.1-zhCN.patch
```

Then copy `patch/Locales/zhCN.lua` into `Locales/`.

**Use `-c core.autocrlf=false`.** The Lua sources are pure LF and this patch is
generated as LF. With `core.autocrlf=true` (the Windows default) git rewrites the
whole file to CRLF as it applies the patch, and every line shows as modified. The
content is fine, but the diff becomes noise and `git diff --stat` shows several hundred
changed lines instead of the 22 real ones. Verified both ways: with
`core.autocrlf=false` the result is byte-identical to the build this patch came from.

If you prefer to apply by hand, the edits are below.

## 1. New file: `Locales/zhCN.lua`

Copy `patch/Locales/zhCN.lua` into your `Locales/` folder as-is.
It defines `ns.LOCALES.zhCN` with 292 keys, one per key in `enUS.lua`, plus a
`L.COMMANDS` table that maps Chinese words onto your command names.

## 2. `Lueur.toc`

Add these two lines next to the other `## Notes-*` lines:

```
## Notes-zhCN: 在你靠近时让矿脉、草药、任务物体、宝箱和鱼漂发出光芒，可选多种光效，并把草药与矿脉以小地图专属图标显示（使用暴雪的软瞄准）。敲 /lueur 打开设置，敲 /lueur help 看全部命令。命令都能用中文，例如 /lueur 开、/lueur 关、/lueur 范围 15、/lueur 预览。检测距离最远 15 码，这是游戏客户端的上限，超过 15 码游戏就不再选中物体，光晕也不会出现。
## Title-zhCN: Lueur
```

And add `Locales\zhCN.lua` to the file list, right after `Locales\ruRU.lua`.

## 3. The five other locale files

Each gets **one character sequence** appended to the `language` help line:
`ru` becomes `ru | zh`. The `language` command validates against
`ns.LOCALES`, so without this, Chinese exists but cannot be selected.

```diff
- "/lueur language <auto | de | en | es | fr | ru> — language of Lueur's texts and commands",
+ "/lueur language <auto | de | en | es | fr | ru | zh> — language of Lueur's texts and commands",
```

Same one-word change in `deDE`, `esES`, `frFR`, `ruRU`.

## 4. `Nodes.lua`

Append a `zhCN` block to `VEIN_NAMES`, after the `ruRU` block:

```lua
	-- 简体中文矿脉名（依《魔兽世界》怀旧服简体中文名）
	zhCN = {
		copper = "铜矿脉", tin = "锡矿脉", incendicite = "焚化矿脉", silver = "银矿脉",
		bloodstone = "次级血石矿藏", iron = "铁矿脉", indurium = "因迪里姆矿脉",
		gold = "金矿脉", mithril = "秘银矿藏", truesilver = "真银矿藏",
		darkiron = "黑铁矿藏", thorium = "瑟银矿脉", richthorium = "富瑟银矿脉",
	},
```

**These 13 names are the weakest part of this patch.** They were written from
Classic-era Simplified Chinese terminology and never checked against a live
`zhCN` client, one vein at a time. Comparing against GatherMate2's `zhCN` tables
afterwards turned up several disagreements (it has `铜矿` where I wrote `铜矿脉`,
and `精铁矿脉` where I wrote `因迪里姆矿脉`). A wrong name costs only a missed
minimap icon — that node falls back to the generic profession icon — but the
table wants a native speaker's pass before it ships upstream.

## 5. Optional: `LICENSE` / `NOTICE.md`

These are mine, not yours. Take them, rewrite them, or drop them — see
`给原作者的说明.md` on why there is no MIT claim here.
