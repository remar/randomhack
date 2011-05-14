package
{
  import org.flixel.FlxSprite;

  public class Field
  {
    // Playing field is 32*24 blocks
    public static const WIDTH:int = 32;
    public static const HEIGHT:int = 24;

    // Offset when drawing on the screen
    public static const X_OFFSET:int = 0;
    public static const Y_OFFSET:int = 192;

    private var field:Array;

    public function Field():void
    {
      clearField(Tile.BLOCK);
    }

    public function clearField(type:int):void
    {
      field = new Array(WIDTH);
      for(var x:int = 0;x < WIDTH;x++)
	{
	  field[x] = new Array(HEIGHT);
	  for(var y:int = 0;y < HEIGHT;y++)
	    {
	      setTile(x, y, type);
	    }
	}
    }

    public function generate():Array
    {
      // Flood with water (0-7 pools of water)

      // Carve holes (7-13 holes)
      var numHoles:int = 4;
      var numHoles2:int = 3 + Math.floor(Math.random() * 7); // [3-9]
      var maxHoleSize:int = 2 + Math.floor(Math.random() * 3); // [2-4]
      var holes:Array = [];

      for(var i:int = 0;i < numHoles;i++)
	{
	  holes.push([Math.round(Math.random() * (WIDTH - 2)) + 1,
		      Math.round(Math.random() * (HEIGHT - 2)) + 1]);
	  carveHole(holes[i][0], holes[i][1], Math.floor(Math.random() * maxHoleSize));
	  // Carve path
	  if(i != 0)
	    {
	      carvePath(holes[i-1], holes[i], 2 + Math.floor(Math.random() * 2));
	    }
	}

      for(i = 0;i < numHoles2;i++)
	{
	  var hole:Array = [Math.round(Math.random() * (WIDTH - 2)) + 1,
			    Math.round(Math.random() * (HEIGHT - 2)) + 1];
	  carveHole(hole[0], hole[1], Math.floor(Math.random() * maxHoleSize));
	  carvePath(hole, holes[Math.floor(Math.random() * (numHoles - 1))],
		    2 + Math.floor(Math.random() * 2));
	}

      // Return proposed start and goal positions
      return [holes[0], holes[holes.length - 1]];
    }

    public function setTile(x:int, y:int, type:int):void
    {
      if ((x < 0 || x >= WIDTH || y < 0 || y >= WIDTH) ||
	  (type == Tile.EMPTY && (x == 0 || x == WIDTH - 1 ||
				  y == 0 || y == HEIGHT - 1)))
	{
	  return;
	}

      field[x][y] = new Tile(type);
    }

    public function getTile(x:int, y:int):Tile
      {
	return field[x][y];
      }

    public function carveHole(x:int, y:int, size:int):void
    {
      for(var j:int = y - size;j <= y + size;j++)
	for(var i:int = x - size;i <= x + size;i++)
	  setTile(i, j, Tile.EMPTY);
    }

    public function carvePath(p1:Array, p2:Array, width:int):void
    {
      // Carve horizontal path
      if(p1[1] == p2[1])
	{
	  carveSimplePath(p1, p1[0] < p2[0] ? [+1, 0] : [-1, 0],
			  Math.abs(p1[0] - p2[0]) + 1, width);
	}

      // Carve vertical path
      else if(p1[0] == p2[0])
	{
	  carveSimplePath(p1, p1[1] < p2[1] ? [0, +1] : [0, -1],
			  Math.abs(p1[1] - p2[1]) + 1, width);
	}

      // Carve diagonal path
      else if(Math.abs(p1[0] - p2[0]) == Math.abs(p1[1] - p2[1]))
	{
	  carveSimplePath(p1, [(p2[0] - p1[0])/Math.abs(p1[0] - p2[0]),
			       (p2[1] - p1[1])/Math.abs(p1[1] - p2[1])],
			  Math.abs(p1[0] - p2[0]) + 1, width);
	}

      // Bresenhams
      else
	{
	  carveBresenhamPath(p1, p2, width);
	}
    }

    private function carveSimplePath(startPoint:Array, direction:Array,
					 length:int, width:int):void
    {
      var x:int = startPoint[0];
      var y:int = startPoint[1];

      for(var i:int = 0;i < length;i++)
	{
	  if(width == 1)
	    {
	      setTile(x, y, Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath([x, y],
			      [direction[1] != 0 ? -1 : 0,
			       direction[1] == 0 ? -1 : 0],
			      width, 1);
	    }
	  x += direction[0];
	  y += direction[1];
	}
    }

    private function carveBresenhamPath(startPoint:Array, endPoint:Array,
					width:int):void
    {
      var dx:int = Math.abs(endPoint[0] - startPoint[0]);
      var dy:int = Math.abs(endPoint[1] - startPoint[1]);
      var sx:int = startPoint[0] < endPoint[0] ? 1 : -1;
      var sy:int = startPoint[1] < endPoint[1] ? 1 : -1;
      var err:int = dx - dy;
      var dir:Array = err > 0 ? [0, -1] : [-1, 0];
      while(true)
	{
	  if(width == 1)
	    {
	      setTile(startPoint[0], startPoint[1], Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath(startPoint, dir, width, 1);
	    }

	  if(startPoint[0] == endPoint[0] && startPoint[1] == endPoint[1])
	    {
	      break;
	    }

	  var e2:int = 2*err;
	  if(e2 > -dy)
	    {
	      err -= dy;
	      startPoint[0] += sx;
	    }
	  if(e2 < dx)
	    {
	      err += dx;
	      startPoint[1] += sy;
	    }
	}
    }

    public function draw(drawable:Drawable):void
    {
      for(var y:int = 0;y < HEIGHT;y++)
	{
	  for(var x:int = 0;x < WIDTH;x++)
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
	      drawable.setPixel(blockX * 8 + x + X_OFFSET,
				blockY * 8 + y + Y_OFFSET,
				color);
	    }
	}
    }
  }
}
