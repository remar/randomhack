package
{
  public class TileType
  {
    public static const EMPTY:int = 0;
    public static const BLOCK:int = 1;
    public static const WATER:int = 2;

    private var type:int;
    public function TileType(type:int):void
    {
      this.type = type;
    }

    public function getType():int
    {
      return type;
    }
  }
}
