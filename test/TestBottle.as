package
{
  import org.flexunit.Assert;

  public class TestBottle
  {
    private var gf:GraphicsFactory;
    private var ds:DisplayableStatus;
    private var ng:DeterministicNumberGenerator;
    private var player:Player;
    private var itemController:ItemController;

    private var bottle:Bottle;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ds = new DisplayableStatus();
      ng = new DeterministicNumberGenerator();
      player = new Player(gf, ng, ds);

      ng.addInts([0]);

      player.generateCharacter(ng);

      itemController = new ItemController();

      bottle = new Bottle(gf, new Point(10, 10));
    }

    [Test]
    public function canBeFilledWithBlood():void
    {
      givenPlayerAt(10, 10);
      givenBloodAt(10, 10);

      whenBottleIsUsed();

      thenNumberOfItemsInTheFieldIs(0);
      thenBottleGetsName("bottled blood");
    }

    [Test]
    public function canPourOutBlood():void
    {
      canBeFilledWithBlood();

      whenBottleIsUsed();

      thenNumberOfItemsInTheFieldIs(1);
      thenBottleGetsName("an empty bottle");
    }

    private function givenPlayerAt(playerX:int, playerY:int):void
    {
      player.position = new Point(playerX, playerY);
    }

    private function givenBloodAt(x:int, y:int):void
    {
      var blood:Blood = new Blood(gf);
      blood.position = new Point(x, y);
      itemController.addItem(blood);
    }

    private function whenBottleIsUsed():void
    {
      bottle.useItem(player, null, itemController, null, ds);
    }

    private function thenNumberOfItemsInTheFieldIs(items:int):void
    {
      Assert.assertEquals(items, itemController.getItems().length);
    }

    private function thenBottleGetsName(name:String):void
    {
      Assert.assertEquals(name, bottle.name);
    }
  }
}
