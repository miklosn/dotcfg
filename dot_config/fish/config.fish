/opt/homebrew/bin/brew shellenv | source
# ============================================================================
# Environment Variables (Always Active)
# ============================================================================

set -gx EDITOR nvim
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1
set -gx ZK_NOTEBOOK_DIR /Users/mico/c/zk/

# PATH additions using fish_add_path (deduplicated)
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/bin
fish_add_path $HOME/go/bin
fish_add_path /usr/local/sbin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.lmstudio/bin
fish_add_path $HOME/.opencode/bin

# ============================================================================
# Tool Activations (Always Active)
# ============================================================================

# mise - tool version manager
if type -q mise
    mise activate fish | source
end

# direnv - environment directory
if type -q direnv
    direnv hook fish | source
end

# nix integration
if test -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end

# ============================================================================
# Interactive-Only Configuration
# ============================================================================

if status is-interactive
    # Prompt: starship
    if type -q starship
        starship init fish | source
    end

    # Smart cd: zoxide
    zoxide init fish | source

    # Vi mode
    fish_vi_key_bindings

    # fzf.fish plugin handles fuzzy finder key bindings
    # (Ctrl+R: history, Ctrl+T: files, Alt+C: cd)

    # ========================================================================
    # Aliases
    # ========================================================================

    alias k kubectl
    alias g git
    alias tf terraform
    alias mtrr 'sudo mtr -T -P 443 -e -z'
    alias config '/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
end

# ============================================================================
# Functions
# ============================================================================

# yazi - terminal file manager with cd on exit
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    set cwd (cat "$tmp")
    if test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# ============================================================================
# Completions
# ============================================================================

# gcloud completions - fish handles this automatically for tools in PATH
