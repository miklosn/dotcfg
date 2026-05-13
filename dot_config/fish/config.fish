/opt/homebrew/bin/brew shellenv | source
# ============================================================================
# Environment Variables (Always Active)
# ============================================================================

set -gx EDITOR nvim
set -gx NIXPKGS_ALLOW_UNFREE 1
set -gx CLOUDSDK_PYTHON_SITEPACKAGES 1
set -gx ZK_NOTEBOOK_DIR /Users/mico/c/zk/

# ============================================================================
# Tool Activations (Always Active)
# ============================================================================

# PATH additions using fish_add_path (deduplicated)
# These run BEFORE mise activation so the subsequent `fish_add_path --move`
# on the mise shims directory pushes shims to the very front of PATH.
fish_add_path $HOME/.opencode/bin
fish_add_path $HOME/.lmstudio/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/bin
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin

# mise - tool version manager (activate AFTER user paths so shims take priority)
if type -q mise
    mise activate fish | source
    # mise shims take highest priority over everything else
    fish_add_path --move $HOME/.local/share/mise/shims
end

# direnv - environment directory
if type -q direnv
    direnv hook fish | source
end

# wtp - git worktree management
wtp shell-init fish | source

# nix integration
if test -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
    source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end

# ============================================================================
# Interactive-Only Configuration
# ============================================================================

if status is-interactive
    set -gx COLORTERM truecolor

    # Smart cd: zoxide
    zoxide init --cmd cd fish | source

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

    # Minimal prompt for Zed IDE terminal
    if set -q ZED_TERM
        function fish_prompt
            set -l last_status $status
            if test $last_status -ne 0
                set_color red
            else
                set_color green
            end
            echo -n '❯ '
            set_color normal
        end
        function fish_right_prompt; end
    end
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


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/c5394507/.lmstudio/bin
# End of LM Studio CLI section

