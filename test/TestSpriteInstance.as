package
{
  import org.flexunit.Assert;

  public class TestSpriteInstance
  {
    private var fakeScreen:PixelScreen;
    private var drawable:Drawable;

    [Before]
    public function setUp():void
    {
      fakeScreen = new FakePixelScreen(256, 384);
      drawable = new FlixelPixelGraphicsFactory(fakeScreen).getDrawable();
    }

    [Test]
    public function shouldDrawPixelsAtCorrectPosition():void
    {
      var sprite:Sprite = new PixelSprite(2, 2);
      var color:int = 0xffffff;
      var data:Array = [1,0,
			0,1,
			color];
      sprite.setData(data);

      var instance:SpriteInstance = new SpriteInstance(sprite);
      instance.setPosition(new Point(3, 5));
      instance.draw(drawable);

      Assert.assertEquals(color, fakeScreen.getPixel(3, 5));
      Assert.assertEquals(0x000000, fakeScreen.getPixel(4, 5));
      Assert.assertEquals(color, fakeScreen.getPixel(4, 6));
      Assert.assertEquals(0x000000, fakeScreen.getPixel(3, 6));
    }
  }
}
