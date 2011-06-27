package
{
  public class OffsetDrawable implements Drawable
  {
    private var parentDrawable:Drawable;
    private var offset:Point;

    public function OffsetDrawable(parentDrawable:Drawable, offset:Point):void
    {
      this.parentDrawable = parentDrawable;
      this.offset = offset;
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
