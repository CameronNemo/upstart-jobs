# Upstart Jobs

This repository is somewhat of a dump of Upstart jobs that have been produced by myself and others over the years.

Most of the jobs attempt to use well known event names so that they may be used across different Upstart configurations.

## Checkpoints

Although there are more jobs than one would ever want to run in a single environment, there are some jobs which form the plumbing layer of an Upstart based init process. These are called `checkpoints`. All checkpoints emit at least two events: an `up` event and a `down` event. Jobs that are a part of the respective checkpoint should include these events in their `start on` and `stop on` stanzas. Before continuing, the checkpoint will wait until all jobs acting on these events finish their work. To order a job before or after a checkpoint, the `starting`, `started`, `stopping`, and `stopped` events can be used.

For example, a job that is part of the checkpoint multiuser would use the following configuration:

    start on multiuser-up
    stop on multiuser-down

A job that will start after and stop before the multiuser checkpoint:

    start on started multiuser
    stop on stopping multiuser

A job that will start before and stop after the checkpoint:

    start on starting multiuser
    stop on stopped multiuser

### sysinit: where it all starts

`sysinit` is the first checkpoint job that runs on boot. Jobs that are a part of this checkpoint will:

* ensure that the filesystem is mounted correctly (sub-checkpoint: fs)
* bring up static network configuration, including firewall (sub-checkpoint: net, firewall)
* set the hostname, motd, sysctl options, and system clock time
* load kernel modules, seed urandom, save boot logs
* start the device manager and trigger events for coldplug devices
* etc

### basic: bring up Upstart bridges

Upstart provides extensibility through the use of bridges. Any privileged process may emit Upstart events, and the `file` and `socket` events are emitted exclusively by Upstart bridges.

### multiuser

#### syslog

#### nss-lookup (named)

#### rc

#### single user mode

### login

### graphical

## Notable services
