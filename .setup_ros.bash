## bash setup for ROS development, invoke via "source" command

alias rosenv="env | sort | egrep 'ROS|CATKIN|CMAKE|GAZEBO'"
alias rdi="roscd; rosdep install --from-paths src --ignore-src --rosdistro=hydro"
alias ws='source $ROS_WORKSPACE/devel/setup.bash'

## set ROS overlay name (W is a symlink)
OVR=W
export WS=$(readlink -f ~/ros/$OVR)

if [ -r $WS/devel/setup.bash -o -r $WS/devel_isolated/setup.bash -o -r $WS/setup.bash ]
then
    export ROS_MASTER_URI=http://$HOSTNAME:11311

    # catkin workspaces are set up differently
    if [ -r $WS/devel/setup.bash ]
    then    source $WS/devel/setup.bash
            export CATKIN_TEST_RESULTS_DIR=~/ros/$OVR/build/test_results
    else
        if [ -r $WS/devel_isolated/setup.bash ]
        then
            source $WS/devel_isolated/setup.bash
            export CATKIN_TEST_RESULTS_DIR=~/ros/$OVR/build_isolated/test_results
        else
            source $WS/setup.bash
        fi
    fi

    export ROS_HOME=~/.ros
    export ROSCONSOLE_CONFIG_FILE=$ROS_HOME/config/rosconsole.config
    export ROS_EMAIL=jack.oquin@gmail.com
    export ROS_WORKSPACE=$WS
    export GAZEBO_MODEL_PATH=~/ros/gazebo/gazebo_models:${GAZEBO_MODEL_PATH}

    # add art_run/bin to $PATH
    #if [ $(which rospack) ]
    #then ART_RUN=$(rospack find art_run 2>/dev/null)
    #fi
    #if [ "$ART_RUN" != "" ] && [ -d $ART_RUN/bin ]
    #then export PATH=$ART_RUN/bin:$PATH
    #fi
else                            # no ROS workspace
    if [ -r /opt/ros/hydro/setup.bash ]
    then
        source /opt/ros/hydro/setup.bash
    else                        # ROS hydro not installed
        if [ -r /opt/ros/indigo/setup.bash ]
        then
            source /opt/ros/indigo/setup.bash
        fi
    fi
fi
