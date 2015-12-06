from flask import Flask, send_file
from PIL import Image
import glob
import math

app = Flask(__name__)

def getNearestImage(search_width, search_height):
    nearest_diameter = 10000
    nearest_image = None
    images = glob.glob('static/*')
    for image in images:
        image = Image.open(image)
        if image.width >= search_width and image.height >= search_height:
            diameter = math.sqrt(image.width**2 + image.height**2)
            if diameter <= nearest_diameter:
                nearest_diameter = diameter
                print("nearest diameter: {}".format(diameter))
                nearest_image = image
                print(nearest_image.width)
    cropBox = (0, 0, search_width, search_height)
    print(nearest_image.width)
    nearestImagePath = "static/cropped_{}_{}.png".format(search_width, search_height)
    nearest_image.crop(cropBox).save(nearestImagePath)
    return(nearestImagePath)


@app.route("/<int:width>/<int:height>")
def placeKitten(width, height):
    nearestImage = getNearestImage(width, height)
    return send_file(nearestImage)

if __name__ == "__main__":
    app.run()

