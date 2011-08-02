package
{
  public class Enemy extends GameObject
  {
    protected var numberGenerator:NumberGenerator;

    protected var _name:String;
    protected var lookDistance:int;
    protected var speed:int;
    protected var maxHP:int;
    protected var hp:int;
    protected var power:int;
    protected var accuracy:int;

    protected var playerHit:Boolean;

    public function Enemy(gf:GraphicsFactory, spriteType:int,
			  numberGenerator:NumberGenerator):void
    {
      super(gf, spriteType);
      this.numberGenerator = numberGenerator;

      _name = "Enemy";
      lookDistance = 5;
      speed = 5;
      maxhp = 5;
      power = 5;
      accuracy = 5;
    }

    public function move(field:Field, playerPos:Point, creatures:Array):void
    {
      var distance:int = position.distanceTo(playerPos);

      if(isDead() || distance == 1 || numberGenerator.getIntInRange(1, 10) > speed)
	return;

      if(distance <= lookDistance)
	moveRelative(field, field.getDirection(position, playerPos), creatures);
      else
	roam(field, creatures);
    }

    public function attack(player:Player, displayableStatus:DisplayableStatus):void
    {
      generalAttack(player, displayableStatus);
    }

    public function hit(hurt:int):void
    {
      hp -= hurt;
    }

    public function isDead():Boolean
      {
	return hp <= 0;
      }

    public function get name():String
    {
      return _name;
    }

    protected function generalAttack(player:Player, displayableStatus:DisplayableStatus):void
    {
      playerHit = false;

      if(player.position.distanceTo(position) != 1)
	{
	  return;
	}

      if(numberGenerator.getIntInRange(1, 10) <= accuracy)
	{
	  var damage:int = Math.min(numberGenerator.getIntInRange(0, power - 1), 999);

	  // Struggle
	  if(damage == 0 && numberGenerator.getIntInRange(0, 9) == 0)
	    {
	      damage = 1;
	    }

	  if(damage == 0)
	    {
	      missed(displayableStatus);
	      return;
	    }

	  player.hit(damage);
	  displayableStatus.print(damage + " dmg by " + name);
	  playerHit = true;
	}
      else
	{
	  missed(displayableStatus);
	}      
    }

    protected function set maxhp(maxHP:int):void
    {
      this.maxHP = maxHP;
      hp = maxHP;
    }

    private function roam(field:Field, creatures:Array):void
    {
      var xdiff:int = numberGenerator.getIntInRange(-1, 1);
      var ydiff:int = numberGenerator.getIntInRange(-1, 1);
	    
      moveRelative(field, new Point(xdiff, ydiff), creatures);
    }

    private function missed(displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print(name + " missed");
    }
  }
}
