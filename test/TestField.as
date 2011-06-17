package
{
  import org.flexunit.Assert;

  public class TestField
  {
    private var field:Field;

    [Before]
    public function setUp():void
    {
      field = new Field(32, 24);
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
      Assert.assertEquals(Tile.BLOCK, tile.getType());
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
      var sprite:PixelDrawable = new FakePixelDrawable(256, 384);

      field.setTile(0, 0, Tile.BLOCK);
      field.draw(sprite);

      // Check that position 0,0 is filled
      for(var y:int = 0;y < 8;y++)
	for(var x:int = 0;x < 8;x++)
	  {
	    Assert.assertEquals(Tile.BLOCK_COLOR, sprite.getPixel(x, y));
	  }
    }

    [Test]
    public function testSetTile():void
    {
      field.clearField(Tile.EMPTY);
      field.setTile(3, 4, Tile.BLOCK);
      Assert.assertEquals(Tile.BLOCK, field.getTile(3, 4).getType());
    }

    [Test]
    public function testSetBorderTileToEmpty():void
    {
      var points:Array = [[5, 0], [0, 3],
			  [5, 23], [31, 7]];

      for(var i:int = 0;i < points.length;i++)
	{
	  field.setTile(points[i][0], points[i][1], Tile.EMPTY);
	  Assert.assertEquals(Tile.BLOCK,
			      field.getTile(points[i][0],
					    points[i][1]).getType());
	}
    }

    [Test]
    public function testSettingTileOutsideOfFileShouldNotGenerateException():void
    {
      field.setTile(-5, -3, Tile.EMPTY);
    }

    [Test]
    public function testSetWaterTile():void
    {
      field.setTile(1, 1, Tile.WATER);
      Assert.assertEquals(Tile.WATER, field.getTile(1, 1).getType());
    }

    [Test]
    public function testSettingWaterTileOnLevelEdgeShouldBeAllowed():void
    {
      field.setTile(0, 5, Tile.WATER);
      Assert.assertEquals(Tile.WATER, field.getTile(0, 5).getType());
    }

    //  test water on level edge
  }
}
