package
{
  public class GameObject
  {
    private var pos:Point;
    private var spriteInstance:SpriteInstance;

    protected var graphicsFactory:GraphicsFactory;

    public function GameObject(gf:GraphicsFactory):void
    {
      graphicsFactory = gf;
    }

    public function setSprite(spriteType:SpriteType):void
    {
      if(spriteType == SpriteType.EMPTY)
	spriteInstance = null;
      else
	spriteInstance = new SpriteInstance(graphicsFactory.getSprite(spriteType));
    }

    public function update():void
    {
    }

    public function set position(pos:Point):void
    {
      this.pos = pos;
      if(spriteInstance != null)
	spriteInstance.setFieldPosition(pos);
    }

    public function get position():Point
      {
	return pos;
      }

    public function draw(drawable:Drawable):void
    {
      if(spriteInstance != null)
	spriteInstance.draw(drawable);
    }
  }
}
