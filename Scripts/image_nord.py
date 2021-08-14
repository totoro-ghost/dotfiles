#!/usr/bin/env python3

import os 
from ImageGoNord import NordPaletteFile, GoNord

dir_path = os.path.dirname(os.path.realpath(__file__))
# palette = dir_path+'/palettes/Gruvbox.txt'
dir_path = dir_path+'/palettes/'
# documentation of ImageGoNord - https://github.com/Schrodinger-Hat/ImageGoNord-pip/tree/master/docs
# E.g. Replace pixel by pixel
go_nord = GoNord()
go_nord.set_palette_lookup_path(dir_path)
# go_nord.reset_palette();


# every palllete rquires 9 entries even if they are empty
go_nord.add_file_to_palette("Gruvbox.txt")

# bug=go_nord.get_palette_data()
# print(bug)


image = go_nord.open_image("girl.jpeg")
go_nord.convert_image(image, save_path='girl2.jpeg')

# E.g. Avg algorithm and less colors
# go_nord.enable_avg_algorithm()
# go_nord.reset_palette()
# go_nord.add_file_to_palette(NordPaletteFile.POLAR_NIGHT)
# go_nord.add_file_to_palette(NordPaletteFile.SNOW_STORM)

# You can add color also by their hex code
# go_nord.add_color_to_palette('#FF0000')

# image = go_nord.open_image("images/test.jpg")
# go_nord.convert_image(image, save_path='images/test.avg.jpg')
