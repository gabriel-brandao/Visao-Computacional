#!/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo "[PYNOVISAO INSTALLER] Installing PYNOVISAO... Please wait!"
export OMP_NUM_THREADS=4
export KMP_AFFINITY="verbose,explicit,proclist=[0,3,5,9],granularity=core"

#check if is root
if [ "$EUID" -ne 0 ]
  then printf "${RED}[PYNOVISAO INSTALLER] ERROR! Please run as root.${NC}"
  echo
  exit
fi

read -p "Would you like to install the requirements for python3 usage? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "[PYNOVISAO INSTALLER] Updating apt-get..."
    sudo apt-get -qq update
    echo "[PYNOVISAO INSTALLER] Installing prerequisites..."
    sudo apt-get -qq -y install libfreetype6-dev tk tk-dev python3-pip openjdk-8-jre openjdk-8-jdk weka weka-doc python3-tk
    source ~/.bashrc

    #echo "[PYNOVISAO INSTALLER] Upgrading pip3..."
    #sudo pip3 install --upgrade pip  --quiet
    # Numpy must be installed before installing javabridge
    echo "[PYNOVISAO INSTALLER] Installing numpy..."
    sudo pip3 install numpy --quiet
    echo "[PYNOVISAO INSTALLER] Installing libraries..."
    sudo pip3 install -r requirements_pip3.txt --quiet

    printf "${YELLOW} \n======== WARNING ========\n"
    printf "The Keras is necessary so that it is possible to use CNN. It is recommended to install the version for GPU processing (if available) but it is also possible to use CPU processing.\n"
    printf "To install the GPU version (tricky) follow the steps at: https://www.tensorflow.org/install/install_linux"
    printf "${NC}\n"
    read -p "Would you like to install keras CPU libraries? [y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
       echo "[PYNOVISAO INSTALLER] Installing keras libraries..."
       sudo pip3 install tensorflow 
       sudo pip3 install keras
    fi

    echo
    printf "${BLUE}[PYNOVISAO INSTALLER] Installation completed for Python 3!${NC}"
    echo
fi
    

read -p "Would you like to install the requirements for python2 usage? [y/n]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "[PYNOVISAO INSTALLER] Updating apt-get..."
    sudo apt-get -qq update
    echo "[PYNOVISAO INSTALLER] Installing prerequisites..."
    sudo apt-get -qq -y install libfreetype6-dev tk tk-dev python-pip openjdk-8-jre openjdk-8-jdk weka weka-doc python-tk
    source ~/.bashrc

    #echo "[PYNOVISAO INSTALLER] Upgrading pip3..."
    #sudo pip install --upgrade pip  --quiet
    # Numpy must be installed before installing javabridge
    echo "[PYNOVISAO INSTALLER] Installing numpy..."
    sudo pip install numpy --quiet
    echo "[PYNOVISAO INSTALLER] Installing libraries..."
    sudo pip install -r requeriments.txt --quiet

    printf "${YELLOW} \n======== WARNING ========\n"
    printf "The Keras is necessary so that it is possible to use CNN. It is recommended to install the version for GPU processing (if available) but it is also possible to use CPU processing.\n"
    printf "To install the GPU version (tricky) follow the steps at: https://www.tensorflow.org/install/install_linux"
    printf "${NC}\n"
    read -p "Would you like to install keras CPU libraries? [y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
       echo "[PYNOVISAO INSTALLER] Installing keras libraries..."
       sudo pip install tensorflow 
       sudo pip install keras
    fi

    echo
    printf "${BLUE}[PYNOVISAO INSTALLER] Installation completed for Python 2!${NC}"
    echo
fi
