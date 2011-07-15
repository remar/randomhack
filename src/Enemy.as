package
{
    public class Enemy extends GameObject
    {
	private var numberGenerator:NumberGenerator;
	protected var lookDistance:int;

	public function Enemy(gf:GraphicsFactory, spriteType:int,
			      numberGenerator:NumberGenerator):void
	{
	    super(gf, spriteType);
	    this.numberGenerator = numberGenerator;

	    lookDistance = 5;
	}

	public function move(field:Field, playerPos:Point, creatures:Array):void
	{
	    if(position.distanceTo(playerPos) <= lookDistance)
		moveRelative(field.getDirection(position, playerPos), field);
	    else
		roam(field);
	}

	public function attack(player:Player):void
	{

	}

	private function roam(field:Field):void
	{
	    var xdiff:int = numberGenerator.getIntInRange(-1, 1);
	    var ydiff:int = numberGenerator.getIntInRange(-1, 1);
	    
	    moveRelative(new Point(xdiff, ydiff), field);
	}

	private function moveRelative(delta:Point, field:Field):void
	{
	    if(field.getTile(position.getX() + delta.getX(),
			     position.getY() + delta.getY()).getType() == TileType.EMPTY)
		position = position.add(delta);
	}
    }
}
