package
{
  import org.flixel.FlxG;

  public class FlixelInputReader implements InputReader
  {
    private var keyTypeToString:Array = ["RIGHT", "UP", "LEFT", "DOWN"];

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

    public function keyPressed(keyType:KeyType):Boolean
    {
      return FlxG.keys.justPressed(keyTypeToString[keyType.Index]);
    }

    public function keyHeld(keyType:KeyType):Boolean
    {
      return FlxG.keys.pressed(keyTypeToString[keyType.Index]);
    }
  }
}
