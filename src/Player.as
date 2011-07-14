package
{
  import org.flixel.FlxG;

  public class Player extends GameObject
  {
    private var field:Field;
    private var sprite:Sprite;
    private var actionPerformed:Boolean;

    public function Player(gf:GraphicsFactory, field:Field, position:Point):void
    {
      this.field = field;
      super(gf, SpriteType.PLAYER);
      this.position = position;
      actionPerformed = false;
    }

    override public function update():void
    {
    }

    public function hasPerformedAction():Boolean
    {
	if(actionPerformed)
	    {
		actionPerformed = false;
		return true;
	    }

	return false;
    }

    public function get x():int
    {
      return position.getX();
    }

    public function get y():int
    {
      return position.getY();
    }

    public function moveRelative(xRel:int, yRel:int):void
    {
      if(field.getTile(position.getX() + xRel, position.getY() + yRel).getType() == TileType.EMPTY)
	{
	  position = position.add(new Point(xRel, yRel));

	  actionPerformed = true;
	}
    }

    public function moveAbsolute(position:Point):void
    {
      if(field.getTile(position.getX(), position.getY()).getType()
	 == TileType.EMPTY)
	{
	  super.position = position;

	  actionPerformed = true;
	}
    }
  }
}
