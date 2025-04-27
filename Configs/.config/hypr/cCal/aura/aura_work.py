import os
import subprocess
import sys

clr=subprocess.run(['hyprpicker'], capture_output=True, text=True)
cp=(clr.stdout)
os.system("asusctl led-mode static -c " + cp[1:]) 