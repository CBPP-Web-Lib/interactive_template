Requirements: Docker

Do a global find-replace for $PROJECTID to some unique ID of your choice, then `rm -rf .git` and `git init` to start a new repository.

Windows requires WSL or some sort of Unix shell

Run `./install.sh` first. Then:

Simply run "docker-compose up" in the root directory and visit `http://localhost:8080`

To build the fully minified/polyfilled/production bundle, do `chmod +x build.sh` and `./build.sh`

To bring up a local test site, just run `docker-compose up` and visit `http://localhost:8080`

Test production bundle at `http://localhost:8081` (should work on IE11+)