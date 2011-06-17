package
{
  import org.flexunit.Assert;

  public class TestPixelTile
  {
    private var drawable:PixelDrawable;

    [Before]
    public function setUp():void
    {
      drawable = new FakePixelDrawable(16, 16);
    }
  }
}
