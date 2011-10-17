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
    private var levelType:LevelType;

    public function FlixelPixelGraphicsFactory(screen:PixelScreen):void
    {
      this.screen = screen;
      setLevelType(LevelType.CAVE);

      initSpriteData();
    }

    public function setLevelType(levelType:LevelType):void
    {
      this.levelType = levelType;
    }

    public function getDrawable():Drawable
    {
      return new FlixelPixelDrawable(screen);
    }

    public function getSprite(spriteType:SpriteType):Sprite
    {
      if (!sprites[spriteType])
	{
	  var sprite:Sprite = new PixelSprite(8, 8);
	  sprite.setData(SPRITE_DATA[spriteType.Index]);
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

      switch(type)
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

      if(type == TileType.BLOCK)
	{
	  drawJaggedEdges(data, surrounding, numberGenerator);
	}

      tile.setData(data);

      return tile;
    }

    private function drawJaggedEdges(data:Array, surrounding:Surrounding,
				     numberGenerator:NumberGenerator):void
    {
      var w:int = [2, 0, 0, 0][levelType.Index];

      if(surrounding.east == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 7, 8);
      if(surrounding.north == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 0, 1);
      if(surrounding.west == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
	drawTileLine(data, 0, 8);
      if(surrounding.south == TileType.EMPTY && numberGenerator.getIntInRange(0, w))
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
      SPRITE_DATA[SpriteType.EMPTY.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0];
      SPRITE_DATA[SpriteType.PLAYER.Index] = [0,0,0,1,1,1,0,0,
					      0,0,0,1,1,1,0,1,
					      1,1,1,0,1,0,0,1,
					      1,1,1,1,1,1,1,1,
					      1,1,1,0,1,0,0,1,
					      0,1,0,0,1,0,0,0,
					      0,0,0,1,0,1,0,0,
					      0,0,1,1,0,1,1,0,
					      0xcccccc];
      SPRITE_DATA[SpriteType.GOAL.Index] = [0,0,0,0,1,1,1,1,
					    0,0,0,0,1,1,1,1,
					    0,0,1,1,1,0,0,1,
					    0,0,1,1,1,0,0,1,
					    1,1,1,0,0,0,0,1,
					    1,1,1,0,0,0,0,1,
					    1,0,0,0,0,0,0,1,
					    1,1,1,1,1,1,1,1,
					    0xcccccc];
      SPRITE_DATA[SpriteType.BAT.Index] = [0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   1,0,0,0,0,0,0,1,
					   0,1,1,0,0,1,1,0,
					   0,0,1,1,1,1,0,0,
					   0,0,0,1,1,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0x10ff10];
      SPRITE_DATA[SpriteType.FLEA.Index] = [0,0,0,0,0,0,0,0,
					    0,0,1,1,0,0,0,0,
					    0,1,1,1,1,1,0,0,
					    0,0,0,1,1,1,1,0,
					    0,0,0,1,1,1,1,0,
					    0,0,0,1,0,0,1,0,
					    0,0,1,0,0,1,0,0,
					    0,0,0,1,0,0,1,0,
					    RGB15(4,31,4)];
      SPRITE_DATA[SpriteType.SNAKE.Index] = [0,1,1,1,1,1,0,0,
					     1,0,1,0,0,0,1,0,
					     1,1,0,0,0,0,1,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,1,1,0,0,0,
					     0,0,1,0,0,0,0,1,
					     0,0,1,0,0,0,1,0,
					     0,0,0,1,1,1,0,0,
					     RGB15(4,31,4)];
      SPRITE_DATA[SpriteType.GOBLIN.Index] = [0,0,0,0,0,0,0,0,
					      0,0,1,1,1,0,0,0,
					      0,0,1,1,1,0,1,1,
					      0,0,0,1,0,0,1,1,
					      0,1,1,1,1,1,1,0,
					      0,0,0,1,0,0,1,0,
					      0,0,1,0,1,0,0,0,
					      0,0,1,0,1,0,0,0,
					      RGB15(4,31,4)];
      SPRITE_DATA[SpriteType.MINGBAT.Index] = [0,0,0,0,0,0,0,0,
					       0,0,0,0,0,0,0,0,
					       1,1,0,0,0,0,1,1,
					       0,1,1,0,0,1,1,0,
					       1,0,1,1,1,1,0,1,
					       0,0,0,1,1,0,0,0,
					       0,0,1,0,0,1,0,0,
					       0,0,0,0,0,0,0,0,
					       RGB15(4,31,4)];


      SPRITE_DATA[SpriteType.BLOOD.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,1,
					     1,0,0,0,0,0,0,0,
					     0,0,1,1,0,1,1,0,
					     0,0,0,1,1,0,0,0,
					     0,1,1,0,1,1,0,0,
					     0,0,0,0,0,0,0,1,
					     1,0,0,0,0,0,0,0,
					     0xD03030];

      SPRITE_DATA[SpriteType.STICK.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,1,1,0,0,0,
					     0,0,0,1,1,0,0,0,
					     0,0,1,1,0,0,0,0,
					     0,0,1,0,0,0,0,0,
					     RGB15(22,17,0)];

      SPRITE_DATA[SpriteType.TORCH.Index] = [0,0,0,0,1,0,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,1,1,0,0,0,
					     0,0,0,1,1,0,0,0,
					     0,0,1,1,0,0,0,0,
					     0,0,1,0,0,0,0,0,
					     RGB15(30,26,8)];

      SPRITE_DATA[SpriteType.SWORD.Index] = [0,0,0,0,0,0,1,1,
					     0,0,0,0,0,1,1,1,
					     0,0,0,0,1,1,1,0,
					     0,1,0,1,1,1,0,0,
					     0,1,1,1,1,0,0,0,
					     0,0,1,1,0,0,0,0,
					     0,1,0,1,1,0,0,0,
					     1,0,0,0,0,0,0,0,
					     RGB15(24,24,24)];

      // Font
      SPRITE_DATA[SpriteType.EXCLAMATION.Index] = [0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,0,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,0,0,0,0,
						   0xffffff];
      SPRITE_DATA[SpriteType.QUOTE.Index] = [0,0,0,1,0,1,0,0,
					     0,0,0,1,0,1,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.HASH.Index] = [0,0,0,1,0,1,0,0,
					    0,0,0,1,0,1,0,0,
					    0,1,1,1,1,1,1,1,
					    0,0,0,1,0,1,0,0,
					    0,1,1,1,1,1,1,1,
					    0,0,0,1,0,1,0,0,
					    0,0,0,1,0,1,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.DOLLAR.Index] = [0,0,0,0,1,0,0,0,
					      0,0,0,1,1,1,1,0,
					      0,0,1,0,1,0,0,0,
					      0,0,0,1,1,1,0,0,
					      0,0,0,0,1,0,1,0,
					      0,0,1,1,1,1,0,0,
					      0,0,0,0,1,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0xffffff];
      SPRITE_DATA[SpriteType.PERCENT.Index] = [0,0,0,0,0,0,0,0,
					       0,0,1,1,0,0,1,0,
					       0,0,1,1,0,1,0,0,
					       0,0,0,0,1,0,0,0,
					       0,0,0,1,0,1,1,0,
					       0,0,1,0,0,1,1,0,
					       0,0,0,0,0,0,0,0,
					       0,0,0,0,0,0,0,0,
					       0xffffff];
      SPRITE_DATA[SpriteType.AMPERSAND.Index] = [0,0,0,1,1,0,0,0,
						 0,0,1,0,1,0,0,0,
						 0,0,0,1,0,0,0,0,
						 0,0,1,0,1,0,0,0,
						 0,1,0,0,0,1,1,0,
						 0,1,0,0,0,1,0,0,
						 0,0,1,1,1,0,1,0,
						 0,0,0,0,0,0,0,0,
						 0xffffff];
      SPRITE_DATA[SpriteType.TICK.Index] = [0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.LEFT_PAREN.Index] = [0,0,0,0,0,1,0,0,
						  0,0,0,0,1,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,0,1,0,0,0,
						  0,0,0,0,0,1,0,0,
						  0,0,0,0,0,0,0,0,
						  0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_PAREN.Index] = [0,0,0,1,0,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,0,1,0,0,
						   0,0,0,0,0,1,0,0,
						   0,0,0,0,0,1,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,1,0,0,0,0,
						   0,0,0,0,0,0,0,0,
						   0xffffff];
      SPRITE_DATA[SpriteType.TIMES.Index] = [0,0,0,0,1,0,0,0,
					     0,1,0,0,1,0,0,1,
					     0,0,1,0,1,0,1,0,
					     0,0,0,1,1,1,0,0,
					     0,0,1,0,1,0,1,0,
					     0,1,0,0,1,0,0,1,
					     0,0,0,0,1,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.PLUS.Index] = [0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,1,1,1,1,1,1,1,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.COMMA.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.MINUS.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,1,1,1,1,1,1,1,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.DOT.Index] = [0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0,0,0,0,1,1,0,0,
					   0,0,0,0,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.SLASH.Index] = [0,0,0,0,0,0,0,1,
					     0,0,0,0,0,0,1,0,
					     0,0,0,0,0,1,0,0,
					     0,0,0,0,1,0,0,0,
					     0,0,0,1,0,0,0,0,
					     0,0,1,0,0,0,0,0,
					     0,1,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.N_0.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,1,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_1.Index] = [0,0,0,0,1,0,0,0,
					   0,0,0,1,1,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_2.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,0,0,0,1,0,
					   0,0,0,0,0,1,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,1,1,1,1,1,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_3.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,0,0,0,1,0,
					   0,0,0,0,1,1,0,0,
					   0,0,0,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_4.Index] = [0,0,0,0,1,1,0,0,
					   0,0,0,1,0,1,0,0,
					   0,0,1,0,0,1,0,0,
					   0,0,1,1,1,1,1,0,
					   0,0,0,0,0,1,0,0,
					   0,0,0,0,0,1,0,0,
					   0,0,0,0,1,1,1,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_5.Index] = [0,0,1,1,1,1,1,0,
					   0,0,1,0,0,0,0,0,
					   0,0,1,0,0,0,0,0,
					   0,0,1,1,1,1,0,0,
					   0,0,0,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_6.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,0,0,
					   0,0,1,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_7.Index] = [0,0,1,1,1,1,1,0,
					   0,0,0,0,0,0,1,0,
					   0,0,0,0,0,1,0,0,
					   0,0,0,0,1,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,0,1,0,0,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_8.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.N_9.Index] = [0,0,0,1,1,1,0,0,
					   0,0,1,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,1,0,
					   0,0,0,0,0,0,1,0,
					   0,0,1,0,0,0,1,0,
					   0,0,0,1,1,1,0,0,
					   0,0,0,0,0,0,0,0,
					   0xffffff];
      SPRITE_DATA[SpriteType.COLON.Index] = [0,0,0,0,0,0,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,1,1,0,0,
					     0,0,0,0,0,0,0,0,
					     0,0,0,0,0,0,0,0,
					     0xffffff];
      SPRITE_DATA[SpriteType.SEMI_COLON.Index] = [0,0,0,0,0,0,0,0,
						  0,0,0,0,1,1,0,0,
						  0,0,0,0,1,1,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,1,1,0,0,
						  0,0,0,0,1,1,0,0,
						  0,0,0,0,0,1,0,0,
						  0,0,0,0,1,0,0,0,
						  0xffffff];
      SPRITE_DATA[SpriteType.LESS_THAN.Index] = [0,0,0,0,0,1,0,0,
						 0,0,0,0,1,0,0,0,
						 0,0,0,1,0,0,0,0,
						 0,0,1,0,0,0,0,0,
						 0,0,0,1,0,0,0,0,
						 0,0,0,0,1,0,0,0,
						 0,0,0,0,0,1,0,0,
						 0,0,0,0,0,0,0,0,
						 0xffffff];
      SPRITE_DATA[SpriteType.EQUALS.Index] = [0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0,1,1,1,1,1,1,1,
					      0,0,0,0,0,0,0,0,
					      0,1,1,1,1,1,1,1,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0xffffff];
      SPRITE_DATA[SpriteType.LARGER_THAN.Index] = [0,0,1,0,0,0,0,0,
						   0,0,0,1,0,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,0,1,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,1,0,0,0,0,
						   0,0,1,0,0,0,0,0,
						   0,0,0,0,0,0,0,0,
						   0xffffff];
      SPRITE_DATA[SpriteType.QUESTION.Index] = [0,0,0,1,1,1,0,0,
						0,0,1,0,0,0,1,0,
						0,0,0,0,0,0,1,0,
						0,0,0,0,0,1,0,0,
						0,0,0,0,1,0,0,0,
						0,0,0,0,0,0,0,0,
						0,0,0,0,1,0,0,0,
						0,0,0,0,0,0,0,0,
						0xffffff];
      SPRITE_DATA[SpriteType.AT.Index] = [0,0,0,1,1,1,0,0,
					  0,0,1,0,0,0,1,0,
					  0,0,1,0,1,1,1,0,
					  0,0,1,0,1,0,1,0,
					  0,0,1,0,1,1,1,0,
					  0,0,1,0,0,0,0,0,
					  0,0,0,1,1,1,0,0,
					  0,0,0,0,0,0,0,0,
					  0xffffff];
      SPRITE_DATA[SpriteType.A.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.B.Index] = [0,0,1,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.C.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.D.Index] = [0,0,1,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.E.Index] = [0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,1,1,1,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,1,1,1,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.F.Index] = [0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.G.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,1,1,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.H.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.I.Index] = [0,0,0,1,1,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.J.Index] = [0,0,0,0,1,1,1,0,
					 0,0,0,0,0,1,0,0,
					 0,0,0,0,0,1,0,0,
					 0,0,0,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,0,1,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.K.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,1,1,0,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.L.Index] = [0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,1,1,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.M.Index] = [0,1,0,0,0,0,0,1,
					 0,1,1,0,0,0,1,1,
					 0,1,0,1,0,1,0,1,
					 0,1,0,0,1,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.N.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,1,0,0,1,0,
					 0,0,1,0,1,0,1,0,
					 0,0,1,0,1,0,1,0,
					 0,0,1,0,0,1,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.O.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.P.Index] = [0,0,0,1,1,1,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.Q.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,1,1,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.R.Index] = [0,0,1,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,0,0,
					 0,0,1,0,1,0,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.S.Index] = [0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.T.Index] = [0,0,1,1,1,1,1,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.U.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.V.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.W.Index] = [0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,0,1,0,1,0,1,0,
					 0,0,1,0,1,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.X.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,0,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.Y.Index] = [0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.Z.Index] = [0,0,1,1,1,1,1,0,
					 0,0,0,0,0,0,1,0,
					 0,0,0,0,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,1,1,1,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.LEFT_BRACKET.Index] = [0,0,0,1,1,1,0,0,
						    0,0,0,1,0,0,0,0,
						    0,0,0,1,0,0,0,0,
						    0,0,0,1,0,0,0,0,
						    0,0,0,1,0,0,0,0,
						    0,0,0,1,0,0,0,0,
						    0,0,0,1,1,1,0,0,
						    0,0,0,0,0,0,0,0,
						    0xffffff];
      SPRITE_DATA[SpriteType.BACK_SLASH.Index] = [0,1,0,0,0,0,0,0,
						  0,0,1,0,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,0,1,0,0,0,
						  0,0,0,0,0,1,0,0,
						  0,0,0,0,0,0,1,0,
						  0,0,0,0,0,0,0,1,
						  0,0,0,0,0,0,0,0,
						  0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_BRACKET.Index] = [0,0,0,1,1,1,0,0,
						     0,0,0,0,0,1,0,0,
						     0,0,0,0,0,1,0,0,
						     0,0,0,0,0,1,0,0,
						     0,0,0,0,0,1,0,0,
						     0,0,0,0,0,1,0,0,
						     0,0,0,1,1,1,0,0,
						     0,0,0,0,0,0,0,0,
						     0xffffff];
      SPRITE_DATA[SpriteType.RAISED.Index] = [0,0,0,0,1,0,0,0,
					      0,0,0,1,0,1,0,0,
					      0,0,1,0,0,0,1,0,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0,0,0,0,0,0,0,0,
					      0xffffff];
      SPRITE_DATA[SpriteType.UNDERSCORE.Index] = [0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,0,0,0,0,0,0,0,
						  0,1,1,1,1,1,1,1,
						  0xffffff];
      SPRITE_DATA[SpriteType.BACK_TICK.Index] = [0,0,0,1,0,0,0,0,
						 0,0,0,0,1,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0,0,0,0,0,0,0,0,
						 0xffffff];
      SPRITE_DATA[SpriteType.a.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,1,0,
					 0,0,0,1,1,1,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,1,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.b.Index] = [0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,1,0,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.c.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.d.Index] = [0,0,0,0,0,0,1,0,
					 0,0,0,0,0,0,1,0,
					 0,0,0,0,1,1,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,0,1,1,0,1,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.e.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,1,1,1,1,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.f.Index] = [0,0,0,0,1,1,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,0,0,
					 0,0,1,1,1,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.g.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,1,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,1,0,
					 0,0,0,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.h.Index] = [0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,1,1,0,0,
					 0,0,1,1,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.i.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.j.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,1,1,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.k.Index] = [0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,1,0,0,0,
					 0,0,1,1,0,0,0,0,
					 0,0,1,0,1,0,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.l.Index] = [0,0,0,1,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.m.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 1,0,1,1,0,1,1,0,
					 0,1,0,0,1,0,0,1,
					 0,1,0,0,1,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.n.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,1,1,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.o.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.p.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,1,1,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.q.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,0,1,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,0,1,0,0,
					 0,0,0,0,0,1,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.r.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,1,1,0,0,
					 0,0,1,1,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.s.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,1,0,0,0,0,0,
					 0,0,0,1,1,0,0,0,
					 0,0,0,0,0,1,0,0,
					 0,0,1,1,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.t.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,1,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.u.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,1,0,0,1,0,0,
					 0,0,0,1,1,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.v.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.w.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,0,0,0,1,
					 0,1,0,0,1,0,0,1,
					 0,1,0,1,0,1,0,1,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.x.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,1,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,0,1,0,0,
					 0,0,1,0,0,0,1,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.y.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,1,0,0,1,0,
					 0,0,0,0,1,1,1,0,
					 0,0,0,0,0,0,1,0,
					 0,0,0,1,1,1,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.z.Index] = [0,0,0,0,0,0,0,0,
					 0,0,0,0,0,0,0,0,
					 0,0,1,1,1,1,0,0,
					 0,0,0,0,0,1,0,0,
					 0,0,0,0,1,0,0,0,
					 0,0,0,1,0,0,0,0,
					 0,0,1,1,1,1,0,0,
					 0,0,0,0,0,0,0,0,
					 0xffffff];
      SPRITE_DATA[SpriteType.LEFT_CURLY.Index] = [0,0,0,0,1,1,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,1,0,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,1,0,0,0,0,
						  0,0,0,0,1,1,0,0,
						  0,0,0,0,0,0,0,0,
						  0xffffff];
      SPRITE_DATA[SpriteType.PIPE.Index] = [0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,1,0,0,0,
					    0,0,0,0,0,0,0,0,
					    0xffffff];
      SPRITE_DATA[SpriteType.RIGHT_CURLY.Index] = [0,0,1,1,0,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,0,1,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,0,0,1,0,0,0,
						   0,0,1,1,0,0,0,0,
						   0,0,0,0,0,0,0,0,
						   0xffffff];
      SPRITE_DATA[SpriteType.TILDE.Index] = [0,0,0,0,0,0,0,0,
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
