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
    private var field:Field;
    private var itemFactory:ItemFactory;
    private var infoView:FakeInfoView;

    private var bottle:Bottle;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ds = new DisplayableStatus();
      ng = new DeterministicNumberGenerator();
      player = new Player(gf, ng, ds);

      infoView = new FakeInfoView();
      ds.registerListener(infoView);

      ng.addInts([0]);

      player.generateCharacter(ng);

      itemController = new ItemController();

      field = new Field(32, 24);
      field.clearField(TileType.EMPTY);

      itemFactory = new ItemFactory(gf, ng);

      bottle = new Bottle(gf);
      bottle.position = new Point(10, 10);
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
      givenPlayerAt(10, 10);
      givenBloodAt(10, 10);

      whenBottleIsUsed();
      whenBottleIsUsed();

      thenNumberOfItemsInTheFieldIs(1);
      thenBottleGetsName("an empty bottle");
    }

    [Test]
    public function canBeFilledWithWater():void
    {
      givenPlayerAt(10, 10);
      givenWaterAt(10, 11);

      whenBottleIsUsed();

      thenBottleGetsName("bottled water");
    }

    [Test]
    public function canSplashWaterAround():void
    {
      givenPlayerAt(10, 10);
      givenWaterAt(10, 11);

      // pick up water
      whenBottleIsUsed();

      // splash water around
      whenBottleIsUsed();
      whenBottleIsUsed();
      whenBottleIsUsed();
      whenBottleIsUsed();

      thenBottleGetsName("bottled water");
    }

    [Test]
    public function waterRunsOutAfterFiveUses():void
    {
      givenPlayerAt(10, 10);
      givenWaterAt(10, 11);

      // pick up water
      whenBottleIsUsed();

      // splash water around
      whenBottleIsUsed();
      whenBottleIsUsed();
      whenBottleIsUsed();
      whenBottleIsUsed();
      whenBottleIsUsed();

      thenBottleGetsName("an empty bottle");
    }

    [Test]
    public function informsAboutSplashingAround():void
    {
      givenPlayerAt(10, 10);
      givenWaterAt(10, 11);

      // pick up water
      whenBottleIsUsed();

      // splash water around
      whenBottleIsUsed();

      thenMessageIsPrinted("You splash the water around you");
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

    private function givenWaterAt(x:int, y:int):void
    {
      field.setTile(new Point(x, y), TileType.WATER);
    }

    private function whenBottleIsUsed():void
    {
      bottle.useItem(player, field, itemController, null, ds, itemFactory);
    }

    private function thenNumberOfItemsInTheFieldIs(items:int):void
    {
      Assert.assertEquals(items, itemController.getItems().length);
    }

    private function thenBottleGetsName(name:String):void
    {
      Assert.assertEquals(name, bottle.name);
    }

    private function thenMessageIsPrinted(msg:String):void
    {
      Assert.assertTrue(infoView.hasPrintedMessage(msg));
    }
  }
}
