package
{
  import org.flexunit.Assert;

  public class TestEnemy
  {
    private var gf:GraphicsFactory;
    private var ng:DeterministicNumberGenerator;
    private var enemy:Enemy;
    private var field:Field;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);
      ng = new DeterministicNumberGenerator();
      enemy = new Enemy(gf, SpriteType.BAT, ng);

      field = new Field(32, 24);
      field.clearField(TileType.EMPTY);
    }

    [Test]
    public function shouldRoamIfPlayerIsTooFarAway():void
    {
      ng.addInts([1, -1, -1]);
      enemy.position = new Point(3, 3);
      enemy.move(field, new Point(25, 15), []);

      assertCorrectPosition(new Point(2, 2), enemy.position);
    }

    [Test]
    public function shouldMoveTowardsPlayerWhenWithinLookRange():void
    {
      ng.addInts([1, -1, -1]);
      enemy.position = new Point(3, 3);
      enemy.move(field, new Point(5, 3), []);

      assertCorrectPosition(new Point(4, 3), enemy.position);
    }

    [Test]
    public function shouldNotMoveIfAdjacentToPlayer():void
    {
      ng.addInts([1, -1, -1]);
      enemy.position = new Point(3, 3);
      enemy.move(field, new Point(4, 3), []);

      assertCorrectPosition(new Point(3, 3), enemy.position);
    }

    [Test]
    public function shouldNotMoveIfDieRollIsHighterThanSpeed():void
    {
      ng.addInts([10, -1, -1]);

      enemy.position = new Point(3, 3);
      enemy.move(field, new Point(5, 3), []);

      assertCorrectPosition(new Point(3, 3), enemy.position);
    }

    [Test]
    public function shouldDieWhenTakingTooMuchDamage():void
    {
      enemy.hit(5);
      Assert.assertTrue(enemy.isDead());
    }

    [Test]
    public function shouldNotDieWhenTakingTooLittleDamage():void
    {
      enemy.hit(4);
      Assert.assertFalse(enemy.isDead());
    }

    private function assertCorrectPosition(expected:Point, actual:Point):void
    {
      Assert.assertTrue("Got " + actual.toString() + ", expected " + expected.toString(),
			actual.equals(expected));
    }
  }
}
