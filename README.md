`rsyncd` provides read only RSYNC access to a mounted volume.

## Usage

In the example below:
- I am defining the basepath containing all the to be exported repositories
- ALLOWing connections from any network, and 
- defining which subdirectories of /mirrors/repos/ will be created as rsync modules (rocky, almalinux and parrot in this example).
They should be existing directories inside the basepath

```sh
docker run -d -p 873:873 -e ALLOW='0.0.0.0/0'  -v /mirrors/repos/:/docker/ --name rsyncd hc6pe/rsyncd:latest rocky almalinux parrot
```

You can connect to rsync server inside a container like this:

```sh
rsync rsync://<docker>/
rocky
almalinux
parrot
```

