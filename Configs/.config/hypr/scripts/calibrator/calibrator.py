import os
import sys

def get_monitor_info(command):
    stream=os.popen(command)
    output=stream.read().strip()
    l=len(output)
    i = 0
    #get the pattern starting index
    while(i<l):
        if(output[i]=="a" and output[i+14]==":" and output[i+9]=="M"):
            x=j=i
            break
        else:
            i+=1
    #get monitor info
    while(j<l):
        if(output[j]=="."):
            y=j
            break
        else:
            j+=1
    out=output[x+16:y]
    return out

if __name__ == "__main__":
  command_info=sys.argv[1]
  if command_info == "1":
    print(get_monitor_info("hyprctl monitors"))
    
    
