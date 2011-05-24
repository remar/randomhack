package
{
  public class OffsetDrawable implements Drawable
  {
    private var parentDrawable:Drawable;
    private var xOffset:int;
    private var yOffset:int;

    public function OffsetDrawable(parentDrawable:Drawable,
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
