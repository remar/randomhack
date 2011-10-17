package
{
  import org.flexunit.Assert;

  public class TestMingbat
  {
    private var field:Field;
    private var gf:GraphicsFactory;
    private var ng:DeterministicNumberGenerator;
    private var playerPos:Point;

    private var mingbat:Mingbat;

    [Before]
    public function setUp():void
    {
      field = new Field(32, 24);
      field.clearField(TileType.EMPTY);

      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ng = new DeterministicNumberGenerator();

      playerPos = new Point(7, 10);

      mingbat = new Mingbat(gf, ng);
    }

    [Test]
    public function shouldPickUpItem():void
    {
      var itemController:ItemController = new ItemController();
      var stick:Stick = new Stick(gf, new Point(9, 10));
      itemController.addItem(stick);

      mingbat.position = new Point(10, 10);

      // "random" numbers needed to move towards player
      ng.addInts([1, 1]);

      mingbat.move(field, playerPos, [], itemController);
      mingbat.move(field, playerPos, [], itemController);

      Assert.assertEquals(0, itemController.getItems().length);
    }
  }
}
