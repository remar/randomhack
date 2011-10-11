package
{
  public class GameObject
  {
    private var pos:Point;
    private var spriteInstance:SpriteInstance;

    public function GameObject(gf:GraphicsFactory, spriteType:SpriteType):void
    {
      if(spriteType == SpriteType.EMPTY)
	spriteInstance = null;
      else
	spriteInstance = new SpriteInstance(gf.getSprite(spriteType));
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

    public function moveRelative(field:Field, delta:Point, objects:Array):void
    {
      if(field.getTile(position.add(delta)) != TileType.EMPTY)
	{
	  return;
	}

      var newPosition:Point = position.add(delta);

      var test:Function = function (object:GameObject, i:int, a:Array):Boolean
	                  {
			    return object.position.equals(newPosition);
			  };

      if(!objects.some(test))
	{
	  position = position.add(delta);
	}
    }
  }
}
