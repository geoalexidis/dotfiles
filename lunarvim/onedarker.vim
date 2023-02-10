" Author: Christian Chiarulli <chrisatmachine@gmail.com>

lua << EOF
package.loaded['onedarker'] = nil
package.loaded['onedarker.highlights'] = nil
package.loaded['onedarker.Treesitter'] = nil
package.loaded['onedarker.markdown'] = nil
package.loaded['onedarker.Whichkey'] = nil
package.loaded['onedarker.Git'] = nil
package.loaded['onedarker.LSP'] = nil

require("onedarker")

EOF

" custom adjustemnts here since not knowing any better solution
" transparency when using LunarVim
hi Normal guibg=NONE ctermbg=NONE

" setting relative numbers
set rnu

" how to paste overwithout overwrting register
" https://stackoverflow.com/a/7700319/6138965
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vnoremap <silent> <expr> p <sid>Repl()
