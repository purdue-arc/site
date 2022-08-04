---
title: "Using the Terminal"
linkTitle: "Using the Terminal"
weight: 10
date: 2022-08-04
description: >
    Tutorial on the basic features of Bash
---

## Prerequisites

If you are using Windows, you'll want to install [WSL2](/wiki/tutorials/wsl2) to follow along.

## Introduction

The terminal is an interface for interacting with your computer. While traditional applications are intuitive, they can hold you back from accomplishing complicated tasks.

The terminal is itself an interface to a shell on the system, which handles command execution and other nice features such as piping. Most Linux systems come packaged with BASH (Bourne Again SHell).

## Basic commands

Early on, you'll want to memorize a small subset of commands that can handle a majority of tasks.

```bash
$ pwd
```

This stands for 'print working directory', which as you can guess, prints the directory you are currently in. The shell automatically provides you with a location within your computer's file system. This can change the outcome of certain commands as we'll see.

```bash
$ ls
```

This is short for 'list'. It will print all of files in your working directory. If you modify the command:

```bash
$ ls -a
```

It will print all files (including hidden ones).

```bash
cd <folder>
```

This means 'change directory'. It allows you to modify your working directory. You can specify the `<folder>` argument in a variety of ways. If the folder you want to move into is contained within the current working directory, then you can specify a relative path using a period:

```bash
cd ./relative-directory
```

Similarly, if the folder is contained within your home directory, then you can use the tilde key:

```bash
cd ~/directory-in-home
```

Sometimes it is also useful to specify parent directories, which is done using sequential periods:

```bash
cd ../
```

This will change the working directory to the parent of the current working directory. You can chain this shortcut to move multiple levels:

```bash
cd ../../
```

## Going forward

Purdue's USB has a [cheatsheet](https://purdueusb.com//wiki/terminal-cheatsheet) with some additional information.

It's recommended you also explore shell text editors (such as [vim](https://www.vim.org/)) and version control systems (like [git](https://git-scm.com/)).