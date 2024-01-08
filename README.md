Sw# simtracker: A Simulation Tracking Package for R

## Overview

The `simtracker` package is designed to facilitate the tracking and management of simulation studies in R. Originally intended for use on the BIPS workstation, it is adaptable for use on your local machine as well. The package is currently a work in progress.

## Motivation

The development of `simtracker` arises from the need to move away from `batchtools`, the previous preferred method for cluster computations, which is no longer suitable for the workstation. Instead, the package leverages the R package `parallel` and provides wrapper functions for setting up the cluster object, making it easier to manage and keep track of simulation studies.

## Features

- **Simulation Registry**: Create a registry in the form of the 'simulations' folder to keep track of completed simulation runs based on parameter settings.
- **Results Storage**: Store the results of individual runs in the 'simulations/results' folder.
- **Seed Tracking**: Store the seed with which the simulation has run for each parameter setting, making results reproducible.

## Installation

You can install `simtracker` from GitHub using the following:

```R
devtools::install_github("bips-hb/simtracker")
```

## Usage

```R
# Load the simtracker package
library(simtracker)

# Set up the simulation directory
setup_simulation("my-simulation")

# Create a cluster object
cl <- create_cluster(num_workers = 4)

# Your simulation logic goes here
# ...

# Stop and clean up the cluster
stop_cluster(cl)

# Check the progress of the simulation
check_progress()
```

## Contact

For questions or suggestions on how to improve `simtracker`, please contact [dijkstra@leibniz-bips.de](mailto:dijkstra@leibniz-bips.de).

## Note

The current version of `simtracker` is for internal use only but will be made publicly available later on.

Feel free to customize and expand this template to include more detailed documentation about the package's functions, parameters, and usage examples.
