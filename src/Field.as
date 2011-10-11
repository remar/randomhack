package
{
  public class Field
  {
    private var width:int;
    private var height:int;

    private var field:Array;

    private static const MIN_DISTANCE:int = 4;

    public function Field(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      clearField(TileType.BLOCK);
    }

    public function getWidth():int
    {
      return width;
    }

    public function getHeight():int
    {
      return height;
    }

    public function clearField(type:TileType):void
    {
      field = new Array(width);
      for(var x:int = 0;x < width;x++)
	{
	  field[x] = new Array(height);
	  for(var y:int = 0;y < height;y++)
	    {
	      setTile(new Point(x, y), type);
	    }
	}
    }

    public function setTile(p:Point, type:TileType):void
    {
      if ((p.x < 0 || p.x >= width || p.y < 0 || p.y >= width) ||
	  (type == TileType.EMPTY && (p.x == 0 || p.x == width - 1 ||
				      p.y == 0 || p.y == height - 1)))
	{
	  return;
	}

      field[p.x][p.y] = [type, null];
    }

    public function getTile(p:Point):TileType
    {
      return field[p.x][p.y][0];
    }

    public function renderBackgroundTiles(graphicsFactory:GraphicsFactory,
					  numberGenerator:NumberGenerator):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      field[x][y][1] = graphicsFactory.getTile(field[x][y][0],
						       getSurrounding(x, y),
						       numberGenerator);
	    }
	}      
    }

    public function draw(drawable:Drawable):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      var tile:Tile = field[x][y][1];
	      drawable.drawTile(tile, new Point(x * tile.getWidth(),
						y * tile.getHeight()));
	    }
	}
    }

    public function getDirection(p1:Point, p2:Point):Point
    {
      if(p1.equals(p2))
	return new Point(0, 0);

      var xdiff:int = p2.x - p1.x;
      var ydiff:int = p2.y - p1.y;

      var angle:Number = Math.atan(-ydiff/Math.abs(xdiff));

      var xComponent:int = 0;
      var yComponent:int = 0;

      if(angle > -Math.PI/3 && angle < Math.PI/3)
	{
	  xComponent = sign(xdiff);
	}
 
      if(angle > Math.PI/6 || angle < -Math.PI/6)
	{
	  yComponent = sign(ydiff);
	}

      return new Point(xComponent, yComponent);
    }

    public function getEmptyPositionsInRandomOrder(numberGenerator:NumberGenerator,
						   startPositions:StartPositions):Array
    {
      var positions:Array = [];

      for(var y:int = 0;y < height;y++)
	for(var x:int = 0;x < width;x++)
	  {
	    if(getTile(new Point(x, y)) == TileType.EMPTY)
	      positions.push(new Point(x, y));
	  }

      positions = positions.filter(function (p:Point, i:int, a:Array):Boolean
				   {
				     return p.distanceTo(startPositions.start) > MIN_DISTANCE &&
				            p.distanceTo(startPositions.goal) > MIN_DISTANCE;
				   });      

      for(var i:int = 0;i < positions.length - 1;i++)
	{
	  var elem:int = numberGenerator.getIntInRange(i, positions.length - 1);

	  if(elem === i)
	    continue;

	  var temp:Point = positions[elem];
	  positions[elem] = positions[i];
	  positions[i] = temp;
	}

      return positions;
    }

    private function sign(x:int):int
    {
      if (x < 0)
	return -1;
      else
	return 1;
    }

    private function getSurrounding(x:int, y:int):Surrounding
    {
      var east:TileType = x + 1 < width ? field[x + 1][y][0] : TileType.BLOCK;
      var north:TileType = y - 1 >= 0 ? field[x][y - 1][0] : TileType.BLOCK;
      var west:TileType = x - 1 >= 0 ? field[x - 1][y][0] : TileType.BLOCK;
      var south:TileType = y + 1 < height ? field[x][y + 1][0] : TileType.BLOCK;
      return new Surrounding([east, north, west, south]);
    }
  }
}
