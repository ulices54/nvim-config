# Configuración de Neovim 0.12

Configuración personal de Neovim **0.12** escrita en Lua. Usa el gestor de plugins nativo **`vim.pack`** (sin lazy.nvim) y la nueva interfaz de mensajes `ui2`.

El colorscheme es [nvim-dark-ide](https://github.com/ulices54/nvim-dark-ide.nvim), basado en el tema *Dark 2026* de VS Code.

## Requisitos

| Requisito | Uso |
| --- | --- |
| [Neovim](https://github.com/neovim/neovim/releases) **>= 0.12** | `vim.pack` y `ui2` solo existen a partir de esta versión |
| `git` | `vim.pack` clona los plugins con git |
| Una [Nerd Font](https://www.nerdfonts.com/) | Íconos en el explorador, la statusline, el autocompletado y los diagnósticos |
| Terminal con *true color* | El colorscheme usa colores de 24 bits (`termguicolors`) |
| `xclip` o `xsel` (X11) / `wl-clipboard` (Wayland) | Portapapeles del sistema (`clipboard = "unnamedplus"`) |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) | Búsqueda de texto en el proyecto (`<leader>fs`) |
| [`fd`](https://github.com/sharkdp/fd) | Búsqueda de archivos más rápida (`<leader>ff`); sin él se usa `rg` o `find` |
| [`tree-sitter` CLI](https://github.com/tree-sitter/tree-sitter) y un compilador de C (`gcc`/`clang`) | La rama `main` de nvim-treesitter compila los parsers localmente |
| `curl`, `tar`, `unzip`, `gzip` | Mason descarga los servidores LSP y formateadores; blink.cmp descarga su binario |
| [Node.js](https://nodejs.org/) y `npm` | Varios servidores LSP y formateadores se instalan con npm |
| [`lazygit`](https://github.com/jesseduffield/lazygit) *(opcional)* | Cliente de git dentro de Neovim (`<leader>lg`) |
| [`tmux`](https://github.com/tmux/tmux) *(opcional)* | Navegación entre paneles de tmux y ventanas de Neovim |
| [`deno`](https://deno.com/) *(opcional)* | LSP y formateo en proyectos Deno (se usa el binario del sistema) |

En Fedora, por ejemplo:

```sh
sudo dnf install neovim git ripgrep fd-find xclip wl-clipboard gcc curl tar unzip gzip nodejs npm tmux
```

`tree-sitter` CLI y `lazygit` pueden no estar en los repositorios de tu distribución; se instalan desde sus releases de GitHub o con `cargo install tree-sitter-cli`.

## Instalación

Respalda tu configuración actual si tienes una:

```sh
mv ~/.config/nvim ~/.config/nvim.bak
```

Clona el repositorio y abre Neovim:

```sh
git clone https://github.com/ulices54/nvim-config ~/.config/nvim
nvim
```

La primera vez, `vim.pack` pide confirmación para instalar los plugins, Mason instala los servidores LSP y formateadores, y nvim-treesitter compila los parsers. Puede tardar un par de minutos.

### Probarla sin reemplazar tu configuración

Con `NVIM_APPNAME` puedes tener varias configuraciones en paralelo:

```sh
git clone https://github.com/ulices54/nvim-config ~/.config/nvim-config
NVIM_APPNAME=nvim-config nvim
```

## Plugins

| Plugin | Funcionalidad |
| --- | --- |
| [nvim-dark-ide.nvim](https://github.com/ulices54/nvim-dark-ide.nvim) | Colorscheme estilo VS Code *Dark 2026* con variante pastel para trabajar de noche |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard de inicio, buscador de archivos y texto, guías de indentación, notificaciones e integración con lazygit |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | Explorador de archivos en panel lateral con estado de git |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | Íconos por tipo de archivo |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Barra de estado: modo, rama de git, diagnósticos, tipo de archivo |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Pestañas en la parte superior |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Instalación de parsers para resaltado de sintaxis e indentación precisos |
| [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) | Colorea `()`, `[]` y `{}` por nivel de anidación, como VS Code |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Cierra y renombra automáticamente etiquetas HTML/JSX |
| [Comment.nvim](https://github.com/numtostr/comment.nvim) | Comentar y descomentar líneas y bloques (`gcc`, `gc`) |
| [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) | Usa el tipo de comentario correcto según el contexto (JSX, HTML, etc.) |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | Cierra automáticamente paréntesis, corchetes y comillas |
| [mini.surround](https://github.com/nvim-mini/mini.surround) | Agregar, cambiar y eliminar delimitadores alrededor de texto |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Configuraciones base de los servidores LSP |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Instalador de servidores LSP, linters y formateadores |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Instala y activa automáticamente los servidores LSP |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Instala automáticamente formateadores y linters (prettier, stylua, eslint_d) |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Configura `lua_ls` para la API de Neovim (`vim.*`) al editar la config |
| [blink.cmp](https://github.com/saghen/blink.cmp) | Autocompletado (LSP, rutas, snippets y buffer) |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Motor de snippets |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets para muchos lenguajes |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | Íconos para los tipos de sugerencias del autocompletado |
| [colorful-menu.nvim](https://github.com/xzbdmw/colorful-menu.nvim) | Resaltado de sintaxis dentro del menú de autocompletado |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formateo al guardar (prettierd, stylua, deno fmt) |
| [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Muestra los diagnósticos del LSP en línea con mejor formato |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Lista de diagnósticos, quickfix y location list |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Resalta y busca comentarios `TODO`, `FIX`, `NOTE`, etc. |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Librería de funciones Lua (dependencia de todo-comments) |
| [noice.nvim](https://github.com/folke/noice.nvim) | Línea de comandos flotante y mejor presentación de mensajes |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | Componentes de interfaz (dependencia de noice) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Muestra los atajos disponibles al presionar una tecla líder |
| [auto-session](https://github.com/rmagatti/auto-session) | Guarda sesiones automáticamente y las restaura bajo demanda |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Moverse entre ventanas de Neovim y paneles de tmux con `<C-h/j/k/l>` |

### Servidores LSP y herramientas

Mason instala automáticamente:

- **LSP:** astro, bashls, cssls, emmet_ls, html, lua_ls, marksman, pyright, tailwindcss, ts_ls, vimls
- **Formateadores y linters:** eslint_d, prettier, prettierd, stylua

`denols` usa el binario `deno` del sistema y solo se activa en proyectos con `deno.json`, `deno.jsonc` o `deno.lock`.

## Estructura

```
.
├── init.lua                  # Punto de entrada
├── nvim-pack-lock.json       # Versiones fijadas de los plugins (vim.pack)
├── after/queries/            # Ajustes a queries de treesitter
├── queries/                  # Queries propias de treesitter
└── lua/config/
    ├── core/                 # Opciones, atajos, comandos y LSP
    ├── plugins.lua           # Lista de plugins que se cargan
    └── plugins/              # Un archivo por plugin
```

## Gestión de plugins

Los plugins se declaran con `vim.pack.add()` en cada archivo de `lua/config/plugins/`, y sus versiones quedan fijadas en `nvim-pack-lock.json`. Comandos incluidos:

| Comando | Acción |
| --- | --- |
| `:PackUpdate [plugins...]` | Actualiza todos los plugins o solo los indicados |
| `:PackAdd <urls...>` | Agrega plugins |
| `:PackDel <plugins...>` | Elimina plugins |

La tecla líder es `<Space>`. Presiónala y espera para ver todos los atajos con which-key.
