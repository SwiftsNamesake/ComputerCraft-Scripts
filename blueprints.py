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

	bp = Blueprint.load('C:/Users/Jonatan/Pictures/Minecraft blueprints/mobgrinder.png', {
			(255, 255, 255): 'minecraft:air',           # Air
			(191,  16, 250): 'minecraft:stonebrick',    # Exterior walls
			(130,  52,   0): 'minecraft:redstone_lamp', # Redstone lamps
			(255, 127,  39): 'minecraft:stone',         # Floors and pedestals
			(237,  28,  36): 'minecraft:redstone',      # Redstone
			(153, 217, 234): 'minecraft:water',         # Water
			( 34, 177,  76): 'minecraft:wooden_slab',   # Half slabs
			(185, 122,  87): 'minecraft:dirt'           # Floor access
			# (255, 127,  39): '?' # 
	})

	bp.save('mobgrinder', 'blueprints/mobgrinder.lua')
	# print(bp.toLuaArray())



class Blueprint(object):

	'''
	Docstring goes here

	'''
	
	def __init__(self, layers, blockmap):
		self.layers   = layers
		self.blockmap = blockmap


	def toLuaArray(self):
		# TODO: Let's not go overboard with the obscure oneliners, alright? (recurse?)
		l = max(len(block) for block in self.blockmap.values())
		return '{{ {0} }}'.format('{{ {0} }}'.format(', '.join(', '.join('{{ {0} }}\n'.format(', '.join(repr(block.rjust(l, ' ')) for block in row)) for row in layer) for layer in self.layers)))


	def save(self, name, fn):
		with open(fn, mode='w', encoding='utf-8') as f:
			f.write('{0} = {1}'.format(name, self.toLuaArray()))


	# @staticmethod
	# def toLuaArray(items):
	# 	pass


	@staticmethod
	def load(fn, blockmap):

		'''
		Docstring goes here

		'''

		# TODO: Refactor

		im     = Image.open(fn) #
		pixels = im.load()      #
		dx, dy = im.size        #

		framecolour = (0, 0, 0) # The colour of the frames around each vertical layer

		assert all(pixels[x, 0]    == framecolour for x in range(dx)), 'Blueprint must have valid layer borders' # Upper border
		assert all(pixels[x, dy-1] == framecolour for x in range(dx)), 'Blueprint must have valid layer borders' # Lower border

		verticalBorders = [x for x in range(dx) if pixels[x, 1] == framecolour] #
		assert verticalBorders == [x for x in range(0, dx, verticalBorders[1]-verticalBorders[0])], 'All layers must be the same size' #

		framesize = (verticalBorders[1]-verticalBorders[0], dy)

		layers = []

		for layer in verticalBorders[:-1]:
			layers.append([[blockmap[pixels[x+layer,y]] for x in range(1, framesize[0]-1)] for y in range(1, framesize[1]-1)])

		return Blueprint(layers, blockmap)


def showLayer(layer):
	return '\n'.join(''.join(row) for row in layer)


if __name__ == '__main__':
	main()