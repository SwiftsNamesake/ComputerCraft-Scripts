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

  # Mob grinder
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

  # Ender pad
  bp = Blueprint.load('C:/Users/Jonatan/Pictures/Minecraft blueprints/enderpad-plain.png', {
    (255, 255, 255, 255): 'minecraft:air',       # Air
    ( 63,  72, 204, 255): 'minecraft:end_bricks' # 
  })

  bp.save('mobgrinder', 'blueprints/enderpad.lua')
  # print(bp.toLuaArray())



class Blueprint(object):

  '''
  Docstring goes here

  '''
  
  def __init__(self, layers, blockmap):
    self.layers   = layers
    self.blockmap = blockmap


  def toLuaArray(self):
    
    # TODO: Simplify further (use multiline literals?)
    # columnWidths = [max(len(block))]

    indent = 2 # Spaces per indentation level

    def showBlock(b, pad=0, i=None):
      # l = max(len(block) for block in self.blockmap.values())
      return repr(b[len('minecraft:'):]).rjust(pad, ' ')
    
    def showRow(r, columnWidths, i=None):
      return '{{ {0} }}'.format(', '.join(showBlock(block, pad=width) for block, width in zip(r, columnWidths)))
    
    def showLayer(l, i=None):
      pad = 1
      columnWidths = [max(len(showBlock(block)) for block in (r[i] for r in l))+pad for i,_ in enumerate(l[0])]
      return '{{\n{1}{1}{0}\n{1}}}'.format(',\n{0}{0}'.format(' ' * indent).join(showRow(row, columnWidths) for row in l), ' ' * indent)
    
    return '{{\n{1}{0}\n}}'.format(',\n\n{0}'.format(' ' * indent).join(showLayer(layer) for layer in self.layers), ' ' * indent)


  def save(self, name, fn):
    with open(fn, mode='w', encoding='utf-8') as f:
      f.write('{0} = {1}'.format(name, self.toLuaArray()))


  # @staticmethod
  # def toLuaArray(items):
  #   pass


  @staticmethod
  def load(fn, blockmap):

    '''
    Docstring goes here

    '''

    # TODO: Refactor

    im     = Image.open(fn) #
    pixels = im.load()      #
    dx, dy = im.size        #
    
    framecolour = (0, 0, 0) if len(pixels[0,0]) == 3 else (0,0,0,255) # The colour of the frames around each vertical layer
    
    print(framecolour)
    assert all(pixels[x, 0]    == framecolour for x in range(dx)), 'Blueprint must have valid layer borders ({})'.format([pixels[x,0] for x in range(dx)]) # Upper border
    assert all(pixels[x, dy-1] == framecolour for x in range(dx)), 'Blueprint must have valid layer borders' # Lower border

    verticalBorders = [x for x in range(dx) if pixels[x, 1] == framecolour] #
    print(verticalBorders)
    assert verticalBorders == [x for x in range(0, dx, verticalBorders[1]-verticalBorders[0])], 'All layers must be the same size' #

    framesize = (verticalBorders[1]-verticalBorders[0], dy)

    layers = []

    for layer in verticalBorders[:-1]:
      print(layer)
      layers.append([[blockmap[pixels[x+layer,y]] for x in range(1, framesize[0]-1)] for y in range(1, framesize[1]-1)])

    return Blueprint(layers, blockmap)


def showLayer(layer):
  return '\n'.join(''.join(row) for row in layer)


if __name__ == '__main__':
  main()