package
{
  import org.flixel.FlxSprite;

  public class FlixelPixelDrawable implements PixelDrawable
  {
    private var flxSprite:FlxSprite;

    public function FlixelPixelDrawable(flxSprite:FlxSprite):void
    {
      this.flxSprite = flxSprite;
    }

    public function setPixel(x:int, y:int, color:int):void
    {
      flxSprite.pixels.setPixel(x, y, color);
    }

    public function getPixel(x:int, y:int):int
    {
      return 0;
    }
  }
}
