" Plugin: uuidhl.vim
" Author: Øystein Dale
" Date: 2018-11-04
"
" :HighlightUUID highlights UUIDs in files. Uses a hashing algorithm to ensure
" that a specific UUID always has the same color.

if exists('g:did_highlight_uuid')
    finish
endif
let g:did_highlight_uuid = 1

python << EOF
def uuid_to_color(uuid):
    from operator import mul
    from operator import add
    from operator import div
    from math import floor

    l = [ int(x, 16) for x in uuid.split("-") ]
    l = [ l[0], sum(l[1:4]), l[4] ]

    r_primes = (59, 61, 67)
    g_primes = (71, 73, 79)
    b_primes = (83, 89, 97)

    bias = (0x16, 0x0e, 0x1f)

    color = [
        sum(map(mul, l, r_primes)) % (0xFF - bias[0]),
        sum(map(mul, l, g_primes)) % (0xFF - bias[1]),
        sum(map(mul, l, b_primes)) % (0xFF - bias[2]),
    ]
    color = map(add, color, bias)

    flatten = (0x1a,0x1a, 0x1a)

    color = map(div, color, flatten)
    color = map(floor, color)
    color = map(int, color)
    color = map(mul, color, flatten)

    return color
EOF

function! s:FindAllUUID()
    let l:uuid_regex = '[0-9a-f]\{8\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{12\}'
    let l:res = []
    call substitute(join(readfile(expand('%')), '\n'), l:uuid_regex, '\=add(l:res, submatch(0))', 'g')
    return l:res
endfunction

function! s:UuidToColor(uuid)
python << EOF
vim.command('return "#{:02X}{:02X}{:02X}"'.format(*uuid_to_color(vim.eval('a:uuid'))))
EOF
endfunction

function! s:HighlightUUID()
    let l:uuids = s:FindAllUUID()

    for uuid in l:uuids
        let uuid_arg = substitute(uuid, "-", "_", "g")
        let l:syntax = "syntax match " . uuid_arg . " \"" . uuid . "\""
        exec l:syntax
        let l:hilight = "highlight " . uuid_arg . " guifg=" . s:UuidToColor(l:uuid)
        exec l:hilight
    endfor
endfunction

command! HighlightUUID call s:HighlightUUID()
