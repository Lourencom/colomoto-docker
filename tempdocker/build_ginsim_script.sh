#!/bin/bash

# Define a function for the complete process
run_all() {
    echo "--------------------- Going into bioLQM -------------------------"
    cd /home/lourenco/research/colomoto/bioLQM
    echo "---------------------- Compiling bioLQM -------------------------"
    mvn package

    echo "-------------------- Going into GINsim --------------------------"
    cd /home/lourenco/research/colomoto/GINsim

    echo "----------- Installing bioLQM into GINsim -----------------------"
    mvn install:install-file -Dfile=../bioLQM/target/bioLQM-0.8-SNAPSHOT-jar-with-dependencies.jar -DgroupId=org.colomoto -DartifactId=bioLQM -Dversion=0.8-CUSTOM -Dpackaging=jar

    echo "------------------ Compiling GINsim -----------------------------"
    mvn package

    echo "-------------------- Copying GINsim fat jar ---------------------"
    cp target/GINsim-3.0.0b-SNAPSHOT-jar-with-dependencies.jar ../colomoto-docker/tempdocker/GINSIM-fat.jar
}

# Define a function for copying and removing pymodrev
copy_and_remove_pymodrev() {
    echo "------------------- Navigating to tempdocker --------------------"
    cd /home/lourenco/research/colomoto/colomoto-docker/tempdocker/

    echo "----------------------- Removing modrev -------------------------"
    rm -rf pymodrev

    echo "-------------------- Copying pymodrev ---------------------------"
    cp -rf ../../pymodrev/ .

    echo "--------------------- Copying tutorial --------------------------"

    cp -rf ../../pymodrev/modrev_tutorial.ipynb .

    echo "--------------- GINsim ready for colomoto-docker use ------------"
}

# Main script logic based on input argument
if [ "$1" = "0" ]; then
    run_all
    copy_and_remove_pymodrev  # This part is common and should be executed in both cases
elif [ "$1" = "1" ]; then
    copy_and_remove_pymodrev
else
    echo "Usage: $0 [0|1]"
    echo "  0: Run all steps."
    echo "  1: Only copy and remove pymodrev."
fi

