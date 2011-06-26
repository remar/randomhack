package
{
  import org.flexunit.Assert;

  public class TestTile
  {
    private var fakeScreen:PixelScreen;
    private var pixelDrawable:Drawable;

    [Before]
    public function setUp():void
    {
      fakeScreen = new FakePixelScreen(256, 384);
      pixelDrawable = new FlixelPixelGraphicsFactory(fakeScreen).getDrawable();
    }

    [Test]
    public function shouldDrawPixels():void
    {
      var tile:Tile = new PixelTile(2, 2);
      tile.setData([1, 2, 3, 4]);

      pixelDrawable.drawTile(tile, new Point(2 * tile.getWidth(),
					     1 * tile.getHeight()));

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

      Assert.assertEquals(1, fakeScreen.getPixel(4, 2));
      Assert.assertEquals(2, fakeScreen.getPixel(5, 2));
      Assert.assertEquals(3, fakeScreen.getPixel(4, 3));
      Assert.assertEquals(4, fakeScreen.getPixel(5, 3));
    }
  }
}
