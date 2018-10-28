" Vim indent file for Tandberg/Cisco coding 'style'
" Language:	C++
"
" Maintainer: Edwin Vane (edwin.vane@intel.com)
"
" Based on https://github.com/benlangmuir/home/blob/master/.vim/indent/cpp.vim
" with modifications.
"
" cindent is good enough to indent C++ in most cases but there are a few cases
" that need special handling:
"
" namespace blocks
"   Don't indent the contents of namespace blocks. Since namespace
"   declarations should always start in column 0, we just simplify the indent
"   for namespace block conents to be 0.
" template declaration
"   Don't indent the continuation line after a template declaration.
" Constructor initializer lists
"
"   constructor(...)
"       : member(1)
"       , member(2)
"       ...
"   {}

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" Searches backward from the current cursor position over a constructor
" definition to leave the cursor on the start of the constructor name if found.
"
" Returns: 0 - if no constructor could be found
"          !0 - Line number containing the first line of the constructor
"          function signature.
function! s:locate_constructor_name()
    let cline_num = line('.')

    let a = search(')\_s*:', 'Wbcen')
    if a != line('.')
        return 0
    endif
    call search(')\_s*:', 'Wbc')
    normal [(
    let a = search('\i\+\_s*(', 'Wbcen')
    if a != line('.')
        return 0
    endif
    return search('\i\+\_s*(', 'Wbc')
endfunction

function! Cpp_indent_impl(line_num)
    let cline_num = a:line_num
    let pline_num = prevnonblank(cline_num - 1)
    let pline = getline(pline_num)
    let cline = getline(cline_num)

    " Treat comments as empty space when looking for a previous line to apply
    " special case tests below. Otherwise we end up using cindent() which won't
    " use preceding comments to set an indent level.
    "
    " Only worry about C++-style comments.
    while pline =~ '^\s*//'
        let pline_num = prevnonblank(pline_num - 1)
        let pline = getline(pline_num)
    endwhile

    if pline =~# '^\s*template.*'
        " Return indent of previous line. But don't use cindent directly as the
        " previous line might be one of our special cases (e.g. namespace).
        let retv = Cpp_indent_impl(pline_num)
    elseif pline =~# '^\s*namespace.*'
        let retv = 0
    elseif cline =~ '^\s*,'

        let retv = Cpp_indent_impl(pline_num)
    elseif cline =~ '^\s*{'
        " Blocks after a constructor should be unindented.
        " If the previous line starts with , or :, do not use it to indent the
        " next line
        while pline =~ '^\s*[:,]'
            let pline_num = prevnonblank(pline_num - 1)
            let pline = getline(pline_num)
        endwhile
        let retv = Cpp_indent_impl(pline_num)
    elseif cline =~ '^\s*:'
        " Except certain cases with the conditional assignment operator (i.e. ? :)
        " a ':' on a new line indicates the first item in an initializer list. It
        " should be indented level to the constructor definition.
        "
        " Return the indent level (as calculated by us to handle any special cases)
        " of the first line of the constructor function signature. Otherwise, just
        " use cindent()
        let a = s:locate_constructor_name()
        if a == 0
            let retv = cindent(cline_num)
        else
            let retv = &shiftwidth + Cpp_indent_impl(a)
        endif
    else
        " This line isn't a special case. Defer to cindent.
        let retv = cindent(cline_num)
    endif

    return retv
endfunction

" This function must be available to the buffer where indenting is taking
" place
function! Cpp_indent()
    let cline_num = line('.')
    return Cpp_indent_impl(cline_num)
endfunction

setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4
setlocal expandtab

setlocal cindent
setlocal cinoptions=:0,l1,g0,t0,i0,(0,w1

setlocal indentexpr=Cpp_indent()
" re-indent a line when a user enters ':' as the first non-white character on
" a line. This ensures constructor initializer lists are indented properly
" right away. Also indent if comma is the first character on a line.
setlocal indentkeys+=0<:>
setlocal indentkeys+=0\,

"let b:undo_indent = "setl sw< ts< sts< et< tw< wrap< cin< cino< inde<"
