# blueprints.py
# Load blueprints in the form of bitmaps
#
# Jonatan H Sundqvist
# August 9 2016



from PIL import Image


def main():

	'''
	Docstring goes here

	'''

	Blueprint.load('C:/Users/Jonatan/Pictures/Minecraft blueprints/mobgrinder.png')



class Blueprint(object):

	'''
	Docstring goes here

	'''

	def __init__(self):
		pass



	@staticmethod
	def load(fn):

		'''
		Docstring goes here

		'''

		image  = Image.open(fn) #
		pixels = image.load()   #
		dx, dy = image.size
		print(image, dx, dy)

		framecolour = (0, 0, 0) # The colour of the frames around each vertical layer

		assert all(pixels[x, 0]    == framecolour for x in range(dx)), 'Blueprint must have valid layer borders' # Upper border
		assert all(pixels[x, dy-1] == framecolour for x in range(dx)), 'Blueprint must have valid layer borders' # Lower border

		verticalBorders = [x for x in range(dx) if pixels[x, 1] == framecolour] #
		print(verticalBorders)
		assert verticalBorders == [x for x in range(0, dx, verticalBorders[1]-verticalBorders[0])], 'All layers must be the same size' #

		framesize = (verticalBorders[1]-verticalBorders[0], dy)

		layers = []

		blockmap = {
			(255, 255, 255): ' ', # Air
			(191,  16, 250): 'W', # ?
			(255, 127,  39): 'b', # ?
			(130,  52,   0): 'c', # ?
			(255, 127,  39): 'e', # ?
			(237,  28,  36): 'f', # ?
			(153, 217, 234): 'g', # ?
			( 34, 177,  76): 'h', # ?
			(185, 122,  87): 'i'  # ?
		}

		for layer in verticalBorders[:-1]:
			print(layer)
			layers.append([[blockmap[pixels[x+layer,y]] for x in range(1, framesize[0]-1)] for y in range(1, framesize[1]-1)])

		for l in layers:
			print(showLayer(l))


def showLayer(layer):
	return '\n'.join(''.join(row) for row in layer)

def toLuaArray(layer):
	pass

if __name__ == '__main__':
	main()