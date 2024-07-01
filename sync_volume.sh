#!/bin/bash
print"Initialising...."
echo -n "Please enter SYNC ID [pactl list sync] : "

# Read the user input
read BLUETOOTH_SINK
# Set the sink name or index of your Bluetooth device

# Function to get system volume
get_system_volume() {
    # Code to get system volume (e.g., using pactl or amixer)
    # Replace the following line with the appropriate command for your system
    pactl list sinks | grep 'Volume:' | head -n 1 | awk '{print $5}'
}

# Function to get system mute status
get_system_mute() {
    # Code to get system mute status (e.g., using pactl or amixer)
    # Replace the following line with the appropriate command for your system
    pactl list sinks | grep 'Mute:' | awk '{print $2}'
}

# Function to set system volume
set_system_volume() {
    # Code to set system volume (e.g., using pactl or amixer)
    # Replace the following line with the appropriate command for your system
    pactl set-sink-volume @DEFAULT_SINK@ "$1"
}

# Function to set system mute status
set_system_mute() {
    # Code to set system mute status (e.g., using pactl or amixer)
    # Replace the following line with the appropriate command for your system
    pactl set-sink-mute @DEFAULT_SINK@ "$1"
}

# Function to synchronize Bluetooth sink volume with system volume
sync_bluetooth_volume() {
    bluetooth_volume="$1"
    set_system_volume "$bluetooth_volume"
}

# Function to synchronize Bluetooth sink mute status with system mute status
sync_bluetooth_mute() {
    bluetooth_mute="$1"
    set_system_mute "$bluetooth_mute"
}

# Function to synchronize system volume with Bluetooth sink volume
sync_system_volume() {
    system_volume="$1"
    pactl set-sink-volume "$BLUETOOTH_SINK" "$system_volume"
}

# Function to synchronize system mute status with Bluetooth sink mute status
sync_system_mute() {
    system_mute="$1"
    pactl set-sink-mute "$BLUETOOTH_SINK" "$system_mute"
}

echo "Sysncing volume for given sync id : $BLUETOOTH_SINK"

# Monitor changes to system volume and mute status and synchronize with Bluetooth sink
while true; do
    current_volume=$(get_system_volume)
    current_mute=$(get_system_mute)
    sync_bluetooth_volume "$current_volume"
    sync_bluetooth_mute "$current_mute"
    sleep 0.5  # Adjust interval as needed
done
