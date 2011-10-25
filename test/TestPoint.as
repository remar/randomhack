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
      Assert.assertEquals(8, p2.x);
      Assert.assertEquals(12, p2.y);
    }

    [Test]
    public function canProduceMultiple():void
    {
      var p:Point = new Point(2, 3);
      var p2:Point = p.multiple(5);
      Assert.assertEquals(10, p2.x);
      Assert.assertEquals(15, p2.y);
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

    [Test]
    public function distanceBetweenTwoDiagonallyAdjactentPointsIsOne():void
    {
      var p1:Point = new Point(4, 7);
      var p2:Point = new Point(5, 8);

      Assert.assertEquals(1, p1.distanceTo(p2));
    }

    [Test]
    public function distanceBetweenPoint11AndPoint64Is5():void
    {
      var p1:Point = new Point(1, 1);
      var p2:Point = new Point(6, 4);

      Assert.assertEquals(5, p1.distanceTo(p2));
    }

    [Test]
    public function distanceBetweenTwoEqualPointsIsZero():void
    {
      var p1:Point = new Point(3, 5);
      var p2:Point = new Point(3, 5);

      Assert.assertEquals(0, p1.distanceTo(p2));
    }

    [Test]
    public function shouldReturnPointsAround():void
    {
      var p:Point = new Point(10, 10);

      var points:Array = p.getPointsAround();

      Assert.assertEquals(8, points.length);

      var expected:Array = [new Point(9, 9),  new Point(10, 9),  new Point(11, 9),
			    new Point(9, 10),                    new Point(11, 10),
			    new Point(9, 11), new Point(10, 11), new Point(11, 11)];

      for(var i:int = 0;i < expected.length;i++)
	{
	  var ex:Point = expected[i];
	  var callback:Function = 
	    function(p:Point, i:int, a:Array):Boolean
	    {
	      return p.equals(ex);
	    };
	  Assert.assertTrue(points.some(callback));
	}
    }
  }
}
