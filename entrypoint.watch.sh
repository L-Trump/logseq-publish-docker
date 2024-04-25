#!/bin/bash

# Get options
MONITOR_DIR=${PUB_GRAPH_DIR:-/graph}
MONITOR_INTERVAL=${MONITOR_INTERVAL:-60}

# check if graph directory exists
if [ ! -d "$MONITOR_DIR" ]; then
	echo "Error: The graph directory does not exist"
	exit 1
fi

ts_echo() {
	local message="$1"
	echo "$(date '+%Y-%m-%d %H:%M:%S'): $message"
}

inotify_pid=0

# Main loop
while true; do
	# monitor change
	inotifywait -r -e create,move,delete,modify,attrib "$MONITOR_DIR" 2>/dev/null &
	inotify_pid=$!
	# Run the publish script
	ts_echo "Start publishing..."
	./entrypoint.sh
	# Waiting for next graphic changes
	ts_echo "Waiting for graphic changes"
	wait $inotify_pid
	ts_echo "Graph changes detected. Waiting for the end of the change..."
	# Until the end of the change lasts INTERVAL.
	while [ $? -ne 2 ]; do
		inotifywait -r -e create,move,delete,modify,attrib --timeout $MONITOR_INTERVAL "$MONITOR_DIR" 2>/dev/null
	done
done

# Cleanup
trap "kill -9 $inotify_pid" EXIT
