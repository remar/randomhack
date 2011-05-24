package
{
  import org.flixel.FlxSprite;

  public class Field
  {
    private var width:int;
    private var height:int;

    private var field:Array;

    public function Field(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      clearField(Tile.BLOCK);
    }

    public function getWidth():int
    {
      return width;
    }

    public function getHeight():int
    {
      return height;
    }

    public function clearField(type:int):void
    {
      field = new Array(width);
      for(var x:int = 0;x < width;x++)
	{
	  field[x] = new Array(height);
	  for(var y:int = 0;y < height;y++)
	    {
	      setTile(x, y, type);
	    }
	}
    }

    public function generate(numberGenerator:NumberGenerator):Array
    {
      var fieldGenerator:FieldGenerator = new FieldGenerator(this);

      // Flood with water (0-7 pools of water)
      var pools:int = numberGenerator.getIntInRange(0, 7);

      for(var i:int = 0;i < pools;i++)
	{
	  fieldGenerator.createPool(numberGenerator);
	}

      // Carve holes (7-13 holes)
      var numHoles:int = 4;
      var numHoles2:int = numberGenerator.getIntInRange(3, 9);
      var maxHoleSize:int = numberGenerator.getIntInRange(2, 4);
      var holes:Array = [];

      for(i = 0;i < numHoles;i++)
	{
	  // TODO: Last hole should get position depending on first
	  // hole position, to move goal away from start.

	  holes.push([numberGenerator.getIntInRange(1, width - 2),
		      numberGenerator.getIntInRange(1, height - 2)]);
	  fieldGenerator.carveHole(holes[i][0], holes[i][1],
				   numberGenerator.getIntInRange(0, maxHoleSize));
	  // Carve path
	  if(i != 0)
	    {
	      fieldGenerator.carvePath(holes[i-1], holes[i],
				       numberGenerator.getIntInRange(2, 3));
	    }
	}

      for(i = 0;i < numHoles2;i++)
	{
	  var hole:Array = [numberGenerator.getIntInRange(1, width - 2),
			    numberGenerator.getIntInRange(1, height - 2)];
	  fieldGenerator.carveHole(hole[0], hole[1], numberGenerator.getIntInRange(0, maxHoleSize));
	  fieldGenerator.carvePath(hole,
				   holes[numberGenerator.getIntInRange(0, numHoles - 2)],
		    numberGenerator.getIntInRange(2, 3));
	}

      // Return proposed start and goal positions
      return [holes[0], holes[holes.length - 1]];
    }

    public function setTile(x:int, y:int, type:int):void
    {
      if ((x < 0 || x >= width || y < 0 || y >= width) ||
	  (type == Tile.EMPTY && (x == 0 || x == width - 1 ||
				  y == 0 || y == height - 1)))
	{
	  return;
	}

      field[x][y] = new Tile(type);
    }

    public function getTile(x:int, y:int):Tile
      {
	return field[x][y];
      }

    public function draw(drawable:Drawable):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      // Draw block or empty space
	      drawBlock(drawable, x, y, field[x][y].getColor());
	    }
	}
    }

    private function drawBlock(drawable:Drawable,
			       blockX:int, blockY:int, color:int):void
    {
      for(var y:int = 0;y < 8;y++)
	{
	  for(var x:int = 0;x < 8;x++)
	    {
	      drawable.setPixel(blockX * 8 + x,
				blockY * 8 + y,
				color);
	    }
	}
    }
  }
}
