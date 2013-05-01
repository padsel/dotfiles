" proft gvim config [http://proft.me]

"colorscheme rdark
colorscheme lilypink

" font for gvim
set guifont=Courier\ New\ 17

set guioptions-=T
set guioptions-=m
" set lines=30
" set columns=105
set lines=42
set columns=130

" normal work backspace
set backspace=indent,eol,start whichwrap+=<,>,[,]
inoremap <C-BS> <ESC>cb
inoremap <C-Del> <ESC>cw

" Always keep 2 lines on the top and bottom of the screen
set scrolloff=2

" fullscreen
set guioptions-=e
set guioptions-=r
set guioptions-=R
set guioptions-=b
set guioptions-=l
set guioptions-=L

function ToggleFullScreen()
    exec('silent !wmctrl -r :ACTIVE: -b toggle,fullscreen')
endfunction

nmap <F11> :call ToggleFullScreen()<CR>

function FixCursor()
    exec('highlight iCursor guifg=white guibg=orange')
endfunction

nmap ,f :call FixCursor()<CR>

" m$ ���������
source $VIMRUNTIME/mswin.vim

" increment
nnoremap <C-S-A> <C-A>

" spelling
" setlocal spell spelllang=ru,en

imap <F8> <Esc>:set spell!<CR><Esc>:setlocal spell spelllang=ru,en<CR>
nmap <F8> :set spell!<CR>:setlocal spell spelllang=ru,en<CR>

map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" autocmd FileType human,text set spell spelllang=ru,en

" change color of cursor
highlight iCursor guifg=white guibg=orange
set guicursor+=i:ver10-iCursor

" ���� ������ ��� ������������ ���������
"set langmap=�q,�w,�e,�r,�t,�y,�u,�i,�o,�p,�a,�s,�d,�f,�g,�h,�j,�k,�l,�z,�x,�c,�v,�b,�n,�m,�',�Q,�W,�E,�R,�T,�Y,�U,�I,�O,�P,�\{,�\},�A,�S,�D,�F,�G,�H,�J,�K,�L,�\:,�\",�Z,�X,�C,�V,�B,�N,�M
"set langmap=�q,�w,�e,�r,�t,�y,�u,�i,�o,�p,�a,�s,�d,�f,�g,�h,�j,�k,�l,�',�z,�x,�c,�v,�b,�n,�m,�\,,�.,�',�Q,�W,�E,�R,�T,�Y,�U,�I,�O,�P,�\{,�\},�A,�S,�D,�F,�G,�H,�J,�K,�L,�\:,�\",�Z,�X,�C,�V,�B,�N,�M,�\<,�\>

" ������������� ��������� ����������, ���������� ������� ���������
set iskeyword=@,48-57,_,192-255

" ���������� shift-insert �������� ��� � Xterm
"map <S-Insert> <MiddleMouse>

" tidy html
vnoremap <Leader>T :!tidy -q -i -xml<CR>

" for python
let python_highlight_all = 1
let python_highlight_space_errors = 0
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType python set cc=80
autocmd FileType python iab pdb import ipdb; ipdb.set_trace() 
autocmd FileType python iab u8 # -*- coding: utf-8 -*-
au Filetype htmldjango inoremap <buffer> <c-g> {{<space><space>}}<left><left><left>
au Filetype htmldjango inoremap <buffer> <c-h> {%<space><space>%}<left><left><left>
au Filetype htmldjango inoremap <buffer> <c-f> {{<space>MEDIA_URL<space>}}
au Filetype htmldjango let b:surround_{char2nr("v")} = "{{ \r }}"
au Filetype htmldjango let b:surround_{char2nr("{")} = "{{ \r }}"
au Filetype htmldjango let b:surround_{char2nr("%")} = "{% \r %}"
au Filetype htmldjango let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
au Filetype htmldjango let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
au Filetype htmldjango let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
au Filetype htmldjango let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
au Filetype htmldjango let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

" for django 
let g:last_relative_dir = ''
nnoremap \1 :call RelatedFile ("models.py")<cr>
nnoremap \2 :call RelatedFile ("views.py")<cr>
nnoremap \3 :call RelatedFile ("urls.py")<cr>
nnoremap \4 :call RelatedFile ("admin.py")<cr>
nnoremap \5 :call RelatedFile ("tests.py")<cr>
nnoremap \6 :call RelatedFile ( "templates/" )<cr>
nnoremap \7 :call RelatedFile ( "templatetags/" )<cr>
nnoremap \8 :call RelatedFile ( "management/" )<cr>
nnoremap \0 :e settings.py<cr>
nnoremap \9 :e urls.py<cr>

fun! RelatedFile(file)
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        exec "edit %:h/" . a:file
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
    if g:last_relative_dir != ''
        exec "edit " . g:last_relative_dir . a:file
        return ''
    endif
    echo "Cant determine where relative file is : " . a:file
    return ''
endfun

fun SetAppDir()
    if filereadable(expand("%:h"). '/models.py') || isdirectory(expand("%:h") . "/templatetags/")
        let g:last_relative_dir = expand("%:h") . '/'
        return ''
    endif
endfun
autocmd BufEnter *.py call SetAppDir()

" for markdown
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} set filetype=markdown
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} let g:surround_{char2nr("c")} = "<pre class=\"prettyprint\">\r</pre>" 
autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*} let g:surround_{char2nr("h")} = "<h3 class=\"lb\">\r</h3>" 
" autocmd BufNewFile * silent! 0r ~/.vim/skel/tpl.%:e

" for html
autocmd BufNewFile,BufRead *.{html} let g:surround_{char2nr("c")} = "<pre class=\"prettyprint\">\r</pre>" 
autocmd BufNewFile,BufRead *.{html} let g:surround_{char2nr("h")} = "<b class=\"lb\">\r</b>" 

" for javascript
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType css set smartindent

" load template
function! LoadTemplate()
    silent! 0r ~/.vim/skel/tpl.%:e
    syn match Todo "%\u\+%" containedIn=ALL
endfunction
autocmd! BufNewFile * call LoadTemplate()
nnoremap <c-p> /%\u.\{-1,}%<cr>c/%/e<cr>
" inoremap <c-p> <ESC>/%\u.\{-1,}%<cr>c/%/e<cr>

" [TABS]

" tab navigation like firefox
nmap <S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
nmap <C-t> :tabnew<cr>
map <S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
map <C-E> :tabclose<cr>
imap <S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
imap <C-t> <ESC>:tabnew<cr> 
imap <C-E> <ESC>:tabclose<cr>
map ,tl :call MoveTabLeft()<CR>
map ,tr :call MoveTabRight()<CR>

function MoveTabLeft()
   let current_tab = tabpagenr()
   if current_tab > 1
       let current_tab = current_tab - 2
       execute 'tabmove' current_tab
    endif
endfunction

function MoveTabRight()
    let current_tab = tabpagenr()
    execute 'tabmove' current_tab
endfunction

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor

  " Append the tab number
  let label .= v:lnum.': '

  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name

  " Append the number of windows in the tab page
  " let wincount = tabpagewinnr(v:lnum, '$')
  " return label . '  [' . wincount . ']'
  return label
endfunction

set guitablabel=%{GuiTabLabel()}
" set tablabel=

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= '%{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let label = fnamemodify(bufname(buflist[winnr - 1]), ':t')

    if label == ''
        if &buftype == 'quickfix'
          let label = '[Quickfix List]'
        else
          let label = 'NoName'
        endif
    endif

    if getbufvar(buflist[winnr - 1], "&modified")
        let label = "+".label
    endif

    let label = a:n.":".label

    return label
endfunction

set tabline=%!MyTabLine()

" [PLUGINS]

" *** mru ***
"nmap <F3> :MRU<cr>
"let MRU_Max_Entries = 30

" *** nerd tree ***
autocmd BufEnter * lcd %:p:h
"if exists("loaded_nerd_tree")
"    function ShowNerdTreeToggle()
"        :execute 'NERDTreeToggle'
        "set columns=140
"    endfunction

"    nmap <F3> :call ShowNerdTreeToggle()<CR>
    "nmap <F3> :NERDTreeToggle<CR>
"endif
map <F6> <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup = 0

" *** sessionman ***
if exists("loaded_sessionman")
    nmap ,ss :SessionSave<CR>
    nmap ,so :SessionOpen
    nmap ,sc :SessionClose<CR>
endif

" *** fuzzyfinder ***
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 400
let g:fuf_mrucmd_maxItem = 400
let g:fuf_coveragefile_globPatterns = ['**/*.py', '**/*.html', '**/*.css', '**/*.js']
nnoremap <silent> sf :FufFile<CR>
nnoremap <silent> sd :FufDir<CR>
nnoremap <silent> sb :FufBuffer<CR>
nnoremap <silent> <leader>2 :FufFile ~/Dropbox/tabs/<CR>
nnoremap <silent> <leader>3 :FufFile ~/Dropbox/blog/<CR>
nnoremap <silent> <leader>1 :FufFile ~/Dropbox/blog/0force/<CR>
nnoremap <silent> <leader>h :FufFile ~/<CR>
nnoremap <silent> <leader>n :FufFile ~/Dropbox/notes/<CR>
nnoremap <silent> sc :FufCoverageFile<CR>

" *** tcomment ***
inoremap <leader>c <Esc>:TComment<CR>
nnoremap <leader>c :TComment<CR>
vnoremap <leader>c :TComment<CR>

" *** rope ***
let ropevim_vim_completion=1
function! TabWrapperRope()
  if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-R>=RopeCodeAssistInsertMode()\<CR>"
  endif
endfunction
inoremap <C-Tab> <C-R>=RopeCodeAssistInsertMode()<CR>

" *** rainbow_parenthsis ***
nnoremap <leader>R :call rainbow_parentheses#Toggle()<CR>

" *** vim-ack ***
nnoremap <leader>a :Ack

" *** tagbar ***
" let g:tagbar_left = 1
"let g:tagbar_autoclose = 1
"nmap <F6> :TagbarToggle<CR>



" *** scratch ***
nmap <leader><tab> :Sscratch<cr><C-W>x<C-j>:resize 10<cr>

" *** pyflakes ***
nmap <leader>e :cc<cr>
let g:pyflakes_use_quickfix = 0

" *** pep8 ***
let g:pep8_map='<leader>8'

" *** supertab ***
let g:SuperTabDefaultCompletionType="context"
set completeopt=menuone,longest,preview

" *** gundo ***
map <leader>g :GundoToggle<CR>

" *** indentline ***
hi Conceal guifg=#404040 guibg=NONE

" *** local config
let gv_local = expand('~/.gvim.local')
if filereadable(gv_local)
    exec ':so ' . gv_local
endif

" *** python-klen
let g:pymode_lint_ignore = "E401,E501"
let g:pymode_options = 0
let g:pymode_lint_write = 0 " off check on save 
let g:pymode_folding = 0 " off folding
let g:pymode_rope_vim_completion = 0 " off rope autocompletion

"create line break when pressing enter
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
