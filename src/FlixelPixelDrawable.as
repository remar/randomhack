package
{
  public class FlixelPixelDrawable implements Drawable
  {
    private var pixelScreen:PixelScreen;

    public function FlixelPixelDrawable(pixelScreen:PixelScreen):void
    {
      this.pixelScreen = pixelScreen;
    }

    public function drawSprite(sprite:Sprite, position:Point):void
    {
      var width:int = sprite.getWidth();
      var height:int = sprite.getHeight();
      var data:Array = sprite.getData();
      var color:int = data[width*height];

      var xOffset:int = position.x;
      var yOffset:int = position.y;

      var pixelColor:int;

      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      pixelScreen.setPixel(x + xOffset, y + yOffset, data[x + y * width] ? color : 0);
	    }
	}
    }

    public function drawTile(tile:Tile, position:Point):void
    {
      var width:int = tile.getWidth();
      var height:int = tile.getHeight();
      var data:Array = tile.getData();

      var xOffset:int = position.x;
      var yOffset:int = position.y;

      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      pixelScreen.setPixel(x + xOffset,
				   y + yOffset,
				   data[x + y * width]);
	    }
	}      
    }
  }
}
