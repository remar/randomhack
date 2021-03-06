package
{
  public class Snake extends Enemy
  {
    public function Snake(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.SNAKE, ng, ds);

      _name = "Snake";
      _prefix = "a";
      maxhp=3;
      power=2;
      accuracy=3;
      lookDistance=4;
      speed=4;
    }

    override public function attack(player:Player):void
    {
      generalAttack(player);
      if(creatureHit && numberGenerator.getIntInRange(0, 9) == 0)
	{
	  player.poison(PoisonType.POISON);
	}
    }
  }
}
