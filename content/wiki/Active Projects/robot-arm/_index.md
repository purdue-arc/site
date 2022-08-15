---
title: Robot Arm
date: 2021-06-01 00:00:00 Z
weight: 3
no_list: true
description: >
    Building a open-source, 3d-printed manipulator
---

## Goal

### Mission

Our overarching goal is to explore why robots are limited to factory environments and why we don't have them cooking for us  and folding our clothes yet.

In our journey, we plan to publish our progress, tutorials, code, and workshops. 

### Right now 

Right now, we're building software/hardware for a robot arm to play chess. 

From this, we hope to validate fundamental understanding of robot arm design, control (using control systems and/or reinforcement learning), sensor systems (vision, encoders, tactile), and mechanical actuator systems (servos, steppers, gearboxes). 

#### Hardware
We currently have two hardware efforts:
1. Designing a [Mr. Janktastic](https://wiki.purduearc.com/wiki/robot-arm/hardware#mr-janktastic) from scratch
2. Building the [open-source BCN3D Moveo Arm](https://wiki.purduearc.com/wiki/robot-arm/hardware#bcn3d-moveo-arm) for a better hardware system for software to experiment and test vision, RL systems with.

#### Software 
Working on a variety of problems in vision, control, and high level planning (RL soon!)). See the [Software Docs](https://wiki.purduearc.com/wiki/robot-arm/software) for a deeper dive.

## What have we done?

### May 2021

- Object detection working on chess pieces with 90%+ accuracy using YOLOv5 and usable in ROS
  - Put together a 500+ chess piece dataset for detection

<img src="images/obj_det_may_21.png" alt="Object detection demo" width="400"/>

- Prototype gripper fingers that can pick up chess pieces decently well

{% include googleDrivePlayer.html id="1P8rwWDJa1Yuv88X697RMvEq04j1IgpqW/preview" %}

- Created Gazebo simulation that is controlled by MoveIt pipeline, including a simulated camera, chessboard, and chess pieces

{% include googleDrivePlayer.html id="19FZ7lsqCn6DEChjjdBgsTy0feUANYaVO/preview" %}

### December 2020
- Got an early version of protoarm to stack some boxes using IK and trajectory planning from MoveIt and ROS

{% include googleDrivePlayer.html id="1yms3OuqYp-n4JCt-yBGZg8yEyajXOj_M/preview" %}

- Designed a prototype 6dof arm

<img src="images/6dof_dec_20.png" alt="6DOF arm CAD" width="200"/>

## Quick links 

- [GitHub](https://github.com/purdue-arc/arc_robot_arm)