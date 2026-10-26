# Configuración de Neovim 0.12

Configuración personal de Neovim **0.12** escrita en Lua. Usa el gestor de plugins nativo **`vim.pack`** (sin lazy.nvim).

Es mi configuración **estable**: vive directamente en `~/.config/nvim` y se usa a diario con Neovim **0.12.6**.

Está preparada para desarrollo web (JavaScript/TypeScript, HTML, CSS, Astro, Deno), Lua, Python y **Kotlin/Android**. El soporte de Kotlin es opcional: tiene sus propios [requisitos](#kotlin) y se puede [quitar](#quitar-el-soporte-de-kotlin) si no lo necesitas.

El colorscheme por defecto es [nvim-dark-ide](https://github.com/ulices54/nvim-dark-ide.nvim), basado en el tema *Dark 2026* de VS Code. También está instalado [catppuccin](https://github.com/catppuccin/nvim) con todas sus variantes (ver [Colorschemes](#colorschemes)).

## Requisitos

| Requisito | Uso |
| --- | --- |
| [Neovim](https://github.com/neovim/neovim/releases) **>= 0.12** (probada con 0.12.6) | `vim.pack` solo existe a partir de esta versión |
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

Para programar en Kotlin hacen falta además los [requisitos de Kotlin](#requisitos-de-kotlin).

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
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme alternativo con sus cuatro variantes (latte, frappe, macchiato, mocha) y configuración personalizada |
| [harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2) (rama `harpoon2`) | Marca archivos para saltar entre ellos rápidamente, con menú para abrirlos en splits o pestañas |
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
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Colección de snippets para muchos lenguajes (se expanden con el motor nativo `vim.snippet`) |
| [lspkind.nvim](https://github.com/onsails/lspkind.nvim) | Íconos para los tipos de sugerencias del autocompletado |
| [colorful-menu.nvim](https://github.com/xzbdmw/colorful-menu.nvim) | Resaltado de sintaxis dentro del menú de autocompletado |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formateo al guardar (prettierd, stylua, deno fmt, ktlint) |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Linters que no son LSP: eslint_d en JavaScript/TypeScript y ktlint en Kotlin (`<leader>ll` para ejecutarlo a mano) |
| [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) | Muestra los diagnósticos del LSP en línea con mejor formato |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Lista de diagnósticos, quickfix y location list |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Renderiza Markdown dentro del buffer: encabezados, listas, tablas, bloques de código y casillas (usa los parsers `markdown` y `markdown_inline` de treesitter) |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Resalta y busca comentarios `TODO`, `FIX`, `NOTE`, etc. |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Librería de funciones Lua (dependencia de todo-comments y harpoon) |
| [noice.nvim](https://github.com/folke/noice.nvim) | Línea de comandos flotante y mejor presentación de mensajes |
| [nui.nvim](https://github.com/MunifTanjim/nui.nvim) | Componentes de interfaz (dependencia de noice) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Muestra los atajos disponibles al presionar una tecla líder |
| [maximizer.nvim](https://github.com/0x00-ketsu/maximizer.nvim) | Maximizar el split actual y restaurar la distribución (`<leader>mt`, `<leader>mr`) |
| [auto-session](https://github.com/rmagatti/auto-session) | Guarda sesiones automáticamente y las restaura bajo demanda |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Moverse entre ventanas de Neovim y paneles de tmux con `<C-h/j/k/l>` |

### Servidores LSP y herramientas

Mason instala automáticamente:

- **LSP:** astro, bashls, cssls, emmet_ls, html, lua_ls, marksman, pyright, tailwindcss, ts_ls, vimls
- **Formateadores y linters:** eslint_d, ktlint, prettier, prettierd, stylua

`denols` usa el binario `deno` del sistema y solo se activa en proyectos con `deno.json`, `deno.jsonc` o `deno.lock`.

## Colorschemes

Los dos colorschemes se configuran en `lua/config/plugins/colorscheme.lua`. Por defecto se carga `nvim-dark-ide`; para usar catppuccin, comenta esa línea y descomenta `vim.cmd.colorscheme("catppuccin")`.

| Colorscheme | Variantes |
| --- | --- |
| nvim-dark-ide | `nvim-dark-ide`, `nvim-dark-ide-soft` (pastel) |
| catppuccin | `catppuccin-latte` (claro), `catppuccin-frappe`, `catppuccin-macchiato`, `catppuccin-mocha` |

También se puede cambiar en cualquier momento sin editar la config, por ejemplo `:colorscheme catppuccin-macchiato`.

Configuración personalizada de catppuccin:

- **Variante por defecto:** `mocha`, tanto con `background=dark` como con `background=light` (`:colorscheme catppuccin` siempre usa mocha; las demás variantes se eligen por nombre).
- **Ventanas inactivas atenuadas:** las ventanas sin foco se oscurecen un 15 % (`dim_inactive`).
- **Cursivas** en comentarios, condicionales y palabras clave.
- **Integraciones automáticas** (`auto_integrations`): detecta los plugins instalados (lualine, bufferline, blink.cmp, noice, snacks, trouble, which-key, etc.) y les aplica los colores del tema.

## Harpoon

[Harpoon 2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2) guarda una lista de archivos por proyecto para saltar entre ellos sin buscarlos.

| Atajo | Acción |
| --- | --- |
| `<leader>a` | Agregar el archivo actual a la lista |
| `<C-e>` | Abrir/cerrar el menú con la lista |
| `<C-S-p>` | Ir al archivo anterior de la lista |
| `<C-S-n>` | Ir al archivo siguiente de la lista |

Dentro del menú (además de `<CR>` para abrir y editar la lista como un buffer normal para reordenar o borrar entradas):

| Atajo | Acción |
| --- | --- |
| `<C-v>` | Abrir en un split vertical |
| `<C-x>` | Abrir en un split horizontal |
| `<C-t>` | Abrir en una pestaña nueva |

## Kotlin

Pensado para proyectos Kotlin/Android: la edición se hace en Neovim, y la compilación pesada, el debug y los previews de Compose se quedan en Android Studio.

| Función | Herramienta |
| --- | --- |
| LSP (autocompletado, ir a definición, diagnósticos, renombrar) | [kotlin-lsp](https://github.com/Kotlin/kotlin-lsp), el servidor oficial de JetBrains |
| Formateo al guardar y lint | [ktlint](https://github.com/pinterest/ktlint) con estilo de Android Studio e indentación de 2 espacios |
| Resaltado de sintaxis | Parser `kotlin` de treesitter |
| Compilar, instalar y probar | Atajos que ejecutan `./gradlew` |

Otros detalles:

- **Estilo de ktlint:** se toma de [`ktlint/editorconfig`](ktlint/editorconfig). Un `.editorconfig` dentro del proyecto tiene prioridad.
- **Jetpack Compose:** las funciones `@Composable` se pueden nombrar en PascalCase (`HomeScreen()`) sin que ktlint ni kotlin-lsp lo marquen como error.
- **Rendimiento:** ktlint arranca una JVM en cada ejecución (~0.8 s), así que en Kotlin el formateo corre *después* de guardar (el archivo se vuelve a guardar solo) y el lint espera 1 segundo sin cambios.

| Atajo | Acción |
| --- | --- |
| `<leader>kb` | `./gradlew assembleDebug` |
| `<leader>ki` | `./gradlew installDebug` (dispositivo o emulador) |
| `<leader>kt` | `./gradlew test` |
| `<leader>kl` | `./gradlew lint` (Android lint) |
| `<leader>ks` | Buscar un símbolo en el workspace |

Los comandos de Gradle se ejecutan en una terminal en la parte inferior, desde la carpeta donde está `gradlew`. Los atajos solo existen en archivos Kotlin.

### Requisitos de Kotlin

| Requisito | Uso | Instalación |
| --- | --- | --- |
| Java 11 o superior en el `PATH` | ktlint es un programa de Java | `sudo dnf install java-21-openjdk` (Fedora) o el JDK de tu sistema |
| kotlin-lsp | Servidor LSP | Manual, ver abajo |
| ktlint | Formateo y lint | Automática con Mason al abrir Neovim |
| El JDK y el Android SDK que usa tu proyecto | Solo para los atajos de Gradle | Los mismos que usa Android Studio |

kotlin-lsp **no necesita** un Java instalado: trae el suyo.

#### Instalar kotlin-lsp

El paquete de Mason para kotlin-lsp no funciona (su URL de descarga da 404), así que se instala a mano:

1. Descarga el archivo para Linux (`kotlin-server-<versión>.tar.gz`) desde los [releases de kotlin-lsp](https://github.com/Kotlin/kotlin-lsp/releases).
2. Extráelo en `~/.local/share/kotlin-lsp`:
   ```sh
   mkdir -p ~/.local/share/kotlin-lsp
   tar -xzf ~/Downloads/kotlin-server-*.tar.gz -C ~/.local/share/kotlin-lsp
   ```
3. Comprueba que quedó en su lugar:
   ```sh
   ls ~/.local/share/kotlin-lsp/kotlin-server-*/bin/intellij-server
   ```

La config usa la versión más reciente que encuentre en esa carpeta; para actualizar, extrae la nueva versión ahí mismo (puedes borrar la anterior). Si kotlin-lsp no está instalado, Kotlin funciona igual pero sin LSP: sin errores al arrancar.

#### Verificar

Abre un archivo `.kt` dentro de un proyecto Gradle (con `settings.gradle(.kts)` o `build.gradle(.kts)`) y ejecuta:

```vim
:checkhealth vim.lsp
```

Debe aparecer `kotlin_lsp` entre los clientes activos. La primera vez kotlin-lsp importa el proyecto de Gradle y puede tardar en mostrar diagnósticos.

### Compatibilidad con otros proyectos

El soporte de Kotlin no causa conflictos con proyectos que no son de Kotlin: todo se activa solo en archivos `.kt` y `.kts`. En otros lenguajes no se inicia kotlin-lsp, no corre ktlint, no se crean los atajos `<leader>k*` y el formateo al guardar funciona igual que sin Kotlin.

### Quitar el soporte de Kotlin

Si no programas en Kotlin, puedes dejarlo como está: nada de esto se activa fuera de archivos `.kt`/`.kts`. Lo único que ocurre es que Mason descarga ktlint y treesitter compila el parser de Kotlin. Si prefieres quitarlo por completo:

1. Borra el archivo de Kotlin y el estilo de ktlint:
   ```sh
   rm lua/config/plugins/kotlin.lua
   rm -r ktlint
   ```
2. En `lua/config/plugins.lua`, elimina la línea `require("config.plugins.kotlin")`. Hazlo en el mismo cambio que el paso 1: si el archivo ya no existe pero la línea sigue, Neovim da error al arrancar.
3. En `lua/config/core/lsp.lua`, elimina el bloque que empieza en el comentario `-- Kotlin:` y termina en el `end` de `if #kotlin_server > 0 then`.
4. En `lua/config/plugins/conform.lua`, elimina:
   - la variable `ktlint_editorconfig` y su comentario,
   - la línea `kotlin = { "ktlint" },`,
   - el bloque `formatters = { ktlint = { ... } },`.
5. En `lua/config/plugins/nvim-lint.lua`, elimina:
   - la línea `kotlin = { "ktlint" },`,
   - la línea `table.insert(lint.linters.ktlint.args, ...)` y su comentario,
   - todo el bloque desde el comentario `-- ktlint arranca una JVM...` hasta el final del autocmd de `*.kt`/`*.kts` (el atajo `<leader>ll` se queda).
6. En `lua/config/plugins/lsp/mason.lua`, quita `"ktlint"` de `mason-tool-installer`.
7. En `lua/config/plugins/treesitter.lua`, quita `"kotlin"` de la lista de parsers.
8. Abre Neovim y desinstala lo que ya no se usa:
   ```vim
   :MasonUninstall ktlint
   :TSUninstall kotlin
   ```
   Y, si lo instalaste, borra kotlin-lsp: `rm -rf ~/.local/share/kotlin-lsp`.

Opcional: en `conform.lua` y `nvim-lint.lua` quedan algunas condiciones `if vim.bo[...].filetype == "kotlin"` que ya no hacen nada. Puedes dejarlas o simplificarlas:
- en `conform.lua`, reemplaza las funciones `format_on_save` y `format_after_save` por
  ```lua
  format_on_save = {
    lsp_format = "fallback",
    async = false,
    timeout_ms = 500,
  },
  ```
- en `nvim-lint.lua`, borra el `if` con el comentario `-- En Kotlin, ktlint va por su propio autocmd`.

## Estructura

```
.
├── init.lua                  # Punto de entrada
├── nvim-pack-lock.json       # Versiones fijadas de los plugins (vim.pack)
├── after/queries/            # Ajustes a queries de treesitter
├── ktlint/editorconfig       # Estilo por defecto de ktlint
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
