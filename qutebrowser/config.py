# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'w': 'session-save', 'q': 'close', 'wq': 'quit --save', 'mpv': 'spawn --userscript view_in_mpv', 'pass': 'spawn --userscript  qute-pass'}

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = True

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# List of URLs of lists which contain hosts to block.  The file can be
# in one of the following formats:  - An `/etc/hosts`-like file - One
# host per line - A zip-file of any of the above, with either only one
# file, or a file   named `hosts` (with any extension).
# Type: List of Url
c.content.host_blocking.lists = ['https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts', 'http://1hosts.cf/', 'http://winhelp2002.mvps.org/hosts.zip', 'https://pgl.yoyo.org/adservers/serverlist.php?showintro=0;hostformat=hosts']

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# List of user stylesheet filenames to use.
# Type: List of File, or File
c.content.user_stylesheets = []

# Enable WebGL.
# Type: Bool
c.content.webgl = False

# Height (in pixels or as percentage of the window) of the completion.
# Type: PercOrInt
c.completion.height = '40%'

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['emacs', '{}']

# Show a scrollbar.
# Type: Bool
c.scrolling.bar = False

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = False

# Languages to use for spell checking. You can check for available
# languages and install dictionaries using scripts/dictcli.py. Run the
# script with -h/--help for instructions.
# Type: List of String
# Valid values:
#   - af-ZA: Afrikaans (South Africa)
#   - bg-BG: Bulgarian (Bulgaria)
#   - ca-ES: Catalan (Spain)
#   - cs-CZ: Czech (Czech Republic)
#   - da-DK: Danish (Denmark)
#   - de-DE: German (Germany)
#   - el-GR: Greek (Greece)
#   - en-AU: English (Australia)
#   - en-CA: English (Canada)
#   - en-GB: English (United Kingdom)
#   - en-US: English (United States)
#   - es-ES: Spanish (Spain)
#   - et-EE: Estonian (Estonia)
#   - fa-IR: Farsi (Iran)
#   - fo-FO: Faroese (Faroe Islands)
#   - fr-FR: French (France)
#   - he-IL: Hebrew (Israel)
#   - hi-IN: Hindi (India)
#   - hr-HR: Croatian (Croatia)
#   - hu-HU: Hungarian (Hungary)
#   - id-ID: Indonesian (Indonesia)
#   - it-IT: Italian (Italy)
#   - ko: Korean
#   - lt-LT: Lithuanian (Lithuania)
#   - lv-LV: Latvian (Latvia)
#   - nb-NO: Norwegian (Norway)
#   - nl-NL: Dutch (Netherlands)
#   - pl-PL: Polish (Poland)
#   - pt-BR: Portuguese (Brazil)
#   - pt-PT: Portuguese (Portugal)
#   - ro-RO: Romanian (Romania)
#   - ru-RU: Russian (Russia)
#   - sh: Serbo-Croatian
#   - sk-SK: Slovak (Slovakia)
#   - sl-SI: Slovenian (Slovenia)
#   - sq: Albanian
#   - sr: Serbian
#   - sv-SE: Swedish (Sweden)
#   - ta-IN: Tamil (India)
#   - tg-TG: Tajik (Tajikistan)
#   - tr-TR: Turkish (Turkey)
#   - uk-UA: Ukrainian (Ukraine)
#   - vi-VN: Vietnamese (Viet Nam)
c.spellcheck.languages = ['en-US', 'es-ES']

# Open new tabs (middleclick/ctrl+click) in the background.
# Type: Bool
c.tabs.background = True

# Search engines which can be used via the address bar. Maps a search
# engine name (such as `DEFAULT`, or `ddg`) to a URL with a `{}`
# placeholder. The placeholder will be replaced by the search term, use
# `{{` and `}}` for literal `{`/`}` signs. The search engine named
# `DEFAULT` is used when `url.auto_search` is turned on and something
# else than a URL was entered to be opened. Other search engines can be
# used by prepending the search engine name to the search term, e.g.
# `:open google qutebrowser`.
# Type: Dict
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'g': 'https://encrypted.google.com/search?q={}'}

# Default zoom level.
# Type: Perc
c.zoom.default = '100%'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = 'Iosevka SS04'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '9pt monospace'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 9pt monospace'

# Font used for the debugging console.
# Type: QtFont
c.fonts.debug_console = '9pt monospace'

# Font used for the downloadbar.
# Type: Font
c.fonts.downloads = '9pt monospace'

# Font used for the hints.
# Type: Font
c.fonts.hints = 'bold 8pt monospace'

# Font used in the keyhint widget.
# Type: Font
c.fonts.keyhint = '9pt monospace'

# Font used for error messages.
# Type: Font
c.fonts.messages.error = '9pt monospace'

# Font used for info messages.
# Type: Font
c.fonts.messages.info = '9pt monospace'

# Font used for warning messages.
# Type: Font
c.fonts.messages.warning = '9pt monospace'

# Font used for prompts.
# Type: Font
c.fonts.prompts = '10pt sans-serif'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '9pt monospace'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '9pt monospace'

# colors
base00 = "#181818"
base01 = "#282828"
base02 = "#383838"
base03 = "#585858"
base04 = "#b8b8b8"
base05 = "#d8d8d8"
base06 = "#e8e8e8"
base07 = "#f8f8f8"
base08 = "#ab4642"
base09 = "#dc9656"
base0A = "#f7ca88"
base0B = "#a1b56c"
base0C = "#86c1b9"
base0D = "#7cafc2"
base0E = "#ba8baf"
base0F = "#a16946"

# set qutebrowser colors
c.colors.completion.category.bg = base00
c.colors.completion.category.border.bottom= base00
c.colors.completion.category.border.top= base00
c.colors.completion.category.fg = base0A
c.colors.completion.fg = base05
c.colors.completion.item.selected.bg = base0A
c.colors.completion.item.selected.border.bottom = base0A
c.colors.completion.item.selected.border.top = base0A
c.colors.completion.item.selected.fg = base01
c.colors.completion.match.fg = base0B
c.colors.completion.odd.bg = base03
c.colors.completion.even.bg = base00
c.colors.completion.scrollbar.bg = base00
c.colors.completion.scrollbar.fg = base05
c.colors.downloads.bar.bg = base00
c.colors.downloads.error.fg = base08
c.colors.downloads.start.bg = base0D
c.colors.downloads.start.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.stop.fg = base00
c.colors.hints.bg = base0A
c.colors.hints.fg = base00
c.colors.hints.match.fg = base05
c.colors.keyhint.bg = base00
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05
c.colors.messages.error.fg = base00
c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.messages.info.fg = base05
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.warning.fg = base00
c.colors.prompts.bg = base00
c.colors.prompts.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.selected.bg = base0A
c.colors.statusbar.caret.bg = base0E
c.colors.statusbar.caret.fg = base00
c.colors.statusbar.caret.selection.bg = base0D
c.colors.statusbar.caret.selection.fg = base00
c.colors.statusbar.command.bg = base00
c.colors.statusbar.command.fg = base05
c.colors.statusbar.command.private.bg = base00
c.colors.statusbar.command.private.fg = base05
c.colors.statusbar.insert.bg = base0D
c.colors.statusbar.insert.fg = base00
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.passthrough.bg = base0C
c.colors.statusbar.passthrough.fg = base00
c.colors.statusbar.private.bg = base03
c.colors.statusbar.private.fg = base00
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.success.http.fg = base0C
c.colors.statusbar.url.success.https.fg =base0B
c.colors.statusbar.url.warn.fg = base0E
c.colors.tabs.bar.bg = base00
c.colors.tabs.even.bg = base00
c.colors.tabs.even.fg = base05
c.colors.tabs.indicator.error = base08
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.odd.bg = base03
c.colors.tabs.odd.fg = base05
c.colors.tabs.selected.even.bg = base05
c.colors.tabs.selected.even.fg = base00
c.colors.tabs.selected.odd.bg = base05
c.colors.tabs.selected.odd.fg = base00
# c.colors.webpage.bg = base00

# Bindings for normal mode
config.bind(',n', 'config-cycle content.user_stylesheets nightmode.css nightmode2.css ""')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('W', 'set-cmd-text -s :open -p')
config.bind('X', 'close')
config.bind('t', 'set-cmd-text -s :open -t')

# Bindings for command mode
config.bind('<Ctrl+Return>', 'set-cmd-text --append .com ;; command-accept', mode='command')

# start page
c.url.default_page = '~/.config/qutebrowser/start/start.html'
c.url.start_pages = '~/.config/qutebrowser/start/start.html'

# Disable reading from canvas
c.content.canvas_reading = False
# Don't expose lan address via webrtc
c.content.webrtc_public_interfaces_only = True

