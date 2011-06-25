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
				  field.getTile(x, y).getType());
	    }
	}
    }

    [Test]
    public function getPosition00():void
    {
      field.setTile(0, 0, TileType.BLOCK);
      var tile:TileType = field.getTile(0, 0);
      Assert.assertEquals(TileType.BLOCK, tile.getType());
    }

    [Test]
    public function getPosition11():void
    {
      field.setTile(1, 1, TileType.EMPTY);
      var tile:TileType = field.getTile(1, 1);
      Assert.assertEquals(TileType.EMPTY, tile.getType());
    }

    [Test]
    public function testDraw():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      var gf:GraphicsFactory = new FlixelPixelGraphicsFactory(fakeScreen);

      field.setTile(0, 0, TileType.BLOCK);
      field.renderBackgroundTiles(gf);
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
      field.setTile(3, 4, TileType.BLOCK);
      Assert.assertEquals(TileType.BLOCK, field.getTile(3, 4).getType());
    }

    [Test]
    public function testSetBorderTileToEmpty():void
    {
      var points:Array = [[5, 0], [0, 3],
			  [5, 23], [31, 7]];

      for(var i:int = 0;i < points.length;i++)
	{
	  field.setTile(points[i][0], points[i][1], TileType.EMPTY);
	  Assert.assertEquals(TileType.BLOCK,
			      field.getTile(points[i][0],
					    points[i][1]).getType());
	}
    }

    [Test]
    public function testSettingTileOutsideOfFileShouldNotGenerateException():void
    {
      field.setTile(-5, -3, TileType.EMPTY);
    }

    [Test]
    public function testSetWaterTile():void
    {
      field.setTile(1, 1, TileType.WATER);
      Assert.assertEquals(TileType.WATER, field.getTile(1, 1).getType());
    }


    [Test]
    public function testSettingWaterTileOnLevelEdgeShouldBeAllowed():void
    {
      field.setTile(0, 5, TileType.WATER);
      Assert.assertEquals(TileType.WATER, field.getTile(0, 5).getType());
    }
  }
}

class FakePixelScreen implements PixelScreen
{
  private var canvas:Array;  
  private static const defaultColor:int = 0x000000;

  public function FakePixelScreen(width:int, height:int):void
  {
    canvas = new Array(width);
    for(var i:int = 0;i < width;i++)
      {
	canvas[i] = new Array(height);
	for(var j:int = 0;j < height;j++)
	  {
	    canvas[i][j] = defaultColor;
	  }
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
