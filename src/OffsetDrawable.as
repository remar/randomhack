package
{
  public class OffsetDrawable implements Drawable
  {
    private var parentDrawable:Drawable;
    private var xOffset:int;
    private var yOffset:int;
    private var offset:Point;

    public function OffsetDrawable(parentDrawable:Drawable,
				   xOffset:int, yOffset:int):void
    {
      this.parentDrawable = parentDrawable;
      this.xOffset = xOffset;
      this.yOffset = yOffset;
      this.offset = new Point(xOffset, yOffset);
    }

    public function drawSprite(sprite:Sprite, position:Point):void
    {
      parentDrawable.drawSprite(sprite, position.add(offset));
    }

    public function drawTile(tile:Tile, position:Point):void
    {
      parentDrawable.drawTile(tile, position.add(offset));
    }
  }
}
