package
{
  import org.flexunit.Assert;

  public class TestSprite
  {
    private var drawable:Drawable;

    [Before]
    public function setUp():void
    {
      drawable = new FakeDrawable(16, 16);
    }

    [Test]
    public function shouldDrawPixels():void
    {
      var sprite:Sprite = new Sprite(2, 2);
      var data:Array = [1,0,
			0,1];
      var color:int = 0xffffff;

      sprite.setData(data);
      sprite.setColor(color);

      sprite.draw(drawable, new Point(0, 0));

      Assert.assertEquals(color, drawable.getPixel(0, 0));
      Assert.assertEquals(0x000000, drawable.getPixel(1, 0));
      Assert.assertEquals(color, drawable.getPixel(1, 1));
      Assert.assertEquals(0x000000, drawable.getPixel(0, 1));
    }
  }
}
