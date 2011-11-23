package
{
  public class Undead extends Enemy
  {
    public function Undead(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.UNDEAD, ng, ds);

      _name = "Undead";
      _prefix = "an";
      lookDistance = 3;
      speed = 2;
      accuracy = 4;
      power = 6;
      maxhp = 12;
    }

    override public function get causesFear():Boolean
    {
      return true;
    }

    override public function get fearType():FearType
    {
      return FearType.FEAR;
    }

    override public function attack(player:Player):void
    {
      generalAttack(player);

      if(creatureHit && numberGenerator.getIntInRange(0, 9) == 0)
	{      
	  player.poison(PoisonType.POISON);
	}
    }

    override public function attackedWithFire(player:Player, ds:DisplayableStatus):void
    {
      generalAttackedWithFire(player, ds);
    }
  }
}
