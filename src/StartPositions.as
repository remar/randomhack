package
{
  public class StartPositions
  {
    private var startPosition:Point;
    private var goalPosition:Point;

    public function StartPositions(start:Point, goal:Point)
    {
      startPosition = start;
      goalPosition = goal;
    }

    public function get start():Point
    {
      return startPosition;
    }

    public function get goal():Point
    {
      return goalPosition;
    }
  }
}
