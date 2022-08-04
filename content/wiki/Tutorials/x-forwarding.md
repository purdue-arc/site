---
title: "X Forwarding"
linkTitle: "X Forwarding"
weight: 15
date: 2022-08-04
description: >
    Tutorial on forwarding remote graphical interfaces to your local machine
---

## Prerequisites

Before starting this tutorial, we recommend:
- [Familiarity with using the terminal](/wiki/tutorials/terminal)

## Introduction

X forwarding is what will let you display GUIs (graphical user interfaces)
on your machine that are being run from your Docker container. You need
to install an X client, set up the appropriate firewall rules, then tell Docker
to forward its display to your client.

## Instructions by OS

X forwarding configuration varies by machine, so follow the steps that match your operating system. If you run into any issues or don't have a supported OS, reach out in the comments below.

### Windows 10 / 11

**X Client Set Up**

There are several options available here. VcXsrv has been tested to work with
the ARC development environment and is available on [SourceForge](https://sourceforge.net/projects/vcxsrv/).
VcXsrv is the recommended client.

If you install VcXsrv, launch it with the `XLaunch.exe` executable, not `VcXsrv.exe`.
When you launch it for the first time, you will see several configuration pages.
You may leave them all at the default: multiple windows, no clients.

**Windows Firewall Setup**

When you first launch your X client, you should see Windows Firwall pop up. Go
ahead with the default settings.

Now that everything is blocked, we need to put in an exception so that our WSL2
instance is able to access the X client.

These instructions are taken from a [Reddit post](https://www.reddit.com/r/Windows10/comments/gd7n5z/how_do_i_convince_windows_10_that_a_vethernet/)
1. Launch Windows Firewall. Simply search "Firewall" in the Start Menu
2. [Go to properties](https://i.imgur.com/oo9L3pH.png)
3. [Go to "Public Profile](https://i.imgur.com/ZbSjO8k.png)
4. [Select "Customize"](https://i.imgur.com/1rOprzr.png)
5. [Uncheck the "(WSL)" option](https://i.imgur.com/9ZaWc3S.png)

Go ahead and save and close everything. You may need to reboot your X client.

**WSL2 Setup**

We will need to edit a file called the `bashrc`. This is a script that is run
every time you open a new terminal in order to set up your environment. Modify
it by copy and pasting the below command in _exactly_. Run these commands in
WLS2, not Powershell or Windows Commandline. From now on, all commands to be
listed like this should be put into the WSL2 commandline.
```bash
echo -e '\nexport DISPLAY=$(awk '\''/nameserver / {print $2; exit}'\'' /etc/resolv.conf 2>/dev/null):0\nexport LIBGL_ALWAYS_INDIRECT=1' >> ~/.bashrc
```
Since we just changed our `bashrc`, we need to run the below command for the
changes to take effect in our current terminal:
```bash
source ~/.bashrc
```

**Testing**

You will need to download a small program called `xeyes` in order to test the X
forwarding. It can be installed and run with the following commands:
```bash
sudo apt install -y x11-apps
xeyes
```
You'll see a little pair of eyes follow your cursor around. You can X out of it
or hit `CTRL+C` in order to kill the program.

### Mac

**X Client Set Up**

The most widely used X client for Mac is X Quartz. You can install it [here](https://www.xquartz.org/).

**Configure X Quartz**

You need to first allow connections from network clients:

```zsh
defaults write org.macosforge.xquartz.X11.plist nolisten_tcp 0
```

Now run the following command to allow localhost access on startup:

```zsh
echo 'export DISPLAY=host.docker.internal:0 \nxhost + 127.0.0.1' >> ~/.zshrc
```

After running the above command, restart your system.

**Errors with running X Quartx**

If you have errors while completing the above steps, take a look at the following [trouble shooting guide](mac-errors).

**Testing**

You will need to download a small program called `xeyes` in order to test the X
forwarding. It can be installed and run with the following commands:
```bash
sudo apt install -y x11-apps
xeyes
```
You'll see a little pair of eyes follow your cursor around. You can X out of it
or hit `CTRL+C` in order to kill the program.