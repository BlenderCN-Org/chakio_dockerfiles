#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/catkin_ws/src/naoqi_bridge/naoqi_navigation/python"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/catkin_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/catkin_ws/install/lib/python2.7/dist-packages:/catkin_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/catkin_ws/build" \
    "/usr/bin/python" \
    "/catkin_ws/src/naoqi_bridge/naoqi_navigation/python/setup.py" \
    build --build-base "/catkin_ws/build/naoqi_bridge/naoqi_navigation/python" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/catkin_ws/install" --install-scripts="/catkin_ws/install/bin"
