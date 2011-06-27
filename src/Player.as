package
{
  import org.flixel.FlxG;

  public class Player extends GameObject
  {
    private var field:Field;
    private var sprite:Sprite;

    public function Player(gf:GraphicsFactory, field:Field, position:Point):void
    {
      this.field = field;
      super(gf, SpriteType.PLAYER);
      this.position = position;
    }

    override public function update():void
    {
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
	}
    }

    public function moveAbsolute(position:Point):void
    {
      if(field.getTile(position.getX(), position.getY()).getType()
	 == TileType.EMPTY)
	{
	  super.position = position;
	}
    }
  }
}
