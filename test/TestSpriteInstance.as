package
{
  import org.flexunit.Assert;

  public class TestSpriteInstance
  {
    private var drawable:PixelDrawable;

    [Before]
    public function setUp():void
    {
      drawable = new FakePixelDrawable(16, 16);
    }

    [Test]
    public function shouldDrawPixelsAtCorrectPosition():void
    {
      var sprite:Sprite = new Sprite(2, 2);
      var data:Array = [1,0,
			0,1];
      var color:int = 0xffffff;
      sprite.setData(data);
      sprite.setColor(color);

      var instance:SpriteInstance = new SpriteInstance(sprite);
      instance.setPosition(new Point(3, 5));
      instance.draw(drawable);

      Assert.assertEquals(color, drawable.getPixel(3, 5));
      Assert.assertEquals(0x000000, drawable.getPixel(4, 5));
      Assert.assertEquals(color, drawable.getPixel(4, 6));
      Assert.assertEquals(0x000000, drawable.getPixel(3, 6));
    }
  }
}
