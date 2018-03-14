" Set Custom vim folder
" set runtimepath=~/sources/vimfiles,$VIMRUNTIME

autocmd!
" Pathogen
filetype plugin indent off

call pathogen#infect('bundle/{}')
call pathogen#helptags()

" Set GOPATH
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

" Syntax Highlighting
syntax on
colorscheme monokai

filetype plugin indent on

"Fix cursors
set term=linux

"Fix wordwrap
set ww+=<,>

"Fix Backspace
set backspace=indent,eol,start

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL EDITOR CONFIGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set complete-=i
set smarttab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set cmdheight=1

set ignorecase smartcase

set nrformats-=octal

" Line Numbers
set number

set ttimeout
set ttimeoutlen=100

" Highlight searches
set hlsearch
set showmatch
" Start highlighting on keystroke
set incsearch
" Clear highlighted searches with enter in normal mode
nnoremap <CR> :noh<CR><CR>

set laststatus=2
set ruler
set showcmd
set wildmenu

" Enable copy/paste to work with OSX clipboard
set clipboard=unnamed

" Highlight line cursor is on
set cursorline

set winwidth=90

" Set shell when launching commands
set shell=/bin/zsh

set t_Co=256
set t_ti= t_te=

" Turn folding off
set foldmethod=manual
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

set autoread
set fileformats+=mac

" Highlight whitespace
match ErrorMsg '\s\+$'

" Removes trailing spaces on save
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"start mapped commands with ,
let mapleader=',' " lead

" Show matching parens
set showmatch

" Use prettier to format javascript
let g:prettier#autoformat = 0
let g:prettier#config#trailing_comma = 'none'
" let g:prettier#config#config_precedence = 'prefer-file'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql Prettier
autocmd BufWritePre *.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md Prettier

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM VROOM SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only load rails on files with a spec_helper
let g:vroom_detect_spec_helper = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM MOCHA SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONVENIENCE KEYMAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly reload vimrc
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" Quickly load vimrc
" nmap <silent> <leader>ev :e ~/sources/vimfiles/vimrc<CR>
nmap <silent> <leader>ev :e ~/.vimrc<CR>
" Redraw screen
nmap <silent> <leader>rd :redraw!<CR>
" Reload CtrlP
nmap <silent> <leader>rp :CtrlPClearCache<CR>
" Insert blank link above or below current line
" Note, on macs mapping Alt key doesn't work, so you have to map the actual
" character that the key combination generates
nnoremap <silent>∆ :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>˚ :set paste<CR>m`O<Esc>``:set nopaste<CR>
" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv
" Make Y behave like other capitals
nnoremap Y y$
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx

  " Arc Lisp
  autocmd! BufRead,BufNewFile *.arc setfiletype lisp

  "Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,coffee,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.md  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()

  " *.md is markdown
  autocmd! BufNewFile,BufRead *.md setlocal ft=

  " indent slim two spaces, not four
  autocmd! FileType *.slim set sw=2 sts=2 et

  " Enable code folding for javascript
  " au FileType javascript call JavaScriptFold()

  au BufNewFile,BufRead *.ejs set filetype=html

  " Enable csv.vim features
  autocmd! BufRead,BufNewFile *.csv,*.dat setfiletype csv

  " *.go is for go
  au BufRead,BufNewFile *.go set filetype=go
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

nnoremap <leader><leader> <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'ra'
" Wildignore is only used when not using user_command
" Use find for listing files
" let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](lib|dist)$' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" WILDIGNORES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Basic ignores for the mac filesystem
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git/*,.DS_Store,.AppleDouble,.LSOverride

" Thumbnails
set wildignore+=._*

" Logs
set wildignore+=*.log,logs/*

" Scala ignores
set wildignore+=*.class,*/target/*

" Node ignores
set wildignore+=*/node_modules/*,.grunt/*,*/bower_components/*

" Hubski frontend specific
set wildignore+=*/build/*

" Ruby specific
set wildignore+=*.lock,*.sqlite3,*/dump/*,.ruby-version,*/coverage/*,*/spec/reports/*,*.rdoc,*/doc/*

" Arc specific
set wildignore+=*/arc/*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map key to open NERDTree quickly
map <c-n> :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM MACROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run rails in current
let @r=':!rails s'

" Override Ex mode key to run @q
nnoremap Q @q

let g:zipPlugin_ext = '*.zip,*.jar,*.xpi,*.ja,*.war,*.ear,*.celzip,*.oxt,*.kmz,*.wsz,*.xap,*.docx,*.docm,*.dotx,*.dotm,*.potx,*.potm,*.ppsx,*.ppsm,*.pptx,*.pptm,*.ppam,*.sldx,*.thmx,*.crtx,*.vdw,*.glox,*.gcsx,*.gqsx'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTASTIC SYNTAX HIGHLIGHTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Synstatic recommended settings for new users
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

let g:syntastic_coffee_checkers = ['coffeelint', 'coffee']

let g:syntastic_go_checkers = ['golint']

let g:syntastic_javascript_eslint_exe = 'eslint --config .eslintrc.json'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SCALA SHORTCUTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>ac :!activator compile<CR>
nmap <silent> <leader>ar :!activator run<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-GO OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable all the highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_methods = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_extra_types = 1
" Don't open the quickfix window
let g:go_fmt_fail_silently = 1
" let g:go_fmt_autosave = 1

nmap <silent> <leader>gr <Plug>(go-run)
nmap <silent> <leader>gb <Plug>(go-build)
nmap <silent> <leader>gt <Plug>(go-test)
nmap <silent> <leader>gi <Plug>(go-install)
nmap <silent> <leader>gg <Plug>(go-get)

au FileType go imap <c-l> <space>:=<space>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSDOC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_enable_es6 = 1
let g:jsdoc_underscore_private = 1
nmap <silent> <C-u> <Plug>(jsdoc)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" HACKER NEWS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>hn :HackerNews<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TEMP COMMANDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>pr :!pr-enforcer<CR>
nmap <silent> <leader>gk :!ginkgo test/integration<CR>
au BufEnter /private/tmp/crontab.* setl backupcopy=yes
