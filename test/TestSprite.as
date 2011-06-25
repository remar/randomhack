package
{
  import org.flexunit.Assert;

  public class TestSprite
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
      var sprite:Sprite = new PixelSprite(2, 2);
      var color:int = 0xffffff;
      var data:Array = [1,0,
			0,1,
			color];
      sprite.setData(data);

      pixelDrawable.drawSprite(sprite, new Point(0, 0));

      Assert.assertEquals(color, pixelDrawable.getPixel(0, 0));
      Assert.assertEquals(0x000000, pixelDrawable.getPixel(1, 0));
      Assert.assertEquals(color, pixelDrawable.getPixel(1, 1));
      Assert.assertEquals(0x000000, pixelDrawable.getPixel(0, 1));
    }
  }
}
