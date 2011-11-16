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

    public function generate(field:Field, type:LevelType):StartPositions
    {
      this.field = field;

      var fieldCarver:FieldCarver = new FieldCarver(field);

      var startPos:StartPositions;

      if(type == LevelType.CAVE)
	{
	  startPos = generateCave(fieldCarver);
	}
      else if(type == LevelType.RUINS)
	{
	  startPos = generateRuins(fieldCarver);
	}

      return startPos;
    }

    private function generateCave(fieldCarver:FieldCarver):StartPositions
    {
      floodWithWater(fieldCarver);

      // Carve rooms (7-13 holes)
      var numPrimaryRooms:int = 4;
      var primaryRooms:Array = getPrimaryRoomPositions(numPrimaryRooms);

      var numSecondaryRooms:int = numberGenerator.getIntInRange(3, 9);
      var secondaryRooms:Array = getSecondaryRoomPositions(numSecondaryRooms);

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

    private function generateRuins(fieldCarver:FieldCarver):StartPositions
    {
      floodWithWater(fieldCarver);

      var numPrimaryRooms:int = 8;
      var primaryRooms:Array = getPrimaryRoomPositionsOrthogonal(numPrimaryRooms);
      var maxHoleSize:int = 2;

      for(var i:int = 0;i < primaryRooms.length;i++)
	{
	  fieldCarver.carveHole(primaryRooms[i],
				numberGenerator.getIntInRange(0, maxHoleSize));
	  // Carve path
	  if(i != 0)
	    {
	      fieldCarver.carvePath(primaryRooms[i-1], primaryRooms[i],
				    numberGenerator.getIntInRange(1, 2));
	    }
	}

      var numSecondaryRooms:int = numberGenerator.getIntInRange(5, 7);
      var moveHorizontal:Boolean = true;

      for(i = 0;i < numSecondaryRooms;i++)
	{
	  var targetRoom:Point = primaryRooms[numberGenerator.getIntInRange(0, numPrimaryRooms - 1)];
	  var secondaryRoom:Point;

	  if(moveHorizontal)
	    {
	      secondaryRoom = new Point(getRandomFieldPositionX(), targetRoom.y);
	    }
	  else
	    {
	      secondaryRoom = new Point(targetRoom.x, getRandomFieldPositionY());
	    }
	  fieldCarver.carveHole(secondaryRoom,
				numberGenerator.getIntInRange(0, maxHoleSize));	      
	  fieldCarver.carvePath(secondaryRoom, targetRoom,
				numberGenerator.getIntInRange(1, 2));
	}

      return new StartPositions(primaryRooms[0],
				primaryRooms[primaryRooms.length - 1]);      
    }

    private function floodWithWater(fieldCarver:FieldCarver):void
    {
      var pools:int = numberGenerator.getIntInRange(0, 7);

      for(var i:int = 0;i < pools;i++)
	{
	  fieldCarver.createPool(numberGenerator);
	}
    }

    private function getPrimaryRoomPositionsOrthogonal(numPrimaryRooms:int):Array
    {
      return getRoomPositionsOrthogonal(numPrimaryRooms);
    }

    private function getPrimaryRoomPositions(numPrimaryRooms:int):Array
    {
      var roomPositions:Array = getRoomPositions(numPrimaryRooms - 1);

      var firstPosition:Point = roomPositions[0];

      // Last hole should get position depending on first
      // hole position, to move goal away from start.

      // TODO: Make this better reflect how it works in the original
      var x1:int, x2:int, y1:int, y2:int;

      if(firstPosition.x < field.getWidth() / 2)
	{
	  x1 = field.getWidth() / 2;
	  x2 = field.getWidth() - 2;
	}
      else
	{
	  x1 = 1;
	  x2 = field.getWidth() / 2;
	}

      if(firstPosition.y < field.getHeight() / 2)
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

    private function getSecondaryRoomPositions(numSecondaryRooms:int):Array
    {
      return getRoomPositions(numSecondaryRooms);
    }

    private function getRoomPositions(numRooms:int):Array
    {
      var roomPositions:Array = [];
      for(var i:int = 0;i < numRooms;i++)
	{
	  roomPositions.push(new Point(getRandomFieldPositionX(),
				       getRandomFieldPositionY()));
	}
      return roomPositions;
    }

    private function getRoomPositionsOrthogonal(numRooms:int):Array
    {
      var roomPositions:Array = [];

      var x:int = getRandomFieldPositionX();
      var y:int = getRandomFieldPositionY();
      var moveHorizontal:Boolean = true;

      for(var i:int = 0;i < numRooms;i++)
	{
	  if(moveHorizontal)
	    {
	      x = getRandomFieldPositionX();
	    }
	  else
	    {
	      y = getRandomFieldPositionY();
	    }
	  moveHorizontal = !moveHorizontal;
	  roomPositions.push(new Point(x, y));
	}
      return roomPositions;
    }

    private function getRandomFieldPositionX():int
    {
      return numberGenerator.getIntInRange(1, field.getWidth() - 2);
    }

    private function getRandomFieldPositionY():int
    {
      return numberGenerator.getIntInRange(1, field.getHeight() - 2);
    }
  }
}
