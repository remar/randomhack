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
    private var levelType:int;

    public function FlixelPixelGraphicsFactory(screen:PixelScreen):void
    {
      this.screen = screen;
      setLevelType(LevelType.CAVE);

      initSpriteData();
    }

    public function setLevelType(levelType:int):void
    {
      this.levelType = levelType;
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

    public function getTile(type:TileType, surrounding:Surrounding,
			    numberGenerator:NumberGenerator):Tile
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

      if(type.getType() == TileType.BLOCK)
	{
	  drawJaggedEdges(data, surrounding, numberGenerator);
	}

      tile.setData(data);

      return tile;
    }

    private function drawJaggedEdges(data:Array, surrounding:Surrounding,
				     numberGenerator:NumberGenerator):void
    {
      var w:int = [2, 0, 0, 0][levelType];

      if(surrounding.east.getType() == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 7, 8);
      if(surrounding.north.getType() == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 0, 1);
      if(surrounding.west.getType() == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 0, 8);
      if(surrounding.south.getType() == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 7*8, 1);
    }

    private function drawTileLine(data:Array, offset:int, jump:int):void
    {
      for(var i:int = 0;i < 8;i++)
	{
	  data[offset] = EMPTY_COLOR;
	  offset += jump;
	}
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
      SPRITE_DATA[SpriteType.FLEA] = [0,0,0,0,0,0,0,0,
				      0,0,1,1,0,0,0,0,
				      0,1,1,1,1,1,0,0,
				      0,0,0,1,1,1,1,0,
				      0,0,0,1,1,1,1,0,
				      0,0,0,1,0,0,1,0,
				      0,0,1,0,0,1,0,0,
				      0,0,0,1,0,0,1,0,
				      RGB15(4,31,4)];
      SPRITE_DATA[SpriteType.SNAKE] = [0,1,1,1,1,1,0,0,
				       1,0,1,0,0,0,1,0,
				       1,1,0,0,0,0,1,0,
				       0,0,0,0,0,1,0,0,
				       0,0,0,1,1,0,0,0,
				       0,0,1,0,0,0,0,1,
				       0,0,1,0,0,0,1,0,
				       0,0,0,1,1,1,0,0,
				       RGB15(4,31,4)];
      SPRITE_DATA[SpriteType.GOBLIN] = [0,0,0,0,0,0,0,0,
					0,0,1,1,1,0,0,0,
					0,0,1,1,1,0,1,1,
					0,0,0,1,0,0,1,1,
					0,1,1,1,1,1,1,0,
					0,0,0,1,0,0,1,0,
					0,0,1,0,1,0,0,0,
					0,0,1,0,1,0,0,0,
					RGB15(4,31,4)];

      SPRITE_DATA[SpriteType.BLOOD] = [0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,1,
				       1,0,0,0,0,0,0,0,
				       0,0,1,1,0,1,1,0,
				       0,0,0,1,1,0,0,0,
				       0,1,1,0,1,1,0,0,
				       0,0,0,0,0,0,0,1,
				       1,0,0,0,0,0,0,0,
				       0xD03030];

      SPRITE_DATA[SpriteType.SWORD] = [0,0,0,0,0,0,1,1,
				       0,0,0,0,0,1,1,1,
				       0,0,0,0,1,1,1,0,
				       0,1,0,1,1,1,0,0,
				       0,1,1,1,1,0,0,0,
				       0,0,1,1,0,0,0,0,
				       0,1,0,1,1,0,0,0,
				       1,0,0,0,0,0,0,0,
				       RGB15(24,24,24)];

      // Font
      SPRITE_DATA[SpriteType.EXCLAMATION] = [0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.QUOTE] = [0,0,0,1,0,1,0,0,
				       0,0,0,1,0,1,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.HASH] = [0,0,0,1,0,1,0,0,
				      0,0,0,1,0,1,0,0,
				      0,1,1,1,1,1,1,1,
				      0,0,0,1,0,1,0,0,
				      0,1,1,1,1,1,1,1,
				      0,0,0,1,0,1,0,0,
				      0,0,0,1,0,1,0,0,
				      0,0,0,0,0,0,0,0,
				      0xffffff];
      SPRITE_DATA[SpriteType.DOLLAR] = [0,0,0,0,1,0,0,0,
					0,0,0,1,1,1,1,0,
					0,0,1,0,1,0,0,0,
					0,0,0,1,1,1,0,0,
					0,0,0,0,1,0,1,0,
					0,0,1,1,1,1,0,0,
					0,0,0,0,1,0,0,0,
					0,0,0,0,0,0,0,0,
					0xffffff];
      SPRITE_DATA[SpriteType.PERCENT] = [0,0,0,0,0,0,0,0,
					 0,0,1,1,0,0,1,0,
					 0,0,1,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,0,1,1,0,
					 0,0,1,0,0,1,1,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.AMPERSAND] = [0,0,0,1,1,0,0,0,
					   0,0,1,0,1,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,1,0,1,0,0,0,
					   0,1,0,0,0,1,1,0,
					   0,1,0,0,0,1,0,0,
					   0,0,1,1,1,0,1,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.TICK] = [0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0xffffff];
      SPRITE_DATA[SpriteType.LEFT_PAREN] = [0,0,0,0,0,1,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,0,1,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_PAREN] = [0,0,0,1,0,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,1,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.TIMES] = [0,0,0,0,1,0,0,0,
				       0,1,0,0,1,0,0,1,
				       0,0,1,0,1,0,1,0,
				       0,0,0,1,1,1,0,0,
				       0,0,1,0,1,0,1,0,
				       0,1,0,0,1,0,0,1,
				       0,0,0,0,1,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.PLUS] = [0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,1,1,1,1,1,1,1,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0xffffff];
      SPRITE_DATA[SpriteType.COMMA] = [0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,0,1,0,0,
				       0,0,0,0,1,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.MINUS] = [0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,1,1,1,1,1,1,1,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.DOT] = [0,0,0,0,0,0,0,0,
				     0,0,0,0,0,0,0,0,
				     0,0,0,0,0,0,0,0,
				     0,0,0,0,0,0,0,0,
				     0,0,0,0,0,0,0,0,
				     0,0,0,0,1,1,0,0,
				     0,0,0,0,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.SLASH] = [0,0,0,0,0,0,0,1,
				       0,0,0,0,0,0,1,0,
				       0,0,0,0,0,1,0,0,
				       0,0,0,0,1,0,0,0,
				       0,0,0,1,0,0,0,0,
				       0,0,1,0,0,0,0,0,
				       0,1,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.N_0] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,1,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_1] = [0,0,0,0,1,0,0,0,
				     0,0,0,1,1,0,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_2] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,0,0,0,1,0,
				     0,0,0,0,0,1,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,1,0,0,0,0,
				     0,0,1,1,1,1,1,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_3] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,0,0,0,1,0,
				     0,0,0,0,1,1,0,0,
				     0,0,0,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_4] = [0,0,0,0,1,1,0,0,
				     0,0,0,1,0,1,0,0,
				     0,0,1,0,0,1,0,0,
				     0,0,1,1,1,1,1,0,
				     0,0,0,0,0,1,0,0,
				     0,0,0,0,0,1,0,0,
				     0,0,0,0,1,1,1,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_5] = [0,0,1,1,1,1,1,0,
				     0,0,1,0,0,0,0,0,
				     0,0,1,0,0,0,0,0,
				     0,0,1,1,1,1,0,0,
				     0,0,0,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_6] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,0,0,
				     0,0,1,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_7] = [0,0,1,1,1,1,1,0,
				     0,0,0,0,0,0,1,0,
				     0,0,0,0,0,1,0,0,
				     0,0,0,0,1,0,0,0,
				     0,0,0,1,0,0,0,0,
				     0,0,0,1,0,0,0,0,
				     0,0,0,1,0,0,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_8] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.N_9] = [0,0,0,1,1,1,0,0,
				     0,0,1,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,1,0,
				     0,0,0,0,0,0,1,0,
				     0,0,1,0,0,0,1,0,
				     0,0,0,1,1,1,0,0,
				     0,0,0,0,0,0,0,0,
				     0xffffff];
      SPRITE_DATA[SpriteType.COLON] = [0,0,0,0,0,0,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,1,1,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
      SPRITE_DATA[SpriteType.SEMI_COLON] = [0,0,0,0,0,0,0,0,
					    0,0,0,0,1,1,0,0,
					    0,0,0,0,1,1,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,1,1,0,0,
					    0,0,0,0,1,1,0,0,
					    0,0,0,0,0,1,0,0,
					    0,0,0,0,1,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.LESS_THAN] = [0,0,0,0,0,1,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,1,0,0,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,0,0,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.EQUALS] = [0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0,1,1,1,1,1,1,1,
					0,0,0,0,0,0,0,0,
					0,1,1,1,1,1,1,1,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0xffffff];
      SPRITE_DATA[SpriteType.LARGER_THAN] = [0,0,1,0,0,0,0,0,
					     0,0,0,1,0,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,1,0,0,0,0,
					     0,0,1,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.QUESTION] = [0,0,0,1,1,1,0,0,
					  0,0,1,0,0,0,1,0,
					  0,0,0,0,0,0,1,0,
					  0,0,0,0,0,1,0,0,
					  0,0,0,0,1,0,0,0,
					  0,0,0,0,0,0,0,0,
					  0,0,0,0,1,0,0,0,
					  0,0,0,0,0,0,0,0,
					  0xffffff];
      SPRITE_DATA[SpriteType.AT] = [0,0,0,1,1,1,0,0,
				    0,0,1,0,0,0,1,0,
				    0,0,1,0,1,1,1,0,
				    0,0,1,0,1,0,1,0,
				    0,0,1,0,1,1,1,0,
				    0,0,1,0,0,0,0,0,
				    0,0,0,1,1,1,0,0,
				    0,0,0,0,0,0,0,0,
				    0xffffff];
      SPRITE_DATA[SpriteType.A] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.B] = [0,0,1,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.C] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.D] = [0,0,1,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.E] = [0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,1,1,1,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,1,1,1,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.F] = [0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.G] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,1,1,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.H] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.I] = [0,0,0,1,1,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.J] = [0,0,0,0,1,1,1,0,
				   0,0,0,0,0,1,0,0,
				   0,0,0,0,0,1,0,0,
				   0,0,0,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,0,1,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.K] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,1,1,0,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.L] = [0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,1,1,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.M] = [0,1,0,0,0,0,0,1,
				   0,1,1,0,0,0,1,1,
				   0,1,0,1,0,1,0,1,
				   0,1,0,0,1,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.N] = [0,0,1,0,0,0,1,0,
				   0,0,1,1,0,0,1,0,
				   0,0,1,0,1,0,1,0,
				   0,0,1,0,1,0,1,0,
				   0,0,1,0,0,1,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.O] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.P] = [0,0,0,1,1,1,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.Q] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,1,1,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.R] = [0,0,1,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,0,0,
				   0,0,1,0,1,0,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.S] = [0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.T] = [0,0,1,1,1,1,1,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.U] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.V] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.W] = [0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,0,1,0,1,0,1,0,
				   0,0,1,0,1,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.X] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,0,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.Y] = [0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.Z] = [0,0,1,1,1,1,1,0,
				   0,0,0,0,0,0,1,0,
				   0,0,0,0,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,1,1,1,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.LEFT_BRACKET] = [0,0,0,1,1,1,0,0,
					      0,0,0,1,0,0,0,0,
					      0,0,0,1,0,0,0,0,
					      0,0,0,1,0,0,0,0,
					      0,0,0,1,0,0,0,0,
					      0,0,0,1,0,0,0,0,
					      0,0,0,1,1,1,0,0,
					      0,0,0,0,0,0,0,0,
					      0xffffff];
      SPRITE_DATA[SpriteType.BACK_SLASH] = [0,1,0,0,0,0,0,0,
					    0,0,1,0,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,0,1,0,0,
					    0,0,0,0,0,0,1,0,
					    0,0,0,0,0,0,0,1,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_BRACKET] = [0,0,0,1,1,1,0,0,
					       0,0,0,0,0,1,0,0,
					       0,0,0,0,0,1,0,0,
					       0,0,0,0,0,1,0,0,
					       0,0,0,0,0,1,0,0,
					       0,0,0,0,0,1,0,0,
					       0,0,0,1,1,1,0,0,
					       0,0,0,0,0,0,0,0,
					       0xffffff];
      SPRITE_DATA[SpriteType.RAISED] = [0,0,0,0,1,0,0,0,
					0,0,0,1,0,1,0,0,
					0,0,1,0,0,0,1,0,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,
					0xffffff];
      SPRITE_DATA[SpriteType.UNDERSCORE] = [0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,1,1,1,1,1,1,1,
					    0xffffff];
      SPRITE_DATA[SpriteType.BACK_TICK] = [0,0,0,1,0,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.a] = [0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,1,0,
				   0,0,0,1,1,1,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,1,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.b] = [0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,1,0,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.c] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.d] = [0,0,0,0,0,0,1,0,
				   0,0,0,0,0,0,1,0,
				   0,0,0,0,1,1,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,0,1,1,0,1,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.e] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,1,1,1,1,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.f] = [0,0,0,0,1,1,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,0,0,
				   0,0,1,1,1,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.g] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,1,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,1,0,
				   0,0,0,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.h] = [0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,1,1,0,0,
				   0,0,1,1,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.i] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.j] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,1,1,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.k] = [0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,1,0,0,0,
				   0,0,1,1,0,0,0,0,
				   0,0,1,0,1,0,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.l] = [0,0,0,1,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.m] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   1,0,1,1,0,1,1,0,
				   0,1,0,0,1,0,0,1,
				   0,1,0,0,1,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.n] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,1,1,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.o] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.p] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,1,1,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.q] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,0,1,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,0,1,0,0,
				   0,0,0,0,0,1,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.r] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,1,1,0,0,
				   0,0,1,1,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.s] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,1,0,0,0,0,0,
				   0,0,0,1,1,0,0,0,
				   0,0,0,0,0,1,0,0,
				   0,0,1,1,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.t] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,1,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.u] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,1,0,0,1,0,0,
				   0,0,0,1,1,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.v] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.w] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,0,0,0,1,
				   0,1,0,0,1,0,0,1,
				   0,1,0,1,0,1,0,1,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.x] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,1,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,0,1,0,0,
				   0,0,1,0,0,0,1,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.y] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,1,0,0,1,0,
				   0,0,0,0,1,1,1,0,
				   0,0,0,0,0,0,1,0,
				   0,0,0,1,1,1,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.z] = [0,0,0,0,0,0,0,0,
				   0,0,0,0,0,0,0,0,
				   0,0,1,1,1,1,0,0,
				   0,0,0,0,0,1,0,0,
				   0,0,0,0,1,0,0,0,
				   0,0,0,1,0,0,0,0,
				   0,0,1,1,1,1,0,0,
				   0,0,0,0,0,0,0,0,
				   0xffffff];
      SPRITE_DATA[SpriteType.LEFT_CURLY] = [0,0,0,0,1,1,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,1,0,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,1,0,0,0,0,
					    0,0,0,0,1,1,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.PIPE] = [0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,1,0,0,0,
				      0,0,0,0,0,0,0,0,
				      0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_CURLY] = [0,0,1,1,0,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,1,1,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.TILDE] = [0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,1,1,0,0,0,0,
				       0,1,0,0,1,0,0,1,
				       0,0,0,0,0,1,1,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0,0,0,0,0,0,0,0,
				       0xffffff];
    }

    private function RGB15(r:int, g:int, b:int):int
    {
      return (r << 19) + (g << 11) + (b << 3);
    }
  }
}
