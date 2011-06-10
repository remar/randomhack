package
{
  public class SpriteInstance
  {
    private var sprite:Sprite;
    private var position:Point;

    public function SpriteInstance(sprite:Sprite):void
    {
      this.sprite = sprite;
      position = new Point(0, 0);
    }

    public function setPosition(position:Point):void
    {
      this.position = position;
    }

    public function setFieldPosition(position:Point):void
    {
      this.position = position.multiple(8);
    }

    public function draw(drawable:Drawable):void
    {
      sprite.draw(drawable, position);
    }
  }
}
