package
{
    public class Enemy extends GameObject
    {
	private var numberGenerator:NumberGenerator;

	public function Enemy(gf:GraphicsFactory, spriteType:int,
			      numberGenerator:NumberGenerator):void
	{
	    super(gf, spriteType);
	    this.numberGenerator = numberGenerator;
	}

	public function move(field:Field, playerPos:Point, creatures:Array):void
	{
	    // Roam
	    var xdiff:int = numberGenerator.getIntInRange(-1, 1);
	    var ydiff:int = numberGenerator.getIntInRange(-1, 1);

	    var p:Point = this.position;

	    if(field.getTile(p.getX() + xdiff, p.getY() + ydiff).getType() == TileType.EMPTY)
		{
		    position = p.add(new Point(xdiff, ydiff));
		}
	}

	public function attack(player:Player):void
	{

	}
    }
}
