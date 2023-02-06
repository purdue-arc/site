---
title: Drone Delivery
weight: 3
description: >
    Developing an drone that autonomously delivers packages. 
---

## Goal
Build and develop a drone that can be used in the applications of last-mile delivery. 

## Subteams
1. Hardware: Build the physical drone, develop the controls algorithm for a flight controller. 
2. Obstacle Avoidance: Plan a long term route, detect obstacles, and avoid them. 
3. Flight Controller: Design and build a simple flight controller using Raspberry Pi PICOs. 
4. Research: Identify the latest technologies in the field that can be used by the other team. 
5. Mobile App: Build a mobile app that enables users to interface with the drone. 

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
* Flight Controller: Custom controller. 
  * Based on Raspberry PI Pico.
  * 3 axis Gyro, and 3 axis acclereometer. 
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

 
