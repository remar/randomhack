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

	public static const EMPTY:int = 0;
	public static const BLOCK:int = 1;

	public static const EMPTY_COLOR:int = 0x000000;
	public static const BLOCK_COLOR:int = 0xff0000;

	private var field:Array;

	public function Field():void
	{
	    clearField(EMPTY);
	}

	public function clearField(type:int):void
	{
	    field = new Array(WIDTH);
	    for(var x:int = 0;x < WIDTH;x++)
		{
		    field[x] = new Array(HEIGHT);
		    for(var y:int = 0;y < HEIGHT;y++)
			{
			    field[x][y] = type;
			}
		}
	}

	public function generate():void
	{
	    // Generate field
	    // First naive implementation, just fill in the border
	    for(var x:int = 0;x < WIDTH;x++)
		{
		    field[x][0] = field[x][HEIGHT-1] = BLOCK;
		}
	    for(var y:int = 0;y < WIDTH;y++)
		{
		    field[0][y] = field[WIDTH-1][y] = BLOCK;
		}
	}

	public function setTile(x:int, y:int, type:int):void
	{
	    field[x][y] = type;
	}

	public function getTile(x:int, y:int):int
	{
	    return field[x][y];
	}

	public function draw(drawable:Drawable):void
	{
	    for(var y:int = 0;y < HEIGHT;y++)
		{
		    for(var x:int = 0;x < WIDTH;x++)
			{
			    // Draw block or empty space
			    var colors:Array = [EMPTY_COLOR, BLOCK_COLOR];
			    drawBlock(drawable, x, y, colors[field[x][y]]);
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
