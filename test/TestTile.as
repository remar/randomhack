package
{
  import org.flexunit.Assert;

  public class TestTile
  {
    private var pixelDrawable:PixelDrawable;

    [Before]
    public function setUp():void
    {
      pixelDrawable = new FakePixelDrawable(16, 16);
    }

    [Test]
    public function shouldDrawPixels():void
    {
      var tile:Tile = new PixelTile(2, 2);
      tile.setData([1, 2, 3, 4]);

      pixelDrawable.drawTile(tile, new Point(2, 1));

      /* . == 0
	................
	................
	....12..........
	....34..........
	................
	................
	................
	................
       */

      Assert.assertEquals(1, pixelDrawable.getPixel(4, 2));
      Assert.assertEquals(2, pixelDrawable.getPixel(5, 2));
      Assert.assertEquals(3, pixelDrawable.getPixel(4, 3));
      Assert.assertEquals(4, pixelDrawable.getPixel(5, 3));
    }
  }
}
