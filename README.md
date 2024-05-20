iso2usb
=======

Attempted platform agnostic utility to convert iso -> usb


# Supported OS:

- MacOS
- Linux


# Examples

## On a MacOS host


### Determine USB disk

Run this command and find your USB disk

```
diskutil list
```

Next, once the drive is known

```
./iso2usb.sh ~/Downloads/linuxmint-21.3-xfce-64bit.iso disk2
```


## On a Linux host

Run this command and find your USB disk
```
sudo disk -l
```

Next, once the drive is known

```
./iso2usb.sh ~/Downloads/linuxmint-21.3-xfce-64bit.iso sdb
```


# Copyright 2024
