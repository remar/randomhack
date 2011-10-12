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
      var player:Player = new Player(gf, null);
      player.position = new Point(3, 3);
      player.moveRelative(field, new Point(1, 0), []);
      Assert.assertTrue(player.position.equals(new Point(4, 3)));
    }

    [Test]
    public function shouldNotWalkOverEnemies():void
    {
      var player:Player = new Player(gf, null);
      player.position = new Point(3, 3);
      var ng:NumberGenerator = new DeterministicNumberGenerator();
      var enemy:Enemy = new Enemy(gf, SpriteType.BAT, ng);
      enemy.position = new Point(4, 3);
      player.moveRelative(field, new Point(1, 0), [enemy]);
      Assert.assertTrue(player.position.equals(new Point(3, 3)));
    }

    [Test]
    public function shouldTake4HPDamageFromPoison():void
    {
      var player:Player = new Player(gf, new DisplayableStatus());
      player.position = new Point(3, 3);
      player.hp = 10;

      player.poison(PoisonType.POISON);

      var directions:Array = [new Point(-1, 0), new Point(1, 0)];
      for (var i:int = 0;i < 50;i++) {
	player.move(field, directions[i % 2], []);
      }

      Assert.assertEquals(6, player.hp);
    }
  }
}
