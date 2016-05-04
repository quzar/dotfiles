" For Unix and Win32, if a directory ends in two path separators, the swap
" file name will be built from the complete path to the file with all path
" separators substituted to percent '%' signs. This will ensure file name
" uniqueness in the preserve directory.

" Change to file directory
if exists('&autochdir')
  set autochdir
endif

" Set background to dark 
set background=dark

" Set syntax on
syntax on

" Grow to maximum horizontal size on entering fullscreen mode
if has("gui_running")
  set fuopt+=maxhorz
endif

" Turn on line numbers
if has("gui_running")
  set number
  set numberwidth=5
  colorscheme slate
endif

" Convert tabs to spaces
set expandtab
set tabstop=4

" Turn off automatic word wrapping
set tw=0

" Execute selected python code
vnoremap <F5> :!python<CR>

" Set tags directories
set tags=../../tags,../tags,tags,tags

" Open tag under cursor in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Toggle line numbers and fold column for easy copying
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" Proper indentation and formatting
filetype plugin indent on
autocmd FileType python set complete+=k~/.vim/syntax/python.vim

" Execute file being edited with <Shift> + e
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" Taglist variables ==========================================
" Display function name in status bar
let g:ctags_statusline=1

" Automatically start script
let generate_tags=1

" Displays taglist results in a vertical window:
let Tlist_Use_Horiz_Window=0

" Shorter commands to toggle Taglist display
nnoremap TT :TlistToggle<CR>
map <F4> :TlistToggle<CR>

" Various Taglist diplay config:
let Tlist_Use_Right_Window = 1
let Tlist_Compact_Format = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_File_Fold_Auto_Close = 1

" Pretty XML =================================================
function! DoPrettyXML()
  silent %!xmllint --format -
endfunction

command! XmlLint call DoPrettyXML()
command! XmlTidy call DoPrettyXML()
command! PrettyXML call DoPrettyXML()
command! DoPrettyXML call DoPrettyXML()
command! DoPrettyXml call DoPrettyXML()

" Toggle Comment =============================================
autocmd FileType c,cpp,java      let b:comment_leader = '\/\/'
autocmd FileType javascript      let b:comment_leader = '\/\/'
autocmd FileType sh,ruby,python  let b:comment_leader = '#'
autocmd FileType conf,fstab      let b:comment_leader = '#'
autocmd FileType matlab,tex      let b:comment_leader = '%'
autocmd FileType vim             let b:comment_leader = '"'

function! ToggleComment()
" help with :h \v or pattern-atoms
  if exists('b:comment_leader')
    if getline('.') =~ '\v^\s*' .b:comment_leader
      " uncomment the line
      execute 'silent s/\v^\s*\zs' .b:comment_leader.'[ ]?//g'
    else
      " comment the line
      execute 'silent s/\v^\s*\zs\ze(\S|\n)/' .b:comment_leader.' /g'
    endif
  else
    echo 'no comment leader found for filetype'
  end
endfunction

nnoremap <leader>c :call ToggleComment()<cr>

execute pathogen#infect()

