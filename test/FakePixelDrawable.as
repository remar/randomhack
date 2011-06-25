package
{
  public class FakePixelDrawable implements PixelDrawable
  {
    private var canvas:Array;
    private static const defaultColor:int = 0x000000;

    public function FakePixelDrawable(width:int, height:int):void
    {
      canvas = new Array(width);
      for(var i:int = 0;i < width;i++)
	{
	  canvas[i] = new Array(height);
	  for(var j:int = 0;j < height;j++)
	    {
	      canvas[i][j] = defaultColor;
	    }
	}
    }

    public function drawSprite(sprite:Sprite, position:Point):void
    {
      var width:int = sprite.getWidth();
      var height:int = sprite.getHeight();
      var data:Array = sprite.getData();
      var color:int = data[width*height];

      var xOffset:int = position.getX();
      var yOffset:int = position.getY();

      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      if (data[x + y * width] !== 0)
		{
		  setPixel(x + xOffset, y + yOffset, color);
		}
	    }
	}
    }

    public function drawTile(tile:Tile, position:Point):void
    {
      var width:int = tile.getWidth();
      var height:int = tile.getHeight();
      var data:Array = tile.getData();
      var color:int = data[width*height];

      var xOffset:int = position.getX() * width;
      var yOffset:int = position.getY() * height;

      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      setPixel(x + xOffset, y + yOffset, data[x + y * width]);
	    }
	}
    }

    public function setPixel(x:int, y:int, color:int):void
    {
      canvas[x][y] = color;
    }

    public function getPixel(x:int, y:int):int
    {
      return canvas[x][y];
    }
  }
}
