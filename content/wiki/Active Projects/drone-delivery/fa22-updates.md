---
title: Fall 2022 Progress Updates
weight: 3
description: >
    A general summary of all the progress that was made in the Fall of 2022. 
---

<img src="/wiki/active-projects/drone-delivery/images/nav_idea.png" alt="idea" width="400"/>

### Pre-flight Planning

The idea was to generate a occupancy grid of campus that can be used as an occupancy grid. 
* Used OpenStreetMap to generate a isolated 3d map of campus. 
    * https://www.openstreetmap.org/#map=5/38.007/-95.844
* Converted that into a 2D map using Rasterization techniques. 
* Initially planned on using Octrees, but later decided not to due to the vast amount of memory that would consume. 
* Has a separate page, which describes the stack in much greater detail.
/wiki/active-projects/drone-delivery/images/
The following is the point cloud generated from OpenStreetMap.
<img src="/wiki/active-projects/drone-delivery/images/point_cloud.png" alt="cloud" width="400"/>

The Octree that was generated. 
<img src="/wiki/active-projects/drone-delivery/images/octree.png" alt="tree" width="400"/>

The occupancy gird that was generated.
<img src="/wiki/active-projects/drone-delivery/images/occupancy.png" alt="occupancy" width="400"/>



### Obstacle Avoidance:

* Migrate the code for Realsense camera from Python → C++
   * Able to get depth matrix
   * Can convert to occupancy matrix
* Implimenting a the D* and A* algorithms. 
   * There are issues in how the paths are generated, in that sometimes diagonal paths are taken over straight ones, even though the latter is possible to produce. 
   * To be improved in Spring 2023. 
* OpenCV integration for detecting obstacles at a greater depth. 

The Output from the A* algorithm we develped:
<img src="/wiki/active-projects/drone-delivery/images/astar_path.png" alt="astar" width="400"/>

An example of an unideal path:
<img src="/wiki/active-projects/drone-delivery/images/sub_optimal.png" alt="erros" width="400"/>


### Hardware:
* Established mission objectives, such as flight time and pay load weight.
* Picked a drone kit, selected baterries, motor controllers, motors and propellers. 
    *  A detailed document describing all the design choices that were made: 
        https://docs.google.com/document/d/1YcgpvD2AsxBpSHcqvRHN5PRzlyk0kKi2nl-Srrc2DXE/edit?usp=sharing
* Check the main page for details on what hardware components were selected. 

### Interfacing:
* Repaired the old drone, and interfaced a computer with it.
* Simulated pre-programmed fight paths using Gazebo and QGroundControl. 
* Worked on importing OpenStreetMap data into Gazebo. 

<img src="/wiki/active-projects/drone-delivery/images/sim.png" alt="sim" width="400"/>




### Research: 
* Over the course of the semester, the team reseached several important topics and developed whitepapers, and plan documents. 
    * Deegan Osmundson: A* based navigation algorithms.
        https://drive.google.com/file/d/1XcB0w0IvobgjAYehDYUqe3qoPYX0miRA/view
    * Seth Deegan: Drone Delivery Tech Stack
        https://docs.google.com/document/d/1ekadDu0ogtgF6m-fK_AaudN6HzlPpPMSJ_rsvxW74-M/edit#heading=h.fliy5digh3xk
    * Sooraj Chetput: Steps in implimenting the software stack for DD. 
        https://drive.google.com/file/d/1RyhzLklxlVaUF0ReHZfJ17z1Qm90ic8P/view
    * Jake Harrelson and several Authors: Design and Implementation of Unmanned Aerial Vehicle for Local Food Delivery
        https://docs.google.com/document/d/1YcgpvD2AsxBpSHcqvRHN5PRzlyk0kKi2nl-Srrc2DXE/view

### Acknowledgements:
* Project Managers: Sooraj Chetput
* Obstacle Avoidance Team Members: Guna Avula (Lead), Deegan Osmundson, Chris Qiu, Ethan Baird, Mouli Sangita
* Pre-flight planning: Seth Deegan (Lead), Vincent Wang
* Research: Sreevickrant Sreekanth (Lead), Vignesh Charapalli
* Hardware: Jacob Harrelson (Lead), Evan Zher
* Interfacing: Sooraj Chetput (Lead), Atharva Bhide




