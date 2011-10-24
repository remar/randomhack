package
{
  import org.flexunit.Assert;

  public class TestUndead
  {
    private var gf:GraphicsFactory;
    private var ng:DeterministicNumberGenerator;
    private var ds:DisplayableStatus;
    private var infoView:FakeInfoView;
    private var undead:Undead;
    private var player:Player;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ng = new DeterministicNumberGenerator();

      ds = new DisplayableStatus();

      infoView = new FakeInfoView();
      ds.registerListener(infoView);

      undead = new Undead(gf, ng);

      player = new Player(gf, ds);
    }

    [Test]
    public function shouldCauseFear():void
    {
      Assert.assertTrue(undead.causesFear);
      Assert.assertEquals(FearType.FEAR, undead.fearType);
    }

    [Test]
    public function shouldInflictPoisonWhenAttacking():void
    {
      player.position = new Point(10, 10);
      undead.position = new Point(11, 10);

      ng.addInts([1, 2, 0]);

      undead.attack(player, ds);
      Assert.assertTrue(infoView.hasPrintedMessage("You were poisoned!"));
    }
  }
}
