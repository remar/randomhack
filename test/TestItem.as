package
{
  import org.flexunit.Assert;

  public class TestItem
  {
    private var gf:GraphicsFactory;

    [Before]
    public function setUp():void
    {
      var fakeScreen:PixelScreen = new FakePixelScreen(256, 384);
      gf = new FlixelPixelGraphicsFactory(fakeScreen);
    }

    [Test]
    public function createItem():void
    {
      var item:Item = new Item(gf, SpriteType.EMPTY, "Item");
    }
  }
}
