package
{
  import org.flixel.FlxG;

  public class FlixelInputReader implements InputReader
  {
    public function FlixelInputReader():void
    {
      FlxG.mouse.show();
    }

    public function mousePressed():Boolean
    {
      return FlxG.mouse.justPressed();
    }

    public function mousePosition():Point
    {
      var x:int = FlxG.mouse.screenX;
      var y:int = FlxG.mouse.screenY;
      return new Point(x, y);
    }
  }
}
