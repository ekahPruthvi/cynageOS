from colorthief import ColorThief

getti = ColorThief('/home/ekah/.config/swww/wall.blur')
# get the dominant color
dcolor = getti.get_color(quality=1)

print (dcolor)