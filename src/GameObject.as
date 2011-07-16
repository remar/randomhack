package
{
  public class GameObject
  {
    private var pos:Point;
    private var spriteInstance:SpriteInstance;

    public function GameObject(gf:GraphicsFactory, spriteType:int):void
    {
      spriteInstance = new SpriteInstance(gf.getSprite(spriteType));
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

    public function draw(drawable:Drawable):void
    {
      spriteInstance.draw(drawable);
    }

    public function moveRelative(field:Field, delta:Point):void
      {
	  if(field.getTile(position.getX() + delta.getX(),
			   position.getY() + delta.getY()).getType() == TileType.EMPTY)
	      {
		  position = position.add(delta);
	      }
      }
  }
}
