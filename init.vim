set nobackup

set shell=/bin/zsh

inoremap fd <ESC>

syntax on
let g:airline_powerline_fonts=1
set linespace=1
set scrolloff=10
set number

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

set completeopt="menuone"


call plug#begin('~/.config/nvim/plugged')

function! BuildDeoplete(info)
    if a:info.status != 'unchanged' || a:info.force
        normal UpdateRemotePlugins
    endif
endfunction

Plug 'tpope/vim-sensible'
Plug 'rking/ag.vim'
Plug 'Shougo/unite.vim'
Plug 'w0ng/vim-hybrid'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'

Plug 'Shougo/vimproc.vim'
Plug 'Shougo/deoplete.nvim', {'do': function('BuildDeoplete')}

Plug 'benekastah/neomake'

Plug 'zchee/deoplete-jedi'

Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }

Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'fatih/vim-go'
Plug 'zchee/deoplete-go', {'do': 'make'}

Plug 'jimenezrick/vimerl'

Plug 'vim-ruby/vim-ruby'

Plug 'guns/vim-clojure-static'
Plug 'vim-scripts/paredit.vim'

Plug 'pangloss/vim-javascript'
Plug 'carlitux/deoplete-ternjs'

Plug 'kchmck/vim-coffee-script'

call plug#end()


set background=dark
colorscheme hybrid

""" okay, finished bundling
filetype plugin indent on

""" deoplete

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#mappings#close_popup() . "\<CR>"
endfunction

imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#mappings#manual_complete())
inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"


""" ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
map <c-b> :CtrlPBuffer<CR>

""" rust
let g:rustfmt_autosave = 1
let g:racer_cmd = "/Users/aaron/Devel/source-repos/racer/target/release/racer"
let $RUST_SRC_PATH="/Users/aaron/Devel/source-repos/rust/src"

""" golang
let g:go_fmt_command = "goimports"

""" haskell
let g:haddock_browser = "open"
let g:haddock_browser_callformat = "%s %s"
let g:haddock_docdir="/usr/local/share/doc/ghc/html/"
let g:haskellmode_completion_ghc = 0
let g:ghc = "stack ghc"
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

""" neomake
autocmd! BufWritePost,BufEnter * Neomake

""" Unite
nnoremap <c-t> :Unite -start-insert file_rec/async<cr>
nnoremap <c-p> :Unite -start-insert file_rec/async<cr>
nnoremap <c-b> :Unite -no-start-insert buffer<cr>
nnoremap <c-g> :Unite grep:.<cr>
