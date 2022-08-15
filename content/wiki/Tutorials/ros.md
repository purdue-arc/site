---
title: "ROS"
weight: 20
date: 2022-08-04
description: >
    Tutorial on robot operating system
---

## Prerequisites

Before starting this tutorial, we recommend:
- [Familiarity with using the terminal](/wiki/tutorials/terminal)
- [An understanding of Python](https://wiki.python.org/moin/BeginnersGuide/Programmers)

## What is ROS?

ROS stands for Robot Operating System. It is an industry standard tool for creating autonomous robots. Essentially, it is a framework to create a mesh of nodes that work together to control your robot. It has an API for both C++ and Python. Through it, you have a common language to define messages that are sent from one node to another (for example a path planning node can send waypoint messages to a low level control node). The beauty of it is that all the nodes can be modular and developed independently if you have a well defined interface of messages.

Another really excellent reason to use ROS is the 5000+ number of existing packages that can act as ‘plug and play’ into your existing network. If you have a new sensor you’re looking to try, someone has probably already written a ROS driver for it. Tasks such as mapping, perception, and state estimation that many robots need to do probably have multiple packages that you can experiment with and pick the best one for your specific application. There are also pre-defined messages for standard things like sensor data and control commands. For these reasons it can be really useful for jump-starting a new project.

Through this club, you will be learning much more about ROS. The snake_tutorial package will walk you through creating a few simple nodes that can be chained together to control a snake to reach a goal. You will also have the opportunity to expand on the very basic controller given to you in an open ended challenge to create the highest performing AI for the snake.

A downside of ROS is that it works really well on Ubuntu, but isn’t well supported on other operating systems. This is why we must set up a very specific development environment for the club.

For more information on ROS, check out their wiki: [http://wiki.ros.org/ROS/Introduction](http://wiki.ros.org/ROS/Introduction)

## Setup / Installation

A development environment (DE) is a suite of tools used to streamline writing, running, and testing code. 

To simplify the installation and setup process for using ROS, ARC has created a standard DE that we recommend for all members.

ARC's DE relies on a program known as Docker. This program virtualizes various operating systems and dependencies to ensure your software is compatible to run on any device you choose to use.

> ARC use to fully support another DE using Construct. If Docker fails to work on your machine, you can explore [this method](alt-ros) as an alternative.

If you have ever worked with a virtual machine, it's the same concept but avoids a bunch of uncecessary programs and overhead.

'Images' in Docker can be thought of as blueprints for a computer to be virtualized. ARC has created a generic image with all the required dependencies for ROS. When working on a ROS project, you will run a 'container', which is just a single instance of ARC's image. All of this is managed by boilerplate scripts that you just need to include in your project. 

> To learn more about how Docker works internally, check [their documentation](https://docs.docker.com/engine/).

ARC's image uses Ubuntu 20.04 with ROS Noetic installed. It also has a few other handy tools, such as zsh.

The rest of this section will detail the setup process for ARC's DE.

### Docker Installation

Follow [this installation guide](https://docs.docker.com/engine/install/) to get Docker for your specific OS.

### Instructions by OS

See the below instructions depending on what operating system you are running.

#### Windows

> This guide was tested on Windows 10 and 11, if you are using a prior version you will need to upgrade or consider dual-booting.

To use ARC's DE on Windows, you will need WSL2. We have a seperate tutorial for this, which you can follow [here](wsl2).

You then need to setup X forwarding. This allows you to display GUIs (graphical user interfaces) from your WSL2 instance on your Windows machine. Again we have a seperate tutorial for this, which you can follow [here](x-forwarding).


#### Mac

Presently, this guide has not been fully tested on a Mac system. In theory it should because there is a version of Docker for Mac, but some additional work is required to get all features to function. If you're interested in running this on Mac, understand that some experimentation may be required.

You need to setup X forwarding. This allows you to display GUIs (graphical user interfaces) from your Docker instance on your machine. We have a seperate tutorial for this, which you can follow [here](x-forwarding).

#### Linux

This guide has been tested to work on Ubuntu 18.04 and 20.04. If you have a different distribution, it should also work without issue.

### Testing

To ensure that everything works, follow the process below. 

> You don't have to understand what all of these commands do yet, this will be explained with more depth in future sections. If any of these commands return an error, take a moment to try and independently debug. If after 5 minutes you have no luck, reach out in the comments and somebody can assist.

Move to your home directory:
```bash
cd
```

Setup a catkin workspace:
```bash
mkdir -p catkin_ws/src
```

Move into the source code folder:
```bash
cd catkin_ws/src
```

Clone the ARC tutorials package:
```bash
git clone git@github.com:purdue-arc/arc_tutorials.git
```

Build the docker image:
```bash
./arc_tutorials/docker/docker-build.sh
```

Run the docker container:
```bash
./arc_tutorials/docker/docker-run.sh
```

Your terminal should now show a new prompt indicating that you are within the docker container. This is a new environment where all of the ROS dependencies have been installed.

Again move into the catkin workspace:
```bash
cd catkin_ws
```

Build the `arc_tutorial` package:
```bash
catkin build
```

Update your environment with the newest build:
```bash
source devel/setup.bash
```

Lastly launch snake game:
```bash
roslaunch snakesim snakesim.launch
```

Upon running this, two windows should appear:

![Snake Sim](assets/images/snake-sim.PNG)
![Snake control](assets/images/snake-sim-control-board.PNG)

If these windows don't appear, but every other command ran fine, then X forwarding is likely not working. Review the [X forwarding](/wiki/tutorials/x-forwarding) tutorial and if nothing works, then reach out in the comments.

If they did appear however, then your dev environment is fully working!

## Learning the Basics

You now have a basic idea of what ROS is and can run it on your machine. It's time to learn the basics of what it offers.

The environment you tested in the last section will serve as a simple platform to study ROS.

Check out the [video we made to introduce this section of the tutorial](https://youtu.be/q9RCP4lizNM).

After watching the above video, you can move on to the [walkthrough](/wiki/tutorials/snake-game).

## Moving Forward

Congrats! You are one step closer to world domination. While you can learn more about ROS in [their tutorials](http://wiki.ros.org/ROS/Tutorials), we recommend diving in through one of the club projects.
