package
{
  public class Point
  {
    private var x:int;
    private var y:int;

    public function Point(x:int, y:int):void
    {
      this.x = x;
      this.y = y;
    }

    public function getX():int
    {
      return x;
    }

    public function getY():int
    {
      return y;
    }
  }
}
