package
{
  import org.flexunit.Assert;

  public class TestTileType
  {
    [Test]
    public function testGetType():void
    {
      var t:TileType = new TileType(TileType.BLOCK);
      Assert.assertEquals(TileType.BLOCK, t.getType());
    }
  }
}
