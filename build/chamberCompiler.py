import os
from PIL import Image
import json

# ridiculous global variable to prevent multiple readings of a file, or passing a parameter around :(
with open("build/conversion.json", 'r') as json_file:
    conversions = json.JSONDecoder().decode(json_file.read())

# accepts list of layers as argument
# eg ['chamber1_fg.png', 'chamber1_bg.png']
# returns list of strings
def compileChamberLayers(chambers): return [compileChamber(layer) for layer in chambers]

# accepts single path to png
# eg 'chamber1_fg.png'
# returns string
def compileChamber(layer):
	pixels = Image.open(layer).load()
	compile_string = ""
	for x in range(image.size[0]):
		for y in range(image.size[1]):
			compile_string += conversions.get(",".join(map(str, pixels[x,y]))) + ","
	return compile_string

def main():
	# get correct dir even within /build or /
	root = (os.getcwd()[:-6] if os.getcwd().endswith('build') else os.getcwd()) + '/chambers/'
	# list of lists of layerpaths
	chambers = [map(lambda x: root + directory + "/" + x, os.listdir(root + directory)) for directory in os.listdir(root) if not directory.startswith('.')]
	# list of strings (representing an entire compiled chamber)
	compiled_chambers = [compileChamberLayers(layers) for layers in chambers]
	json_out = {"chambers":compiled_chambers}
	# write out to json file
	open("compiled.json", "w+").write(json.dumps(json_out))
	print("Files saved to compiled.json")
	
if __name__ == "__main__":
	main()