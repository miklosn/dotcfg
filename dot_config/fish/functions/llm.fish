function llm --description "Switch LLM provider/model for this shell session"
    set -l dir ~/.config/llm/profiles
    if test (count $argv) -eq 0
        set -l cur (set -q LLM_PROFILE; and echo $LLM_PROFILE; or echo anthropic)
        for p in $dir/*.fish
            set -l name (basename $p .fish)
            string match -q '_*' $name; and continue
            test "$name" = "$cur"; and echo "* $name"; or echo "  $name"
        end
        return
    end
    set -l target $dir/$argv[1].fish
    if not test -f $target
        echo "llm: no profile '$argv[1]' in $dir" >&2
        return 1
    end
    # Always reset to the default first so profiles don't leak into each other.
    source $dir/anthropic.fish
    source $target; or begin
        echo "llm: failed to activate $argv[1] (1Password denied or unavailable?)" >&2
        source $dir/anthropic.fish
        set -e LLM_PROFILE
        return 1
    end
    set -gx LLM_PROFILE $argv[1]
    echo "llm: $argv[1] active in this shell"
end
