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

      floodWithWater(fieldGenerator, numberGenerator);

      // Carve rooms (7-13 holes)
      var numPrimaryRooms:int = 4;
      var primaryRooms:Array = getPrimaryRoomPositions(numberGenerator,
						       numPrimaryRooms);

      var numSecondaryRooms:int = numberGenerator.getIntInRange(3, 9);
      var secondaryRooms:Array = getSecondaryRoomPositions(numberGenerator,
							   numSecondaryRooms);

      var maxHoleSize:int = numberGenerator.getIntInRange(2, 4);

      for(var i:int = 0;i < primaryRooms.length;i++)
	{
	  /* holes.push([numberGenerator.getIntInRange(1, width - 2), */
	  /* 	      numberGenerator.getIntInRange(1, height - 2)]); */
	  fieldGenerator.carveHole(primaryRooms[i],
				   numberGenerator.getIntInRange(0, maxHoleSize));
	  // Carve path
	  if(i != 0)
	    {
	      fieldGenerator.carvePath(primaryRooms[i-1], primaryRooms[i],
				       numberGenerator.getIntInRange(2, 3));
	    }
	}

      for(i = 0;i < secondaryRooms.length;i++)
	{
	  fieldGenerator.carveHole(secondaryRooms[i],
				   numberGenerator.getIntInRange(0, maxHoleSize));
	  fieldGenerator.carvePath(secondaryRooms[i],
				   primaryRooms[numberGenerator.getIntInRange(0, numPrimaryRooms - 2)],
				   numberGenerator.getIntInRange(2, 3));
	}

      // Return proposed start and goal positions
      return [primaryRooms[0], primaryRooms[primaryRooms.length - 1]];
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

    public function draw(drawable:PixelDrawable):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      drawBlock(drawable, x, y, field[x][y].getColor());
	    }
	}
    }

    private function drawBlock(drawable:PixelDrawable,
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

    private function floodWithWater(fieldGenerator:FieldGenerator,
				    numberGenerator:NumberGenerator):void
    {
      var pools:int = numberGenerator.getIntInRange(0, 7);

      for(var i:int = 0;i < pools;i++)
	{
	  fieldGenerator.createPool(numberGenerator);
	}
    }

    private function getPrimaryRoomPositions(numberGenerator:NumberGenerator,
					     numPrimaryRooms:int):Array
    {
      var roomPositions:Array = getRoomPositions(numberGenerator,
						 numPrimaryRooms - 1);

      var firstPosition:Point = roomPositions[0];

      // Last hole should get position depending on first
      // hole position, to move goal away from start.

      // TODO: Make this better reflect how it works in the original
      var x1:int, x2:int, y1:int, y2:int;

      if(firstPosition.getX() < width / 2)
	{
	  x1 = width / 2;
	  x2 = width - 2;
	}
      else
	{
	  x1 = 1;
	  x2 = width / 2;
	}

      if(firstPosition.getY() < height / 2)
	{
	  y1 = height / 2;
	  y2 = height - 2;
	}
      else
	{
	  y1 = 1;
	  y2 = height / 2;
	}

      roomPositions.push(new Point(numberGenerator.getIntInRange(x1, x2),
				   numberGenerator.getIntInRange(y1, y2)));

      return roomPositions;
    }

    private function getSecondaryRoomPositions(numberGenerator:NumberGenerator,
					       numSecondaryRooms:int):Array
    {
      return getRoomPositions(numberGenerator, numSecondaryRooms);
    }

    private function getRoomPositions(numberGenerator:NumberGenerator,
				      numRooms:int):Array
    {
      var roomPositions:Array = [];
      for(var i:int = 0;i < numRooms;i++)
	{
	  roomPositions.push(new Point(numberGenerator.getIntInRange(1, width - 2),
				       numberGenerator.getIntInRange(1, height - 2)));
	}
      return roomPositions;
    }
  }
}
