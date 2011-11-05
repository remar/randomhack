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
    private var itemController:ItemController;

    [Before]
    public function setUp():void
    {
      field = new Field(32, 24);
      field.clearField(TileType.EMPTY);

      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);

      ng = new DeterministicNumberGenerator();

      playerPos = new Point(7, 10);

      mingbat = new Mingbat(gf, ng, null);

      itemController = new ItemController();
    }

    [Test]
    public function shouldPickUpItem():void
    {
      givenStickAt(new Point(9, 10));
      givenNumberGeneratorReturns([1, 1]);
      givenMingbatAtPosition(new Point(10, 10));

      whenMingbatMoves();
      whenMingbatMoves();

      thenNumberOfItemsInTheFieldIs(0);
    }

    [Test]
    public function shouldDropItemWhenItDies():void
    {
      // First, go and pick up an item
      shouldPickUpItem();

      whenMingbatDies();

      thenNumberOfItemsInTheFieldIs(1);
    }

    [Test]
    public function shouldNotPickUpBlood():void
    {
      givenBloodAt(new Point(9, 10));
      givenNumberGeneratorReturns([1, 1]);
      givenMingbatAtPosition(new Point(10, 10));

      whenMingbatMoves();
      whenMingbatMoves();

      thenNumberOfItemsInTheFieldIs(1);
    }

    private function givenStickAt(position:Point):void
    {
      var stick:Stick = new Stick(gf);
      stick.position = position;
      itemController.addItem(stick);
    }

    private function givenBloodAt(position:Point):void
    {
      var blood:Blood = new Blood(gf);
      blood.position = position;
      itemController.addItem(blood);
    }

    private function givenNumberGeneratorReturns(ints:Array):void
    {
      ng.addInts(ints);
    }

    private function givenMingbatAtPosition(position:Point):void
    {
      mingbat.position = position;
    }

    private function whenMingbatMoves():void
    {
      mingbat.move(field, playerPos, [], itemController);
    }

    private function whenMingbatDies():void
    {
      mingbat.die(itemController, new DisplayableStatus(), gf);
    }

    private function thenNumberOfItemsInTheFieldIs(items:int):void
    {
      Assert.assertEquals(items, itemController.getItems().length);
    }
  }
}
