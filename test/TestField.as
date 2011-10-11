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
	      Assert.assertEquals(TileType.BLOCK,
				  field.getTile(new Point(x, y)));
	    }
	}
    }

    [Test]
    public function getPosition00():void
    {
      field.setTile(new Point(0, 0), TileType.BLOCK);
      var tile:TileType = field.getTile(new Point(0, 0));
      Assert.assertEquals(TileType.BLOCK, tile);
    }

    [Test]
    public function getPosition11():void
    {
      field.setTile(new Point(1, 1), TileType.EMPTY);
      var tile:TileType = field.getTile(new Point(1, 1));
      Assert.assertEquals(TileType.EMPTY, tile);
    }

    [Test]
    public function testDraw():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      var gf:GraphicsFactory = new FlixelPixelGraphicsFactory(fakeScreen);
      var ng:DeterministicNumberGenerator = new DeterministicNumberGenerator();

      ng.addInt(0);

      field.setTile(new Point(0, 0), TileType.BLOCK);
      field.renderBackgroundTiles(gf, ng);
      field.draw(gf.getDrawable());

      // Check that position 0,0 is filled
      for(var y:int = 0;y < 8;y++)
	for(var x:int = 0;x < 8;x++)
	  {
	    Assert.assertEquals(0xff5050, fakeScreen.getPixel(x, y));
	  }
    }

    [Test]
    public function testSetTile():void
    {
      field.clearField(TileType.EMPTY);
      field.setTile(new Point(3, 4), TileType.BLOCK);
      Assert.assertEquals(TileType.BLOCK, field.getTile(new Point(3, 4)));
    }

    [Test]
    public function testSetBorderTileToEmpty():void
    {
      var points:Array = [new Point(5, 0), new Point(0, 3),
			  new Point(5, 23), new Point(31, 7)];

      for(var i:int = 0;i < points.length;i++)
	{
	  field.setTile(points[i], TileType.EMPTY);
	  Assert.assertEquals(TileType.BLOCK,
			      field.getTile(points[i]));
	}
    }

    [Test]
    public function testSettingTileOutsideOfFileShouldNotGenerateException():void
    {
      field.setTile(new Point(-5, -3), TileType.EMPTY);
    }

    [Test]
    public function testSetWaterTile():void
    {
      field.setTile(new Point(1, 1), TileType.WATER);
      Assert.assertEquals(TileType.WATER, field.getTile(new Point(1, 1)));
    }


    [Test]
    public function testSettingWaterTileOnLevelEdgeShouldBeAllowed():void
    {
      field.setTile(new Point(0, 5), TileType.WATER);
      Assert.assertEquals(TileType.WATER, field.getTile(new Point(0, 5)));
    }

    [Test]
    public function shouldGiveCorrectDeltaWhenPointIsToTheLeft():void
      {
	  var direction:Point = field.getDirection(new Point(6, 8), new Point(3, 8));
	  Assert.assertTrue(direction.equals(new Point(-1, 0)));
      }
  }
}
