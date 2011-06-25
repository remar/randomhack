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

    public function add(p:Point):Point
    {
      return new Point(this.x + p.getX(), this.y + p.getY());
    }

    public function multiple(multiplier:int):Point
    {
      return new Point(x * multiplier, y * multiplier);
    }

    public function equals(other:Point):Boolean
    {
      return x == other.getX() && y == other.getY();
    }
  }
}
