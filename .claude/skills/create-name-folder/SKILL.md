---
name: create-name-folder
description: Create a personal folder in this GitHub repository when someone gives their name. Use whenever a person says their name or introduces themselves (e.g. "my name is Alex Carter", "I'm Alex Carter", "Alex Carter", "make a folder for Alex Carter") — create a folder named after them, commit it, and push it to GitHub.
---

# Create a folder for a person's name

When someone tells you their name, give them their own folder at the root of this repository and push it to GitHub so it is saved permanently.

## Steps

1. **Get the name.** Take the name exactly as the person gave it. If it's unclear whether what they typed is a name (e.g. a single ambiguous word), ask them to confirm before doing anything. A first name alone is fine — don't demand a last name.

2. **Turn it into a folder name.**
   - Trim spaces and capitalize the first letter of each word (`alex carter` → `Alex Carter`).
   - Join the words with hyphens: `Alex-Carter`.
   - Remove any characters other than letters, numbers and hyphens (`O'Brien` → `OBrien`).

3. **Go to the repository root.** Run commands from the top of this repository (`git rev-parse --show-toplevel`), and pull the latest version first so you don't miss folders other people created:
   ```bash
   git fetch origin main && git pull --rebase origin main
   ```
   (Skip this if the remote has no `main` branch yet.)

4. **Check whether the folder already exists.** Compare case-insensitively against existing top-level folders. If one already matches, don't create or overwrite anything — tell the person their folder already exists and give its path.

5. **Create the folder with a README.** Git doesn't save empty folders, so add a `README.md` inside it:
   ```markdown
   # Alex Carter

   Folder created on YYYY-MM-DD.
   ```
   Use the person's name as they gave it (title-cased) and today's date.

6. **Commit and push.**
   ```bash
   git add "Alex-Carter/README.md"
   git commit -m "Add folder for Alex Carter"
   git push -u origin main
   ```
   If the push is rejected because the remote moved ahead, run `git pull --rebase origin main` and push again. If it fails because of a network error, retry up to 4 times, waiting 2s, 4s, 8s, then 16s.

7. **Confirm.** Tell the person their folder was created and pushed, with its name (e.g. `Alex-Carter/`). If the push failed, say so plainly — the folder only exists in this temporary session until it's pushed.
