package
{
  import org.flexunit.Assert;

  public class TestPlayer
  {
    private var field:Field;

    [Before]
    public function setUp():void
    {
      field = new Field(32, 24);
      field.clearField(Tile.EMPTY);
    }

    [After]
    public function tearDown():void
    {
      field = null;
    }

    [Test]
    public function shouldBeAbleToMove():void
    {
      var player:Player = new Player(field, new Point(3, 3));
      player.moveRelative(1, 0);
      Assert.assertEquals(4, player.x);
      Assert.assertEquals(3, player.y);
    }
  }
}
