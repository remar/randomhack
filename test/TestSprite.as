package
{
  import org.flexunit.Assert;

  public class TestSprite
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
      var sprite:Sprite = new PixelSprite(2, 2);
      var color:int = 0xffffff;
      var data:Array = [1,0,
			0,1,
			color];
      sprite.setData(data);

      pixelDrawable.drawSprite(sprite, new Point(0, 0));

      Assert.assertEquals(color, fakeScreen.getPixel(0, 0));
      Assert.assertEquals(0x000000, fakeScreen.getPixel(1, 0));
      Assert.assertEquals(color, fakeScreen.getPixel(1, 1));
      Assert.assertEquals(0x000000, fakeScreen.getPixel(0, 1));
    }
  }
}
