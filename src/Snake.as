package
{
  public class Snake extends Enemy
  {
    public function Snake(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.SNAKE, ng, ds);

      _name = "Snake";
      maxhp=3;
      power=2;
      accuracy=3;
      lookDistance=4;
      speed=4;
    }

    override public function attack(player:Player, displayableStatus:DisplayableStatus):void
    {
      generalAttack(player, displayableStatus);
      if(playerHit && numberGenerator.getIntInRange(0, 9) == 0)
	{
	  player.poison(PoisonType.POISON);
	}
    }
  }
}
