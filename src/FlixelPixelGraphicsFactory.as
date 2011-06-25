package
{
  import org.flixel.FlxSprite;

  public class FlixelPixelGraphicsFactory implements GraphicsFactory
  {
    private var screen:PixelScreen;
    private static const tileWidth:int = 8;
    private static const tileHeight:int = 8;

    private static const EMPTY_COLOR:int = 0x000000;
    private static const BLOCK_COLOR:int = 0xff5050;
    private static const WATER_COLOR:int = 0x0000ff;

    public function FlixelPixelGraphicsFactory(screen:PixelScreen):void
    {
      this.screen = screen;
    }

    public function getDrawable():Drawable
    {
      return new FlixelPixelDrawable(screen);
    }

    public function getSprite(type:SpriteType):Sprite
    {
      return null;
    }

    public function getTile(type:TileType, surrounding:Surrounding):Tile
    {
      var tile:Tile = new PixelTile(tileWidth, tileHeight);
      var data:Array = [];
      var color:int;

      switch(type.getType())
	{
	case TileType.EMPTY:
	  color = EMPTY_COLOR;
	  break;

	case TileType.BLOCK:
	  color = BLOCK_COLOR;
	  break;

	case TileType.WATER:
	  color = WATER_COLOR;
	  break;
	}

      for(var i:int = 0;i < tileWidth * tileHeight;i++)
	{
	  data[i] = color;
	}

      tile.setData(data);

      return tile;
    }
  }
}
