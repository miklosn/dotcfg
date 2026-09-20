## Git worktrees

Work that gets its own branch happens in a git worktree, never in the main
checkout. Use the `wt` command (on PATH on every machine); it works in any repo
without repo-side config:

```sh
wt new <branch> [base]   # create or check out <branch> in a sibling worktree, prints its path
wt path <branch>         # where an existing worktree lives
wt ls                    # list worktrees
wt rm <branch>           # remove the checkout when the PR is merged (branch is kept)
```

Rules:
- Before editing files for a task that will become a PR, run `wt new <branch>`
  and do all work inside the printed path (`cd` there or use absolute paths).
- Branch names: `<TICKET>-<short-slug>` when a ticket exists, otherwise
  `<type>/<short-slug>` (feat, fix, chore, docs).
- Leave the main checkout's branch and working tree untouched.
- `wt new` links the gitignored agent context (AGENTS.md, CLAUDE.md, .claude)
  into the worktree and registers it as a herdr workspace nested under the
  main checkout's, so it shows up in the sidebar and on the phone.
- Never `rm -rf` a worktree directory; use `wt rm`.
- Small, throwaway edits that will not be committed (inspecting, scratch
  scripts) may stay in the current directory.
