package
{
    public class Enemy extends GameObject
    {
	private var numberGenerator:NumberGenerator;

	protected var lookDistance:int;
	protected var speed:int;

	public function Enemy(gf:GraphicsFactory, spriteType:int,
			      numberGenerator:NumberGenerator):void
	{
	    super(gf, spriteType);
	    this.numberGenerator = numberGenerator;

	    lookDistance = 5;
	    speed = 5;
	}

	public function move(field:Field, playerPos:Point, creatures:Array):void
	{
	    var distance:int = position.distanceTo(playerPos);

	    if(distance == 1 || numberGenerator.getIntInRange(1, 10) > speed)
		return;

	    if(distance <= lookDistance)
		moveRelative(field, field.getDirection(position, playerPos));
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
	    
	    moveRelative(field, new Point(xdiff, ydiff));
	}
    }
}
