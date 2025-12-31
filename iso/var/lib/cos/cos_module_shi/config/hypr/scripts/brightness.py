#!/usr/bin/env python3

import subprocess
import sys

def get_brightness():
    result = subprocess.run(["brightnessctl", "get"], capture_output=True, text=True)
    current = int(result.stdout.strip())

    result = subprocess.run(["brightnessctl", "max"], capture_output=True, text=True)
    maximum = int(result.stdout.strip())

    percent = (current * 100) // maximum
    return percent

def set_brightness(change):
    subprocess.run(["brightnessctl", "set", change])

def main():
    if len(sys.argv) < 2:
        print("Usage: brightness.py [i|d|m|0|get] [optional step %]")
        sys.exit(1)

    action = sys.argv[1]
    step = sys.argv[2] if len(sys.argv) >= 3 else "5"

    if not step.endswith("%"):
        step = step + "%"

    if action == "i":
        set_brightness(f"{step}+")
    elif action == "d":
        set_brightness(f"{step}-")
    elif action == "m":
        set_brightness("100%")
    elif action == "0":
        set_brightness("0%")
    elif action == "get":
        print(f"Brightness: {get_brightness()}%")
    else:
        print("Invalid action. Use i, d, m, 0, or get.")

if __name__ == "__main__":
    main()
