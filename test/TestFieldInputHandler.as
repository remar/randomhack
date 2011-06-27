package
{
  import org.flexunit.Assert;

  public class TestFieldInputHandler
  {
    private var fieldInputHandler:FieldInputHandler;
    private var playerPos:Point;

    [Before]
    public function setUp():void
    {
      fieldInputHandler = new FieldInputHandler(8, 8);
      playerPos = new Point(5, 5);
    }

    [Test]
    public function shouldReturnEastWhenPressingToTheRightOfPlayer():void
    {
      var mousePos:Point = new Point(6*8 + 4, 5*8);
      var p:Point = fieldInputHandler.mousePressRelativeToPlayer(mousePos,
								 playerPos);
      Assert.assertTrue(p.equals(new Point(1, 0)));
    }

    [Test]
    public function shouldReturnWestWhenPressingToTheLeftOfPlayer():void
    {
      var mousePos:Point = new Point(2*8, 5*8);
      var p:Point = fieldInputHandler.mousePressRelativeToPlayer(mousePos,
								 playerPos);
      Assert.assertTrue("Result: " + p.toString(), p.equals(new Point(-1, 0)));
    }

    [Test]
    public function shouldReturnNorthWhenPressingAbovePlayer():void
    {
      var mousePos:Point = new Point(5*8, 2*8);
      var p:Point = fieldInputHandler.mousePressRelativeToPlayer(mousePos,
								 playerPos);
      Assert.assertTrue(p.equals(new Point(0, -1)));
    }

    [Test]
    public function shouldReturnSouthWhenPressingBelowPlayer():void
    {
      var mousePos:Point = new Point(5*8, 8*8);
      var p:Point = fieldInputHandler.mousePressRelativeToPlayer(mousePos,
								 playerPos);
      Assert.assertTrue(p.equals(new Point(0, 1)));
    }
  }
}
