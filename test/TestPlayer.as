package
{
  import org.flexunit.Assert;

  public class TestPlayer
  {
    private var field:Field;
    private var gf:GraphicsFactory;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

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
      var player:Player = new Player(gf, field, new Point(3, 3));
      player.moveRelative(field, new Point(1, 0));
      Assert.assertTrue(player.position.equals(new Point(4, 3)));
    }

    [Test]
    public function shouldNotWalkOverEnemies():void
      {
	  var player:Player = new Player(gf, field, new Point(3, 3));
	  var ng:NumberGenerator = new DeterministicNumberGenerator();
	  var enemy:Enemy = new Enemy(gf, SpriteType.BAT, ng);
	  enemy.position = new Point(4, 3);
	  player.move(new Point(1, 0), [enemy]);
	  Assert.assertTrue(player.position.equals(new Point(3, 3)));
      }
  }
}
