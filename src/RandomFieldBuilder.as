package
{
  public class RandomFieldBuilder implements FieldBuilder
  {
    private var field:Field;
    private var numberGenerator:NumberGenerator;

    public function RandomFieldBuilder(numberGenerator:NumberGenerator):void
    {
      this.numberGenerator = numberGenerator;
    }

    public function generate(field:Field):StartPositions
    {
      this.field = field;

      var fieldCarver:FieldCarver = new FieldCarver(field);

      floodWithWater(fieldCarver, numberGenerator);

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
	  fieldCarver.carveHole(primaryRooms[i],
				numberGenerator.getIntInRange(0, maxHoleSize));
	  // Carve path
	  if(i != 0)
	    {
	      fieldCarver.carvePath(primaryRooms[i-1], primaryRooms[i],
				    numberGenerator.getIntInRange(2, 3));
	    }
	}

      for(i = 0;i < secondaryRooms.length;i++)
	{
	  fieldCarver.carveHole(secondaryRooms[i],
				   numberGenerator.getIntInRange(0, maxHoleSize));
	  fieldCarver.carvePath(secondaryRooms[i],
				   primaryRooms[numberGenerator.getIntInRange(0, numPrimaryRooms - 2)],
				   numberGenerator.getIntInRange(2, 3));
	}

      // Return proposed start and goal positions
      return new StartPositions(primaryRooms[0],
				primaryRooms[primaryRooms.length - 1]);
    }

    private function floodWithWater(fieldCarver:FieldCarver,
				    numberGenerator:NumberGenerator):void
    {
      var pools:int = numberGenerator.getIntInRange(0, 7);

      for(var i:int = 0;i < pools;i++)
	{
	  fieldCarver.createPool(numberGenerator);
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

      if(firstPosition.getX() < field.getWidth() / 2)
	{
	  x1 = field.getWidth() / 2;
	  x2 = field.getWidth() - 2;
	}
      else
	{
	  x1 = 1;
	  x2 = field.getWidth() / 2;
	}

      if(firstPosition.getY() < field.getHeight() / 2)
	{
	  y1 = field.getHeight() / 2;
	  y2 = field.getHeight() - 2;
	}
      else
	{
	  y1 = 1;
	  y2 = field.getHeight() / 2;
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
	  roomPositions.push(new Point(numberGenerator.getIntInRange(1, field.getWidth() - 2),
				       numberGenerator.getIntInRange(1, field.getHeight() - 2)));
	}
      return roomPositions;
    }
  }
}