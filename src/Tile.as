package
{
  public class Tile
  {
    public static const EMPTY:int = 0;
    public static const BLOCK:int = 1;

    public static const EMPTY_COLOR:int = 0x000000;
    public static const BLOCK_COLOR:int = 0xff5050;

    private var type:int;
    private var color:int;

    public function Tile(type:int):void
    {
      this.type = type;

      var arr:Array = [EMPTY_COLOR, BLOCK_COLOR];
      color = arr[type];
    }

    public function getType():int
    {
      return type;
    }

    public function getColor():int
    {
      return color;
    }
  }
}
