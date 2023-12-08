Requirements: Must be using Mac OS X, or Windows Subsystem for Linux, and have Docker installed.

After cloning this template repo:

1. Do a global find-replace for $PROJECTID to some unique ID of your choice, then `rm -rf .git` and `git init` to start a new repository.
2. Run `chmod +x * .sh` to make scripts executable
3. Run `./install.sh` to install node modules and set environment variables to your user ID
4. Run `./start.sh` and visit `http://localhost:8080` (dev bundle; builds fast) or `http://localhost:8081` (prod bundle, builds slower, this is the one that gets deployed)
5. In a separate terminal, run `./stop.sh` when done (or just ctrl-x in the running terminal)