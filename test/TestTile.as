package
{
  import org.flexunit.Assert;

  public class TestTile
  {
    [Test]
    public function testGetType():void
    {
      var t:Tile = new Tile(Tile.BLOCK);
      Assert.assertEquals(Tile.BLOCK, t.getType());
    }

    [Test]
    public function testGetColor():void
    {
      var t:Tile = new Tile(Tile.BLOCK);
      Assert.assertEquals(Tile.BLOCK_COLOR, t.getColor());
    }
  }
}
