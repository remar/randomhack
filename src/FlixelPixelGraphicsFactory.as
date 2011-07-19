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

    private static const SPRITE_DATA:Object = {};

    private var sprites:Array = [];

    public function FlixelPixelGraphicsFactory(screen:PixelScreen):void
    {
      this.screen = screen;

      initSpriteData();
    }

    public function getDrawable():Drawable
    {
      return new FlixelPixelDrawable(screen);
    }

    public function getSprite(spriteType:int):Sprite
    {
      if (!sprites[spriteType])
	{
	  var sprite:Sprite = new PixelSprite(8, 8);
	  sprite.setData(SPRITE_DATA[spriteType]);
	  sprites[spriteType] = sprite;
	}

      return sprites[spriteType];
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

      private function initSpriteData():void
      {
	  SPRITE_DATA[SpriteType.EMPTY] = [0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0];
	  SPRITE_DATA[SpriteType.PLAYER] = [0,0,0,1,1,1,0,0,
					    0,0,0,1,1,1,0,1,
					    1,1,1,0,1,0,0,1,
					    1,1,1,1,1,1,1,1,
					    1,1,1,0,1,0,0,1,
					    0,1,0,0,1,0,0,0,
					    0,0,0,1,0,1,0,0,
					    0,0,1,1,0,1,1,0,
					    0xcccccc];
	  SPRITE_DATA[SpriteType.GOAL] = [0,0,0,0,1,1,1,1,
					  0,0,0,0,1,1,1,1,
					  0,0,1,1,1,0,0,1,
					  0,0,1,1,1,0,0,1,
					  1,1,1,0,0,0,0,1,
					  1,1,1,0,0,0,0,1,
					  1,0,0,0,0,0,0,1,
					  1,1,1,1,1,1,1,1,
					  0xcccccc];
	  SPRITE_DATA[SpriteType.BAT] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 1,0,0,0,0,0,0,1,
					 0,1,1,0,0,1,1,0,
					 0,0,1,1,1,1,0,0,
					 0,0,0,1,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0x10ff10];
	  SPRITE_DATA[SpriteType.A] = [0,1,1,1,1,1,0,0,
				       1,0,0,0,0,0,1,0,
				       1,0,0,0,0,0,1,0,
				       1,1,1,1,1,1,1,0,
				       1,0,0,0,0,0,1,0,
				       1,0,0,0,0,0,1,0,
				       1,0,0,0,0,0,1,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
	  SPRITE_DATA[SpriteType.B] = [1,1,1,1,1,1,0,0,
				       1,0,0,0,0,0,1,0,
				       1,0,0,0,0,0,1,0,
				       1,1,1,1,1,1,1,0,
				       1,0,0,0,0,0,1,0,
				       1,0,0,0,0,0,1,0,
				       1,1,1,1,1,1,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      }

  }
}
