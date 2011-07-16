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
      field.clearField(TileType.EMPTY);
    }

    [After]
    public function tearDown():void
    {
      field = null;
    }

    [Test]
    public function shouldBeAbleToMove():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      var gf:GraphicsFactory = new FlixelPixelGraphicsFactory(fakeScreen);
      var player:Player = new Player(gf, field, new Point(3, 3));
      player.moveRelative(field, new Point(1, 0));
      Assert.assertTrue(player.position.equals(new Point(4, 3)));
    }
  }
}
