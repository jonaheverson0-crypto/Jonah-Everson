# How to Work Here and Save Your Work

This workspace runs in a temporary cloud container. **Anything left only in the
container is deleted when the session ends.** Follow these steps so your work
is never lost.

## 1. Folder layout

```
jonah-everson/   (repository root)
├── work/            <- ALL your work goes here, one folder per project
│   ├── budget-tracker/
│   └── dues-calculator/
├── saved/           <- zip files created by the save script
├── save_work.sh     <- the save script
└── HOW_TO_SAVE_WORK.md
```

Rule: **every piece of work gets its own folder inside `work/`.** Never save
files loose in the repository root or directly in `work/`.

## 2. Start a new piece of work

```bash
mkdir -p work/my-project-name
cd work/my-project-name
```

Use short, lowercase names with dashes (e.g. `rush-budget-2026`).
If you are asking Claude to do the work, just say:
> "Start a new project called rush-budget-2026."

## 3. Do the work

Write code, create files, run things — all inside your project folder.

## 4. Zip your work

From the repository root:

```bash
./save_work.sh my-project-name     # saves one project
./save_work.sh --all               # saves everything in work/
```

This creates a dated file such as
`saved/my-project-name_2026-10-22_1430.zip`. Each save makes a new file, so
older versions are kept. (Bulky folders like `node_modules` and `.venv` are
skipped — they can be reinstalled.)

The script then **commits the zip and pushes it to GitHub automatically**, so
it is saved permanently in this repository. If the push fails it says so —
the zip is then only in this temporary session until you push it.
(Run `NO_PUSH=1 ./save_work.sh my-project-name` to make a zip without pushing.)

Or just tell Claude: **"Save my work."**

## 5. Extra copies (optional)

Once the push succeeds, the zip is safe on GitHub in `saved/`. For an extra
copy you can also:

- **Download it:** ask Claude to "send me the zip" — it appears as a file you
  can download in the Claude app.
- **Google Drive:** ask Claude to "upload the zip to my Google Drive."

## 6. Pick up later

Start a new session with this repository — the zips are already in
`saved/`. Then:

```bash
cd work && unzip ../saved/my-project-name_2026-10-22_1430.zip
```

## Quick checklist before ending a session

- [ ] All files are inside `work/<project-name>/`
- [ ] Ran `./save_work.sh <project-name>` (or asked Claude to save)
- [ ] The script said "Pushed ... to GitHub" (not "PUSH FAILED")
