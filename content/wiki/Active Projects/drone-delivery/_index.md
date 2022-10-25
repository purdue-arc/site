---
title: Drone Delivery
weight: 3
description: >
    Building and programming a drone that can deliver packages
---

## Goal

Given a destination, autonomously deliver a package and return with no human intervention.

## Subteams

* Hardware: Designs and builds the drone, its sensors, and package container.
* Flight controls: Programs the drone using Robot Operating System (ROS) to ingest data and fly a given path. Tests flight in the simulation software Gazebo before real-world testing.
* Obstacle avoidance: Programs the drone to avoid obstacles in its planned flight path encountered while its flying. Uses Intel Realsense camera and its depth sensor to recognize near and far objects using computer vision and generate a 3D data structure of its surroundings.

## Technology

### Drone hardware

* Motors: T-Motor U7 V2.0
  * 6 total
  * 4.55kg Lift / Motor
  * Over 27kg of Thrust!
  * 47.5A Draw at 100% Throttle
* Props: Tarot 1855
  * 18'' Diameter
  * 5.5'' Pitch
  * Carbon fiber
* Frame: Tarot T960
  * Hexacopter Configuration
  * 960mm Diameter
* Battery: Tattu Plus LiPo Battery Pack
  * 22000mAh
  * 25C Discharge Rate
  * 6S
  * 22.2V
* Power Delivery (ESC): xRotor 40A
  * 60A Max Current
  * Rated for 6S LiPo (22.2V)
* Flight Controller: Pixhawk 6c
  * H7 Processor @ 480MHZ
    * PX4 Firmware
  * Redundant IMU
  * M8N GPS
* Camera: Intel RealSense D453
  * Stereoscopic Depth Sensing
  * < 2% Error Within 2m
* Companion Computer: Jetson Nano
  * Quad-core AMD Cortex
  * 4GB Onboard Memory
  * 128 Cuda Cores
* Infrared sensor: TBD
  * Used to find precise distance from ground to see if landing area is safe.
* Camera rotator/gimbal
  * Will rotate camera from forward-facing to downwards to ensure safe landing area.
  * Stabilization of camera during flight to minimize noise in optical data
* Parcel container
  * Structure
    * Minimize impact on aerodynamic performance
    * Safe to access for users
  * Food Preservation
    * Keep food hot, or cold, to ensure minimal loss in quality during delivery

### Drone software

* [PX4](https://px4.io/software/software-overview/): PX4 is the firmware that runs on the Pixhawk 6c. It controls and recieves data all of the motors and sensors attached.
* [QGroundControl](http://qgroundcontrol.com/): QGroundControl is the application used to connect to, configure, and program the drone to fly autonomously.
* Robot Operating System (ROS):
* MAVSDK:
* MAVLink:  

### Flight simulator

The flight simulator will run the same software we are programming the drone with on a drone in a simulator. This will allow us to test and quickly improve our sofware without risking breaking the actual drone and taking the time to fly it.

* Initial testing: Gazebo
* Complete solution: [CesiumJS](https://cesium.com/platform/cesiumjs/)

### Obstacle avoidance

* OpenCV

TODO

### Pre-flight path planning

* OpenStreetMap
* Photogrammetry
* Open3D
* Rasterio

### Pathfinding algorithm

D* will be the chosen pathfinding algorithm and will aim to be used by both the obstacle avoidance and pre-flight planning software.

### Flight control command pipeline

Generate a pipeline between the software that is written by various teams and the hardware that must run the code.

* Interface the pixhawk with external computers.
* Work with ROS in order to create sub-systems that interact neatly.
