package
{
  public class GameObject
  {
    private var pos:Point;
    private var spriteInstance:SpriteInstance;

    public function GameObject(sprite:Sprite):void
    {
      spriteInstance = new SpriteInstance(sprite);
    }

    public function update():void
    {
    }

    public function set position(pos:Point):void
    {
      this.pos = pos;
      spriteInstance.setFieldPosition(pos);
    }

    public function get position():Point
    {
      return pos;
    }

    public function draw(drawable:PixelDrawable):void
    {
      spriteInstance.draw(drawable);
    }
  }
}
