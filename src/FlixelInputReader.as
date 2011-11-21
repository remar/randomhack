
package
{
  import org.flixel.FlxG;

  public class FlixelInputReader implements InputReader
  {
    private var keyTypeToString:Object = {};

    public function FlixelInputReader():void
    {
      FlxG.mouse.show();
      setupKeymap();
    }

    private function setupKeymap():void
    {
      keyTypeToString[KeyType.RIGHT.Index] = "RIGHT";
      keyTypeToString[KeyType.UP.Index] = "UP";
      keyTypeToString[KeyType.LEFT.Index] = "LEFT";
      keyTypeToString[KeyType.DOWN.Index] = "DOWN";
      keyTypeToString[KeyType.HELP.Index] = "H";
      keyTypeToString[KeyType.ENTER.Index] = "ENTER";
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
