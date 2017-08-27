import os
from PIL import Image
import json

# ridiculous global variable to prevent multiple readings of a file, or passing a parameter around :(
with open("build/conversion.json", 'r') as json_file:
    conversions = json.JSONDecoder().decode(json_file.read())

# accepts list of paths to layers
# eg ['chamber1_fg.png', 'chamber1_bg.png']
def compileChamber(layers):
	layer_dict = {}
	for layer in layers:
		# this indexing only works if layers are saved as .png or .jpg
		layer_name = layer[layer.find('_')+1:-4]
		image = Image.open(layer)
		layer_dict[layer_name] = compileLayer(list(image.getdata()))
	return {
		# this only works on unix-based systems, and could be troublesome in the future
		"name" : layer[layer.rfind('/')+1:layer.find('_')],
		# size as x by y
		"size" : [image.size[0], image.size[1]],
		# might be good to specify layer orderings
		"layers" : layer_dict
	}

# accepts list of pixel values
# eg 'chamber1_fg.png'
# returns list of object names to instantiate
def compileLayer(pixels):
	obj_list = []
	for pixel in pixels:
		object_name = conversions.get(",".join(map(str, pixel)))
		if object_name is not None:
			obj_list.append(object_name)
		else:
			raise ValueError("some pixel doesn't translate to an object reference.\nValue is: {}".format(pixel)) 
	return obj_list

def main():
	# get correct dir even within /build or /
	root = (os.getcwd()[:-6] if os.getcwd().endswith('build') else os.getcwd()) + '/chambers/'
	# create list of lists of layerpaths
	chambers = [map(lambda x: root + directory + "/" + x, os.listdir(root + directory)) for directory in os.listdir(root) if not directory.startswith('.')]
	# create list of chamber objects
	compiled_chambers = [compileChamber(layers) for layers in chambers]
	json_out = {"chambers":compiled_chambers}
	# write out to json file
	with open("compiled.json", "w+") as output:
		# next line is for printing out readable json
		# output.write(json.dumps(json_out, indent=2, sort_keys=True)) 
		output.write(json.dumps(json_out))
	print("Files saved to compiled.json")
	
if __name__ == "__main__":
	main()