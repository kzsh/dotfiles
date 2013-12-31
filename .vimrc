" The basics
set nocompatible
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set list
set path=.,**,,
set t_Co=256
set incsearch
set hlsearch
set number
set background=dark
set clipboard=unnamed
set backspace=2
set nofoldenable 
set shortmess+=I

filetype off " required!
set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
" Vundle
"Bundle 'https://github.com/gmarik/vundle'
"Bundle 'https://github.com/vim-scripts/L9.git'

"Bundle 'https://github.com/wincent/Command-T.git'
"Bundle 'https://github.com/corntrace/bufexplorer.git'
"Bundle 'https://github.com/scrooloose/nerdtree.git'
"Bundle 'https://github.com/Shougo/neocomplcache.git'
"Bundle 'https://github.com/scrooloose/syntastic.git'
"Bundle 'https://github.com/scrooloose/nerdcommenter.git'
"Bundle 'https://github.com/vim-scripts/ZenCoding.vim.git'
"Bundle 'https://github.com/rson/vim-conque.git'
"Bundle 'https://github.com/majutsushi/tagbar.git'
"Bundle 'https://github.com/airblade/vim-gitgutter.git'

filetype plugin indent on
autocmd FileType * if &completefunc != '' | let &omnifunc=&completefunc | endif
autocmd BufEnter * :syntax sync fromstart

" Pathogen, bundler
call pathogen#infect()
call pathogen#helptags()

" Syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_auto_loclist=1
let g:syntastic_quiet_warnings=0
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

" Command T
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.git,*.svn

" TagBar with JSCTags
"let g:tagbar_type_javascript = {
    "\ 'ctagsbin' : '/usr/local/bin/jsctags'
"\ }


" Disable AutoComplPop. 
"let g:acp_enableAtStartup = 0 
" Use neocomplcache. 
let g:neocomplcache_enable_at_startup = 1 
" Use smartcase. 
let g:neocomplcache_enable_smart_case = 1 
" Use camel case completion. 
let g:neocomplcache_enable_camel_case_completion = 1 
" Use underbar completion. 
let g:neocomplcache_enable_underbar_completion = 1 
" Set minimum syntax keyword length. 
let g:neocomplcache_min_syntax_length = 3 
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*' 

" Define dictionary. 
"let g:neocomplcache_dictionary_filetype_lists = { 
"    \ 'default' : '', 
"    \ 'scheme' : $HOME.'/.gosh_completions' 
"    \ } 

" Define keyword. 
"if !exists('g:neocomplcache_keyword_patterns') 
"    let g:neocomplcache_keyword_patterns = {} 
"endif 
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*' 


" Enable heavy omni completion. 
"if !exists('g:neocomplcache_omni_patterns') 
"let g:neocomplcache_omni_patterns = {} 
"endif 
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::' 
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete 
"let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'



" Plugin key-mappings. 
"imap <C-k>     <Plug>(neocomplcache_snippets_expand) 
"smap <C-k>     <Plug>(neocomplcache_snippets_expand) 
"inoremap <expr><C-g>     neocomplcache#undo_completion() 
"inoremap <expr><C-l>     neocomplcache#complete_common_string() 

" SuperTab like snippets behavior. 
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>" 

" Recommended key-mappings. 
" <CR>: close popup and save indent. 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 
" <TAB>: completion. 
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
" <C-h>, <BS>: close popup and delete backword char. 
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>" 
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>" 
"inoremap <expr><C-y>  neocomplcache#close_popup() 
"inoremap <expr><C-e>  neocomplcache#cancel_popup() 

" AutoComplPop like behavior. 
"let g:neocomplcache_enable_auto_select = 1 

" Shell like behavior(not recommended). 
"set completeopt+=longest 
"let g:neocomplcache_enable_auto_select = 1 
"let g:neocomplcache_disable_auto_complete = 1 
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>" 
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>" 

" Enable omni completion. 
let g:EclimCompletionMethod = 'omnifunc'
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS 
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags 
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete 
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 
autocmd FileType c set omnifunc=ccomplete#Complete

set completeopt=longest,menuone

"
"Status line override (working with Syntastic)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" Ctags // DISABLED
"let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
"let Tlist_WinWidth = 50
"map <F4> :TlistToggle<cr>
"map <F8> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"colorscheme
"colorscheme vividchalk
syntax enable
"if has('gui_running')
"    set background=light
"else
    set background=dark
"endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mkd set filetype=markdown


"set ofu=syntaxcomplete#Complete
"hi SpecialKey ctermfg=240
"hi NonText ctermfg=240
hi SpecialKey term=bold cterm=bold ctermfg=16 guifg=1
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<



" Emmet  (Zen Coding)
let g:user_emmet_mode='a'    "only enable normal mode functions.
let g:user_emmet_expandabbr_key = '<c-y>' 
let g:use_emment_complete_tag = 1
source ~/projects/.vimrc_work

let g:user_emmet_settings = {
  \  'lang' : 'en',
  \  'html' : {
  \    'filters' : 'html',
  \    'indentation' : '  ',
  \    'snippets' : {
  \      'ap' : "data-dojo-attach-point=\"${cursor}\"",
  \      'html' : '<html lang="en">\n<head>\n\t<title></title>\n</head>\n<body>\n</body>\n</html>'
  \    }
  \  },
  \  'css' : {
  \    'filters' : 'fc',
  \    'indentation' : '  ',
  \    'snippets' : {
  \      'border-radius' : "-moz-border-radius: 10px; \n-o-border-radius: 10px; \nborder-radius: 10px;"
  \    },
  \  },
  \  'javascript' : {
  \    'indentation' : '    ',
  \    'snippets' : {
  \      'ap' : "data-dojo-attach-point=\"${cursor}\"",
  \      'require' : "/*global require */\nrequire([${cursor}],function(${child}) {\n\n});",
  \      'define' : "/*global define */\ndefine([\"dojo/_base/declare\"],\nfunction(declare) {\n\treturn declare(\"\",[],{\n\t\t${cursor}${child}\n\t});\n});",
  \      'dijit' : "/*global define */\ndefine([\"dojo/_base/declare\",\n\"dijit/_WidgetBase\",\n\"dijit/_TemplatedMixin\"],\nfunction(declare, _WidgetBase, _TemplatedMixin) {\n\treturn declare([_WidgetBase, _TemplatedMixin],{\n\t\ttemplateString:\n\t\t\t'<div>' +\n\t\t\t'</div>',\n\t\tpostCreate: function() {\n\t\t\tthis.inherited(arguments);\n\t\t\t${cursor}\n\t\t},\n\t\tdestroy: function() {\n\t\t\tthis.destroyRecursive();\n\t\t\tthis.inherited(arguments);\n\t\t}\n\t});\n});",
  \
  \      'udijit' : license+"\n/*global define */\ndefine([\n\t\"dojo/_base/declare\",\n\t\"app/widgets/UReleaseWidget\",\n\t\"dojo/text!app/widgets/templates/MYWIDGITNAMEHERE.html\"\n], function(\n\tdeclare,\n\t_URWidget\n\ttemplate\n) {\n\treturn declare([_URWidget],{\n\t\ttemplateString:template,\n\t\tpostCreate: function() {\n\t\t\tthis.inherited(arguments);\n\t\t\t${cursor}\n\t\t}\n\t});\n});",
  \
  \      'foreach' : "array.forEach(${cursor},function(${child}){\n\n});",
  \      'f' : "function () {\n\t\t\t${cursor}\n\t\t}",
  \      'f,' : "function () {\n\t\t\t${cursor}\n\t\t},",
  \      'on' : "on(${cursor},\"click\", function(){${child}\n\n});",
  \      'then' : "then(function() {\n\t${cursor}\n});",
  \      'c' : "console.log(${cursor});"
  \    },
  \  },
  \ 'java' : {
  \  'indentation' : '    ',
  \  'snippets' : {
  \   'main': "public static void main(String[] args) {\n\t|\n}",
  \   'println': "System.out.println(\"|\");",
  \   'class': "public class | {\n}\n",
  \  },
  \ },
  \}




"Specialized tabs
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype css  setlocal ts=4 sts=4 sw=4
autocmd Filetype tag  setlocal ts=4 sts=4 sw=4
autocmd Filetype xml  setlocal ts=4 sts=4 sw=4
autocmd Filetype jsp  setlocal ts=4 sts=4 sw=4
autocmd Filetype ruby setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
"autocmd VimEnter * NERDTree
":command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78


" ==============================================================================
" = mappings                                                                   =
" ==============================================================================

" ------------------------------------------------------------------------------
" - general_(mappings)                                                         -
" ------------------------------------------------------------------------------


map <F9> <Esc>:NERDTreeToggle<CR>
map <F12> <Esc>:TagbarToggle<CR>
map <S-Tab> <<
" for insert mode
imap <S-Tab> <Esc><<i

" Making it harder not to use VIM bindings
noremap  <Up>    <Nop>
noremap  <Down>  <Nop>
noremap  <Left>  <Nop>
noremap  <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>
inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

" Making it easier to <Esc>
"inoremap jj <Esc>
noremap \gs <Esc>:call GS()<CR>


function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
