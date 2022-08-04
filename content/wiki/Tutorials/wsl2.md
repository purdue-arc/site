---
title: "WSL2"
linkTitle: "WSL2"
weight: 8
date: 2022-08-04
description: >
    Tutorial on Windows Subsystem for Linux
---

## Introduction

Most development tools are built for Linux systems, which is why writing software on pure Windows isn't recommended.

To get around this, developers use WSL2 (Windows Subsystem for Linux version 2). Essentially, Windows is running a full Linux system in tandem with Windows. This has much better performance than running a virtual machine (VM) or using the original WSL.

This document will guide you through setting up WSL 2 on Windows 10 & 11.

## Installation

Microsoft has published an [online guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10),
for setting up WSL2, which contains the most up-to-date information for installing
WSL2 on Windows. Follow the guide fully, and for step 6, install [Ubuntu 20.04 LTS](https://www.microsoft.com/store/apps/9n6svws3rx71).

Make sure to [set up a non-root user account](https://docs.microsoft.com/en-us/windows/wsl/user-support)!

## Windows Terminal

While WSL2 does come with its own terminal, it isn't very aesthetic or functional. That's why we recommend installing [Windows Terminal](https://aka.ms/terminal). Once it is installed, launch it, then click the downwards arrow icon on the list of tabs. Select Ubuntu 20.04 from the dropdown, and you will be greeted with a bash terminal for your WSL2 instance.

If you'd like to make the default behavior to open WSL2 tabs, you can hit the dropdown and select settings.

## Visual Studio Code

When working in a larger project, you might find it a hassle to edit multiple files with vim or other CLI text editors. An alternative is Visual Studio Code, a text editor made by Microsoft to be lightweight and adaptable. With a  few extensions, VS Code can be customized to work efficiently within ARC's development environment.

> Note: This isn't required for working within the ARC development environment. It's purely a tool that some may find useful.

### Installing VS Code
Available builds can be found [here](https://code.visualstudio.com/).

### Extension Installation
After downloading and installing VS Code, open it to find a menu on the left hand side. Then click the icon containing stacked blocks, this is your extension menu. Here you can install applications to give VS Code more capabilities. 

If you are running WSL2, you should start by installing the [Remote - WSL](
   https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl
) extension. You can use the search bar at the top to find it, then simply click install. If you aren't using WSL2, you can skip to installing the Python extension below.

After installing Remote WSL, you will need to reopen VS Code within your Ubuntu environment. You can do this by hitting `CTRL + SHIFT + P`, then typing:

```
Remote-WSL: New Window
```

Hit enter and it should bring up a new VS Code window running on Ubuntu. You can go ahead and close the old VS Code instance. Return to the extension menu, then you should see a new section labeled: _WSL:Ubuntu - Installed_

In order for any extensions to take place within WSL, you need to ensure that they are listed here.

Now we need to ensure that VS Code recognizes the primary language we use for developement, [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python). Which has it's own extension in the marketplace.

Next, you are going to want the [Docker](
   https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker
) extension. This will enable you to run ARC docker containers.

Lastly, it's recommended you get the [Git Graph](
   https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph
) extension. This isn't required, however it helps in any environment where you are utilizing git version control. Git Graph can visualize branches, merges, and commits to help organize your codebase. 

### Extension Usage
Now that you have the extensions installed, how do you use them? 

We are already using the WSL extension, which you can verify by seeing a _WSL: Ubuntu_ label in the bottom left corner (unless you are on Linux or Mac).

To open the console, enter: 

```
CTRL + SHIFT + ~
```

You can now run bash commands as per usual. If there is a file or folder you want to edit in VS Code, run:

```
code (folder or file name)
```

For utilizing Docker in VS Code, click the Docker icon on the menu bar. Now you will be able to see all images and containers you are using. You should still use `docker-build.sh` and `docker-run.sh` scripts for running ARC containers, however this is a useful tool for managing versions.

If you intend on using VS Code, it might be helpful to check out their own [tutorials](https://code.visualstudio.com/docs/introvideos/basics).

## Going Forward

Now that WSL2 is setup, you'll want to setup [X forwarding](x-forwarding) for running GUI applications. Additionally if you are unfamilar with bash, checkout our [terminal guide](terminal).