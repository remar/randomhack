package
{
  public class Enemy extends Creature
  {
    protected var lookDistance:int;
    protected var speed:int;

    public function Enemy(gf:GraphicsFactory, spriteType:SpriteType,
			  numberGenerator:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, numberGenerator, ds);
      setSprite(spriteType);

      this.numberGenerator = numberGenerator;

      _name = "Enemy";
      lookDistance = 5;
      speed = 5;
      maxhp = 5;
      power = 5;
      accuracy = 5;
    }

    public function move(field:Field, playerPos:Point, creatures:Array, itemController:ItemController):void
    {
      generalMove(field, playerPos, creatures, itemController);
    }

    public function attack(player:Player):void
    {
      generalAttack(player);
    }

    public function die(itemController:ItemController,
			displayableStatus:DisplayableStatus,
			graphicsFactory:GraphicsFactory):void
    {
      generalDie(itemController, displayableStatus, graphicsFactory);
    }

    public function get causesFear():Boolean
    {
      return false;
    }

    public function get fearType():FearType
    {
      return FearType.NO_FEAR;
    }

    public function attackedWithFire(player:Player, displayableStatus:DisplayableStatus):void
    {
      // Do nothing in base class
    }

    protected function generalMove(field:Field, playerPos:Point, creatures:Array, itemController:ItemController):void
    {
      var distance:int = position.distanceTo(playerPos);

      if(isDead() || distance == 1 || numberGenerator.getIntInRange(1, 10) > speed)
	return;

      if(distance <= lookDistance)
	moveRelative(field, field.getDirection(position, playerPos), creatures);
      else
	roam(field, creatures);
    }

    protected function generalDie(itemController:ItemController,
				displayableStatus:DisplayableStatus,
				graphicsFactory:GraphicsFactory):void
    {
      if (itemController.getItemAtPosition(position) == null)
	{
	  var blood:Blood = new Blood(graphicsFactory);
	  blood.position = position;
	  itemController.addItem(blood);
	}
      displayableStatus.print(name + " dies");
    }

    override protected function missed():void
    {
      displayableStatus.print(name + " missed");
    }

    override protected function struggle():Boolean
    {
      return numberGenerator.getIntInRange(0, 9) == 0;
    }

    override protected function hitsCreature():Boolean
    {
      return numberGenerator.getIntInRange(1, 10) <= accuracy;
    }

    private function roam(field:Field, creatures:Array):void
    {
      var xdiff:int = numberGenerator.getIntInRange(-1, 1);
      var ydiff:int = numberGenerator.getIntInRange(-1, 1);
	    
      moveRelative(field, new Point(xdiff, ydiff), creatures);
    }
  }
}
