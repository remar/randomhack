package
{
  public class OffsetPixelDrawable implements PixelDrawable
  {
    private var parentDrawable:PixelDrawable;
    private var xOffset:int;
    private var yOffset:int;

    public function OffsetPixelDrawable(parentDrawable:PixelDrawable,
					xOffset:int, yOffset:int):void
    {
      this.parentDrawable = parentDrawable;
      this.xOffset = xOffset;
      this.yOffset = yOffset;
    }

    public function setPixel(x:int, y:int, color:int):void
    {
      parentDrawable.setPixel(x + xOffset, y + yOffset, color);
    }

    public function getPixel(x:int, y:int):int
    {
      return parentDrawable.getPixel(x + xOffset, y + yOffset);
    }
  }
}
