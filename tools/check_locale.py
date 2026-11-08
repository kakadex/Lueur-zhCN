"""对照 enUS.lua 校验 zhCN.lua（仅用于本次改动验证，不属于交付的插件代码）。

检查三件事：
1. 键是否齐全：enUS 定义的大写键，zhCN 是否都有；zhCN 是否多出 enUS 没有的键。
2. 格式化占位符是否一致：同一条文本里 %s/%d/%%.2f 等必须完全相同，
   否则运行期 string.format 会报错或显示错位。
3. HELP 列表条数是否一致。
"""
import re
import sys

KEY_RE = re.compile(r'^L\.([A-Z0-9_]+)\s*=', re.M)
FMT_RE = re.compile(r'%(?:%|[-+ 0#]*\d*(?:\.\d+)?[diouxXeEfgGqsc])')


def load(path):
    with open(path, encoding='utf-8') as f:
        return f.read()


def keys_of(src):
    return KEY_RE.findall(src)


def values_of(src):
    """把 `L.KEY = "..."` 的单行赋值抽出来，用于比对占位符。"""
    out = {}
    for m in re.finditer(r'^L\.([A-Z0-9_]+)\s*=\s*("(?:[^"\\]|\\.)*")', src, re.M):
        key, lit = m.group(1), m.group(2)
        if key not in out:
            out[key] = lit
    return out


def help_entries(src):
    m = re.search(r'L\.HELP\s*=\s*\{(.*?)\n\}', src, re.S)
    if not m:
        return None
    return len(re.findall(r'^\s*"/lueur', m.group(1), re.M))


def main(en_path, zh_path):
    en, zh = load(en_path), load(zh_path)
    en_keys, zh_keys = keys_of(en), keys_of(zh)
    bad = 0

    en_set, zh_set = set(en_keys), set(zh_keys)
    missing = [k for k in en_keys if k not in zh_set]
    extra = [k for k in zh_keys if k not in en_set]
    print(f'enUS 键 {len(en_keys)} 条，zhCN 键 {len(zh_keys)} 条')
    if missing:
        bad = 1
        print(f'  [缺失] {len(missing)} 条: ' + ', '.join(missing))
    if extra:
        bad = 1
        print(f'  [多出] {len(extra)} 条: ' + ', '.join(extra))
    dups = [k for k in zh_set if zh_keys.count(k) > 1]
    if dups:
        bad = 1
        print(f'  [重复定义] {len(dups)} 条: ' + ', '.join(dups))
    if not missing and not extra and not dups:
        print('  [键] 齐全，无多出，无重复')

    # 占位符逐键比对
    en_vals, zh_vals = values_of(en), values_of(zh)
    mismatched = []
    for key, zh_lit in zh_vals.items():
        en_lit = en_vals.get(key)
        if en_lit is None:
            continue
        a = sorted(FMT_RE.findall(en_lit))
        b = sorted(FMT_RE.findall(zh_lit))
        if a != b:
            mismatched.append((key, a, b))
    if mismatched:
        bad = 1
        print(f'  [占位符不一致] {len(mismatched)} 条:')
        for key, a, b in mismatched:
            print(f'    {key}: enUS={a} zhCN={b}')
    else:
        print(f'  [占位符] {len(zh_vals)} 条单行文本全部一致')

    en_help, zh_help = help_entries(en), help_entries(zh)
    if en_help != zh_help:
        bad = 1
        print(f'  [HELP 条数] enUS={en_help} zhCN={zh_help} 不一致')
    else:
        print(f'  [HELP] 条数一致：{zh_help}')

    return bad


if __name__ == '__main__':
    sys.exit(main(sys.argv[1], sys.argv[2]))
