## bash setup for ROS development, invoke via "source" command

alias dr="env | egrep 'ROS|CATKIN|CMAKE|GAZEBO'"

## set ROS overlay name (W is a symlink)
OVR=W
if [ -r ~/ros/$OVR/setup.bash -o -r ~/ros/$OVR/devel/setup.bash -o -r ~/ros/$OVR/devel_isolated/setup.bash ]
then
    export ROS_MASTER_URI=http://$HOSTNAME.local:11311

    # catkin workspaces are set up differently
    if [ -r ~/ros/$OVR/devel/setup.bash ]
    then    source ~/ros/$OVR/devel/setup.bash
            export CATKIN_TEST_RESULTS_DIR=~/ros/$OVR/build/test_results
    else
        if [ -r ~/ros/$OVR/devel_isolated/setup.bash ]
        then
            source ~/ros/$OVR/devel_isolated/setup.bash
            export CATKIN_TEST_RESULTS_DIR=~/ros/$OVR/build_isolated/test_results
        else    source ~/ros/$OVR/setup.bash
        fi
    fi

    # HACK: work around Hydro rosdistro bug
    if [ "$ROS_ROOT" == "/opt/ros/hydro/share/ros" ]
    then
        export ROS_DISTRO="hydro"
    fi

    export ROS_HOME=~/.ros
    export ROSCONSOLE_CONFIG_FILE=$ROS_HOME/config/rosconsole.config
    export ROS_EMAIL=jack.oquin@gmail.com
    export ROS_WORKSPACE=$(readlink -f ~/ros/$OVR)
    export GAZEBO_MODEL_PATH=~/ros/gazebo/gazebo_models:${GAZEBO_MODEL_PATH}

    # add art_run/bin to $PATH
    if [ $(which rospack) ]
    then ART_RUN=$(rospack find art_run 2>/dev/null)
    fi
    if [ "$ART_RUN" != "" ] && [ -d $ART_RUN/bin ]
    then export PATH=$ART_RUN/bin:$PATH
    fi
else                            # no ROS workspace
    if [ -r /opt/ros/hydro/setup.bash ]
    then    source /opt/ros/hydro/setup.bash
    else                        # ROS hydro not installed
        if [ -r /opt/ros/groovy/setup.bash ]
        then    source /opt/ros/groovy/setup.bash
        fi
    fi
fi
