from PIL import Image
import os

folder_path = '/Users/arun.gopakumar/Desktop/logos'
filename1 = 'test.png'

for filename in os.listdir(folder_path):
    if filename.endswith('.png') or filename.endswith('.jpg'):
        image = Image.open(os.path.join(folder_path, filename))
        image = image.convert("RGBA")
        pixdata = image.load()

        # Make the background transparent
        for y in range(image.size[1]):
            for x in range(image.size[0]):
                if pixdata[x, y] == (255, 255, 255, 255):
                    pixdata[x, y] = (255, 255, 255, 0)

        image.save(os.path.join(folder_path, filename1), "PNG")
