package
{
  import org.flixel.FlxSprite;

  public class FlixelPixelScreen implements PixelScreen
  {
    private var screen:FlxSprite;

    public function FlixelPixelScreen(screen:FlxSprite):void
    {
      this.screen = screen;
    }

    public function setPixel(x:int, y:int, color:int):void
    {
      screen.pixels.setPixel(x, y, color);      
    }

    public function getPixel(x:int, y:int):int
    {
      return 0;
    }
  }
}
