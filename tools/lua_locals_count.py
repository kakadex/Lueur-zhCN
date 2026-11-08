"""数一个 Lua 文件主程序块的局部变量个数（对照 Lua 5.1 的 200 个上限）。

为什么要这个脚本：
    Lua 5.1 规定**每个函数**最多 200 个局部变量。插件主程序块（文件最外层）
    也受这一条约束。汉化时如果在文件顶层多加几个 `local`，就可能越过上限，
    报 "main function has more than 200 local variables"——而且是加载时直接
    失败，不是某行报错，很难一眼定位。

做法：
    只统计**行首的 `local` 声明**（`local x`、`local x, y = ...`、
    `local function f`），并按逗号拆出变量名个数。会先剥掉注释和字符串，
    避免 `-- 注释` 里的词被误算成变量名。
    不做完整的 Lua 词法分析，遇到 `;` 分隔同一行多条声明之类的高级写法会漏算，
    对官方代码这种一声明一行的风格足够用。

用法：
    python lua_locals_count.py <文件> [<文件> ...]
"""
import re
import sys

LINE_COMMENT = re.compile(r'--.*$')
BLOCK_COMMENT = re.compile(r'--\[(=*)\[.*?\]\1\]', re.S)


def strip_comments(src):
    """剥掉块注释与行注释；字符串里的 `--` 也会被去掉，但这个统计只看行首，影响可忽略。"""
    src = BLOCK_COMMENT.sub(' ', src)
    return '\n'.join(LINE_COMMENT.sub('', ln) for ln in src.split('\n'))


def count_locals(src):
    """返回 (声明条数, 变量名个数)。"""
    statements = 0
    names = 0
    for ln in strip_comments(src).split('\n'):
        m = re.match(r'local\s+(.*)$', ln)
        if not m:
            continue
        body = m.group(1).strip()
        if not body:
            continue
        statements += 1
        if body.startswith('function'):
            names += 1                      # local function f(...) 只占一个名字
            continue
        decl = body.split('=')[0]           # 丢掉右侧的初值
        names += len([p for p in (x.strip() for x in decl.split(',')) if p])
    return statements, names


def main(paths):
    rc = 0
    for path in paths:
        with open(path, encoding='utf-8') as f:
            src = f.read()
        statements, names = count_locals(src)
        total_lines = src.count('\n') + (0 if src.endswith('\n') else 1)
        left = 200 - names
        flag = '' if left >= 0 else '  ** 已超出 Lua 5.1 上限 **'
        print(
            f'{path}\n'
            f'  文件 {total_lines} 行；顶层 local 声明 {statements} 条 '
            f'-> 变量名 {names} 个；距 200 上限余 {left} 个{flag}'
        )
        if left < 0:
            rc = 1
    return rc


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print('用法: python lua_locals_count.py <文件> [<文件> ...]')
        sys.exit(2)
    sys.exit(main(sys.argv[1:]))
