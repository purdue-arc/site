---
title: "Snake Game"
weight: 10
date: 2022-08-04
toc_hide: true
hide_summary: true
description: >
    Snake game tutorial for learning ROS
---

## Prerequisites

Before starting this tutorial, we recommend:
- [Setting up your development environment](/wiki/tutorials/ros)

## Overview
Before we dive into ROS, let's break down what we will be accomplishing.
Our end goal is to automate a game of Snake. If you have never heard of
Snake, then check out an example 
[here](https://www.google.com/search?client=firefox-b-1-d&q=snake+game). 
We have made a ROS adaptation of it, which is what you will be automating.

There are two parts to this tutorial:
- Controller walkthrough: Here we will walk you through the
  creation of your own snake-controller. This will teach the basics of
  ROS and principles related to automation.
- Controller expansion: By the end of the previous section, you will 
  have a simple but functional controller. To strengthen your ROS skills, 
  you will now look at improving the controller and seeing how high of 
  score your snake can get.

## Setup

If you've correctly setup your development environment, then you should have a `catkin_ws` folder with `src/arc_tutorials` a folder inside. Move into the `arc_tutorials` folder and run the docker container:

```bash
./arc_tutorials/docker/docker-run.sh
```

You should now be inside the container.

## Verification

Ensure your file structure matches the following:
```
catkin_ws/ <-- You should be here
│
└───src/
    │
    └───arc_tutorials/
       │
       └───clock_tutorial/ (deprecated tutorials)
       │
       └───docker/ (virtualization)
       │
       └───docs/ (setup instructions)
       │
       └───snake_tutorial/ (ROS tutorial)
       │
       └───snakesim/ (snake_tutorial backend)
```

We will explain the file structure in-depth later, so don't worry if it doesn't
make any sense now.

## Instructions
To complete this tutorial, simply follow each provided documents in order. Ensure
you are reading thoroughly, as these tutorials are packed with tons of
information.

If you run into issues, start by doing independent research. If you haven't
found a solution after sufficiently making an attempt on your own, then add your question at the [botttom of this page](http://localhost:4000/wiki/tutorials/snake-tutorial#give-us-feedback). 


## Running the Snake Tutorial Example
In this section, we will be covering high-level ROS concepts and run the snake game example to see what we will be working towards.

### ROS Concepts
We discussed previously what ROS is, but now we are going to dive into
how ROS works.

In summary, ROS manages a system through 4 key components:
- Nodes: These are independent processes that perform computations. Nodes
 often relate nicely to physical parts within a system, like a camera or an arm.
- Messages: In order for different nodes to communicate, they need messages
 to define the structure of the data they are sending. If a map node wanted
 to tell a navigation node which way to move, it would have to use a message
 (like a 3-point coordinate) to pass that data.
- Topics: Messages help define the type of data we are sending, but topics
 are what deliver the messages. Without topics, a node would never know 
 where to send it's messages. Nodes can either publish or subscribe to a 
 topic, which means they can either receive all messages
 on that topic, send messages to that topic, or both. 
- Services: Topics are nice because it means nodes can send information
 without worrying about if another node receives it. However sometimes it
 may be necessary that a node receives a response from another before moving on.
 This is where services come in; services allow for request / reply interactions.

Here's a helpful visualization of node communication:

![Node communication](assets/images/node-communication.png)

As a supplementary resource / explanation, we recommend watching [this
video](https://www.youtube.com/watch?v=bJB9tv4ThV4&list=PLJNGprAk4DF5PY0kB866fEZfz6zMLJTF8&index=2)
until 5 minutes and 53 seconds.

> If some of these concepts aren't yet clear, don't worry. Through the
  walkthrough we will continue to strengthen our understanding.

### Snake Example
Now let's try to apply some of the concepts we've learned to the snake
game. We will start by running the `snakesim` package to see what we will
be controlling.

To verify that your workspace is correct, run:
```bash
ls catkin_ws
```
If everything is correct, you should simply see a `src/` folder. Let's now
move into our workspace by running:
```bash
cd catkin_ws
```

Now we need to build our workspace, which will setup our environment
to run packages. This will all be explained in the next section, so hang
in there. We do this with the command:
```bash
catkin build
```

Now if we print our directory contents again:
```bash
ls
```

We should see a few new folders, including a `devel/` folder which is 
also important for configuring our environment.

Again this will be covered in the next section, so just run these
commands and it will make sense soon.
```bash
source devel/setup.bash
```

With our workspace and environment fully configured, we can now run the 
packages we have stored.

Lets start by moving into our package directory:
```bash
cd src/arc_tutorials
```

If we print our directory again with `ls`, we should see 5 folders:
- `clock_tutorial/` a deprecated tutorial for ROS in C++
- `docker/` a set of tools to run ARC's docker environment
- `docs/` the collection of documents to follow this tutorial
- `snake_tutorial/` a ROS python package to teach basic control of the 
snake game
- `snakesim/` a ROS python package to run the snake game

In order to run the snake simulation, we will use what is known as a launch
file. It's not important for you to know how a launch file fully works at
the moment, but just know that it starts up ROS nodes in a set way so you
don't have to do it manually.

To run the launch file:
```bash
roslaunch snakesim snakesim.launch
```

Upon running this, two windows should appear. One shows a display of the
snake game and another is a control board for the snake (this is what we
will be replacing). Here's what they look like:

![Snake sim](assets/images/snake-sim.PNG) ![Snake control board](assets/images/snake-sim-control-board.PNG)

> If you get an error message saying `snakesim` is not a package, then 
you need run: `source devel/setup.bash` in the `catkin_ws/` directory.

> If you get an error message about failing to display, it's likely because X 
forwarding is incorrectly setup. Return to
[setup tutorial #3](../../docs/03_arc-dev-env.md) for more detail.

To control the snake, you can either move it with WASD and shift keys or
manually adjust the speed with the scroll bars.
Play around with it and see how far you can get.

In this example, we are using only one node and that's to
control the position of the snake. Every time you adjust the speed, you
are sending messages on a topic that the snake node is receiving. These
messages adjust the snake's velocity so it knows what position to move to.

Lets now close both of those windows and use `CTRL + C` in the console
to exit the program. Next we are going to run the snake controller
example to see what we are building towards.

Again we will use a launch file:
```bash
roslaunch snake_tutorial snake.launch
```

The snake game should appear again, but this time it should be
autonomously playing the game. If you watch it long enough, eventually
it will fail because its logic is very simple. By the end of this
tutorial, we will have built this same controller from the ground up.

### Final Notes
Congratulations, you just finished getting familiarized with the snake game
and the controller! You'll develop this same controller by following this
tutorial series. In the next step, you'll create a package to hold your
controller, then you'll write some nodes in order to control the snake.


## Creating the Controller Package
Up to this point, we have explored high-level ROS concepts and ran the
Snake game example controller. We will now go through practical concepts
related to development within ROS.

### ROS File Structure
Let's take a deeper dive into our project file structure.

Software in ROS is organized in `packages`. Packages contain our nodes, 
launch files, messages, services and more. When working on a project, you may have multiple
packages all responsible for various tasks. For instance, `snakesim/` and
`snake_tutorial/` are both examples of packages.

Packages are often managed within a catkin workspace, which is what you 
setup as part of your ARC development environment.

The simplified file structure for a workspace is as follows:
```
catkin_ws/
│
└───src/
│   └───example_package/
│   └───another_package/
│
└───devel/
|   └─setup.bash
|
└───build/
|
└───logs/
|
└───install/

```
`src/` is where the source code for all packages are stored. This commonly
contains repositories tracked by Git.

`build/` and `logs/` are created when building your code. We won't go into any
detail on these.

`devel/` and `install/` contain executables and bash files for setting up your
environment. It is optional to have an `install/` directory; we won't be using
one in this tutorial. There are a few distinctions between the two that we won't
get into.

Each time you open your workspace in a new terminal you will need to source this
setup file by running:
```bash
source devel/setup.bash
```

There is a way to do that automatically, which is covered at the end of this
document.

Here is a simplified file structure for Python ROS packages (C++ is different):
```
example_package/
│
└───nodes/
│
└───launch/
│
└───CMakeLists.txt
│
└───package.xml
```

`nodes/` contains node Python files for running ROS nodes. You'll end up making
several of these when following the tutorial.

`launch/` contains launch files. These can launch one or more nodes and contain
logic.

`CMakeLists.txt` is a build file used by your catkin workspace.

`package.xml` is a manifest that contains general package information.

### Creating a New Package
We will start by moving into the `src/` directory of our 
catkin workspace. As a reminder, you should still be within the container environment and 
have the following file path:

`~/catkin_ws/src/`

Now we will use this command to create our new package:

```bash
catkin_create_pkg snake_controller rospy geometry_msgs std_msgs snakesim tf python-angles
```
Looking at this command, `snake_controller` is the name of package and
all the parameters that follow are other packages that `snake_controller` 
depends on. Don't worry about what those packages are right now, you'll learn
about them when completing the tutorials.

Lets now move into our newly created package:

```bash
cd snake_controller/
```
Upon printing the directory contents, you can see have three items within
our package:
- `CMakeLists.txt`
- `package.xml`
- `src/`

In order to make things better set up for a purely Python ROS package, we're
going to modify the `CMakeLists.txt` and `package.xml`. We will also be making
a few directories. If you aren't comfortable making directories on the
commandline, you can do these steps in an IDE like VS Code.

### Modifying Package.xml
The `package.xml` file exists to capture some basic information about your
package, such as the author, maintainer, license, and any dependencies that your
package has. If we open the existing one, you can see it has a lot of
information, and some comments about how to edit it:
```xml
<?xml version="1.0"?>
<package format="2">
  <name>snake_controller</name>
  <version>0.0.0</version>
  <description>The snake_controller package</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag -->
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="jamesb@todo.todo">jamesb</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>


  <!-- Url tags are optional, but multiple are allowed, one per tag -->
  <!-- Optional attribute type can be: website, bugtracker, or repository -->
  <!-- Example: -->
  <!-- <url type="website">http://wiki.ros.org/snake_controller</url> -->


  <!-- Author tags are optional, multiple are allowed, one per tag -->
  <!-- Authors do not have to be maintainers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->


  <!-- The *depend tags are used to specify dependencies -->
  <!-- Dependencies can be catkin packages or system dependencies -->
  <!-- Examples: -->
  <!-- Use depend as a shortcut for packages that are both build and exec dependencies -->
  <!--   <depend>roscpp</depend> -->
  <!--   Note that this is equivalent to the following: -->
  <!--   <build_depend>roscpp</build_depend> -->
  <!--   <exec_depend>roscpp</exec_depend> -->
  <!-- Use build_depend for packages you need at compile time: -->
  <!--   <build_depend>message_generation</build_depend> -->
  <!-- Use build_export_depend for packages you need in order to build against this package: -->
  <!--   <build_export_depend>message_generation</build_export_depend> -->
  <!-- Use buildtool_depend for build tool packages: -->
  <!--   <buildtool_depend>catkin</buildtool_depend> -->
  <!-- Use exec_depend for packages you need at runtime: -->
  <!--   <exec_depend>message_runtime</exec_depend> -->
  <!-- Use test_depend for packages you need only for testing: -->
  <!--   <test_depend>gtest</test_depend> -->
  <!-- Use doc_depend for packages you need only for building documentation: -->
  <!--   <doc_depend>doxygen</doc_depend> -->
  <buildtool_depend>catkin</buildtool_depend>
  <build_depend>geometry_msgs</build_depend>
  <build_depend>python-angles</build_depend>
  <build_depend>rospy</build_depend>
  <build_depend>snakesim</build_depend>
  <build_depend>std_msgs</build_depend>
  <build_depend>tf</build_depend>
  <build_export_depend>geometry_msgs</build_export_depend>
  <build_export_depend>python-angles</build_export_depend>
  <build_export_depend>rospy</build_export_depend>
  <build_export_depend>snakesim</build_export_depend>
  <build_export_depend>std_msgs</build_export_depend>
  <build_export_depend>tf</build_export_depend>
  <exec_depend>geometry_msgs</exec_depend>
  <exec_depend>python-angles</exec_depend>
  <exec_depend>rospy</exec_depend>
  <exec_depend>snakesim</exec_depend>
  <exec_depend>std_msgs</exec_depend>
  <exec_depend>tf</exec_depend>


  <!-- The export tag contains other, unspecified, tags -->
  <export>
    <!-- Other tools can request additional information be placed here -->

  </export>
</package>
```

We're going to go ahead and remove a lot of the stuff that we don't need:
```xml
<?xml version="1.0"?>
<package format="2">
  <name>snake_controller</name>
  <version>0.0.0</version>
  <description>The snake_controller package</description>

  <!-- One maintainer tag required, multiple allowed, one person per tag -->
  <!-- Example:  -->
  <!-- <maintainer email="jane.doe@example.com">Jane Doe</maintainer> -->
  <maintainer email="jamesb@todo.todo">jamesb</maintainer>


  <!-- One license tag required, multiple allowed, one license per tag -->
  <!-- Commonly used license strings: -->
  <!--   BSD, MIT, Boost Software License, GPLv2, GPLv3, LGPLv2.1, LGPLv3 -->
  <license>TODO</license>

  <!-- Author tags are optional, multiple are allowed, one per tag -->
  <!-- Authors do not have to be maintainers, but could be -->
  <!-- Example: -->
  <!-- <author email="jane.doe@example.com">Jane Doe</author> -->
  
  <buildtool_depend>catkin</buildtool_depend>
  <exec_depend>geometry_msgs</exec_depend>
  <exec_depend>python-angles</exec_depend>
  <exec_depend>rospy</exec_depend>
  <exec_depend>snakesim</exec_depend>
  <exec_depend>std_msgs</exec_depend>
  <exec_depend>tf</exec_depend>
</package>
```

Go ahead and make a few changes to personalize it:
- add a version number if you want
- add yourself as the maintainer
- add a license if you want
- add yourself as an author

You should end up with something like this:
```xml
<?xml version="1.0"?>
<package format="2">
  <name>snake_controller</name>
  <version>1.0.0</version>
  <description>A basic controller for the snakesim package</description>

  <maintainer email="pete@purdue.edu">Purdue Pete</maintainer>
  <license>BSD 3 Clause</license>
  <author email="pete@purdue.edu">Purdue Pete</author>
  
  <buildtool_depend>catkin</buildtool_depend>
  <exec_depend>geometry_msgs</exec_depend>
  <exec_depend>python-angles</exec_depend>
  <exec_depend>rospy</exec_depend>
  <exec_depend>snakesim</exec_depend>
  <exec_depend>std_msgs</exec_depend>
  <exec_depend>tf</exec_depend>
</package>
```

### Modifying CMakeLists.txt
The `CMakeLists.txt` is similar to `package.xml` in that it contains a lot of
templated information for you to go in and edit. For a C++ package, it is very
important, rather complicated, and will be used to build the code. For a purely
Python package, it is actually really simple. It is only needed to make your
code compatible with the catkin build system.

If you open the existing one, you should see something like this:
```cmake
cmake_minimum_required(VERSION 3.0.2)
project(snake_controller)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  python-angles
  rospy
  snakesim
  std_msgs
  tf
)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)


## Uncomment this if the package has a setup.py. This macro ensures
## modules and global scripts declared therein get installed
## See http://ros.org/doc/api/catkin/html/user_guide/setup_dot_py.html
# catkin_python_setup()

################################################
## Declare ROS messages, services and actions ##
################################################

## To declare and build messages, services or actions from within this
## package, follow these steps:
## * Let MSG_DEP_SET be the set of packages whose message types you use in
##   your messages/services/actions (e.g. std_msgs, actionlib_msgs, ...).
## * In the file package.xml:
##   * add a build_depend tag for "message_generation"
##   * add a build_depend and a exec_depend tag for each package in MSG_DEP_SET
##   * If MSG_DEP_SET isn't empty the following dependency has been pulled in
##     but can be declared for certainty nonetheless:
##     * add a exec_depend tag for "message_runtime"
## * In this file (CMakeLists.txt):
##   * add "message_generation" and every package in MSG_DEP_SET to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * add "message_runtime" and every package in MSG_DEP_SET to
##     catkin_package(CATKIN_DEPENDS ...)
##   * uncomment the add_*_files sections below as needed
##     and list every .msg/.srv/.action file to be processed
##   * uncomment the generate_messages entry below
##   * add every package in MSG_DEP_SET to generate_messages(DEPENDENCIES ...)

## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
#   Message1.msg
#   Message2.msg
# )

## Generate services in the 'srv' folder
# add_service_files(
#   FILES
#   Service1.srv
#   Service2.srv
# )

## Generate actions in the 'action' folder
# add_action_files(
#   FILES
#   Action1.action
#   Action2.action
# )

## Generate added messages and services with any dependencies listed here
# generate_messages(
#   DEPENDENCIES
#   geometry_msgs#   std_msgs
# )

################################################
## Declare ROS dynamic reconfigure parameters ##
################################################

## To declare and build dynamic reconfigure parameters within this
## package, follow these steps:
## * In the file package.xml:
##   * add a build_depend and a exec_depend tag for "dynamic_reconfigure"
## * In this file (CMakeLists.txt):
##   * add "dynamic_reconfigure" to
##     find_package(catkin REQUIRED COMPONENTS ...)
##   * uncomment the "generate_dynamic_reconfigure_options" section below
##     and list every .cfg file to be processed

## Generate dynamic reconfigure parameters in the 'cfg' folder
# generate_dynamic_reconfigure_options(
#   cfg/DynReconf1.cfg
#   cfg/DynReconf2.cfg
# )

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if your package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES snake_controller
#  CATKIN_DEPENDS geometry_msgs python-angles rospy snakesim std_msgs tf
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

## Declare a C++ library
# add_library(${PROJECT_NAME}
#   src/${PROJECT_NAME}/snake_controller.cpp
# )

## Add cmake target dependencies of the library
## as an example, code may need to be generated before libraries
## either from message generation or dynamic reconfigure
# add_dependencies(${PROJECT_NAME} ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Declare a C++ executable
## With catkin_make all packages are built within a single CMake context
## The recommended prefix ensures that target names across packages don't collide
# add_executable(${PROJECT_NAME}_node src/snake_controller_node.cpp)

## Rename C++ executable without prefix
## The above recommended prefix causes long target names, the following renames the
## target back to the shorter version for ease of user use
## e.g. "rosrun someones_pkg node" instead of "rosrun someones_pkg someones_pkg_node"
# set_target_properties(${PROJECT_NAME}_node PROPERTIES OUTPUT_NAME node PREFIX "")

## Add cmake target dependencies of the executable
## same as for the library above
# add_dependencies(${PROJECT_NAME}_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

## Specify libraries to link a library or executable target against
# target_link_libraries(${PROJECT_NAME}_node
#   ${catkin_LIBRARIES}
# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# catkin_install_python(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_executables.html
# install(TARGETS ${PROJECT_NAME}_node
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark libraries for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_libraries.html
# install(TARGETS ${PROJECT_NAME}
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_snake_controller.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
```

Once we remove everything we don't need, it is pretty short:
```cmake
cmake_minimum_required(VERSION 3.0.2)
project(snake_controller)

# Find catkin macros
find_package(catkin REQUIRED)

# generates cmake config files and set variables for installation
catkin_package()
```

Optionally, you can leave the install and test section in there, but we won't be
using it for this tutorial.

### Creating the Package Directory Structure
We're going to remove the existing `src/` directory, which is commonly used for
C++ code or Python modules (we are making Python nodes, which are different).

Instead, make the directory structure that we talked about earlier:
```
snake_controller/
│
└───nodes/
│
└───launch/
│
└───CMakeLists.txt
│
└───package.xml
```

### Sourcing the Workspace Automatically
Remember how we said that you need to source the workspace for every new
terminal window that you open? The command looks like this:
```bash
source devel/setup.bash
```

Thankfully, there is a way to make that happen automatically by modifying a script called the `bashrc`.
This is a script that is run every time you open a new terminal. If we put that
source command at the end of it, then we don't need to worry about running it
manually for every new terminal we open. You can add that command by running
the following in your shell:
```bash
echo 'source ~/catkin_ws/devel/setup.bash' >> ~/.bashrc
```

We can now run that to make it take effect in our current terminal:
```bash
source ~/.bashrc
```

### Final Notes
Congratulations, you just finished creating a ROS package! In the following
documents, we'll build three nodes that will allow your new package to control
the snake game that you ran earlier.


## Heading Controller
### Overview
Since our snake recieves linear and angular velocity inputs, making a heading
controller seems like a good place to start. This will allow us to control the
heading of the snake using feedback control.

Feedback control (also called closed-loop control) means that we are using
sensor readings (in this case the output pose of the snake) in order to create
our control signal that we send to the snake. As a block diagram, it may look
like this:

![heading controller](assets/images/heading-controller.png)

This node is also going to handle the linear velocity command too. We're just
going to keep that at a constant value in order to keep things simple.

### Creating the Program
Let's go ahead and implement this controller in Python now.

We need to start by creating a new file. In the last tutorial, we were left with
the proper directory structure to start writing code. We need to make a new file
in the `nodes` directory to house our code. We'll call this file
`snake_heading_controller`.

Note that it is general practice not to add a `.py` file extension to nodes.
This is because the file name becomes the name of the node when building our
package with catkin. Ex: `rosrun snake_controller snake_heading_controller`
is cleaner than `rosrun snake_controller snake_heading_controller.py`.

Next, we need to make this file an executable:
```bash
chmod +x snake_heading_controller
```
You will need to do this for every node you create.

Let's start the file by writing a shebang and docstring.
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""
```
A shebang is a one line comment at the start of the file that tells the
computer how to run it. We will always use `#!/usr/bin/env python` for Python
files. You can read more about them [here](https://en.wikipedia.org/wiki/Shebang_(Unix))

A docstring is a comment in triple double quotes (`"""`) that serves as a
comment for that file, class, function, or method. They are part of the PEP 8
style guide for Python, which we'll be following for our Python code. You can
read more about docstrings [here](https://www.python.org/dev/peps/pep-0257/#what-is-a-docstring),
and more about PEP 8 [here](https://www.python.org/dev/peps/pep-0008/#introduction).

Now, let's move on and start laying the foundation for our file by writing our
`__main__` check and creating a class to hold our logic.
```python
class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        pass

if __name__ == "__main__":
    SnakeHeadingController()
```
What we've done in the first part of this program is create a class called
`SnakeHeadingController`. A class lets you group methods and variables together
inside an object. It is a key part of Object Oriented Programming (OOP). It is
useful for us, because we're going to have several variables holding data that
we'll need to access from different methods.

This class has a docstring like before, and it only has one method defined,
`__init__`. This function is called when you create a new instance of that class
and is used for initialization. Right now, we've put `pass` inside, which is a
Python keyword meaning "do nothing." It is a handy placeholder because leaving
the body of that function blank would result in an error.

In the second part of the program, we've told the program what to do if it is
executed. The variable `__name__` is set to `__main__` if this file is the main
one being executed. If this file is included in another through `import`, then
the following statements do not get run. We will call this the "`__main__`
check" moving forward. This is the first part of the program that will be
executing commands once ROS starts the node. In this case, it is creating an
instance of our `SnakeHeadingController` class and doing nothing else.

If you'd like, you can run this piece of code from your terminal with the
command:
```bash
./snake_heading_controller
```
> this command works because of the shebang :)

A keen observer will notice that nothing happened, and our program ended
immediately. This is because our code doesn't do anything yet. We call the
second part of our code, which creates an instance of a `SnakeHeadingController`,
which gets initialized through the `__init__` method, which does nothing. You
can put in print commands in various locations if you are confused about the
order in which that all happens:
```python
print "I am here #1"
```

### Creating the Node
Let's start our ROS specific setup now.

Let's modify the body of the `__init__` function to be the following. This is
replacing the `pass` keyword.
```python
        rospy.init_node('snake_heading_controller')

        rospy.spin()
```

Very importantly, we also need to tell Python to import the `rospy` module, so
that we have access to these functions. Add the following just below the
docstring:
```python
import rospy
```
An import command lets you pull in functionality from other Python files. This
is super useful to be able to re-use code and write small, modular files. If you
look at the source of the `snakesim` package, you will see it is full of imports.

Here is our current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""
import rospy

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        rospy.spin()

if __name__ == "__main__":
    SnakeHeadingController()
```

Let's run the program again to see what happens. Note that the commands are a
little bit more involved since we need the ROS core to be running.

Terminal 1:
```bash
roscore
```

Terminal 2:
```bash
./snake_heading_controller
```
Compared to the first time we ran this program, it may not seem like much has
changed. However, notice that the program will run forever. We need to manually
kill it with `ctrl+C`. This is due to the `spin` command. Essentially, this
command tells the node to wait indefinitely and process message subscriptions.
We don't have any current subscriptions, so the program isn't doing anything.

We can see the effect of the `init_node` command by running this in a third
terminal:
```bash
rosnode list
```
You will see your node, `snake_heading_controller` in the list of running nodes!

Feel free to try changing the name of the node or removing the `spin` command
to see what it does.

### Creating Subscriptions
In the last section, we learned that `spin` tells the program to wait
indefinitely and process message subscriptions. Let's create some of those
subscriptions now.

Before our `spin` command, add the following lines:
```python
        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)
```
The `Subscriber` command tells ROS to subscribe to a topic (argument 1), of a
specific type (argument 2), and call a function (argument 3) when it recieves a
new message. We need to define those callback functions now.

Put these lines after `__init__`:
```python
    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        pass

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        pass
```
We are defining methods for our `SnakeHeadingController` and simply using `pass`
so that we can hold off on the implementation for them. If you remember our
block diagram from earlier, we are subscribing to the desired heading and true
heading respectively.

The callbacks have one argument each (ignoring `self`), which is the contents of
the ROS message recieved. We'll talk more about how to interpret those shortly.

Lastly, we need to tell Python where to find these message types. Put this right
after our existing `import` command:
```python
from geometry_msgs.msg import PoseArray
from std_msgs.msg import Float64
```

Here is our current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""
import rospy
from geometry_msgs.msg import PoseArray
from std_msgs.msg import Float64

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        pass

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        pass

if __name__ == "__main__":
    SnakeHeadingController()
```

If we run the file now, we should see the two new callbacks. We'll use the same
first two commands, but we'll use a slightly different third command in order
to inspect the node.

Terminal 1:
```bash
roscore
```

Terminal 2:
```bash
./snake_heading_controller
```

Terminal 3:
```bash
rosnode info snake_heading_controller
```
You will see it is subscribed to `snake/pose` and `controller/heading` like we
intended!

### Creating Publishers
Thinking back to our block diagram, our program needs to output the commanded
linear velocity. We will need a publisher in order to do this.

Put this by the subscribers code. It can go before or after, but I like to put
them before.
```python
        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)
```
This `Publisher` command is similar to the `Subscriber` command. It will create
a ROS publisher on a given topic (argument 1), of a given type (argument 2),
with a specific queue size (argument 3). A queue size of 1 means that the most
recent message will always be sent and any older messages waiting to be sent
will get dropped. This is good for our application, since we don't want a delay
caused by old messages stuck in a buffer. You can read more about queue sizes
on the [ROS wiki](http://wiki.ros.org/rospy/Overview/Publishers%20and%20Subscribers#queue_size:_publish.28.29_behavior_and_queuing).

Another difference is that we are keeping a reference to the `Publisher` object.
This is important so that we can publish messages via that reference in the
future.

Again, we need to tell Python where to find this new message type. Replace the
existing `PoseArray` import command with the following:
```python
from geometry_msgs.msg import Twist, PoseArray
```

Here is our current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        pass

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        pass

if __name__ == "__main__":
    SnakeHeadingController()
```

We can test with the same commands as earlier:

Terminal 1:
```bash
roscore
```

Terminal 2:
```bash
./snake_heading_controller
```

Terminal 3:
```bash
rosnode info snake_heading_controller
```
You will see it is now publishing to `snake/cmd_vel` as we hoped!

### Dealing with ROS Message Definitions
Let's quickly talk about how to pull data out of the ROS messages that our
callbacks are recieving. The first thing you'll want to do is determine the
layout of the message you're receiving. This can be done by browsing the API
online or with a terminal command.

Online:
- [std_msgs/Float64](http://docs.ros.org/api/std_msgs/html/msg/Float64.html)
- [geometry_msgs/PoseArray](http://docs.ros.org/api/geometry_msgs/html/msg/PoseArray.html)

Terminal:
```bash
rosmsg info std_msgs/Float64
rosmsg info geometry_msgs/PoseArray
```

Note that message definitions can be nested. Our `PoseArray` message holds an
array of `Pose` messages, which is a different message type you can also find
on the [online API](http://docs.ros.org/api/geometry_msgs/html/msg/Pose.html).

Let's look at the heading callback (`heading_cb`) first since it has a simpler
message. There is only one field, `data`, which holds a 64 bit floating point
number. This is the same as a `float` type for most Python implementations.

We'll save that to a local variable and figure out what to do with it later.
Replace `pass` with the following command:
```python
heading_command = heading_msg.data
```

Let's look at the pose callback (`pose_cb`) now. You can see that it contains an
array of `Poses`. From the `README.md` file included in the `snakesim` package,
we know that this is an array with the pose of each element of the snake
starting at the head. We are only interested in the heading of the first
segment, which corresponds to the yaw of the pose at index 0.

We know we'll be looking at something like this:
```python
orientation = pose_msg.poses[0].orientation
```

To make things a little bit trickier, this orientation is encoded as a
quaternion, not an Euler angle. There are many good reasons ROS uses quaternions
instead of Euler angles. It avoids singularities, is compact, and there is no
ambiguity about what convention is in use. For humans though, Euler angles are
normally easier to understand, so we'll convert to them with the help of a
module included with ROS.

First, we'll import the module. Put this with your other `import` commands:
```python
from tf.transformations import euler_from_quaternion
```
You can read the documentation on this function [online](http://docs.ros.org/melodic/api/tf/html/python/transformations.html#tf.transformations.euler_from_quaternion).

Next, we need to put the quaternion data into a tuple in (x,y,z,w) order, then
call the function to get the Euler angles as a tuple in (roll, pitch, yaw)
order. Replace `pass` with the following:
```python
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
```

Here is our current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        orientation = pose_msg.poses[0].orientation

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        quat = (pose_msg.poses[0].orientation.x,
                pose_msg.poses[0].orientation.y,
                pose_msg.poses[0].orientation.z,
                pose_msg.poses[0].orientation.w)

        __, __, heading = euler_from_quaternion(quat)

if __name__ == "__main__":
    SnakeHeadingController()
```

You can run it again if you want, but there shouldn't be any difference from the
last time we ran it.

### Implementing the Controller
Now that everything is nicely laid out, let's get to the actual logic behind
the controller.

The first thing we want to do is figure out where the main loop is going to take
place. Since the pose callback is going to happen at a reasonably high rate, it
seems safe to put our code in there. If we wanted to be more careful, we could
look into using a `timer` or `rate` object.

In order to keep things simple, we're going to implement what is called a
[bang-bang controller](https://en.wikipedia.org/wiki/Bang%E2%80%93bang_control).
Essentially, it will output a fixed magnitude, positive or negative command
depending on the sign of the error. If we are too far left, it will shoot us
right. If we are too far right, it will shoot us left. If we wanted to be
fancier, we could look at something like a PID controller, but this will be
eaiser to implement and work just fine for our puproses.

On a basic level, our logic is going to look something like this:
```python
if have_heading_command:
    error = heading - heading_command
    angular_velocity = sign(error) * ANGULAR_VELOCITY_MAG
```

From this pseudocode, we know a few things:
 - we need a variable to hold the magnitude of the angular velocity output
 - we need to get the heading command data from the other callback
 - we need a good way to subtract angles that can handle +/- pi being the same
 - we need a math library to copy the sign of the error

Let's handle these in order:

First, we'll create an `ANGULAR_VELOCITY_MAG` variable. Put this line in the
`__init__` method after `init_node`:
```python
self.ANGULAR_VELOCITY_MAG = 2.0
```

Next, we'll make a variable for tracking the heading command. Put this by the
previous line:
```python
self.heading_command = None
```

Update the heading callback to use this variable rather than a local variable:
```python
self.heading_command = heading_msg.data
```

In order to handle the difference of angles, we'll use the `angles` module. Put
this line with your imports:
```python
from angles import shortest_angular_distance
```

In order to handle the sign of the error, we'll use the `math` module. Put this
line with your imports:
```python
from math import copysign
```

Now that we have all that out of the way, let's actually write the logic for the
loop. Modify the body of the pose callback to be the following:
```python
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)
```

Here's the current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""

# Python
from math import copysign
from angles import shortest_angular_distance

# ROS
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        self.heading_command = None
        self.ANGULAR_VELOCITY = 6.28

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        self.heading_command = heading_msg.data

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)

if __name__ == "__main__":
    SnakeHeadingController()
```

We'll be able to test this shortly, but it isn't ready just yet.

### Publishing the Output
Earlier we made a publisher and we wrote the logic to get the value to publish.
One of the last things we need is actually publishing the value.

Like we stated earlier, this node is going to use a constant value for the
linear velocity command for the snake. Let's define that constant now in the
`__init__` function:
```python
self.LINEAR_VELOCITY = 2.0
```
Note that we are using all uppercase for our contants. This is just a convention
to make it easier for others to understand our code.

Now that we have the value, we can publish our ROS message. We'll construct a
new message of the correct type, populate our values, then publish it. This will
take place at the end of the pose callback (`pose_cb`).
```python
            twist_msg = Twist()
            twist_msg.linear.x = self.LINEAR_VELOCITY
            twist_msg.angular.z = angular_velocity_command
            self.twist_pub.publish(twist_msg)
```

Here's the current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""

# Python
from math import copysign
from angles import shortest_angular_distance

# ROS
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        self.heading_command = None
        self.ANGULAR_VELOCITY = 6.28
        self.LINEAR_VELOCITY = 2.0

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        self.heading_command = heading_msg.data

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)

            twist_msg = Twist()
            twist_msg.linear.x = self.LINEAR_VELOCITY
            twist_msg.angular.z = angular_velocity_command
            self.twist_pub.publish(twist_msg)

if __name__ == "__main__":
    SnakeHeadingController()
```

We could go ahead and test this right now, but we're going to do a little bit of
finishing touches first.

### Using Parameters
Currently, we have two contants in our code, `ANGULAR_VELOCITY` and
`LINEAR_VELOCITY`. If we want to change them, we would need to edit the Python
file for the node. That may be OK if we never expect these values to change,
but ROS actually has a method for handling parameters that let's you set them
the moment you launch a node. This can be useful if the parameters might need to
be different under different use cases, or it is a value you want the end user
to tune.

Replace our existing definitions of these variables with the below:
```python
        self.ANGULAR_VELOCITY = rospy.get_param('~angular_velocity', 6.28)
        self.LINEAR_VELOCITY = rospy.get_param('~linear_velocity', 2.0)
```
Now, we are using `rospy` in order to get these parameters from a parameter
server. We'll talk about how to set those through ROS in just a minute. The name
of the parameter is the first argument, and the default value is the second.

Note the leading tilda, which makes these _local_ parameters. In general, you
will always want to use local parameters. Also note that this needs to take
place _after_ the call to `init_node`.

Here's the current file for reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""

# Python
from math import copysign
from angles import shortest_angular_distance

# ROS
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        self.heading_command = None
        self.ANGULAR_VELOCITY = rospy.get_param('~angular_velocity', 6.28)
        self.LINEAR_VELOCITY = rospy.get_param('~linear_velocity', 2.0)

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        self.heading_command = heading_msg.data

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)

            twist_msg = Twist()
            twist_msg.linear.x = self.LINEAR_VELOCITY
            twist_msg.angular.z = angular_velocity_command
            self.twist_pub.publish(twist_msg)

if __name__ == "__main__":
    SnakeHeadingController()
```

Again, we could go ahead and test this script right now. However, we're going to
set something up to make that an easier process in the next step.

### Creating a Launch File
Launching this program is somewhat involved. You need to start the ROS core in
one terminal window, then you need to launch this node in another. Can you
imagine how many terminal windows you would need for a large project? Thankfully,
ROS has a system to let you launch multiple nodes at once. It even let's you do
some fancy scripting to set parameters, launch nodes based off conditionals, and
nest files through include tags.

We need to create a new file inside the `launch` directory that we created
earlier. Let's name it `snake_controller.launch`.

Open this file up, and paste this in:
```xml
<launch>
  <node type="snake_heading_controller" pkg="snake_controller" name="snake_heading_controller"/>
</launch>
```

This is an XML description (similar to HTML) of the ROS network we're going to
launch. You can see we put in the type of the node (the filename for Python
nodes), the package, and a name. The name can be anything we want, but it made
sense to repeat the name of the node type.

As we get more nodes, we'll put them in here too so that we can launch them all
at once.

Let's test our code now. Since we've added new nodes since the last time we've
built our package, we need to re-build our project. Run the following command
from anywhere inside your `catkin_ws` directory.
```bash
catkin build
```

We also need to source the project. This let's the shell know what ROS programs
are available to call. If you've added it to your bashrc (if you've followed the
guide, you've done this) you can run the below command from anywhere:
```bash
source ~/.bashrc
```
You only need to do that in any terminal windows that are currently open. Any
new ones will have that done automatically. You could also close and re-open
them all instead of running that command if you really wanted ...

If you haven't added it to your bashrc, or just want to know how to source a
workspace manually, this is the command (from the `catkin_ws` directory):
```bash
source devel/setup.bash
```

Now, let's launch the code:
```bash
roslaunch snake_controller snake_controller.launch
```

This isn't super exciting because it isn't recieving any input and isn't
connected to the snake game. We'll fix that shortly.

### Extending the Launch File
You could launch the snake game in another shell with this command:
```bash
roslaunch snakesim snakesim.launch
```

Or you could launch both of them at once by creating a launch file that includes
both of them. Make a new launch file in the same directory as the last one
called `snake.launch`. This will be our primary launch file to get the whole
thing running.

Put the following lines in:
```xml
<launch>
  <include file="$(find snakesim)/launch/snakesim.launch"/>
  <include file="$(find snake_controller)/launch/snake_controller.launch"/>
</launch>
```

This file will call the `snakesim.launch` from that package, then call the
`snake_controller.launch` file that we just wrote. We can run it with the
below command:
```bash
roslaunch snake_controller snake.launch
```

You can also check that all the connections between the nodes are working by
visualizing it with rqt_graph. In a new terminal (with display capabilities),
run the following command.
```bash
rosrun rqt_graph rqt_graph
```

You should see a cool little diagram showing how your nodes are connected by
various topics.

### Giving the Heading Controller Input
Right now, it still isn't super exciting to run our node. The heading controller
isn't recieving any input so it isn't telling the snake to do anything. There
are a few ways we can fix this.

Let's look at a way to do it through the terminal, then we'll look at a way to
do it through a GUI.

You can manually publish ROS messages from the terminal using the `rostopic pub`
command. To give the snake a heading, you can run the following:
```bash
rostopic pub /controller/heading std_msgs/Float64 "data: 0.0"
```

You can see we need to specify the topic, the type, and the data. This will tab
complete, so that is cool. You can manually give the snake a few headings this
way and make sure the controller works. 0 corresponds to the right and it
increases counter-clockwise, measured in radians.

If you want a GUI to send messages, we can use a program called `rqt_publisher`.

Launch it with the following command on a terminal with display capabilites:
```bash
rosrun rqt_publisher rqt_publisher
```

You need to use a drop down to select the topic, then hit the plus to add it.
Then you need to hit a drop down arrow to be able to access the `data` field.
Once you have all that, hit the checkbox to start publishing. The controller
should behave the same way regardless of where the data is coming from.

### Further Launch File Notes
This is a quick note about how to work with arguments and parameters. This is
super useful for creating a robust system of modular launch files. We won't go
super in depth, and it isn't needed for the tutorial. However, you might find it
useful to know.

Remember how we made our two constants ROS parameters? Let's say that we really
want to be able to make our snake's linear velocity an argument that we can
control by specifying a value when we run roslaunch. We want to be able to
do this:
```bash
roslaunch snake_controller snake.launch linear_velocity:=5.0
```

The cool thing is that we can, and it isn't super difficult. First we need to
modify the `snake_controller.launch`:
```xml
<launch>
  <arg name="linear_velocity" default="2.0"/>
  <node type="snake_heading_controller" pkg="snake_controller" name="snake_heading_controller">
    <param name="linear_velocity" value="$(arg linear_velocity)"/>
  </node>
</launch>
```
Here, we've specified that we're expecting an argument called `linear_velocity`.
If we don't have anything explicitly set, we'll use a default value of 2.0. When
we start the `snake_heading_controller` node, we'll pass the value of our
argument to the node as a parameter.

Remember the distinction that arguments are for launch files, parameters are
for nodes.

If we try the above command, nothing different will happen? Why? Because we are
calling `snake.launch`, not `snake_controller.launch`. We need to set up a basic
pass through. Let's modify `snake.launch` to do that now:
```xml
<launch>
  <arg name="linear_velocity" default="2.0"/>

  <include file="$(find snakesim)/launch/snakesim.launch"/>

  <include file="$(find snake_controller)/launch/snake_controller.launch">
    <arg name="linear_velocity" value="$(arg linear_velocity)"/>
  </include>
</launch>
```

Now our above command will work :)

Note that you can have different default values at all the different levels. If
you want, make them all different and experiment with the speed of the snake
when you remove some of the new stuff that we just added.

If you're curious about what other shenanigans you can achieve with launch
files, the [ROS wiki](http://wiki.ros.org/roslaunch/XML) has a full guide to
the syntax.

### Final Notes
Congratulations, you made it to the end! You just made your first ROS node to
build a controller for the snake. This node is relatively simple, but hopefully
you learned a lot about using ROS that will help you in creating the next two
nodes. Those next two tutorials are much faster since we got all the basic
groundwork taken care of in this one.

Below you'll see the final file we developed, plus a breakdown of it in case if
you forget what a specific section is doing. Feel free to experiment with making
changes to this node, or move on to the next one.

### Full File for Reference:
```python
#!/usr/bin/env python
"""Node to control the heading of the snake.

License removed for brevity
"""

# Python
from math import copysign
from angles import shortest_angular_distance

# ROS
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion

class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        self.heading_command = None
        self.ANGULAR_VELOCITY = rospy.get_param('~angular_velocity', 6.28)
        self.LINEAR_VELOCITY = rospy.get_param('~linear_velocity', 2.0)

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()

    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        self.heading_command = heading_msg.data

    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)

            twist_msg = Twist()
            twist_msg.linear.x = self.LINEAR_VELOCITY
            twist_msg.angular.z = angular_velocity_command
            self.twist_pub.publish(twist_msg)

if __name__ == "__main__":
    SnakeHeadingController()
```

### Full File Broken Down:
```python
#!/usr/bin/env python
```
This is our shebang. It tells the command line how to execute our program.

```python
"""Node to control the heading of the snake.

License removed for brevity
"""
```
This is the docstring for the file. It gives a quick description and may also
include a license.

```python
# Python
from math import copysign
from angles import shortest_angular_distance

# ROS
import rospy
from geometry_msgs.msg import Twist, PoseArray
from std_msgs.msg import Float64
from tf.transformations import euler_from_quaternion
```
These are our import statements. They let us pull functionality from other
Python files. We've split them into two groups for visual purposes / convention.

```python
class SnakeHeadingController(object):
    """Simple heading controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_heading_controller')

        self.heading_command = None
        self.ANGULAR_VELOCITY = rospy.get_param('~angular_velocity', 6.28)
        self.LINEAR_VELOCITY = rospy.get_param('~linear_velocity', 2.0)

        # Publishers
        self.twist_pub = rospy.Publisher('snake/cmd_vel', Twist, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.pose_cb)
        rospy.Subscriber('controller/heading', Float64, self.heading_cb)

        rospy.spin()
```
This is the class definition for `SnakeHeadingController` and the `init` method.
The `init` method is run when a new `SnakeHeadingController` is made. It
initializes the node through ROS and gives it a name. The `heading_command`
variable is initialized as `None` so that we can distinguish between a lack of a
command and a command of 0. Two constants are created from ROS parameters, which
can be set in launch files or on the commandline.

The publishers and subscribers are created by specifying the topic and type. The
publisher also specifies a queue size and the subscribers specify a callback,
which is a function that gets called when a new message is received. A reference
to the publisher is retained so that we can publish to it in the future.

Lastly, we call `spin`. This command will block forever until the node is
shutdown. While it is blocking, the node responds to input by running the
callback methods for each new message it recieves.

```python
    def heading_cb(self, heading_msg):
        """Callback for heading goal."""
        self.heading_command = heading_msg.data

```
This is our callback for heading commands. It has a short docstring, and we
simply save the data from the message so that we can retrieve it later.

```python
    def pose_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if (self.heading_command is not None):
            quat = (pose_msg.poses[0].orientation.x,
                    pose_msg.poses[0].orientation.y,
                    pose_msg.poses[0].orientation.z,
                    pose_msg.poses[0].orientation.w)

            __, __, heading = euler_from_quaternion(quat)
            error = shortest_angular_distance(heading, self.heading_command)
            angular_velocity_command = copysign(self.ANGULAR_VELOCITY, error)

            twist_msg = Twist()
            twist_msg.linear.x = self.LINEAR_VELOCITY
            twist_msg.angular.z = angular_velocity_command
            self.twist_pub.publish(twist_msg)
```
This is the callback for pose messages from the snake. We've given it a nice
docstring and have a little check before running the main logic for the
controller. The orientation quaternion is converted into a yaw angle, we
calculate the error, then determine our control output. The control output is
wrapped up into a ROS message then published.

```python
if __name__ == "__main__":
    SnakeHeadingController()
```
This is the section of our code that gets called first when we start the
program. We simply make a `SnakeheadingController` object, then let the
`__init__` method take over.

## Position Controller
### Overview
Our snake is now controlled by heading. Why don't we try to extend it another
layer and control with with position? That seems useful if we want to tell it
to chase the goal or give it a series of waypoints.

We'll create a closed loop controller like last time. Our inputs will be the
current position of the snake's head and the commanded position. Our output will
be the required heading to reach that positition.

### Creating the Program
This will be just like the last program. Let's call it
`snake_position_controller` and put it in the `nodes` folder like last time.
Make sure to make it executable!

Again, we'll start the program by writing a shebang and docstring. The basic
groundwork for the file will be really similar to last time too. See if you can
write out the `__main__` check, declare a class, and prototype all the methods
our class will need by writing a docstring then using `pass`.

You should have gotten something like this:
```python
#!/usr/bin/env python
"""Node to control the position of the snake.

License removed for brevity
"""

class SnakePositionController(object):
    """Simple position controller for the snake."""
    def __init__(self):
        pass

    def position_cb(self, msg):
        """Callback for position."""
        pass

    def snake_cb(self, msg):
        """Callback for poses from the snake."""
        pass

if __name__ == "__main__":
    SnakePositionController()
```

### ROS Setup
This section will also be very similar to last time. We're going to initilize
the node, create our subscribers, and create our publishers. Take a look on the
ROS wiki, at both the [std_msgs](http://wiki.ros.org/std_msgs) and
[geometry_msgs](http://wiki.ros.org/geometry_msgs) packages and see if you can
pick out a good message type for the subscribers and publishers. Remember that
the message types need to match if we're recieving data from or sending data to
nodes that have already been written.

Once you've got a handle on that, go ahead and write the `__init__` method. You
can also update the argument names in the callbacks to be more explicit. Don't
forget any imports too!

You should have gotten something like this:
```python
#!/usr/bin/env python
"""Node to control the position of the snake.

License removed for brevity
"""

# ROS
import rospy
from geometry_msgs.msg import PoseArray, Point
from std_msgs.msg import Float64

class SnakePositionController(object):
    """Simple position controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_position_controller')

        # Publishers
        self.heading_pub = rospy.Publisher('controller/heading', Float64, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.snake_cb)
        rospy.Subscriber('controller/position', Point, self.position_cb)

        rospy.spin()

    def position_cb(self, point_msg):
        """Callback for position."""
        pass

    def snake_cb(self, pose_msg):
        """Callback for poses from the snake."""
        pass

if __name__ == "__main__":
    SnakePositionController()
```

You can see the `Point` message was selected for the `controller/position`
topic. Other notable options were `Pose`, `Pose2D`, and time-stamped variants of
those messages (`PointStamped` and `PoseStamped`, there is no `Pose2DStamped`).
Since our goal is just a position and doesn't need any orientation data, we
won't use a Pose type. Additionally, Pose2D is depreciated and shouldn't be used
anyways. We could have time-stamped the message, but a timestamp isn't needed.
We'll always just chase the latest position command.

There are many other messages worth looking at on the [ROS wiki](http://wiki.ros.org/common_msgs)
if you have a specific need in the future.

### Implementing the Controller
This controller can be implemented much like the last one. Create a variable to
track the desired position, then modify the positon callback in order to set it.

Try two write out the logic in the snake callback. You'll need a quick check,
then somehow you'll need to calculate the heading command. This can simply be
the heading from the point you are currently at, to the point you want to be at.
Once you have that, publish it as a ROS message. Don't forget any imports!

If you need a hint, the `atan2` function will help you out.

You should have come up with something like this:
```python
#!/usr/bin/env python
"""Node to control the position of the snake.

License removed for brevity
"""

# Python
import math

# ROS
import rospy
from geometry_msgs.msg import PoseArray, Point
from std_msgs.msg import Float64

class SnakePositionController(object):
    """Simple position controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_position_controller')

        self.position = None

        # Publishers
        self.heading_pub = rospy.Publisher('controller/heading', Float64, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.snake_cb)
        rospy.Subscriber('controller/position', Point, self.position_cb)

        rospy.spin()

    def position_cb(self, point_msg):
        """Callback for position."""
        self.position = (point_msg.x, point_msg.y)

    def snake_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if self.position is not None:
            pose = (pose_msg.poses[0].position.x, pose_msg.poses[0].position.y)

            # make a local copy to avoid threading issues
            position = self.position
            heading = math.atan2(position[1] - pose[1], position[0] - pose[0])
            self.heading_pub.publish(heading)

if __name__ == "__main__":
    SnakePositionController()
```
Something you'll notice is how a local copy of position is made. Look at these
two lines:
```python
            # make a local copy to avoid threading issues
            position = self.position
```

In rospy, the callbacks all happen in different threads. A thread is a separate,
simultaneously running, task. In Python, they aren't actually simultaneous, but
instead the computer will jump back and forth between different threads at a
high rate. A bytecode command, which is the smallest chunk that Python commands
can be split into can get interleaved between the two threads from it jumping
back and forth.

Essentially, you're not guaranteed that a callback will run all the way through
before a different callback will get started. If we were to remove the two lines
that were referenced earlier, it is possible that the call to `atan2` will be
started and the program will run a few bytecode commands in order to calculate
the value of the first argument. Then, the execution could go to a different
thread, where the first callback is being run. This could changes the
`self.position` tuple to a completely different number while the earlier thread
calculating the `atan2` is 'paused'. Execution jumps back to the earlier thread
and keeps working on the `atan2` call. The second argument is now calculated
with the new point. When `atan2` is actually called, it would receive the Y
value from the first point, and the X value from the second. It would then be
calculating the heading to a location that isn't either of the two points we
wanted it to go to!

For this specific case, it wouldn't be a critical issue since it can't lead to a
program crash (as far as I know ...). The pose callback would also be running
at a much higher rate than the position callback gets new data, so any weirdness
would be quickly fixed in the next iteration.

Regardless of how big an issue it could potentially be, it is still good to
write threadsafe code. This is discussed further in **06_next-steps**, along
with how making a local copy can resolves that issue. Making a local copy will
not always resolve the issue, but it does for this specific case. It also
discusses another technique to write threadsafe code using `Locks`.

### Updating Launch Files and Testing
Updating the launch file is relatively simple. Put this line in
`snake_controller.launch` right below the other node:
```xml
<node type="snake_position_controller" pkg="snake_tutorial" name="snake_position_controller"/>
```

Running the code follows the same procedure as before. Make sure to `catkin
build` and source!

For testing, you can use either `rostopic pub` or `rqt_publisher`. See if you
can figure out the command for `rostopic pub`. Tab completion will be your
friend :)

### Final Notes
Congratulations, you just finished your second node and are almost done!
This tutorial was much more hands off, so hopefully you were able to apply a lot
of the knowledge you gained while writing the first node in order to write this
one.

Below, you'll see the final file we developed. Feel free to experiment with
making changes to this node, or move on to the next one.

### Full File for Reference:
```python
#!/usr/bin/env python
"""Node to control the position of the snake.

License removed for brevity
"""

# Python
import math

# ROS
import rospy
from geometry_msgs.msg import PoseArray, Point
from std_msgs.msg import Float64

class SnakePositionController(object):
    """Simple position controller for the snake."""
    def __init__(self):
        rospy.init_node('snake_position_controller')

        self.position = None

        # Publishers
        self.heading_pub = rospy.Publisher('controller/heading', Float64, queue_size=1)

        # Subscribers
        rospy.Subscriber('snake/pose', PoseArray, self.snake_cb)
        rospy.Subscriber('controller/position', Point, self.position_cb)

        rospy.spin()

    def position_cb(self, point_msg):
        """Callback for position."""
        self.position = (point_msg.x, point_msg.y)

    def snake_cb(self, pose_msg):
        """Callback for poses from the snake."""
        if self.position is not None:
            pose = (pose_msg.poses[0].position.x, pose_msg.poses[0].position.y)

            # make a local copy to avoid threading issues
            position = self.position
            heading = math.atan2(position[1] - pose[1], position[0] - pose[0])
            self.heading_pub.publish(heading)

if __name__ == "__main__":
    SnakePositionController()
```

## Goal Relay
### Overview
Our snake is now controlled by position. If we want to keep things really
simple, the snake can just chase the goal with no regard for walls or its own
body. You'll find it is pretty effective at the start of the game, but the
approach has some very clear flaws once the snake builds up any decent length.

This simple relay is what we'll develop now. In the future, you can expand on
this controller by fixing these problems. We'll give you a few more notes on
that in the next document.

## Creating the Program
This is going to start like the last program in creating the file and making it
executable, then adding the shebang and docstring. However, things are going to
be different once we start writing code. Go ahead and do all the above, and
write `pass` after the `__main__` check.

You should have something like this:
```python
#!/usr/bin/env python
"""Node to relay goal position to the position controller.

License removed for brevity
"""

if __name__ == "__main__":
    pass
```

We _could_ create a class like we've done in the past. However, this node is
going to be _really_ simple. We don't have any persistent data to keep track of
like commanded headings or positions. We'll also only have a single subscriber,
where we can put all of the logic. The logic won't even be anything spectacular.
It will simply be publishing the data from a PointStamped message as a Point
type. For something really small like this, it can be appropriate to skip over
creating a class, and put everything after the `__main__` check.

Look at the below program to see for yourself:
```python
#!/usr/bin/env python
"""Node to relay goal position to the position controller.

License removed for brevity
"""

# ROS
import rospy
from geometry_msgs.msg import PointStamped, Point

if __name__ == "__main__":
    rospy.init_node('snake_goal_relay')

    # Publishers
    goal_pub = rospy.Publisher('controller/position', Point, queue_size=1)

    # Subscribers
    rospy.Subscriber(
        'snake/goal',
        PointStamped,
        lambda msg, pub=goal_pub: pub.publish(msg.point)
    )

    rospy.spin()
```

We've used something called a lambda in order to put the logic right into the
call to create a subscriber. Rather than include the name of a function, we used
the `lambda` keyword, which lets us put the arguments separated by commas, then
the logic after a semicolon. Note that you can also pass in extra arguments and
even assign them using an equal sign in the argument list.

You can learn more about lambdas [online](https://www.w3schools.com/python/python_lambda.asp).

### Updating Launch Files and Testing
Updating the launch file is no different from the position controller. Give it a
shot and see if the snake runs. Remember to `catkin build` and source!

You should have gotten something like this:
```xml
<node type="snake_goal_relay" pkg="snake_tutorial" name="snake_goal_controller"/>
```

You will find you no longer need to manually plug in data in order to test.
Instead the snake controller is done, and will run automatically. Use `rqt_plot`
to see how all the nodes work together!

### Final Notes
Congratulations, you just finished writing a basic controller for the snake!
Hopefully you learned a great deal about how ROS works, and how to write nodes
in Python. You should be confident to experiment with your own ideas in to
improve upon (or completely rewrite!) the controller we've just finished making.

Below, you'll see the final file we developed. Feel free to experiment with
making changes to this node, any of the previous ones, or start making your own.
There is some information to help you in the next document.

### Full File for Reference:
```python
#!/usr/bin/env python
"""Node to relay goal position to the position controller.

License removed for brevity
"""

# ROS
import rospy
from geometry_msgs.msg import PointStamped, Point

if __name__ == "__main__":
    rospy.init_node('snake_goal_relay')

    # Publishers
    goal_pub = rospy.Publisher('controller/position', Point, queue_size=1)

    # Subscribers
    rospy.Subscriber(
        'snake/goal',
        PointStamped,
        lambda msg, pub=goal_pub: pub.publish(msg.point)
    )

    rospy.spin()
```

## Next Steps
### Overview
You did it. You finished the guided tutorials. You likely learned a lot about
ROS and Python along the way. Hopefully you take some pride in your accomplishment because learning to use ROS is no easy feat.

In this document, we'll present some ideas on how you could improve upon this
controller in order to expand on your ROS knowledge. We'll also give you some
tips and insight into additional topics you may encounter while working on your
improvements.

### Ideas for Improvement
Feel free to use some of these ideas in the list, or go off and do your own
thing. This is designed to be open ended. You can build on the existing
controller or tear it down completely to make your own system.

#### Self Avoidance System
The snake dies when it intersects with itself. You could create a new node to
sit between the goal relay and the position controller that will re-route the
snake if it is detecting a collision.

You could also remove the goal relay completely and design your own waypoint
controller that uses an graph based planning algorithm. For example, grassfire,
Dijkstra, or A* (pronouced "A star") algorithms could all work.

If you want to get really fancy, you could consider the fact that the snake is
going to move as you execute the motion plan, so it may be acceptible to
intersect with the current position by some amount. Cutting corners like this
may save you valuable time if you're trying to maximize the score in a fixed
time frame.

#### Wall Avoidance System
Another way that the snake dies is by intersecting with the wall. Commonly, this
is an issue when the snake approaches a goal near the wall in a way that doesn't
leave room for the snake to get out.

Like the above suggestion, you could create a new node between the goal relay
and position controller that re-routes the snake to a safe path. You could
also remove it completely and build it right into a fancier waypoint controller.

This could be built in addition to the self avoidance system using some sort of
planning algorithm that looks past reaching the next goal. For example Rapidly
Exploring Random Trees (RRT) could be used to find a safe path to the goal and
an arbitray secondary location nearby.

#### Machine Learning
If you have experience with machine learning, you can probably apply it to this
problem. If you want GPU acceleration, take a look at modifying the Docker
scripts to use the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker).
You may also run into issues with Python versions. There is a way to run ROS
with Python 3, but it requires a little bit of extra work. You can also develop
a multicontainer application and use Docker's networking tools to bridge between
this container and another running your machine learning stack. These are all
more advanced topics so we won't discuss how to do that in this document.

## Tips and Insights for Making New Nodes
### Portability
Beginners sometimes like to put all the logic for a system in one big node. This
is like if we put the heading, position, and goal relay nodes all in one place.
Technically, it will work fine with ROS if you have all your inputs and ouputs
set up correctly. However, it may not be the _best_ way to do things.

A really big benefit of ROS is how modular a system of nodes can be. Let's say
that you want to experiment with using a more intelligent waypoint controller
rather than just feeding in the goal position. You can write a new node for that
purpose and create a different launch file to use it. You could even make the
launch file pick the correct node programatically using commandline arguments!

It can also be advantagous to split things up for debugging purposes. If we put
all the logic for the controller in once node, then started having issues with
the heading control to the system, we'd need to go in and put print statements
or use a debugger in order to check the output. With the way we wrote it with
ROS, we can use commandline tools like `rostopic echo` in order to validate the
output. We could also isolate the one node we want to verify and perform unit
testing using `rostopic pub`.

Lastly, using ROS messages defines a command standard for nodes to communicate.
If you put everything in one big node, you probably will use internal Python
data structures to send information back and forth. This may make things more
difficult to maintain later on if you don't define these interfaces very
clearly.

As a general rule of thumb, split up logic into multiple nodes if:
- there are multiple logical steps that may be re-used or replaced in the future
- you want to be able to debug data sent between two logical steps using ROS
- The data sent between multiple logical steps has a complex format that a ROS
message exists for

### Naming Conventions
Here is the general rule of thumb for naming ROS specific items:
- packages: `snake_case`
- nodes: `snake_case`
- topics: `snake_case/with/optional/nesting`
- parameters: `snake_case/with/optional/nesting`

For Python, follow the [PEP 8 guidelines](https://www.python.org/dev/peps/pep-0008/):
- classes: `PascalCase`
- variables: `snake_case`
- "private" variables: `_snake_case_with_leading_underscore`
- "constant" variables: `CAPITALIZED_WITH_UNDERSCORES`
- functions: `snake_case`
- "private" functions: `_snake_case_with_leading_underscore`

### Picking Message Types
Generally, you want to use a ROS message type that is intended for the
application you have in mind. For example, the `Vector3` message and the `Point`
message both have three fields, `x`, `y`, and `z`. However, `Vector3` is
designed to represent vectors in 3D space, while `Point` is designed to
represent points in 3D space.

Another bad thing is to use a message and use the fields for different purposes
than intended. For example, ROS has a `Quaternion` message, but no standard
`EulerAngle` message. If you took a `Quaternion` message and made the `x`,`y`,
and `z` field correspond to roll, pitch, and yaw, that would be really confusing
for future users. It is also generally advisable to use quaternions over Euler
angles since there is no confusion about how to interpret them.

ROS has some standard message types that you can look at online:
- [std_msgs](http://wiki.ros.org/std_msgs)
- [common_msgs](http://wiki.ros.org/common_msgs)

If you feel really adventurous, you can define your own messages, but that is
outside the scope of this document.

### Threading Notes
Earlier, we discussed that for rospy, all of the subscriptions happen in their
own threads. This can be an issue if you have code like the following:
```python
def callback_one(self, msg):
    self.important_variable = msg.data

def callback_two(self, msg):
    # Check that we can take the log of important_variable
    if self.important_variable > 0:
        self.some_variable = msg.data * math.log(self.important_variable)
```

What _could_ happen is that `callback_two` gets called and performs the check.
Then `callback_one` gets called and sets `important_variable` to a negative
number. Then, the execution goes back to `callback_two` and we crash the
program since `math.log` throws an error if you try to take the natural
logarithm of a negative number.

You could also have issues with something like iterating through an array if
the array is being changed in a different callback.

There are a few ways to get around this:
- use locks
- use atomic operations

#### Locks
Locks (similar to mutex's in other langues) let you enforce rules about how
threads can access shared data. Let's see what the earlier example looks like
when lock are being used:
```python
import threading
# ...
self.lock = threading.Lock()
# ...

def callback_one(self, msg):
    self.lock.acquire()
    self.important_variable = msg.data
    self.lock.release()

def callback_two(self, msg):
    self.lock.acquire()
    # Check that we can take the log of important_variable
    if self.important_variable > 0:
        self.some_variable = msg.data * math.log(self.important_variable)
    self.lock.release()
```

This works because one callback can't acquire the lock until the other has
released it. It is a blocking call by default. Locks are provided through the
`threading` library, and you can read more about them
[online](https://docs.python.org/2/library/threading.html#lock-objects).

#### Atomic Operations
This is a more advanced concept, but it can make things a little bit simpler if
you understand it well.

In CPython atleast, there is something called the Global Interpreter Lock or
GIL. This essentially makes a restriction that multithreaded programs can really
only run in a single thread. Instead it switches back and forth between running
bytecode commands from the different "threads". The benefit is that if you know
a certain command is atomic (meaning it is one bytecode instruction), you don't
need to worry about breaking things as much.

This is why it was safe in the `snake_position_controller` node to make a local
copy. Making a local copy of a tuple is atomic. Tuples are immutable, meaning
that when it is updated in another thread, a new one is made, the variable is
changed to point to the new one, and the old one is thrown out if nothing else
is still using it. For our case, we were still using it with our local variable,
so it was kept safe for us. Lists are a good example of a datatype that is not
immutable. If our X and Y values had been stored in a list, we would not have
been thread safe.

A full list of atomic operations are proved [online](https://docs.python.org/2/faq/library.html#what-kinds-of-global-value-mutation-are-thread-safe).

### Debugging
There are going to be many times where ROS wants to make you slam your head into a wall.
Luckily there are tools to reduce that frustration and help spot issues.

This is a short list of the many options avaliable:

- [rqt_graph](http://wiki.ros.org/rqt_graph): This ROS package allows users to 
visualize the ROS computation graph. In other words, you can see what nodes 
are active as well as
how nodes are communicating. Here is an example of a graph:
![rqt graph example](assets/images/rqt-example.png)

- [roswtf](http://wiki.ros.org/roswtf): This ROS package is an automated
debugging tool that finds issues by searching your workspace and graph. It can
find things like improperly set up packages and nodes with unconnected topics.
Additionally it has a fun name.

- [rostopic](http://wiki.ros.org/rostopic): This command-line tool can be used 
in debugging nodes by the messages sent on connected topics. The main commands
you might find most useful are `list`, `echo` and `pub`. `list` will list all
active topics on the ROS graph. `echo` will let you monitor a topic live on the
commandline. `pub` will let you send messages via the command line. This tool is
espcially helpful for testing or when running nodes independently.

- [rosnode](http://wiki.ros.org/rosnode): This is another useful command-line
tool for debugging nodes. You can use `list` to see all active nodes, then
`info` to print out various information about a given node.

- [Python Specific Debugger (PDB)](https://docs.python.org/3/library/pdb.html):
This is a tool built to help debug python applications. It has nothing to do
with ROS. It has a bit of a learning curve, but it was used heavily in making
the `snakesim` package. It may be worth using if you think you have issues
inside of a node that you can't debug by looking at ROS messages going in and
out. It will allow you to step through your code using breakpoints, and monitor
the value of variables as you do so.

## Additional Resources and Getting Help
If you're part of the Autonomous Robotics Club of Purdue, you can post questions
to other members on Slack. This is a really good way to get quick feedback.

If you're looking for other resources online, there are a few official ones:
- [ROS Wiki](http://wiki.ros.org/)
- [ROS Answers](https://answers.ros.org/questions/)
- [ROS Discourse](https://discourse.ros.org/)

And of course, there are always other forum sites like [StackOverflow](https://stackoverflow.com/).
You can also find resources on YouTube that may help with the explanation of
general concepts.

If you're looking for a textbook like experience, there is an excellent free
book called [A Gentle Introduction to ROS](https://www.cse.sc.edu/~jokane/agitr/agitr-letter.pdf).

## Give Us Feedback
Feel free to give us feedback on this tutorial. If you are part of the
Autonomous Robotics Club of Purdue, let us know about any potential improvements
or errors you found through Slack. If you have an interest in creating your own
tutorial to add to this package, lets us know.

If you're outside of the club and found this useful, please let us know. You can
give the repo some stars on [GitHub](https://github.com/purdue-arc/arc_tutorials).
You can also create GitHub Issues for any problems you found, or open up a PR if
you have a fix. If you want to get in contact with the maintainer, send us an
email through [autonomy@purdue.edu](mailto:autonomy@purdue.edu).