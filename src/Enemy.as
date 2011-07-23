package
{
  public class Enemy extends GameObject
  {
    private var numberGenerator:NumberGenerator;

    protected var lookDistance:int;
    protected var speed:int;
    protected var maxHP:int;
    protected var hp:int;

    public function Enemy(gf:GraphicsFactory, spriteType:int,
			  numberGenerator:NumberGenerator):void
    {
      super(gf, spriteType);
      this.numberGenerator = numberGenerator;

      lookDistance = 5;
      speed = 5;
      maxhp = 5;
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

    public function attack(player:Player):void
    {

    }

    public function hit(hurt:int):void
    {
      hp -= hurt;
    }

    public function isDead():Boolean
      {
	return hp <= 0;
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
  }
}
