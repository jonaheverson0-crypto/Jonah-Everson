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

Or just tell Claude: **"Save my work."**

## 5. Get the zip OUT of the container (important!)

The `saved/` folder is still inside the temporary container. Before you
leave, do one of these:

- **Download it:** ask Claude to "send me the zip" — it appears as a file you
  can download in the Claude app.
- **Google Drive:** ask Claude to "upload the zip to my Google Drive."

## 6. Pick up later

Start a new session, upload the zip (or ask Claude to fetch it from Drive),
then:

```bash
cd work && unzip /path/to/my-project-name_2026-10-22_1430.zip
```

## Quick checklist before ending a session

- [ ] All files are inside `work/<project-name>/`
- [ ] Ran `./save_work.sh <project-name>` (or asked Claude to save)
- [ ] Downloaded the zip or uploaded it to Google Drive
