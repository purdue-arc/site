---
title: Pre-flight path planning
weight: 3
description: >
    How we plan the path the drone will take before it takes flight
---

## Why

The drone should fly a path known not to have obstacles so that we can minimize the amount of time avoiding obstacles during its flight.

## Getting the obstacle data

We can get data of obstacles we want to avoid like buildings, trees, and lightposts from a geospatial data source.

The geospatial data source we decided to use for our initial implementation was [OpenStreetMap](https://www.openstreetmap.org). OpenStreetMap is a free-to-use map of the world that can be contributed to by anyone. A large variety of features can be mapped in OpenStreetMap including all of the obstacles we need to avoid: buildings, trees, and lightposts. Because OpenStreetMap data is free, can be updated by ourselves if data is missing, and has all the obstacles we need to avoid, it is a clear choice over Google Maps which is costly, cannot be updated, and does not have data on eveything we need to avoid.

OpenStreetMap data is is made up of features. There are 3 types of features: points, lines, and areas. Lines and areas are ordered lists of points. Each point has a laditude and longitude and thus determines the position of a feature or the shape of a line or area in the world. To describe the type of feature such as "building" and attributes that feature has such as "levels" or "color", every feature has a list of key-value pairs (a map/dictionary).

We only want to get all of the buildings, trees, and streetlight features and not any of the other features in an area in OpenStreetMap, so we need to filter the features in a selected area by their tags.

We can use the Overpass API querying service to get only these features. The Overpass API can be easily interfaced through by using [Overpass Turbo](https://overpass-turbo.eu/). We can easily create a query clicking the `Wizard` button at the top and inputting the tags we want.

Every building in OSM has a tag with the key `building`. The value of the `building` tag determines the type of the building. For example, `building=school`. We don't care about the type of the building so we can just add `building=*` to get all of the buildings that have a tag with the key `buildling` regardless of its value.

OSM allows users to document map individual parts of buildings to distinguish which parts have different attributes. For example, one part of a building might have more levels than another. The key for getting these "building part" features is `building:part`. So, we can add `or building:part=*` to also select all of these building parts.

Finally, we want to get all of the trees. The tag for a tree is `natural=tree` so we can add `or natural=tree` to also select all of the trees.

So, our final input inside of the query wizard should be `building=* or building:part=* or natural=tree`. You can then click `Build query` and the actual Overpass Query Language query text will appear on the left.

To select the area of data you want to get, click the picture icon in the upper left of the map and click adjust the box on the map to "manually select the bbox".

Now, we click `Run` in the upper right to run the query and return the data we need.

> Note, you might have selected a large area and it will give you a warning you are returning a lot of data. Click `continue anyway`. You can minimize the impact this will have on your computer by disabling the results from showing on the map. This is done by removing the `>; out skel qt;` at the end of the query and re-running it.

You can browse the data returned visually on the map or by clicking the `Data` button in the upper right.

The next step is to export the data. This can be done by clicking the `Export` button at the top and selecting which file format to export to. What file format should be exported is dependent on the type of occupancy matrix needed. Read the following section to understand what an occupancy matrix is and how it will help us find a path.

## Creating an occupancy matrix

The data outputted from OSM is a list of shapes and points and their locations. We want to run a path planning algorithm on this data. We cannot do this though with the data in this format. Path planning algorithms require a graph to traverse (see how this works [here](https://www.redblobgames.com/pathfinding/a-star/introduction.html)). The best way to convert multi-dimensional space into a graph is by breaking it up into square chunks where each chunk is a node in the graph. One structure these chunks can be broken into is a 2D or 3D matrix. Another structure is a [quadtree](https://en.wikipedia.org/wiki/Quadtree) (2D) or [octree](http://www.open3d.org/docs/latest/tutorial/geometry/octree.html) (3D). If a node in each type of matrix intersects an obstacle, we give it a value of 1 (occupied). Otherwise it has a value of 0. This is where the name "occupancy matrix" comes from. We can then take all of the nodes that are not occupied and link them together to create a graph that the path finding algorithm can traverse.

So, we need a solution that will convert our OSM data to an occupancy matrix.

## Creating a 3D octree

The first occupancy matrix we pursued creating was a 3D one.

We first researched if there were any libraries that could convert a 3D scene file like a .gltf to an occupancy matrix. We found a MATLAB function that could do this for us however we decided not to use this as it would lock us into using MATLAB's technology and if in the future we wanted to deploy this, we would have to pay MATLAB for computation. Therefore, we pushed on to try to find an open-source library that could do this. We ended up finding Open3D, a library that can convert a mesh like .gltf to a point cloud and then convert the point cloud to an octree. At the same time, we also found that the library OSM2World included a Command Line Interface that could convert a .osm file to a .gltf file. So, we used both tools together and ended up with a beautiful octree of campus!

## Creating a 2D matrix

We were anticipating that the 3D occupancy matrix would be used in the initial flight planning and testing of the drone, however this was determined to be unecessary after we learned that we would would not be flying over buildings or trees for the first tests of the drone. Because we will not be flying over them, we could just use a 2D matrix that would document where every obstacle is located regardless of their height and thus the path planned would avoid flying over any of those obstacles.

Researching libraries that could do this for us, we found an R library that could take GeoJSON and output a matrix. However, we soon realized that the process of taking 2D shapes and converting them to a matrix is identical to the rasterization process your computer does when it is given the points of a shape like text and needs to calculate which pixels should be colored to show that text. So, we refined our search to look for libraries that could rasterize geospatail files. We finally found the Python library [Rasterio](https://rasterio.readthedocs.io/en/latest/) that could rasterize GeoJSON into a TIFF file (an image file). All we needed to do is change the resolution of the image to fit our expected node dimensions.

The resulting converter created is located at this repository.

## Future plans

In the future we are going to use [photogrammetry](https://en.wikipedia.org/wiki/Photogrammetry) for our obstacle data source. Photogrammetry is the technology used to generate 3D buildings in Google Maps. It is generated by taking images of features from multiple angles and the location and direction they were taken to create a 3D mesh.

Photogrammetry can be collected by flying our drone around its operating area and using images captured to generate photogrammetry.

The advantage of photogrametry over using OpenStreetMap data is it much more precise and easier to keep up-to-date than OpenStreetMap data. Photogrammetery can outline the precise geometries and locations of all obstacles in an area whereas OpenStreetMap can only document features to such detail and requires manually editing the map to document it. Photogrametry can also be much easier to keep up-to-date than OpenStreetMap. If a temporary construction area is setup where the drone typically flies, the drone can forward the imagery collected while it avoided the newly-found obstacle to the photogrametry world server to create fresh set of obstacle meshes that can will be accounted in the calculation of the flight path the next time a flight is planned through that area.

The reason photogrammetry was not chosen initially as the obstacle dataset was that we did not have a functional drone at the time of developing it to take the images used for photogrammetry.
