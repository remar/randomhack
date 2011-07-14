package
{
    public class Bat extends Enemy
    {
	public function Bat(gf:GraphicsFactory, numberGenerator:NumberGenerator):void
	{
	    super(gf, SpriteType.BAT, numberGenerator);
	}

	override public function move(field:Field, playerPos:Point, creatures:Array):void
	{
	    super.move(field, playerPos, creatures);
	}

	override public function attack(player:Player):void
	{
	    
	}
    }
}
