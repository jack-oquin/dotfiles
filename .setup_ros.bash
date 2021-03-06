## bash setup for ROS development, invoke via "source" command

alias e="env | sort | egrep 'ROS|CATKIN|CMAKE'"
alias g='source /opt/ros/groovy/setup.bash'
alias h='source /opt/ros/hydro/setup.bash'
alias i='source /opt/ros/indigo/setup.bash'
alias j='source /opt/ros/jade/setup.bash'
alias k='source /opt/ros/kinetic/setup.bash'
alias l='source /opt/ros/lunar/setup.bash'
alias lw='source ~/ros/lunar_ws/devel/setup.bash'
alias srb='source ~/.setup_ros.bash'
alias ti='source ~/ros/trusty_indigo/devel/setup.bash'
alias v3='source ~/ros/v3/devel/setup.bash'
alias ws='source ~/ros/ws/devel/setup.bash'

## global ROS environment settings
export ROS_EMAIL=jack.oquin@gmail.com
export ROS_HOME=~/.ros
export ROS_MASTER_URI=http://$HOSTNAME:11311
#export ROSCONSOLE_CONFIG_FILE=$ROS_HOME/config/rosconsole.config

## UTexas CS settings
export BL=".ros/bwi/bwi_logging"
export CSRES=csres.utexas.edu
export NH=nixons-head.$CSRES

## Segbot V3/V4 settings
export ROBOT_NETWORK=wlan4
export SEGWAY_BASE_PLATFORM=RMP_110
export SEGWAY_HAS_BSA=false
export SEGWAY_HAS_ONBOARD_JOY=true
export SEGWAY_INTERFACE_ADDRESS=10.66.171.1
export SEGWAY_IP_ADDRESS=10.66.171.5
export SEGWAY_IP_PORT_NUM=8080
export SEGWAY_PLATFORM_NAME=RMP_110
export SEGWAY_POWERS_PC_ONBOARD=true
export SEGWAY_RUNS_IN_BALANCE_MODE=false
