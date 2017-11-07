# Tools

This folder contains a number of scripts useful for building, distributing
or otherwise working with the super-dials repository.

### Repository management

- `update-super.sh`: Fetches each of the submodule repositories, resets
  the repository to remote master, and then commits the changes to the
  master repository. Since this will reset changes, this should only be
  used for e.g. automatic tools to update the master repository.