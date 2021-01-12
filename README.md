Docker image for SSH Git Server

There are couple users:
- git is used for git-shell
- gitadmin is used to manage repositories

Use PUBLIC_KEY env var to add the initial public key (added to both git and gitadmin users)
