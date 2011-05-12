package
{
  import org.flixel.FlxSprite;

  public class Field
  {
    // Playing field is 32*24 blocks
    private static const WIDTH:int = 32;
    private static const HEIGHT:int = 24;

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

    public function generate():void
    {
      // Flood with water (0-7 pools of water)
      // Carve holes (7-13 holes)
      // Carve paths
      // Return proposed start and goal positions
    }

    public function setTile(x:int, y:int, type:int):void
    {
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

    private function carveOrthogonalPath(startPoint:Array, direction:Array,
					 length:int, width:int):void
    {
      var x:int = startPoint[0];
      var y:int = startPoint[1];

      setTile(x, y, Tile.EMPTY);
      for(var i:int = 0;i <= length;i++)
	{
	  x += direction[0];
	  y += direction[1];
	  setTile(x, y, Tile.EMPTY);
	}
    }

    public function carvePath(p1:Array, p2:Array, width:int):void
    {
      // Carve horizontal path
      if(p1[1] == p2[1])
	{
	  carveOrthogonalPath(p1, p1[0] < p2[0] ? [+1, 0] : [-1, 0],
			      Math.abs(p1[0] - p2[0]), width);
	}

      // Carve vertical path
      if(p1[0] == p2[0])
	{
	  carveOrthogonalPath(p1, p1[1] < p2[1] ? [0, +1] : [0, -1],
			      Math.abs(p1[1] - p2[1]), width);
	}

      // Bresenhams
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
