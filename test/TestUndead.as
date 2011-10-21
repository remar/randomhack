package
{
  import org.flexunit.Assert;

  public class TestUndead
  {
    private var gf:GraphicsFactory;
    private var ng:NumberGenerator;
    private var undead:Undead;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ng = new DeterministicNumberGenerator();

      undead = new Undead(gf, ng);
    }

    [Test]
    public function shouldCauseFear():void
    {
      Assert.assertTrue(undead.causesFear);
      Assert.assertEquals(FearType.FEAR, undead.fearType);
    }
  }
}
