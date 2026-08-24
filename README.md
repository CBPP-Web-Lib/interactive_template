Requirements: Must be using Mac OS X, or Windows Subsystem for Linux, and have Docker installed. Deploying additionally requires an SSH key registered on your Pantheon account.

After cloning this template repo:

1. Do a global find-replace for $PROJECTID to some unique ID of your choice, then `rm -rf .git` and `git init` to start a new repository.
2. Run `chmod +x *.sh` to make scripts executable
3. Run `./install.sh` to install node modules and set environment variables to your user ID
4. Run `./start.sh` and visit `http://localhost:8080` (dev bundle; builds fast) or `http://localhost:8081` (prod bundle, builds slower, this is the one that gets deployed)
5. In a separate terminal, run `./stop.sh` when done (or just ctrl-x in the running terminal)

To enter the Node container (for example, to run `npm i` this or that) just run `./enter_container.sh` to be dropped into a shell inside; and then just `exit` when done.

## Cross-platform notes

`install.sh` writes your user and group IDs into `.env` as `HOST_UID` / `HOST_GID`, and the Node containers run as that user so files they create are owned by you rather than by root.

- **Re-run `./install.sh` if your user ID changes** — a different machine, a different account, or a repo copied between them. A stale `.env` is the usual cause of files you can't delete without `sudo`.
- **macOS runs the containers as root on purpose.** Docker Desktop maps container-root writes back to the invoking host user, so root avoids ownership problems there instead of creating them.
- **On WSL, keep this repo inside the Linux filesystem** (somewhere under `~`), not on a Windows drive under `/mnt/c`. Windows drives are mounted through a translation layer that doesn't carry real Unix ownership, so running as a specific user ID can't work properly and permissions behave unpredictably.
- **Don't use `UID` / `GID` as the variable names.** `UID` is a shell builtin that some shells export, and Compose prefers the process environment over `.env` — so the value in `.env` gets silently ignored, or worse, you get the UID from your shell and the GID from `.env`.
- The scripts work with either `docker compose` (v2 plugin) or a standalone `docker-compose` binary; `_compose.sh` picks whichever is present.

## Deploying

`./deploy.sh` pushes to the Pantheon files directory, so the graphic is served from the main cbpp.org domain:

```
https://www.cbpp.org/sites/default/files/interactives/$PROJECTID/
```

Same-origin means no CORS headers to maintain and no separate host to keep alive. This replaces the old apps.cbpp.org target — new graphics should live on the main domain.

Deploy to test first, then live:

```
PANTHEON_ENV=test ./deploy.sh
./deploy.sh
```

Two things to know about Pantheon's files directory:

- **Files are per-environment and do not propagate.** Deploying code dev → test → live does nothing to files. Each environment has to be pushed to directly.
- **A content clone from live overwrites test.** If someone clones live content down to test, whatever you pushed to test is gone. Re-run the deploy.

`deploy.sh` sends `./html/` to the project root and `./node/prod/` to `js/`, so the prod bundle at `http://localhost:8081` is what ships — not the dev bundle on `8080`.

## Embedding in Drupal

Reference the deployed path directly, without a domain:

```html
<script src="/sites/default/files/interactives/$PROJECTID/js/app.js"></script>
```

Keep every path inside the project relative, and never reach outside the project folder — no `../` pointing at a sibling directory, and no absolute `https://apps.cbpp.org/...` URLs. Older graphics load shared libraries as `../CBPP_Shared/...`, which only resolves because everything sat together at the apps.cbpp.org root. That pattern breaks under `files/interactives/`, and it is the main reason the older graphics were not migrated. Anything shared should be vendored into the project instead.
