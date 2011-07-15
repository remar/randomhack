package
{
  import org.flexunit.Assert;

  public class TestPoint
  {
    [Test]
    public function canBeMoved():void
    {
      var p:Point = new Point(5, 8);
      var p2:Point = p.add(new Point(3, 4));
      Assert.assertEquals(8, p2.getX());
      Assert.assertEquals(12, p2.getY());
    }

    [Test]
    public function canProduceMultiple():void
    {
      var p:Point = new Point(2, 3);
      var p2:Point = p.multiple(5);
      Assert.assertEquals(10, p2.getX());
      Assert.assertEquals(15, p2.getY());
    }

    [Test]
    public function canBeComparedWithOtherPoints():void
    {
      var p1:Point = new Point(3, 5);
      var p2:Point = new Point(5, 4);
      var p3:Point = new Point(3, 5);

      Assert.assertFalse(p1.equals(p2));
      Assert.assertTrue(p1.equals(p3));
    }

    [Test]
    public function distanceBetweenTwoAdjacentPointsIsOne():void
      {
	  var p1:Point = new Point(4, 7);
	  var p2:Point = new Point(5, 7);

	  Assert.assertEquals(1, p1.distanceTo(p2));
      }
  }
}
