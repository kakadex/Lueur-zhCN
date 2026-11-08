# Lueur — Simplified Chinese localization

Simplified Chinese (`zhCN`) localization for **Lueur**, a World of Warcraft addon by
[Armytille](https://www.curseforge.com/wow/addons/lueur) (CurseForge project 1732324).

This repository holds **only the localization work**, prepared so the addon's author
can review it and take it upstream if he wants to. It is not a fork and it ships no
copy of the addon.

---

## 中文摘要（给中文读者）

这是魔兽世界插件 **Lueur** 的简体中文补丁，**作者未声明许可证**，所以这个仓库只放我方新增的内容和最小改动差异，**不复制作者的原始代码与美术资源**。

- 插件作者是 **Armytille**，本仓库与他无隶属关系；
- 本版简体中文汉化由 **骑人知福-正直** 整理（GitHub 账号 `kakadex`）；
- `Lueur.lua` **一个字没改**，与官方 1.4.0 逐字节相同；
- 中文文本派生自 NGA 论坛流传的 Lueur 0.7.0 汉化版（原译者未署名），**不是原创翻译**；
- 这个仓库的目的是把改动整理好交给作者，**公开发布或再分发前应先取得作者许可**。

详细说明见 [`docs/改动说明.md`](docs/改动说明.md)，给作者的正式说明见 [`给原作者的说明.md`](给原作者的说明.md)。

---

## What is in here

| Path | What it is |
|---|---|
| `patch/Locales/zhCN.lua` | The new locale file. 292 keys, one per key in `enUS.lua`. |
| `patch/Lueur-1.4.1-zhCN.patch` | Minimal unified diff against upstream 1.4.0 — 22 changed lines total (16 added, 6 removed) across 7 files. |
| `patch/APPLY.md` | How to apply it by hand, step by step. |
| `给原作者的说明.md` | The note to the author, in English. |
| `NOTICE.md` | Provenance, translation derivation, and license status. |
| `docs/改动说明.md` | What changed and how it was verified (Chinese). |
| `tools/` | The three static checkers used to validate the locale file and the local-variable budget. |

## What the patch actually changes

The patch touches **7 existing files** in **22 changed lines** (16 added, 6 removed), and adds
one new file (`Locales/zhCN.lua`). No logic is touched:

| File | Change |
|---|---|
| `Locales/zhCN.lua` | **New file.** Full Simplified Chinese text plus a `L.COMMANDS` table mapping Chinese words onto command names. |
| `Locales/{deDE,enUS,esES,frFR,ruRU}.lua` | One word each: `zh` added to the `language` enum in the help text, so `/lueur language` can select Chinese. |
| `Lueur.toc` | `## Notes-zhCN`, `## Title-zhCN`, version → 1.4.1, and `Locales\zhCN.lua` in the file list. |
| `Nodes.lua` | A `VEIN_NAMES.zhCN` block, 13 entries. |

`Lueur.lua`, `Menu.lua`, `Effects.lua`, `NodeScan.lua`, `Preview.lua`, `Skin.lua` and
`Locales/Locales.lua` are **untouched**. Schema version stays 8; no CVars, no new
saved-variable keys, no API surface changes.

## License status — read this before reusing anything

**Lueur has no declared license.** As of upstream 1.4.0 (2026-10-21):

- the CurseForge `license` field is empty;
- the released archive contains no `LICENSE` and no `README`;
- `Lueur.toc` has no `Author` or license field;
- the source repository linked from CurseForge (`repos.curseforge.com/wow/lueur`) returns 404.

Under ordinary copyright rules that means **all rights reserved**. So:

- the [`LICENSE`](LICENSE) in this repository covers **only the localization work
  added here** (the Chinese text, the command aliases, the vein names, the `toc`
  lines, the documentation) — it is MIT;
- it **does not** grant anything over the addon itself, its name, its icon, or its
  artwork;
- if you want to redistribute a Chinese build of Lueur, **ask the author first**.

This repository exists so that conversation can start with a concrete diff in hand.
It deliberately does not redistribute the addon.

## How to apply

```
git -c core.autocrlf=false apply patch/Lueur-1.4.1-zhCN.patch
cp patch/Locales/zhCN.lua Locales/
```

`-c core.autocrlf=false` matters: with the Windows default `core.autocrlf=true`, git
rewrites the patched files to CRLF and the 7-line `Nodes.lua` change shows up as 350
modified lines. Verified both ways — see [`patch/APPLY.md`](patch/APPLY.md).

## How it was verified

Static checks only — there is no Lua interpreter on the machine that produced this:

| Check | Result |
|---|---|
| `patch/Lueur-1.4.1-zhCN.patch` on a pristine 1.4.0 | `git apply --check` and the real apply both exit 0 |
| Result of that apply vs. the build this came from | 31 files, **every one byte-identical** (SHA256) |
| Key parity with `enUS.lua` | 292 keys, no missing, no extra, no duplicates |
| Format placeholders (`%s`, `%d`, `%%`) | 290 single-line strings, counts and order match |
| Help list length | 30 lines on both sides |
| Block balance (`function`/`if`/`for`/`end`) | 9 files, all balanced |
| Top-level local count in `Lueur.lua` | 198 of Lua 5.1's 200 ceiling — unchanged from upstream |

**Not verified:** that the addon loads in-game, that Chinese glyphs render in the
client font, that `/lueur help` wraps correctly, or that `/lueur 范围 15` dispatches
as intended. Those need a real client.

## The 15-yard limit

The original description says range is 5 to 15 yards. That is a client limit, not a
setting: raising `SoftTargetInteractRange` to 40 was measured in-game on build 16001
and the client still stopped designating a soft-target beyond 15 yards, so no glow
appeared. `ClosestGameObjectPosition` returned `nil` for all 14 object IDs tested,
which is also why projecting a marker onto distant ground objects cannot work.

The measurement is written up in [`给原作者的说明.md`](给原作者的说明.md).

## Credits

- Original addon, code, name, icon and artwork: **Armytille**.
- Simplified Chinese localization: compiled by **骑人知福-正直** (GitHub
  [`kakadex`](https://github.com/kakadex)), derived from a community 0.7.0
  localization circulated on the NGA forum, **translator uncredited** in that
  archive — see `NOTICE.md` for the measured overlap. Attribution for the
  underlying Chinese text belongs to that translator first.
- World of Warcraft and related assets are property of Blizzard Entertainment.

Addons for World of Warcraft must be distributed free of charge under Blizzard's UI
Addon Policy; nothing here may be sold.
