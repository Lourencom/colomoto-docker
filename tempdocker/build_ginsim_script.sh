#!/bin/bash

# Change project's local PATHs, according to your own installation
BIOLQM=/home/ptgm/git/bioLQM_Lourenco
GINSIM=/home/ptgm/git/GINsim-dev
PYMODREV=/home/ptgm/git/pymodrev
COLOMOTO=`pwd`

# Define a function for the complete process
run_all() {
    echo "--------------------- Going into bioLQM -------------------------"
    cd $BIOLQM
    echo "---------------------- Compiling bioLQM -------------------------"
    mvn package assembly:single -Dmaven.javadoc.skip=true

    echo "-------------------- Going into GINsim --------------------------"
    cd $GINSIM

    echo "----------- Installing bioLQM into GINsim -----------------------"
    mvn install:install-file -Dfile=$BIOLQM/target/bioLQM-0.8-SNAPSHOT-jar-with-dependencies.jar -DgroupId=org.colomoto -DartifactId=bioLQM -Dversion=0.8-CUSTOM -Dpackaging=jar

    echo "------------------ Compiling GINsim -----------------------------"
    mvn package assembly:single -Dmaven.javadoc.skip=true

    echo "-------------------- Copying GINsim fat jar ---------------------"
    cp $GINSIM/target/GINsim-3.0.0b-SNAPSHOT-jar-with-dependencies.jar $COLOMOTO/GINSIM-fat.jar
}

# Define a function for copying and removing pymodrev
copy_and_remove_pymodrev() {
    echo "------------------- Navigating to tempdocker --------------------"
    cd $COLOMOTO

    echo "----------------------- Removing modrev -------------------------"
    rm -rf pymodrev

    echo "-------------------- Copying pymodrev ---------------------------"
    cp -rf $PYMODREV .

    echo "--------------------- Copying tutorial --------------------------"

    cp -rf $PYMODREV/modrev_tutorial.ipynb .

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

