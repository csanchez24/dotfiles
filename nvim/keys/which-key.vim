" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['/']  =  [ ':Commentary'                , 'comment' ]
let g:which_key_map['_']  =  [ '<C-W>s'                     , 'split below']
let g:which_key_map['|']  =  [ '<C-W>v'                     , 'split right']
let g:which_key_map['=']  =  [ '<C-W>='                     , 'balance windows' ]
let g:which_key_map['.']  =  [ ':e $MYVIMRC'                , 'open init' ]
let g:which_key_map[';']  =  [ ':Commands'                  , 'commands' ]
let g:which_key_map[',']  =  [ 'Startify'                   , 'start screen' ]
let g:which_key_map['e']  =  [ ':CocCommand explorer'       , 'explorer' ]
let g:which_key_map['f']  =  [ ':Files'                     , 'search files' ]
let g:which_key_map['t']  =  [ ':Rg'                        , 'search text' ]
let g:which_key_map['l']  =  [ ':BLines'                    , 'search lines in current buffer' ]
let g:which_key_map['b']  =  [ ':Buffers'                   , 'search in buffers' ]
let g:which_key_map['r']  =  [ ':RnvimrToggle'              , 'ranger' ]
let g:which_key_map['w']  =  [ ':w'                         , 'write' ]
let g:which_key_map['q']  =  [ ':q'                         , 'quit' ]
let g:which_key_map['wq'] =  [ ':wq'                        , 'write and quit' ]

" Hide some of the key automatically mapped by some of the plugins
let g:which_key_map['*']  =  'which_key_ignore'

" Group mappings

" A is for actions
let g:which_key_map.A = {
      \ 'name' : '+actions' ,
      \ 'e' : [':CocCommand explorer'         , 'explorer'],
      \ 'n' : [':set nonumber!'               , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'       , 'relative line nums'],
      \ 'v' : [':Vista!!'                     , 'tag viewer'],
      \ }

" B is for buffer
let g:which_key_map.B = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'd' : ['bd'        , 'delete-buffer']   ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'h' : ['Startify'  , 'home-buffer']     ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'n' : ['bnext'     , 'next-buffer']     ,
      \ 'p' : ['bprevious' , 'previous-buffer'] ,
      \ '?' : ['Buffers'   , 'fzf-buffer']      ,
      \ }

" S is for search
let g:which_key_map.S = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

" G is for git
let g:which_key_map.G = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'A' : [':Git add %'                        , 'add current'],
      \ 'b' : [':Gblame'                           , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'c' : [':Gcommit'                          , 'commit'],
      \ 'd' : [':Gdiffsplit'                       , 'diff'],
      \ 'D' : [':Gvdiffsplit'                      , 'vertical diff split'],
      \ 'g' : [':Gstatus'                          , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
      \ 'l' : [':Glog'                             , 'log'],
      \ 'p' : [':Gpush'                            , 'push'],
      \ 'P' : [':Gpull'                            , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 's' : ['Gstatus'                           , 'git status'],
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }

" L is for language server protocol
let g:which_key_map.L = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'v' : [':Vista!!'                            , 'tag viewer'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")


