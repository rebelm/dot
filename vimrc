" jonssl@adm01alp> cd git/github.com
" jonssl@adm01alp> git clone git@gitlab.pjm.com:jonssl/vim-plug.git
" Cloning into 'vim-plug'...
" remote: Counting objects: 1907, done.
" remote: Compressing objects: 100% (799/799), done.
" remote: Total 1907 (delta 1152), reused 1832 (delta 1102)
" Receiving objects: 100% (1907/1907), 8.28 MiB, done.
" Resolving deltas: 100% (1152/1152), done.
"
" jonssl@adm01alp> cd ~/vim/autoload
" jonssl@adm01alp> ln -s ~/git/gitbub.com/vim-plug/plug.vim  .

"#######################################################
"##
"## Key binding summary
"##
"## <F5>    Re-read .vimrc
"## <F6>    Toggle syntastic
"## <F7>    Toggle syntax high-lighting
"## <F8>    Toggle tab mode
"## <F9>    Disable line numbers
"## <ENTER> Toggle between absolute and standard
"##         line numbers
"## <C-n>   Toggle NerdTree
"## <C-J>   Switch to previous buffer
"## <C-K>   Switch to next buffer
"## \l      Sticky highlight
"##
"#######################################################

call plug#begin()
Plug 'git@gitlab.pjm.com:unix/vim-sensible.git'
Plug 'git@gitlab.pjm.com:unix/vim-colors-solarized.git'
Plug 'git@gitlab.pjm.com:unix/vim-monokai.git'
Plug 'git@gitlab.pjm.com:unix/vim-speeddating.git'
Plug 'git@gitlab.pjm.com:unix/vim-splunk.git'

" ZoomWin is too slow
" Use these instead:
" <C-W>-| <C-W>-_ <C-W>-= <C-W>-- <C-W>-+
"Plug 'git@gitlab.pjm.com:unix/ZoomWin.git'

" Syntastic is pretty slow, perhaps rely on git pre-commit hooks instead
" Or just toggle with <F6>, see below
Plug 'git@gitlab.pjm.com:unix/syntastic.git'

" More useful stuff in the vim status bar
Plug 'git@gitlab.pjm.com:unix/vim-airline.git'
Plug 'git@gitlab.pjm.com:unix/vim-airline-themes.git'

" Puppet DSL aware code layout tool
Plug 'git@gitlab.pjm.com:puppet/vim-puppet.git'

"Plug 'git@gitlab.pjm.com:jonssl/xmledit.git'

" Json beautifier
Plug 'git@gitlab.pjm.com:unix/vim-json.git'

" Tab completer on steroids
Plug 'git@gitlab.pjm.com:unix/ctrlp.vim.git'

" File explorer
Plug 'git@gitlab.pjm.com:unix/nerdtree.git', { 'on': 'NERDTreeToggle' }
call plug#end()

augroup myvimrc                            " Re-read vimrc automatically when saved
    autocmd!
    autocmd BufWritePost ~/.vimrc source $MYVIMRC
augroup END

nnoremap <F5> :source ~/.vimrc<CR>         " A keyboard shortcut for the same for the case
                                           " when vimrc has changed outside vim, like when
                                           " toggling solarized dark/light

" ****************************************************
" NERDTreeNERDTree
noremap <C-n> :NERDTreeToggle<CR>          " C-n to show the NERDTree
let NERDTreeMinimalUI=1                    " Less clutter
let NERDTreeShowBookmarks=1                " Show bookmarks
let NERDTreeDirArrows=1                    " Use ▸ and ▾ in directory tree

" Close NERDTree if it is the only buffer left
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nnoremap <C-x> :bp\|bd #<CR>
" ****************************************************

" ****************************************************
" Syntastic settings
nnoremap <F6> :SyntasticToggleMode<CR>         " A keyboard shortcut to toggle Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
" ****************************************************

" ****************************************************
" vim-airline
let g:airline#extensions#tabline#enabled = 1        " Show all buffers
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_theme='molokai'
"let g:airline_theme='solarized'
"let g:airline_powerline_fonts = 1
" ****************************************************

set formatoptions=tcq                      " How to format text
set nocompatible                           " Default to vim behaviour
set modeline

set hlsearch                               " Highlight searches
set incsearch                              " ... as you type
set laststatus=2                           " Always show the status line

syntax on                                  " Syntax highlighting (likely aready enabled)
syntax enable

"set background=light
set background=dark
"colorscheme solarized
"colorscheme monokai
hi Search term=reverse ctermfg=235 ctermbg=186 guifg=#272822 guibg=#e6db74
hi IncSearch term=reverse ctermfg=235 ctermbg=186 guifg=#272822 guibg=#e6db74
hi Comment ctermfg=gray

"
" Toggle syntax highlighting with F7
nnoremap <F7> :if exists("g:syntax_on") <Bar>
            \   syntax off <Bar>
            \ else <Bar>
            \   syntax enable <Bar>
            \ endif <CR>

" Toggle indentation between 4 spaces and 8 wide tab
nnoremap <F8> :call ToggleTabmode() <CR>

let g:tabmode = 0
function! EnableTabmode()
    set tabstop=8                              " Size of a tab
    set softtabstop=8                          " Unclear if this is useful
    set shiftwidth=8                           " >> and << indent amount
    set noexpandtab                            " Use spaces instead of tabs
    set nolist
    let g:tabmode = 1
endfunc

function! DisableTabmode()
    set tabstop=4                              " Size of a tab
    set softtabstop=4                          " Unclear if this is useful
    set shiftwidth=4                           " >> and << indent amount
    set expandtab                              " Use spaces instead of tabs
    set list
    let g:tabmode = 0
endfunc

function! ToggleTabmode()
    if(g:tabmode == 0)
        call EnableTabmode()
    else
        call DisableTabmode()
    endif
endfunc

set ruler                                  " Show ruler (if not already set by theme)

set tabstop=4                              " Size of a tab
set softtabstop=4                          " Unclear if this is useful
set shiftwidth=4                           " >> and << indent amount
set expandtab                              " Use spaces instead of tabs

set visualbell t_vb=                       " Silence error beeping and flashing
set noerrorbells

set cursorline                             " Highlight current line
hi CursorLine cterm=none term=reverse ctermbg=237 guibg=#3c3d37
"set cursorcolumn                           " Highlight current column (too much)

" Sticky highlight a line
" http://vim.wikia.com/wiki/Highlight_current_line
nnoremap <silent> <Leader>l ml:execute 'match Search /\%'.line('.').'l/'<CR>

set list                                   " Show whitespaces
set listchars=tab:\ \ ,trail:·             " Highlight tabs and trailing spaces
" TODO: Add indentation scope highlighting

filetype plugin indent on                  " Autoindent

nnoremap <C-Q> <C-W>                       " No longer needed since tmux.conf maps <C-Q> and <C-S>
" to prefix and prefix2 respectively.
" Don't need to worry about XON / XOFF anymore.

" Toggle line numbers
"nnoremap <C-M> :set nonumber!<CR>

nnoremap <C-J> :bprev!<CR>                      " Switch to previous or next buffer
nnoremap <C-K> :bnext!<CR>                      " even if current buffer is modified

nnoremap <C-O> zo
nnoremap <C-C> zc
set foldlevel=99

autocmd InsertLeave * redraw!              " Redraw screen when leaving insert mode

cmap w!! %!sudo tee > /dev/null %          " Write file using sudo if write protected
                                           " https://coderwall.com/p/xp9kjw
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif




" ****************************************************
" Enter key to toggle absolute or relative line numbers
" <F9> to turn off.  Relative line numbers requires
" vim > 7.3 (I think).  Compile 8.0 and be done with it.
let g:loaded_numbertoggle = 1
let g:insertmode = 0
let g:focus = 1
let g:relativemode = 1

nnoremap <C-M> :call NumberToggle()<CR>
nnoremap <F9> :set nonumber<Bar>set norelativenumber<CR>

" Enables relative numbers.
function! EnableRelativeNumbers()
  set number
  set relativenumber
endfunc

" Disables relative numbers.
function! DisableRelativeNumbers()
  set number
  set norelativenumber
endfunc

" NumberToggle toggles between relative and absolute line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    call DisableRelativeNumbers()
    let g:relativemode = 0
  else
    call EnableRelativeNumbers()
    let g:relativemode = 1
  endif
endfunc

"function! UpdateMode()
"  if(&number == 0 && &relativenumber == 0)
"    return
"  end
"
"  if(g:focus == 0)
"    call DisableRelativeNumbers()
"  elseif(g:insertmode == 0 && g:relativemode == 1)
"    call EnableRelativeNumbers()
"  else
"    call DisableRelativeNumbers()
"  end
"
"  if !exists("&numberwidth") || &numberwidth <= 4
"    " Avoid changing actual width of the number column with each jump between
"    " number and relativenumber:
"    let &numberwidth = max([4, 1+len(line('$'))])
"  else
"    " Explanation of the calculation:
"    " - Add 1 to the calculated maximal width to make room for the space
"    " - Assume 4 as the minimum desired width if &numberwidth is not set or is
"    "   smaller than 4
"    let &numberwidth = max([&numberwidth, 1+len(line('$'))])
"  endif
"endfunc
"
"function! FocusGained()
"  let g:focus = 1
"  call UpdateMode()
"endfunc
"
"function! FocusLost()
"  let g:focus = 0
"  call UpdateMode()
"endfunc
"
"function! InsertLeave()
"  let g:insertmode = 0
"  call UpdateMode()
"endfunc
"
"function! InsertEnter()
"  let g:insertmode = 1
"  call UpdateMode()
"endfunc
"
"" Automatically set relative line numbers when opening a new document
"autocmd BufNewFile * :call UpdateMode()
"autocmd BufReadPost * :call UpdateMode()
"autocmd FilterReadPost * :call UpdateMode()
"autocmd FileReadPost * :call UpdateMode()
"
"" Automatically switch to absolute numbers when focus is lost and switch back
"" when the focus is regained.
"autocmd FocusLost * :call FocusLost()
"autocmd FocusGained * :call FocusGained()
"autocmd WinLeave * :call FocusLost()
"autocmd WinEnter * :call FocusGained()
"
"" Switch to absolute line numbers when the window loses focus and switch back
"" to relative line numbers when the focus is regained.
"autocmd WinLeave * :call FocusLost()
"autocmd WinEnter * :call FocusGained()
"
"" Switch to absolute line numbers when entering insert mode and switch back to
"" relative line numbers when switching back to normal mode.
"autocmd InsertEnter * :call InsertEnter()
"autocmd InsertLeave * :call InsertLeave()

" " ensures default behavior / backward compatibility
" if ! exists ( 'g:UseNumberToggleTrigger' )
"   let g:UseNumberToggleTrigger = 1
" endif
" 
" if exists('g:NumberToggleTrigger')
"   exec "nnoremap <silent> " . g:NumberToggleTrigger . " :call NumberToggle()<cr>"
" elseif g:UseNumberToggleTrigger
"   nnoremap <silent> <F9> :call NumberToggle()<cr>
" "  nnoremap <silent> <C-n> :call NumberToggle()<cr>
" endif
" ****************************************************
