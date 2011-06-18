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
  }
}
