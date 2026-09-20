# Terminal title: "project[/dir]@branch · command". herdr-autotitle uses it to
# label tabs in the mobile/collapsed views; agents (claude, opencode) override it.
# Project = nearest *.nosync ancestor (the ~/c convention: <project>.nosync/{repo,
# worktrees/<x>, wt-*}), so a "repo" or worktree checkout is not named "repo".
function fish_title
    set -l top (command git rev-parse --show-toplevel 2>/dev/null)
    set -l project (string match -r -g '.*/([^/]+)\.nosync(?:/|$)' -- $PWD)
    if test -z "$project"
        test -n "$top"; and set project (basename -- $top); or set project (basename -- $PWD)
    end
    set -l title $project
    if test -n "$top" -a "$PWD" != "$top"
        set title "$title/"(basename -- $PWD)
    end
    set -l branch (command git branch --show-current 2>/dev/null)
    test -n "$branch"; and set title "$title@$branch"
    set -l cmd (status current-command)
    if test -n "$cmd" -a "$cmd" != fish
        set title "$title · $cmd"
    end
    echo $title
end
