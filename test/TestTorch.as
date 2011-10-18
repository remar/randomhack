package
{
  import org.flexunit.Assert;

  public class TestTorch
  {
    private var gf:GraphicsFactory;
    private var ds:DisplayableStatus;
    private var ng:DeterministicNumberGenerator;
    private var player:Player;
    private var itemController:ItemController;

    private var torch:Torch;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);      

      ds = new DisplayableStatus();
      ng = new DeterministicNumberGenerator();
      player = new Player(gf, ds);

      ng.addInts([0]);

      player.generateCharacter(ng);

      itemController = new ItemController();

      torch = new Torch(gf, new Point(10, 10));
    }

    [Test]
    public function shouldLightSticksOnTheGround():void
    {
      var playerX:int = 10;
      var playerY:int = 10;

      givenPlayerAt(playerX, playerY);
      givenSticksAllAroundPlayer(playerX, playerY);

      whenTorchIsUsed();

      thenSticksAreConvertedToTorchesAroundPlayer(playerX, playerY);
    }

    private function givenPlayerAt(playerX:int, playerY:int):void
    {
      player.position = new Point(playerX, playerY);
    }

    private function givenSticksAllAroundPlayer(playerX:int, playerY:int):void
    {
      for(var y:int = -1;y < 2;y++)
	for(var x:int = -1;x < 2;x++)
	  givenStickAt(new Point(playerX+x, playerY+y));
    }

    private function givenStickAt(position:Point):void
    {
      var stick:Stick = new Stick(gf, position);
      itemController.addItem(stick);
    }

    private function whenTorchIsUsed():void
    {
      torch.useItem(player, null, itemController, null, ds);
    }

    private function thenSticksAreConvertedToTorchesAroundPlayer(playerX:int, playerY:int):void
    {
      for(var y:int = -1;y < 2;y++)
	for(var x:int = -1;x < 2;x++)
	  {
	    var item:Item = itemController.getItemAtPosition(new Point(playerX + x, playerY + y));
	    Assert.assertTrue(item is Torch);
	  }
    }
  }
}
