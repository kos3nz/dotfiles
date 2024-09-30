#### Default apps ###
export TERMINAL="alacritty"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

### bat ###
export BAT_THEME="base16"
export BAT_STYLE='numbers,changes,header,header-filesize,grid'

### fzf ###
export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--reverse --border --height 60% --tmux 55%,60% --bind="ctrl-f:replace-query"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#6c7086,fg+:#cdd6f4,bg:#11111b,bg+:#1e1e2e,hl:#89b4fa,hl+:#89b4fa,info:#fab387,prompt:#a6e3a1,pointer:#89b4fa,marker:#89b4fa,border:#89b4fa'

# fzf-file-widget
export FZF_CTRL_T_COMMAND="fd --hidden --type f --exclude .git" # show only files
export FZF_CTRL_T_OPTS="
  --height 75%
  --tmux 85%,75%
  --preview 'bat --theme=base16 --color=always --style="numbers,header,header-filesize,grid" {}'
  --preview 'bat --theme=base16 --color=always --style="numbers,header,header-filesize,grid" {}'
  --preview-window 'right,70%'
  --bind 'ctrl-/:change-preview-window(down|hidden|),ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'
"

# fzf-cd-widget
export FZF_ALT_C_COMMAND="fd --hidden --type d --exclude .git" # show only directories

### ni ###
export NI_CONFIG_FILE="$HOME/.config/ni/nirc"

### ripgrep ###
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

### rust ###
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

### starship ###
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

#### tmux plugin: t-smart-tmux-session-manager ###
# export PATH="$XDG_CONFIG_HOME/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH"

#### volta ###
export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

#### lf ###
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.cjs=:\
*.mjs=:\
*.jsx=:\
*.json=:\
*.lua=:\
*.md=:\
*.mdx=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.sass=:\
*.scala=:\
*.scss=:\
*.ts=:\
*.tsx=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
*.gitconfig=:\
*.gitignore=:\
*.zshrc=:\
*.zshenv=:\
*.zprofile=:\
*.vimrc=:\
*favicon.ico=:\
*license=:\
*node_modules=:\
*dockerfile=:\
*docker-compose.yml=:\
*Dockerfile=:\
*Docker-compose.yml=:\
*Makefile=:\
*Makefile=:\
*robots.txt=ﮧ:\
"
