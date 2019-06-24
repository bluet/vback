[![Open Source Helpers](https://www.codetriage.com/bluet/vback/badges/users.svg)](https://www.codetriage.com/bluet/vback)
[![GitHub license](https://img.shields.io/github/license/BlueT/vback.svg)](https://github.com/BlueT/vback/blob/master/LICENSE)


# vback

Backup your Docker Volumes

- Fast and clean.
- Archive whole volume into one file.
- Gzip in Parallel, with progress bar.

See usage: `docker run bluet/vback`


**Note**: Make sure no container is using the volume before backup or restore, otherwise your data might be damaged.

## Syntax

`docker run [options] [volumes] bluet/vback <action> file`

### Backup / Restore volume to/from File

Use `-it` to see progress bar.

```
docker run [-it] -v [source-volume-name]:/volume -v [archive-dir]:/backup --rm bluet/vback backup [archive-name]
docker run [-it] -v [target-volume-name]:/volume -v [archive-dir]:/backup --rm bluet/vback restore [archive-name]
```

Example:

Backup all data in volume *docker_dbdata*, save the archive file *dbsata.tar.gz* into *./backup/*.
  - `docker run -it -v docker_dbdata:/volume -v $PWD/backup:/backup --rm bluet/vback backup dbdata`

Restore data from archive file */data/backup/dbsata.tar.gz* to volume *drsite_dbdata*.
  - **Note**: This operation will delete all contents of the volume
  - `docker run -it -v drsite_dbdata:/volume -v /data/backup:/backup --rm bluet/vback restore dbdata`


### Backup / Restore volume to/from standard input/output (STDIO)

With STDIO support, you can pipe or redirect raw data stream of archive file to next program, any new file, or even send over network.

Must at least use `-i` to interact with process pipe.

    docker run -it -v [source-volume-name]:/volume --rm bluet/vback backup - > [archive-filename]
    cat [archive-filename] | docker run -it -v [target-volume-name]:/volume --rm bluet/vback restore -

Example:

Avoids mounting a second backup volume.
  - `docker run -v docker_dbdata:/volume --rm bluet/vback backup - > dbdata.tar.gz`
  - `cat dbdata.tar.gz | docker run -i -v drsite_dbdata:/volume --rm bluet/vback restore -`

Or, even send to remote over network
  - (local) $ `docker run -v local_data:/volume --rm bluet/vback backup - | nc ...`
  - (remote) $ `nc ... | docker run -v imported_data:/volume --rm bluet/vback restore -`



## Credit

This is an improved version of [loomchild's volume-backup](https://github.com/loomchild/volume-backup) utility to backup and restore [docker volumes](https://docs.docker.com/engine/reference/commandline/volume/). 
