package
{
  public class Point
  {
    private var X:int;
    private var Y:int;

    public function Point(X:int, Y:int):void
    {
      this.X = X;
      this.Y = Y;
    }

    public function get x():int
    {
      return X;
    }

    public function get y():int
    {
      return Y;
    }

    public function add(p:Point):Point
    {
      return new Point(this.x + p.x, this.y + p.y);
    }

    public function subtract(p:Point):Point
    {
      return new Point(this.x - p.x, this.y - p.y);
    }

    public function multiple(multiplier:int):Point
    {
      return new Point(x * multiplier, y * multiplier);
    }

    public function equals(other:Point):Boolean
    {
      return x == other.x && y == other.y;
    }

    public function withinBounds(upperLeft:Point, lowerRight:Point):Boolean
    {
      return x >= upperLeft.x && y >= upperLeft.y &&
	x < lowerRight.x && y < lowerRight.y;
    }
      
    public function distanceTo(other:Point):int
    {
      return Math.max(Math.abs(x - other.x), Math.abs(y - other.y));
    }

    public function toString():String
    {
      return "(" + x + "," + y + ")";
    }

    public function getPointsAround():Array
    {
      var offsets:Array = [new Point(-1, -1), new Point(0, -1), new Point(1, -1),
			   new Point(-1, 0), new Point(1, 0),
			   new Point(-1, 1), new Point(0, 1), new Point(1, 1)];
      var point:Point = this;
      return offsets.map(function (p:Point, i:int, a:Array):Point
			 {
			   return point.add(p);
			 });
    }
  }
}
