package
{
  import org.flixel.FlxG;

  public class Player
  {
    private var field:Field;
    private var position:Point;
    private var sprite:Sprite;
    private var spriteInstance:SpriteInstance;

    public function Player(field:Field, position:Point):void
    {
      this.field = field;
      this.position = position;
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
      spriteInstance = new SpriteInstance(sprite);
      spriteInstance.setPosition(position.multiple(8));
    }

    public function update():void
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
	  position = position.add(xRel, yRel);
	  spriteInstance.setPosition(position.multiple(8));
	}
    }

    public function moveAbsolute(position:Point):void
    {
      if(field.getTile(position.getX(), position.getY()).getType()
	 == Tile.EMPTY)
	{
	  this.position = position;
	  spriteInstance.setPosition(position.multiple(8));
	}
    }

    public function draw(drawable:Drawable):void
    {
      spriteInstance.draw(drawable);
    }
  }
}
