package
{
  import org.flexunit.Assert;

  public class TestSprite
  {
    [Test]
    public function testShouldDrawPixels():void
    {
      var sprite:Sprite = new Sprite(2, 2);
      var data:Array = [1,0,
			0,1];
      var color:int = 0xffffff;

      sprite.setData(data);
      sprite.setColor(color);

      var drawable:Drawable = new FakeDrawable(16, 16);

      sprite.draw(drawable, 1, 1);

      Assert.assertEquals(color, drawable.getPixel(1, 1))
      Assert.assertEquals(0x000000, drawable.getPixel(2, 1))
      Assert.assertEquals(color, drawable.getPixel(2, 2))
      Assert.assertEquals(0x000000, drawable.getPixel(1, 2))
    }
  }
}


class FakeDrawable implements Drawable
{
  private var canvas:Array;
  private static const defaultColor:int = 0x000000;

  public function FakeDrawable(width:int, height:int):void
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
