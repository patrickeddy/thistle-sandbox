import os
from PIL import Image

# accepts list of layers as argument
# eg ['chamber1_fg.png', 'chamber1_bg.png']
# returns string
def compileChamberLayers(chambers): return reduce(lambda x, y: x + y, [compileChamber(layer) for layer in chambers])

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
	compile_string += "\n"
	return compile_string

def saveFiles(file_pairs):
	for pair in file_pairs: saveFile(*pair)

def saveFile(filename, filecontent):
	filename = filename.split("/")[:-1]
	filename[filename.index("chambers")] = "compiled"
	filename[-1] += ".cham"
	filename = os.path.join(os.path.abspath(os.sep), *filename)
	open(filename, "w+").write(filecontent)


def main():
	# get correct dir even within /build or /
	root = (os.getcwd()[:-6] if os.getcwd().endswith('build') else os.getcwd()) + '/chambers/'
	# list of lists of layerpaths
	chambers = [map(lambda x: root + directory + "/" + x, os.listdir(root + directory)) for directory in os.listdir(root) if not directory.startswith('.')]
	# list of strings (representing an entire compiled chamber)
	compiled_chambers = [compileChamberLayers(layers) for layers in chambers]
	# list of string tuples of (filename, filecontent)
	file_pairs = zip([chamber[0].split("_")[0] for chamber in chambers], compiled_chambers)
	print(file_pairs)
	# print out each string to its own file in /compiled 
	saveFiles(file_pairs)
	print("Files saved to /compiled")
	
if __name__ == "__main__":
	main()