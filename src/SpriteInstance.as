package
{
  public class SpriteInstance
  {
    private var sprite:Sprite;
    private var position:Point;

    public function SpriteInstance(sprite:Sprite):void
    {
      this.sprite = sprite;
    }

    public function setPosition(position:Point):void
    {
      this.position = position;
    }

    public function draw(drawable:Drawable):void
    {
      sprite.draw(drawable, position);
    }
  }
}
