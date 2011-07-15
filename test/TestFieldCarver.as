package
{
  import org.flexunit.Assert;

  public class TestFieldCarver
  {
    private var field:Field;
    private var generator:FieldCarver;

    [Before]
    public function setUp():void
    {
      field = new Field(32, 24);
      generator = new FieldCarver(field);
    }

    [After]
    public function tearDown():void
    {
      field = null;
      generator = null;
    }

    [Test]
    public function testCarveHole():void
    {
      generator.carveHole(new Point(3, 3), 1);

      for(var y:int = 2;y <= 4;y++)
	for(var x:int = 2;x <= 4;x++)
	  Assert.assertEquals(TileType.EMPTY, field.getTile(x, y).getType());
    }

    [Test]
    public function testCarveVeryShortPath():void
    {
      generator.carvePath(new Point(1, 1), new Point(1, 1), 1);
      Assert.assertEquals(TileType.EMPTY, field.getTile(1, 1).getType());
    }

    [Test]
    public function testCarveHorizontalPath():void
    {
      generator.carvePath(new Point(1, 1), new Point(8, 1), 1);

      for(var i:int = 1;i <= 8;i++)
	Assert.assertEquals(TileType.EMPTY, field.getTile(i, 1).getType());
    }
    [Test]
    public function testCarveVerticalPath():void
    {
      generator.carvePath(new Point(1, 1), new Point(1, 9), 1);

      for(var i:int = 1;i <= 9;i++)
	Assert.assertEquals(TileType.EMPTY, field.getTile(1, i).getType());
    }

    [Test]
    public function testCarveDiagonalPath():void
    {
      generator.carvePath(new Point(2, 2), new Point(5, 5), 1);

      for(var i:int = 2;i <= 5;i++)
	Assert.assertEquals(TileType.EMPTY, field.getTile(i, i).getType());
    }

    [Test]
    public function testCarveDiagonalPathReversed():void
    {
      generator.carvePath(new Point(5, 5), new Point(2, 2), 1);

      for(var i:int = 2;i <= 5;i++)
	Assert.assertEquals(TileType.EMPTY, field.getTile(i, i).getType());
    }

    [Test]
    public function testCarveEastSouthEastPath():void
    {
      /*
	Path will look like this:
	......
	.xx...
	...xx.
	......
       */
      generator.carvePath(new Point(1, 1), new Point(4, 2), 1);

      Assert.assertEquals(TileType.EMPTY, field.getTile(1, 1).getType());
      Assert.assertEquals(TileType.EMPTY, field.getTile(2, 1).getType());
      Assert.assertEquals(TileType.EMPTY, field.getTile(3, 2).getType());
      Assert.assertEquals(TileType.EMPTY, field.getTile(4, 2).getType());
    }

    [Test]
    public function testCarveHorizontalPathWithWidthTwo():void
    {
      generator.carvePath(new Point(1, 2), new Point(5, 2), 2);

      for(var i:int = 1;i <= 5;i++)
	{
	  Assert.assertEquals(TileType.EMPTY, field.getTile(i, 1).getType());
	  Assert.assertEquals(TileType.EMPTY, field.getTile(i, 2).getType());
	}
    }

    [Test]
    public function testCarveVerticalPathWithWidthTwo():void
    {
      generator.carvePath(new Point(2, 1), new Point(2, 5), 2);

      for(var i:int = 1;i <= 5;i++)
	{
	  Assert.assertEquals(TileType.EMPTY, field.getTile(1, i).getType());
	  Assert.assertEquals(TileType.EMPTY, field.getTile(2, i).getType());
	}
    }

    [Test]
    public function testCarveDiagonalPathWithWidthTwo():void
    {
      generator.carvePath(new Point(3, 4), new Point(7, 8), 2);

      for(var i:int = 3;i <= 7;i++)
	{
	  Assert.assertEquals(TileType.EMPTY, field.getTile(i, i+1).getType());
	  Assert.assertEquals(TileType.EMPTY, field.getTile(i-1, i+1).getType());
	}
    }

    [Test]
    public function testCarveEastSouthEastPathWithWidthTwo():void
    {
      generator.carvePath(new Point(2, 2), new Point(5, 3), 2);

      var points:Array = [[2, 2], [3, 2], [4, 3], [5, 3]];

      for(var i:int = 0;i < points.length;i++)
	{
	  Assert.assertEquals(TileType.EMPTY,
			      field.getTile(points[i][0],
					    points[i][1]).getType());
	  Assert.assertEquals(TileType.EMPTY,
			      field.getTile(points[i][0],
					    points[i][1] - 1).getType());
	}
    }

    [Test]
    public function testCarveSouthSouthEastPathWithWidthTwo():void
    {
      /*
	......
	......
	.xx...
	.xx...
	..xx..
	..xx..
	......
       */
      generator.carvePath(new Point(2, 2), new Point(3, 5), 2);

      var points:Array = [[2, 2], [2, 3], [3, 4], [3, 5]];

      for(var i:int = 0;i < points.length;i++)
	{
	  Assert.assertEquals(TileType.EMPTY,
			      field.getTile(points[i][0],
					    points[i][1]).getType());
	  Assert.assertEquals(TileType.EMPTY,
			      field.getTile(points[i][0] - 1,
					    points[i][1]).getType());
	}
    }

    [Test]
    public function makeMinimalWaterPool():void
    {
      var numberGenerator:DeterministicNumberGenerator
	= new DeterministicNumberGenerator();

      numberGenerator.addInts([3, // width
			       3, // height
			       1, // x offset
			       1, // y offset
			       0, 0, 0, 0]); // adjustments

      generator.createPool(numberGenerator);

      var water:Array = [[1, 1], [2, 1], [3, 1],
			 [1, 2], [2, 2], [3, 2],
			 [1, 3], [2, 3], [3, 3]];
      for(var i:int = 0;i < water.length;i++)
	{
	  Assert.assertEquals("Test tile at x: " + water[i][0] + 
			      ", y: " + water[i][1],
			      TileType.WATER,
			      field.getTile(water[i][0],
					    water[i][1]).getType());	
	}
    }

    [Test]
    public function makeWaterPoolWithJaggedEdge():void
    {
      var numberGenerator:DeterministicNumberGenerator
	= new DeterministicNumberGenerator();

      numberGenerator.addInts([3, // width
			       3, // height
			       1, // x offset
			       1, // y offset
			       1, // water length adjustment
			       -1, // x offset adjustment
			       -1, // water length adjustment
			       0, // x offset adjustment
			       ]);

      /*
	........
	.xxx....
	xxxx....
	xxx.....
	........
       */
      generator.createPool(numberGenerator);

      var water:Array = [[1, 1], [2, 1], [3, 1],
			 [0, 2], [1, 2], [2, 2], [3, 2],
			 [0, 3], [1, 3], [2, 3]];
      for(var i:int = 0;i < water.length;i++)
	{
	  Assert.assertEquals("Test tile at x: " + water[i][0] + 
			      ", y: " + water[i][1],
			      TileType.WATER,
			      field.getTile(water[i][0],
					    water[i][1]).getType());	
	}
    }
    /*
      test water with jagged edges
      test maximum water
     */
  }
}
