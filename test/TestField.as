package
{
    import org.flexunit.Assert;

    public class TestField
    {
	private var field:Field;

	[Before]
	public function setUp():void
	{
	    field = new Field();
	}

	[Test]
	public function newFieldShouldBeEmpty():void
	{
	    for(var y:int;y < 24;y++)
		{
		    for(var x:int;x < 32;x++)
			{
			    Assert.assertEquals(Field.EMPTY,
						field.getTile(x, y));
			}
		}
	}

	[Test]
	public function testGenerate():void
	{
	    field.generate();
	}

	[Test]
	public function getPosition00():void
	{
	    field.generate();
	    var tile:int = field.getTile(0, 0);
	    Assert.assertEquals(tile, Field.BLOCK);
	}

	[Test]
	public function getPosition11():void
	{
	    field.generate();
	    var tile:int = field.getTile(1, 1);
	    Assert.assertEquals(tile, Field.EMPTY);
	}

	[Test]
	public function testDraw():void
	{
	    var sprite:Drawable = new TestDrawable(256, 384);

	    field.generate();
	    field.draw(sprite);

	    // Check that position 0,0 is filled
	    for(var y:int = 0;y < 8;y++)
		for(var x:int = 0;x < 8;x++)
		    {
			Assert.assertEquals(Field.BLOCK_COLOR,
					    sprite.getPixel(x + Field.X_OFFSET,
							    y + Field.Y_OFFSET));
		    }
	}

	[Test]
	public function testSetTile():void
	{
	    field.generate();
	    field.setTile(3, 4, Field.BLOCK);
	    Assert.assertEquals(Field.BLOCK, field.getTile(3, 4));
	}
    }
}

class TestDrawable implements Drawable
{
    private var canvas:Array;

    public function TestDrawable(width:int, height:int):void
    {
	canvas = new Array(width);
	for(var i:int = 0;i < width;i++)
	    {
		canvas[i] = new Array(height);
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
