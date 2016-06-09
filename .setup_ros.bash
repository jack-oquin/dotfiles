## bash setup for ROS development, invoke via "source" command

alias e="env | sort | egrep 'ROS|CATKIN|CMAKE'"
alias g='source /opt/ros/groovy/setup.bash'
alias h='source /opt/ros/hydro/setup.bash'
alias i='source /opt/ros/indigo/setup.bash'
alias j='source /opt/ros/jade/setup.bash'
alias k='source /opt/ros/kinetic/setup.bash'
alias ws='source ~/ros/ws/devel/setup.bash'

## global ROS environment settings
export ROS_EMAIL=jack.oquin@gmail.com
export ROS_HOME=~/.ros
export ROS_MASTER_URI=http://$HOSTNAME:11311
export ROSCONSOLE_CONFIG_FILE=$ROS_HOME/config/rosconsole.config

## UTexas CS settings
export BL=".ros/bwi/bwi_logging"
export CSRES=csres.utexas.edu
export NH=nixons-head.$CSRES

## Segbot V3 settings
export SEGWAY_INTERFACE_ADDRESS=10.66.171.1
export SEGWAY_IP_ADDRESS=10.66.171.5
export SEGWAY_IP_PORT_NUM=8080
export SEGWAY_BASE_PLATFORM=RMP_210
export SEGWAY_PLATFORM_NAME=RMP_210

## set ROS overlay name (W is a symlink)
###OVR=W
###export WS=$(readlink -f ~/ros/$OVR)
###
###if [ -r $WS/devel/setup.bash -o -r $WS/devel_isolated/setup.bash -o -r $WS/setup.bash ]
###then
###
###    # catkin workspaces are set up differently
###    if [ -r $WS/devel/setup.bash ]
###    then    source $WS/devel/setup.bash
###            export CATKIN_TEST_RESULTS_DIR=$WS/build/test_results
###    else
###        if [ -r $WS/devel_isolated/setup.bash ]
###        then
###            source $WS/devel_isolated/setup.bash
###            export CATKIN_TEST_RESULTS_DIR=$WS/build_isolated/test_results
###        else
###            source $WS/setup.bash
###        fi
###    fi
###    export ROS_WORKSPACE=$WS
###else                            # no ROS workspace
###    if [ -r /opt/ros/hydro/setup.bash ]
###    then
###        source /opt/ros/hydro/setup.bash
###    else                        # ROS hydro not installed
###        if [ -r /opt/ros/indigo/setup.bash ]
###        then
###            source /opt/ros/indigo/setup.bash
###        fi
###    fi
###fi
