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

    public function subtract(p:Point):Point
    {
      return new Point(this.x - p.getX(), this.y - p.getY());
    }

    public function multiple(multiplier:int):Point
    {
      return new Point(x * multiplier, y * multiplier);
    }

    public function equals(other:Point):Boolean
    {
      return x == other.getX() && y == other.getY();
    }

    public function withinBounds(upperLeft:Point, lowerRight:Point):Boolean
    {
      return x >= upperLeft.getX() && y >= upperLeft.getY() &&
	x < lowerRight.getX() && y < lowerRight.getY();
    }
      
    public function distanceTo(other:Point):int
    {
	return Math.abs(x - other.getX()) + Math.abs(y - other.getY());
    }

    public function toString():String
    {
      return "(" + x + "," + y + ")";
    }
  }
}
