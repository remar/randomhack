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
    private var cc:CreatureController;

    private var torch:Torch;

    private var undead:Undead;

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
      cc = new CreatureController();

      torch = new Torch(gf);
      torch.position = new Point(10, 10);
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

    [Test]
    public function shouldHurtFireWeakCreaturesWhenUsed():void
    {
      var playerX:int = 10;
      var playerY:int = 10;

      givenPlayerAt(playerX, playerY);
      givenUndeadAt(new Point(playerX + 1, playerY));

      ng.clear();
      ng.addInts([20]);

      whenTorchIsUsed();

      thenUndeadIsKilled();
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
      var stick:Stick = new Stick(gf);
      stick.position = position;
      itemController.addItem(stick);
    }

    private function givenUndeadAt(position:Point):void
    {
      undead = new Undead(gf, ng, ds);
      undead.position = position;
      cc.addEnemy(undead);
    }

    private function whenTorchIsUsed():void
    {
      torch.useItem(player, null, itemController, cc, ds, null);
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

    private function thenUndeadIsKilled():void
    {
      Assert.assertTrue(undead.isDead());
    }
  }
}
