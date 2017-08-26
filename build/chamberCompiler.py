import os
from PIL import Image
import json

# accepts list of layers as argument
# eg ['chamber1_fg.png', 'chamber1_bg.png']
# returns string
def compileChamberLayers(chambers): return [compileChamber(layer) for layer in chambers]

# accepts single path to png
# eg 'chamber1_fg.png'
# returns string
def compileChamber(layer):
	image = Image.open(layer)
	pixels = image.load()
	compile_string = ""
	for x in range(image.size[0]):
		for y in range(image.size[1]):
			if pixels[x,y] == (255, 255, 255, 255):
				compile_string += "w"
			elif pixels[x,y] == (0, 0, 0, 255):
				compile_string += "b"
	return compile_string

def main():
	# get correct dir even within /build or /
	root = (os.getcwd()[:-6] if os.getcwd().endswith('build') else os.getcwd()) + '/chambers/'
	# list of lists of layerpaths
	chambers = [map(lambda x: root + directory + "/" + x, os.listdir(root + directory)) for directory in os.listdir(root) if not directory.startswith('.')]
	# list of strings (representing an entire compiled chamber)
	compiled_chambers = [compileChamberLayers(layers) for layers in chambers]
	json_out = {"chambers":compiled_chambers}
	open("compiled.json", "w+").write(json.dumps(json_out))
	# list of string tuples of (filename, filecontent)
	#file_pairs = zip([chamber[0].split("_")[0] for chamber in chambers], compiled_chambers)
	# print out each string to its own file in /compiled 
	# saveFiles(file_pairs)
	print("Files saved to compiled.json")
	
if __name__ == "__main__":
	main()