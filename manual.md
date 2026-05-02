# Manual de Neovim

Este manual resume los plugins configurados directamente en `nvim/init.lua` y los modulos cargados desde `nvim/lua/plugins`, que hace cada uno, como se usa y que dependencias importantes tiene.

Convenciones:

- `<leader>` es `Space`.
- `<localleader>` es `\`.
- Los atajos pueden aparecer en `which-key`/descripciones de Neovim si presionas `Space` y esperas.
- Para revisar todos los atajos cargados: `:Telescope keymaps`.
- Para revisar plugins instalados/estado: `:Lazy`.

## Comandos de salud y diagnostico

| Comando | Para que sirve |
| --- | --- |
| `:checkhealth` | Healthcheck general de Neovim y plugins. |
| `:checkhealth nvim-treesitter` | Ver parsers, queries y requisitos de Treesitter. |
| `:LspInfo` | Alias configurado para `:checkhealth vim.lsp`. |
| `:Mason` | UI para instalar/ver LSPs, formatters y linters. |
| `:ConformInfo` | Estado de formatters de `conform.nvim`. |
| `:TSResetHighlight` | Reinicia Treesitter en el buffer actual. Util si un archivo queda sin color. |

## Plugin manager

### lazy.nvim

Lazy carga y actualiza plugins.

| Atajo/comando | Accion |
| --- | --- |
| `<leader>ll` | Abrir UI de Lazy. |
| `:Lazy` | Abrir UI de Lazy. |
| `:Lazy sync` | Instalar/actualizar plugins segun config y lockfile. |
| `:Lazy update` | Actualizar plugins. |
| `:Lazy clean` | Limpiar plugins que ya no estan en config. |

## Plugins base en `init.lua`

Estos plugins estan declarados directamente en `nvim/init.lua` porque son simples o porque conviene cargarlos temprano.

### nvim-ts-autotag: `windwp/nvim-ts-autotag`

Renombra y cierra tags usando Treesitter. Declarado en `init.lua` porque se carga temprano en `BufRead`.

Uso:

- En HTML/JSX/TSX/Blade, al cambiar una etiqueta de apertura, actualiza la etiqueta de cierre automaticamente.
- Al escribir `>` puede cerrar tags segun el contexto.

Dependencias:

- Treesitter funcionando para el lenguaje del buffer.

### vim-sleuth: `tpope/vim-sleuth`

Detecta automaticamente `tabstop`, `shiftwidth` y estilo de indentacion segun el archivo/proyecto.

Uso:

- No tiene comandos principales.
- Trabaja solo al abrir archivos.
- Es util cuando saltas entre proyectos con 2 espacios, 4 espacios, tabs, etc.



### gopher.nvim: `olexsmir/gopher.nvim`

Herramientas extra para Go.

Dependencias:

- `nvim-lua/plenary.nvim`.
- Treesitter.
- Servidor Go configurado desde LSP: `gopls`.
- Herramientas instaladas por Mason: `goimports`, `gofumpt`, `golangci-lint`, `delve`.

Comandos utiles:

| Comando | Accion |
| --- | --- |
| `:GoTagAdd json` | Agrega tags `json` a structs. |
| `:GoTagRm json` | Remueve tags `json`. |
| `:GoTestAdd` | Genera test para funcion actual. |
| `:GoTestsAll` | Genera tests para todo el archivo. |
| `:GoMod tidy` | Ejecuta `go mod tidy`. |
| `:GoGet <pkg>` | Instala paquete Go. |

Notas:

- Solo carga en archivos `go`.
- El formateo principal sigue pasando por `conform.nvim`.

## Busqueda y navegacion

### Telescope: `nvim-telescope/telescope.nvim`

Fuzzy finder principal para archivos, texto, buffers, git, LSP y diagnosticos.

Dependencias:

- `nvim-lua/plenary.nvim`: utilidades Lua que Telescope necesita.
- `nvim-telescope/telescope-fzf-native.nvim`: sorter nativo mas rapido, requiere `make`.
- `nvim-telescope/telescope-ui-select.nvim`: usa Telescope para menus `vim.ui.select`.
- `nvim-telescope/telescope-file-browser.nvim`: explorador de archivos dentro de Telescope.
- `nvim-tree/nvim-web-devicons`: iconos.

Atajos globales:

| Atajo | Accion |
| --- | --- |
| `<leader><space>` | Buffers recientes/usados. |
| `<leader>sf` | Buscar archivos. |
| `<leader>fr` | Archivos recientes. |
| `<leader>sg` | Buscar texto en proyecto (`live_grep`). |
| `<leader>sw` | Buscar palabra bajo cursor. |
| `<leader>sb` | Buscar dentro del buffer actual. |
| `<leader>sc` | Historial de comandos. |
| `<leader>sh` | Ayuda de Neovim. |
| `<leader>sk` | Keymaps. |
| `<leader>sm` | Marks. |
| `<leader>sr` | Reanudar ultimo picker. |
| `<leader>gc` | Commits git. |
| `<leader>gs` | Estado git. |
| `<leader>ss` | Simbolos del documento. |
| `<leader>sS` | Simbolos del workspace. |
| `<leader>sd` | Diagnosticos del buffer. |
| `<leader>sD` | Diagnosticos del workspace. |
| `<leader>sE` | File browser. |
| `<leader>se` | File browser en el directorio del archivo actual. |
| `<leader>sn` | Buscar archivos en config de Neovim. |

Dentro de Telescope:

| Atajo | Accion |
| --- | --- |
| `<C-n>` / `<C-j>` | Siguiente resultado. |
| `<C-p>` / `<C-k>` | Resultado anterior. |
| `<CR>` | Abrir seleccionado. |
| `<C-x>` | Abrir en split horizontal. |
| `<C-v>` | Abrir en split vertical. |
| `<C-t>` | Abrir en tab. |
| `<Tab>` / `<S-Tab>` | Marcar/desmarcar multiples resultados. |
| `<C-q>` | Mandar seleccionados a quickfix y abrirlo. |
| `<M-q>` | Mandar todos a quickfix y abrirlo. |
| `<C-u>` / `<C-d>` | Scroll del preview. |
| `?` en normal | Ver keymaps del picker. |

### Flash: `folke/flash.nvim`

Salto rapido visual con labels.

| Atajo | Modo | Accion |
| --- | --- | --- |
| `s` | normal/visual/operator | Jump con labels. |
| `S` | normal/visual/operator | Jump basado en Treesitter. |
| `r` | operator | Remote Flash. |
| `R` | operator/visual | Treesitter search. |
| `<C-s>` | command | Toggle Flash search. |

### Harpoon: `ThePrimeagen/harpoon`

Lista pequena de archivos frecuentes para saltar rapido.

Dependencia:

- `nvim-lua/plenary.nvim`.

| Atajo | Accion |
| --- | --- |
| `<leader>ha` | Agregar archivo actual a Harpoon. |
| `<leader>hh` | Abrir menu de Harpoon. |
| `<leader>1` ... `<leader>5` | Ir al archivo 1..5 de Harpoon. |

### Yazi: `mikavilpas/yazi.nvim`

Integra el file manager `yazi`.

| Atajo | Accion |
| --- | --- |
| `<leader>sy` | Abrir Yazi en el archivo actual. |
| `<leader>sY` | Abrir Yazi en el cwd de Neovim. |

Dentro de Yazi:

| Atajo | Accion |
| --- | --- |
| `<F1>` | Ayuda. |
| `<C-v>` | Abrir en split vertical. |
| `<C-x>` | Abrir en split horizontal. |
| `<C-t>` | Abrir en tab. |
| `<C-s>` | Grep en directorio. |
| `<C-g>` | Replace en directorio. |
| `<Tab>` | Ciclar buffers abiertos. |
| `<C-y>` | Copiar paths relativos. |
| `<C-q>` | Enviar a quickfix. |

## Explorador de archivos

### Oil: `stevearc/oil.nvim`

Explorador editable: los directorios se editan como buffers. Sirve para crear, renombrar, mover y borrar archivos usando operaciones normales de texto.

| Atajo/comando | Accion |
| --- | --- |
| `<leader>e` | Toggle de Oil. |
| `:OilToggle` | Toggle de Oil. |
| `:edit .` | Abre Oil como explorador por defecto. |

Dentro de Oil:

| Atajo | Accion |
| --- | --- |
| `q` / `<Esc>` | Cerrar Oil. |
| `h` | Directorio padre. |
| `l` | Abrir archivo o entrar a directorio. |
| `<C-v>` | Abrir en split vertical. |
| `<C-x>` | Abrir en split horizontal. |

Notas:

- `delete_to_trash = true`: borrar manda a la papelera.
- Muestra archivos ocultos.

## LSP, Mason y diagnosticos

### nvim-lspconfig: `neovim/nvim-lspconfig`

Define servidores LSP y keymaps por buffer cuando un LSP se adjunta.

Dependencias:

- `mason-org/mason.nvim`: instala binarios de LSP/tools.
- `mason-org/mason-lspconfig.nvim`: conecta Mason con `vim.lsp`.
- `WhoIsSethDaniel/mason-tool-installer.nvim`: asegura formatters/linters.
- `nanotee/sqls.nvim`: comandos extra para `sqls`; `sqls` no se autoactiva para archivos sueltos.
- `b0o/schemastore.nvim`: schemas JSON/YAML.
- `folke/lazydev.nvim`: mejora Lua LSP en config de Neovim.
- `blink.cmp`: aporta capabilities de completion al LSP.

Servidores configurados:

| Server | Lenguajes/uso |
| --- | --- |
| `lua_ls` | Lua y config de Neovim. |
| `ts_ls` | JavaScript, TypeScript, TSX. |
| `html` | HTML, templ, Blade. |
| `cssls` | CSS/SCSS/LESS. |
| `tailwindcss` | Tailwind en HTML/CSS/JS/TS/Vue. |
| `jsonls` | JSON con schemastore. |
| `yamlls` | YAML con schemastore. |
| `basedpyright` | Python. |
| `gopls` | Go. |
| `intelephense` | PHP. |
| `astro` | Astro. |
| `sqls` | SQL, solo si se activa/configura con root markers `.sqls.yml`, `.sqls.yaml`, `sqls.yml`, `sqls.yaml`. |

Atajos LSP cuando hay cliente activo:

| Atajo | Accion |
| --- | --- |
| `gd` | Ir a definicion con Telescope. |
| `gr` | Referencias con Telescope. |
| `gI` | Implementaciones. |
| `gD` | Declaracion. |
| `gy` | Type definition. |
| `K` | Hover docs. |
| `gK` | Signature help. |
| `<leader>ca` | Code action. |
| `<leader>rn` | Rename. |
| `<leader>cd` | Diagnostico de linea en float. |
| `[d` / `]d` | Diagnostico anterior/siguiente. |
| `<leader>ds` | Simbolos del documento. |
| `<leader>ws` | Simbolos del workspace. |
| `<leader>wa` | Agregar workspace folder. |
| `<leader>wr` | Remover workspace folder. |
| `<leader>wl` | Listar workspace folders. |
| `<leader>th` | Toggle inlay hints si el server lo soporta. |
| `<leader>co` | Organizar imports en TypeScript (`ts_ls`). |

Comandos LSP:

| Comando | Accion |
| --- | --- |
| `:LspInfo` | Health y clientes activos. |
| `:LspStart [server]` | Habilitar server. |
| `:LspStop [server]` | Detener server activo. |
| `:LspRestart [server]` | Reiniciar server activo. |

### Mason

Abre `:Mason` para instalar y revisar servidores/tools.

Tools aseguradas por config:

- `prettier`
- `stylua`
- `shfmt`
- `ruff`
- `goimports`
- `sqlfluff`
- `taplo`
- `blade-formatter`
- `phpcs`
- `phpcbf`

Comandos utiles:

| Comando | Accion |
| --- | --- |
| `:Mason` | UI de Mason. |
| `:MasonToolsInstall` | Instala tools faltantes. |
| `:MasonToolsUpdate` | Actualiza tools. |
| `:MasonToolsInstallSync` | Igual, bloqueante para headless. |

## Completion e IA

### blink.cmp: `saghen/blink.cmp`

Completion engine principal.

Dependencia:

- `rafamadriz/friendly-snippets`: snippets listos.

Fuentes configuradas:

- `lsp`
- `path`
- `snippets`
- `buffer`

Atajos principales:

| Atajo | Accion |
| --- | --- |
| `<CR>` | Aceptar completion por preset `enter`. |
| `<C-n>` / `<Down>` | Siguiente item. |
| `<C-p>` / `<Up>` | Item anterior. |
| `<C-space>` | Abrir menu o docs. |
| `<C-e>` | Cerrar menu. |
| `<C-k>` | Signature help si esta disponible. |

### Supermaven: `supermaven-inc/supermaven-nvim`

Sugerencias inline tipo copilot.

| Atajo | Accion |
| --- | --- |
| `<Tab>` | Aceptar sugerencia. |
| `<C-j>` | Aceptar una palabra. |
| `<C-]>` | Limpiar sugerencia. |

No corre en `TelescopePrompt`, `gitcommit`, `markdown`, `dotenv`, `env`, `codecompanion`.

### CodeCompanion: `olimorris/CodeCompanion.nvim`

Chat y acciones de IA dentro de Neovim.

Dependencias:

- `nvim-lua/plenary.nvim`
- `nvim-treesitter/nvim-treesitter`
- `nvim-telescope/telescope.nvim`

Adapters configurados:

- `codex` como default para chat.
- `claude_code` como alternativa.

Atajos/comandos:

| Atajo/comando | Modo | Accion |
| --- | --- | --- |
| `<leader>aa` | normal/visual | Abrir palette de acciones AI. |
| `<leader>ac` | normal/visual | Toggle chat AI. |
| `<leader>an` | normal/visual | Nuevo chat AI. |
| `ga` | visual | Agregar seleccion al chat. |
| `<leader>ab` | normal | Agregar buffer actual al chat. |
| `:CodeCompanion` | command | Comando base. |
| `:CodeCompanionChat` | command | Chat. |
| `:CodeCompanionActions` | command | Acciones. |
| `:CodeCompanionCmd` | command | Command mode. |
| `:AIAdapter [codex|claude_code]` | command | Cambiar adapter del chat. |

## Treesitter y syntax

### nvim-treesitter: `neovim-treesitter/nvim-treesitter`

Syntax highlighting, indent, folds, injections y soporte estructural por lenguaje.

Dependencias:

- `neovim-treesitter/treesitter-parser-registry`: registry nuevo de parsers/queries.
- `nvim-treesitter/nvim-treesitter-textobjects`: textobjects y movimientos por estructura.

Comandos utiles:

| Comando | Accion |
| --- | --- |
| `:checkhealth nvim-treesitter` | Ver parsers/queries instalados. |
| `:TSInstall lang` | Instalar parser/query. |
| `:TSUpdate` | Actualizar parsers/queries. |
| `:TSUpdate!` | Actualizar ignorando cache. |
| `:TSResetHighlight` | Reiniciar highlighting en buffer actual. |
| `:Inspect` | Ver highlights/captures bajo el cursor. |
| `:InspectTree` | Ver arbol Treesitter. |

Lenguajes configurados incluyen:

`blade`, `bash`, `c`, `css`, `diff`, `dockerfile`, `ecma`, `go`, `html`, `javascript`, `jsx`, `json`, `lua`, `markdown`, `php`, `python`, `sql`, `toml`, `tsx`, `typescript`, `vim`, `yaml`, entre otros.

Nota TSX:

- Se fuerza una query combinada para TSX usando `ecma + jsx + typescript + tsx` al iniciar Neovim.
- Esto corrige que el highlighting de TSX quede en blanco por el bug de herencia de queries en el fork `neovim-treesitter`.
- Si haces `:TSUpdate`, corre `:TSResetHighlight` en un buffer `.tsx` para reaplicar el fix.

Textobjects/movimiento:

| Atajo | Modo | Accion |
| --- | --- | --- |
| `]f` | normal/visual/operator | Siguiente inicio de funcion. |
| `]F` | normal/visual/operator | Siguiente fin de funcion. |
| `[f` | normal/visual/operator | Anterior inicio de funcion. |
| `[F` | normal/visual/operator | Anterior fin de funcion. |
| `]c` | normal/visual/operator | Siguiente clase. |
| `]C` | normal/visual/operator | Siguiente fin de clase. |
| `[c` | normal/visual/operator | Clase anterior. |
| `[C` | normal/visual/operator | Fin de clase anterior. |

## Formato y lint

### Conform: `stevearc/conform.nvim`

Formato automatico en save y manual.

| Atajo/comando | Accion |
| --- | --- |
| `<leader>cf` | Formatear buffer/rango. |
| `<leader>cF` | Formatear buffer/rango. |
| `:Format` | Formatear buffer o rango. |
| `:FormatDisable` | Desactivar autoformat global. |
| `:FormatDisable!` | Desactivar autoformat solo en buffer actual. |
| `:FormatEnable` | Reactivar autoformat. |
| `:ConformInfo` | Ver estado de formatters. |

Formatters por lenguaje:

| Filetype | Formatter |
| --- | --- |
| Lua | `stylua` |
| Shell | `shfmt` / `fish_indent` |
| Web/JS/TS/JSON/YAML/Markdown | `prettier` |
| TOML | `taplo` |
| Python | `ruff_format`, `ruff_organize_imports` |
| Go | `goimports`, `gofmt` |
| Rust | `rustfmt` |
| PHP | `pint`, fallback `phpcbf` |
| Blade | `blade-formatter` |
| SQL | `sqlfluff` |
| C/C++ | `clang_format` |

Autoformat esta desactivado para `sql` y `java`.

### nvim-lint: `mfussenegger/nvim-lint`

Linting en `BufEnter`, `BufWritePost` e `InsertLeave`.

Linters:

| Filetype | Linter |
| --- | --- |
| `fish` | `fish` |
| `javascript` / `typescript` / `typescriptreact` | `eslint`, solo si hay config ESLint/package. |
| `json` | `eslint` |
| `php` | `phpcs` |

### ts-error-translator: `dmmulroy/ts-error-translator.nvim`

Traduce/mejora diagnosticos de TypeScript para que sean mas legibles.

Se carga en:

- `typescript`
- `typescriptreact`
- `javascript`
- `javascriptreact`

Servers:

- `astro`
- `svelte`
- `ts_ls`
- `tsserver`
- `typescript-tools`
- `volar`
- `vtsls`

## Git

### Gitsigns: `lewis6991/gitsigns.nvim`

Muestra cambios Git en el gutter y acciones por hunk.

| Atajo | Modo | Accion |
| --- | --- | --- |
| `]c` | normal | Siguiente hunk. |
| `[c` | normal | Hunk anterior. |
| `<leader>hs` | normal/visual | Stage hunk actual/seleccionado. |
| `<leader>hr` | normal/visual | Reset hunk actual/seleccionado. |
| `<leader>hS` | normal | Stage buffer completo. |
| `<leader>hR` | normal | Reset buffer completo. |
| `<leader>hp` | normal | Preview hunk. |
| `<leader>hi` | normal | Preview inline. |
| `<leader>hb` | normal | Blame de linea. |
| `<leader>hd` | normal | Diff contra index. |
| `<leader>hD` | normal | Diff contra ultimo commit. |
| `<leader>tb` | normal | Toggle blame inline. |
| `<leader>tw` | normal | Toggle word diff. |
| `ih` | operator/visual | Textobject de hunk. |

## UI y mensajes

### Noice: `folke/noice.nvim`

Mejora mensajes, command line, notificaciones y popups LSP.

Dependencias:

- `MunifTanjim/nui.nvim`: UI components.
- `rcarriga/nvim-notify`: backend de notificaciones.

| Atajo | Modo | Accion |
| --- | --- | --- |
| `<S-Enter>` | command | Redirigir command line a Noice. |
| `<leader>snl` | normal | Ultimo mensaje. |
| `<leader>snh` | normal | Historial de mensajes. |
| `<leader>sna` | normal | Todos los mensajes. |
| `<C-f>` | insert/normal/select | Scroll adelante en docs LSP/Noice. |
| `<C-b>` | insert/normal/select | Scroll atras en docs LSP/Noice. |

### nvim-notify: `rcarriga/nvim-notify`

Notificaciones flotantes.

| Atajo | Accion |
| --- | --- |
| `<leader>un` | Cerrar notificaciones pendientes/visibles. |

### lualine: `nvim-lualine/lualine.nvim`

Statusline con tema Dracula Pro:

- modo
- branch
- diff
- diagnosticos
- filename
- filetype
- progreso
- linea/columna

Dependencia:

- `nvim-tree/nvim-web-devicons`.

### alpha-nvim: `goolord/alpha-nvim`

Dashboard inicial con accesos:

| Tecla en dashboard | Accion |
| --- | --- |
| `e` | Nuevo archivo. |
| `f` | Buscar archivo con Telescope. |
| `r` | Archivos recientes. |
| `s` | Abrir settings/init. |
| `q` | Salir de Neovim. |

Dependencia:

- `nvim-tree/nvim-web-devicons`.

### Dracula Pro local

Tema local:

- plugin id: `dracula_pro`
- path: `~/.config/nvim/dracula_pro`
- colorscheme: `dracula_pro_van_helsing`

## Markdown

### render-markdown: `MeanderingProgrammer/render-markdown.nvim`

Render visual de Markdown dentro de Neovim.

Dependencias:

- `nvim-treesitter/nvim-treesitter`
- `nvim-tree/nvim-web-devicons`

| Atajo/comando | Accion |
| --- | --- |
| `<leader>tm` | Toggle render markdown. |
| `:RenderMarkdown toggle` | Toggle render markdown. |

Features configuradas:

- headings con iconos/colores
- code blocks con fondo
- bullets y checkboxes visuales
- links con iconos
- horizontal rules
- quotes
- pipe tables
- callouts `NOTE`, `TIP`, `IMPORTANT`, `WARNING`, `CAUTION`
- LaTeX desactivado para evitar warnings si no hay parser/tools LaTeX

## Mini.nvim

### mini.nvim: `echasnovski/mini.nvim`

Coleccion de modulos pequenos.

Modulos usados:

| Modulo | Para que sirve |
| --- | --- |
| `mini.icons` | Iconos; mockea `nvim-web-devicons` para compatibilidad. |
| `mini.ai` | Textobjects inteligentes. |
| `mini.surround` | Agregar, borrar y reemplazar surrounding. |
| `mini.pairs` | Auto-cierre de pares. |
| `mini.comment` | Comentarios. |
| `mini.bufremove` | Borrar buffers sin cerrar ventanas. |
| `mini.indentscope` | Guia visual del scope de indentacion. |

Dependencia:

- `JoosepAlviste/nvim-ts-context-commentstring`: comentario correcto en JSX/TSX/HTML embebido.

Atajos importantes:

| Atajo | Accion |
| --- | --- |
| `gcc` | Toggle comentario de linea. |
| `gc` | Toggle comentario en visual/operator. |
| `gcap` | Comentar parrafo. |
| `sa` | Agregar surround. |
| `sd` | Borrar surround. |
| `sr` | Reemplazar surround. |
| `sf` / `sF` | Buscar surround derecha/izquierda. |
| `sh` | Highlight surround. |
| `sn` | Actualizar lineas usadas por surround. |
| `<leader>bd` | Borrar buffer sin cerrar ventana. |
| `<leader>bD` | Borrar buffer forzado. |

Ejemplos:

| Ejemplo | Resultado |
| --- | --- |
| `saiw)` | Rodear palabra con parentesis. |
| `sd'` | Quitar comillas simples. |
| `sr)'` | Cambiar parentesis por comillas simples. |
| `va)` | Seleccionar alrededor de parentesis con `mini.ai`. |
| `ci'` | Cambiar dentro de comillas simples. |

## Folding

### nvim-ufo: `kevinhwang91/nvim-ufo`

Folds modernos usando Treesitter e indent.

Dependencia:

- `kevinhwang91/promise-async`

Configuracion:

- `foldcolumn = 1`
- `foldlevel = 99`
- provider selector: `{ "treesitter", "indent" }`

Atajos de fold son los nativos de Vim/Neovim:

| Atajo | Accion |
| --- | --- |
| `za` | Toggle fold bajo cursor. |
| `zR` | Abrir todos los folds. |
| `zM` | Cerrar todos los folds. |
| `zo` / `zc` | Abrir/cerrar fold. |

## TODO comments

### todo-comments: `folke/todo-comments.nvim`

Detecta y navega comentarios como `TODO`, `FIX`, `FIXME`.

| Atajo/comando | Accion |
| --- | --- |
| `]t` | Siguiente TODO. |
| `[t` | TODO anterior. |
| `<leader>xt` | Ver TODOs en Trouble. |
| `<leader>xT` | Ver TODO/FIX/FIXME en Trouble. |
| `<leader>st` | Buscar TODOs con Telescope. |
| `<leader>sT` | Buscar TODO/FIX/FIXME con Telescope. |
| `:TodoTrouble` | TODOs en Trouble. |
| `:TodoTelescope` | TODOs en Telescope. |

## Trouble y listas

### Trouble: `folke/trouble.nvim`

Vista organizada para diagnosticos, simbolos, quickfix/location list y resultados LSP.

| Atajo/comando | Accion |
| --- | --- |
| `<leader>xx` | Diagnosticos del workspace. |
| `<leader>xX` | Diagnosticos del buffer. |
| `<leader>cs` | Simbolos del documento. |
| `<leader>cl` | LSP definitions/references/etc a la derecha. |
| `<leader>xL` | Location list. |
| `<leader>xQ` | Quickfix list. |
| `:Trouble diagnostics toggle` | Toggle diagnosticos. |
| `:Trouble symbols toggle focus=false` | Toggle simbolos. |
| `:Trouble lsp toggle focus=false win.position=right` | Toggle resultados LSP. |

## Comandos base utiles de la config

Estos no son todos plugins, pero ayudan a usar la configuracion:

| Atajo | Accion |
| --- | --- |
| `<Esc>` | Quitar highlight de busqueda. |
| `<C-s>` | Guardar archivo. |
| `<C-h/j/k/l>` | Moverse entre ventanas. |
| `<S-h>` / `<S-l>` | Buffer anterior/siguiente. |
| `[b` / `]b` | Buffer anterior/siguiente. |
| `<leader>bb` | Alternar al buffer anterior. |
| `<leader><leader>` | Alternar al buffer anterior. |
| `<leader>fn` | Nuevo archivo. |
| `<leader>xl` | Abrir location list. |
| `<leader>xq` | Abrir quickfix. |
| `[q` / `]q` | Quickfix anterior/siguiente. |
| `<leader>qq` | Salir de todo. |
| `<leader>w-` / `<leader>-` | Split horizontal. |
| `<leader>w|` / `<leader>|` | Split vertical. |
| `<leader>wd` | Cerrar ventana. |
| `<leader>ww` | Volver a otra ventana. |
| `<leader><tab><tab>` | Nuevo tab. |
| `<leader><tab>d` | Cerrar tab. |
| `<C-]>` / `<C-[>` | Tab siguiente/anterior. |
| `<leader>ts` | Toggle spell check. |

## Flujo recomendado

### Buscar y abrir archivos

1. `<leader>sf` para buscar archivo.
2. `<leader>sg` para buscar texto.
3. `<leader><space>` para volver a buffers usados.
4. `<leader>e` si quieres editar filesystem con Oil.

### Revisar errores

1. `<leader>sd` para diagnosticos del buffer.
2. `<leader>sD` para diagnosticos del workspace.
3. `<leader>xx` para Trouble.
4. `]d` / `[d` para navegar diagnosticos.
5. `K` para hover del error bajo cursor.

### Trabajar con codigo

1. `gd`, `gr`, `gI`, `gy` para navegar con LSP.
2. `<leader>ca` para code actions.
3. `<leader>rn` para rename.
4. `<leader>cf` para formatear.
5. `<leader>co` en TypeScript para organizar imports.

### Git rapido

1. `]c` / `[c` para navegar cambios.
2. `<leader>hp` para preview.
3. `<leader>hs` para stage hunk.
4. `<leader>hr` para reset hunk.
5. `<leader>gs` para estado Git en Telescope.

### IA

1. `<leader>ac` para abrir/cerrar chat.
2. En visual, selecciona codigo y usa `ga` para mandarlo al chat.
3. `<leader>aa` para palette de acciones.
4. `:AIAdapter codex` o `:AIAdapter claude_code` para cambiar adapter.

## Archivos principales

| Archivo | Contenido |
| --- | --- |
| `nvim/lua/plugins/telescope.lua` | Busqueda y file browser. |
| `nvim/lua/plugins/lsp.lua` | LSP, Mason, servers, comandos LSP. |
| `nvim/lua/plugins/treesitter.lua` | Parsers, highlighting, textobjects. |
| `nvim/lua/plugins/formatter.lua` | Conform y formatters. |
| `nvim/lua/plugins/linter.lua` | nvim-lint. |
| `nvim/lua/plugins/extras.lua` | Noice, notify, Trouble, UFO, TODO, Flash, Harpoon. |
| `nvim/lua/plugins/mini.lua` | Mini modules. |
| `nvim/lua/plugins/gitsigns.lua` | Git hunks. |
| `nvim/lua/plugins/file_exp.lua` | Oil. |
| `nvim/lua/plugins/codecompanion.lua` | AI chat/actions. |
| `nvim/lua/plugins/markdown.lua` | Render Markdown. |
| `nvim/lua/plugins/yazi.lua` | Yazi. |
| `nvim/lua/plugins/statusline.lua` | Lualine. |
| `nvim/lua/plugins/theme.lua` | Dracula Pro. |
