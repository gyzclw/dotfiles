if has('nvim')
  "开启真彩模式
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  "neovim 开启python
endif

set nocompatible
let g:python3_host_prog = '/usr/local/bin/python3'

" enable syntax processing
syntax enable
"---------------------------------------------------------------------
" 插件导入
"---------------------------------------------------------------------
if filereadable(expand("~/.config/nvim/nvimrc.bundles"))
    source ~/.config/nvim/nvimrc.bundles
endif
"---------------------------------------------------------------------
"主题设置
"---------------------------------------------------------------------
set background=dark
colorscheme Dracula
let g:rehash256 = 1
" TODO: 设置内置终端的颜色
let g:terminal_color_0  = '#282a36'
let g:terminal_color_1  = '#ff5555'
let g:terminal_color_2  = '#50fa7b'
let g:terminal_color_3  = '#f1fa8c'
let g:terminal_color_4  = '#bd93f9'
let g:terminal_color_5  = '#ff79c6'
let g:terminal_color_6  = '#8be9fd'
let g:terminal_color_7  = '#50fa7b'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

"---------------------------------------------------------------------
"系统设置
"---------------------------------------------------------------------
" 让水平滚动更加自然
set sidescroll=1
set sidescrolloff=3
" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
" 插入模式自动补全标签显示更多信息
set showfulltag
" tab 缩进
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround smartindent
autocmd FileType css,scss,slim,html,eruby,coffee,javascript setlocal iskeyword+=-
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4
"UI Config
set gcr=a:block-blinkon0

set      number              " 显示行数
set      showcmd             " show command in bottom bar
filetype indent on           " load filetype-specific indent files
set      wildmenu            " visual autocomplete for command menu
set      lazyredraw          " redraw only when we need to.
set      showmatch           " highlight matching [{()}]

"查找设置

set      incsearch           " search as characters are entered
set      hlsearch            " highlight matches
nnoremap <leader><space> :nohlsearch<CR>
"Folding

"用逗号代替mapleader
let mapleader = "," " leader is comma
" jk 替代 escape
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set      foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable
filetype plugin indent on

"Movement
" move to beginning/end of line
nnoremap B ^
nnoremap E $


" highlight last inserted text
nnoremap gV `[v`]

" 修改宽度
let g:gundo_width = 30

" 修改高度
let g:gundo_preview_height =20
" edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>

" 代码块
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
"多窗口编辑,临时放大某个窗口
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>z :ZoomToggle<CR>
" 滚动Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" Quickly close the current window
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>
" Quickly save the current file
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>
"---------------------------------------------------------------------
"Emmet setting
"---------------------------------------------------------------------
let g:user_emmet_install_global = 0

autocmd FileType html,css,htmldjango,scss,eruby,less EmmetInstall

function! s:return_without_deoplete() abort
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction
"---------------------------------------------------------------------
"自动补全代码
"---------------------------------------------------------------------
if has('nvim')
"异步自动补全代码
let g:deoplete#enable_at_startup = 1                 " 缺省开启自动补全
" <CR> 直接换行而不执行 deoplete 的默认行为
inoremap <silent> <CR> <C-r>=<SID>return_without_deoplete()<CR>

"UltiSnips插件设置
let g:UltiSnipsSnippetsDir         = $HOME.'/.config/nvim/UltiSnips'
let g:UltiSnipsExpandTrigger       = '<TAB>'
let g:UltiSnipsListSnippets        = '<A-TAB>'
let g:UltiSnipsJumpForwardTrigger  = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:UltiSnipsMappingsToIgnore    = ["deoplete"]
else

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
endif
"---------------------------------------------------------------------
"缩写
"---------------------------------------------------------------------
" 缩写 :so -> :source % 用于重新加载当前文件
cnoreabbrev <expr> so getcmdtype() == ':' && getcmdline() == 'so' ? 'source %' : 'so'
" 缩写 :sw -> :w !sudo tee % 用于获取 Admin 权限写入文件
cnoreabbrev <expr> sw getcmdtype() == ':' && getcmdline() == 'sw' ? 'w !sudo tee %' : 'sw'
" 缩写 :ev -> :tabedit PATH/TO/init.vim 用于新开标签页编辑 init.vim 文件
cnoreabbrev <expr> ev getcmdtype() == ':' && getcmdline() == 'ev' ? 'tabedit $MYVIMRC' : 'ev'
" 缩写 :ue -> :UltiSnipsEdit 用于编辑 UltiSnips
cnoreabbrev <expr> ue getcmdtype() == ':' && getcmdline() == 'ue' ? 'UltiSnipsEdit' : 'ue'

"---------------------------------------------------------------------
" RSpec.vim mappings
"---------------------------------------------------------------------
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>a :call RunAllSpecs()<CR>

"---------------------------------------------------------------------
"easty-motion插件设置
"---------------------------------------------------------------------
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" easymotion-repeat：重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)
"---------------------------------------------------------------------
" EasyAlign 快速格式化
"---------------------------------------------------------------------
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
"---------------------------------------------------------------------
"代码检查
"---------------------------------------------------------------------
if has('nvim')
"代码检查neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_jshint_maker = {
      \ 'args': ['--verbose'],
      \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
      \ }
let g:neomake_javascript_enabled_makers = ['jshint']
else
"syntastic 语法检查
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5
nnoremap <Leader>s :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>
endif
function! ToggleErrors()
  let old_last_winnr = winnr('$')
  lclose
  if old_last_winnr == winnr('$')
    " Nothing was closed, open syntastic error location panel
    Errors
  endif
endfunction
"---------------------------------------------------------------------
"Autogroup
"---------------------------------------------------------------------
augroup configgroup
  autocmd!
  autocmd VimEnter * highlight clear SignColumn
  autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
        \:call <SID>StripTrailingWhitespaces()
  autocmd FileType java setlocal noexpandtab
  autocmd FileType java setlocal list
  autocmd FileType java setlocal listchars=tab:+\ ,eol:-
  autocmd FileType java setlocal formatprg=par\ -w80\ -T4
  autocmd FileType php setlocal expandtab
  autocmd FileType php setlocal list
  autocmd FileType php setlocal listchars=tab:+\ ,eol:-
  autocmd FileType php setlocal formatprg=par\ -w80\ -T4
  autocmd FileType ruby setlocal tabstop=2
  autocmd FileType ruby setlocal shiftwidth=2
  autocmd FileType ruby setlocal softtabstop=2
  autocmd FileType ruby setlocal commentstring=#\ %s
  autocmd FileType python setlocal commentstring=#\ %s
  autocmd BufEnter *.cls setlocal filetype=java
  autocmd BufEnter *.zsh-theme setlocal filetype=zsh
  autocmd BufEnter Makefile setlocal noexpandtab
  autocmd BufEnter *.sh setlocal tabstop=2
  autocmd BufEnter *.sh setlocal shiftwidth=2
  autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
"Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim
"}}}"
"--------------------------------------------------------------
" lightline 设置
"--------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"---------------------------------------------------------------------------
" goyo.vim + limelight.vim
"---------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  " hi NonText ctermfg=101
  Limelight
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>g :Goyo<CR>
" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
"terminal setting
if has('nvim')
    tnoremap jk  <C-\><C-n>
endif
nmap t<Enter> :bo sp term://zsh\|resize 5<CR>i
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" multi_cursor setting
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" File preview using CodeRay (http://coderay.rubychan.de/)
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader><Leader>p :Files<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>fu        :BTags<CR>
nnoremap <silent> <Leader>f/ :History:<CR>
nnoremap <silent> <Leader>f :History<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 498 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~40%',
  \ 'sink':    'Explore'})
"-----------------------------------------------------------------
"fugitive
"-----------------------------------------------------------------
set diffopt+=vertical

