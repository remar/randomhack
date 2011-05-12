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

    [After]
    public function tearDown():void
    {
      field = null;
    }

    [Test]
    public function newFieldShouldBeJustBlocks():void
    {
      for(var y:int;y < 24;y++)
	{
	  for(var x:int;x < 32;x++)
	    {
	      Assert.assertEquals(Tile.BLOCK,
				  field.getTile(x, y).getType());
	    }
	}
    }

    [Test]
    public function getPosition00():void
    {
      field.setTile(0, 0, Tile.BLOCK);
      var tile:Tile = field.getTile(0, 0);
      Assert.assertEquals(tile.getType(), Tile.BLOCK);
    }

    [Test]
    public function getPosition11():void
    {
      field.setTile(1, 1, Tile.EMPTY);
      var tile:Tile = field.getTile(1, 1);
      Assert.assertEquals(Tile.EMPTY, tile.getType());
    }

    [Test]
    public function testDraw():void
    {
      var sprite:Drawable = new FakeDrawable(256, 384);

      field.setTile(0, 0, Tile.BLOCK);
      field.draw(sprite);

      // Check that position 0,0 is filled
      for(var y:int = 0;y < 8;y++)
	for(var x:int = 0;x < 8;x++)
	  {
	    Assert.assertEquals(Tile.BLOCK_COLOR,
				sprite.getPixel(x + Field.X_OFFSET,
						y + Field.Y_OFFSET));
	  }
    }

    [Test]
    public function testSetTile():void
    {
      field.generate();
      field.setTile(3, 4, Tile.BLOCK);
      Assert.assertEquals(Tile.BLOCK, field.getTile(3, 4).getType());
    }

    [Test]
    public function testCarveHole():void
    {
      field.carveHole(3, 3, 1);

      for(var y:int = 2;y <= 4;y++)
	for(var x:int = 2;x <= 4;x++)
	  Assert.assertEquals(Tile.EMPTY, field.getTile(x, y).getType());
    }

    [Test]
    public function testCarveVeryShortPath():void
    {
      field.carvePath([1, 1], [1, 1], 1);
      Assert.assertEquals(Tile.EMPTY, field.getTile(1, 1).getType());
    }

    [Test]
    public function testCarveHorizontalPath():void
    {
      field.carvePath([1, 1], [8, 1], 1);

      for(var i:int = 1;i <= 8;i++)
	Assert.assertEquals(Tile.EMPTY, field.getTile(i, 1).getType());
    }

    [Test]
    public function testCarveVerticalPath():void
    {
      field.carvePath([1, 1], [1, 9], 1);

      for(var i:int = 1;i <= 9;i++)
	Assert.assertEquals(Tile.EMPTY, field.getTile(1, i).getType());
    }
  }
}

class FakeDrawable implements Drawable
{
  private var canvas:Array;

  public function FakeDrawable(width:int, height:int):void
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
