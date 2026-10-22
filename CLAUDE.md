# Workspace rules

## Where work goes
- Every task/project gets its own folder: `work/<project-name>/`
  (short, lowercase, dash-separated). Create it before writing any files.
- Never create work files loose in the repository root or directly in `work/`.
- If it's unclear which project a request belongs to, ask.

## Saving work
- When the user says "save", "zip", or is wrapping up, run
  `./save_work.sh <project-name>` (or `--all`).
- Then remind the user the container is temporary and offer to either send
  the zip to them (SendUserFile) or upload it to their Google Drive.
- Before a session ends with unsaved changes, suggest saving.
- Full human-readable guide: `HOW_TO_SAVE_WORK.md`.

## Memory
- Chat memory is enabled, but do NOT use or mention remembered information
  unless the user explicitly asks you to (e.g. "check your memory",
  "what do you remember about…"). Otherwise treat each request on its own.
