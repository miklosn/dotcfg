# Terminal title: "dir@branch · command". herdr-autotitle uses it to label tabs
# in the mobile/collapsed views; agents (claude, opencode) override it themselves.
function fish_title
    set -l title (basename -- $PWD)
    set -l branch (command git branch --show-current 2>/dev/null)
    test -n "$branch"; and set title "$title@$branch"
    set -l cmd (status current-command)
    if test -n "$cmd" -a "$cmd" != fish
        set title "$title · $cmd"
    end
    echo $title
end
