package
{
  import org.flixel.FlxG;

  public class Player extends GameObject
  {
    private var field:Field;
    private var sprite:Sprite;

    public function Player(field:Field, position:Point):void
    {
      this.field = field;
      sprite = new Sprite(8, 8);
      sprite.setData([0,0,0,1,1,1,0,0,
		      0,0,0,1,1,1,0,1,
		      1,1,1,0,1,0,0,1,
		      1,1,1,1,1,1,1,1,
		      1,1,1,0,1,0,0,1,
		      0,1,0,0,1,0,0,0,
		      0,0,0,1,0,1,0,0,
		      0,0,1,1,0,1,1,0]);
      sprite.setColor(0xcccccc);
      super(sprite);
      super.position = position;
    }

    override public function update():void
    {
      if(FlxG.keys.justPressed("LEFT"))
	{
	  moveRelative(-1, 0);
	}
      else if(FlxG.keys.justPressed("RIGHT"))
	{
	  moveRelative(+1, 0);
	}      
      if(FlxG.keys.justPressed("UP"))
	{
	  moveRelative(0, -1);
	}
      else if(FlxG.keys.justPressed("DOWN"))
	{
	  moveRelative(0, +1);
	}      
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
      if(field.getTile(position.getX() + xRel, position.getY() + yRel).getType() == Tile.EMPTY)
	{
	  super.position = position.add(xRel, yRel);
	}
    }

    public function moveAbsolute(position:Point):void
    {
      if(field.getTile(position.getX(), position.getY()).getType()
	 == Tile.EMPTY)
	{
	  super.position = position;
	}
    }
  }
}
