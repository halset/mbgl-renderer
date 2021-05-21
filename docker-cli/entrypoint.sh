#!/bin/sh

# Start Xvfb
echo "Starting Xvfb"
Xvfb ${DISPLAY} -screen 0 "1024x768x24" -ac +extension GLX +render -noreset  -nolisten tcp  &
Xvfb_pid="$!"
echo "Waiting for Xvfb (PID: $Xvfb_pid) to be ready..."
while ! xdpyinfo -display ${DISPLAY} > /dev/null 2>&1; do
    sleep 0.1
done
echo "Xvfb is running"

echo "Starting mbgl-renderer cli"
node dist/cli.js $@
