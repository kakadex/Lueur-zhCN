"""Lua 5.1 结构校验（仅用于本次改动验证，不属于交付的插件代码）。

做法：剥掉注释和字符串，再检查块关键字是否配平
（function / if / for / while / do / repeat ... end / until）。
它不能替代真正的 luac 语法检查，但能抓出少写或多写 end 这类手误。
"""
import sys


def strip_comments_and_strings(src):
    out = []
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        # 长字符串 [[ ]] 或 [==[ ]==]
        if c == '[':
            j = i + 1
            eq = 0
            while j < n and src[j] == '=':
                eq += 1
                j += 1
            if j < n and src[j] == '[':
                closer = ']' + '=' * eq + ']'
                k = src.find(closer, j + 1)
                i = n if k < 0 else k + len(closer)
                out.append(' ')
                continue
        # 长注释 --[[ ]] 或 --[==[ ]==]
        if c == '-' and src.startswith('--', i):
            j = i + 2
            eq = 0
            while j < n and src[j] == '=':
                eq += 1
                j += 1
            if j < n and src[j] == '[' and src.startswith('[', j):
                # 确认是 [[ 或 [==[
                k2 = j + 1
                e2 = 0
                while k2 < n and src[k2] == '=':
                    e2 += 1
                    k2 += 1
                if k2 < n and src[k2] == '[':
                    closer = ']' + '=' * e2 + ']'
                    end = src.find(closer, k2 + 1)
                    i = n if end < 0 else end + len(closer)
                    continue
            while i < n and src[i] != '\n':
                i += 1
            continue
        if c in ('"', "'"):
            quote = c
            i += 1
            while i < n:
                if src[i] == '\\':
                    i += 2
                    continue
                if src[i] == quote:
                    i += 1
                    break
                if src[i] == '\n':
                    break
                i += 1
            out.append(' ')
            continue
        out.append(c)
        i += 1
    return ''.join(out)


def tokenize(code):
    tokens = []
    word = []
    for ch in code:
        if ch.isalnum() or ch == '_':
            word.append(ch)
        else:
            if word:
                tokens.append(''.join(word))
                word = []
            if not ch.isspace():
                tokens.append(ch)
    if word:
        tokens.append(''.join(word))
    return tokens


def check(path):
    with open(path, 'r', encoding='utf-8') as f:
        code = strip_comments_and_strings(f.read())
    tokens = tokenize(code)

    stack = []
    pending_loop = 0  # 刚读到 for/while，等它的 do
    for idx, tok in enumerate(tokens):
        if tok == 'for' or tok == 'while':
            stack.append(tok)
            pending_loop += 1
        elif tok == 'do':
            if pending_loop > 0:
                pending_loop -= 1      # for/while 的 do 属于它自己的块
            else:
                stack.append('do')     # 独立的 do ... end
        elif tok == 'function':
            stack.append('function')
        elif tok == 'if':
            stack.append('if')
        elif tok == 'repeat':
            stack.append('repeat')
        elif tok == 'end':
            if not stack:
                print(f'{path}: 多余的 end（token#{idx}）')
                return 1
            stack.pop()
        elif tok == 'until':
            if not stack or stack[-1] != 'repeat':
                print(f'{path}: until 没有配对的 repeat（token#{idx}）')
                return 1
            stack.pop()
    if stack:
        print(f'{path}: 未闭合的块 {stack}')
        return 1
    print(f'{path}: 结构配平 OK')
    return 0


if __name__ == '__main__':
    rc = 0
    for p in sys.argv[1:]:
        rc |= check(p)
    sys.exit(rc)
