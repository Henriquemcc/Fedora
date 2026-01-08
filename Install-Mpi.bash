#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing MPI
install_rpm_package openmpi
install_rpm_package openmpi-devel

# Getting the executable path
mpi_executable_path_32="/usr/lib/openmpi/bin/mpirun"
mpi_executable_path_64="/usr/lib64/openmpi/bin/mpirun"
if [ -f "$mpi_executable_path_64" ]; then
  mpi_executable_path="$mpi_executable_path_64"
elif [ -f "$mpi_executable_path_32" ]; then
  mpi_executable_path="$mpi_executable_path_32"
fi

# Creating executable symbolic link
ln --symbolic "$mpi_executable_path" "/bin/mpirun"

# Getting the compiler path
mpi_compiler_path_32="/usr/lib/openmpi/bin/mpicc"
mpi_compiler_path_64="/usr/lib64/openmpi/bin/mpicc"
if [ -f "$mpi_compiler_path_64" ]; then
    mpi_compiler_path="$mpi_compiler_path_64"
elif [ -f "$mpi_compiler_path_32" ]; then
    mpi_compiler_path="$mpi_compiler_path_32"
fi

# Creating executable symbolic link
ln --symbolic "$mpi_compiler_path" "/bin/mpicc"