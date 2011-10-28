package
{
  public class Creature extends GameObject
  {
    // Find similarities in Player and Enemy, move here.
    protected var numberGenerator:NumberGenerator;
    protected var displayableStatus:DisplayableStatus;

    protected var creatureHit:Boolean;
    protected var power:int;
    protected var accuracy:int;

    protected var _name:String;

    public function Creature(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf);
      numberGenerator = ng;
      displayableStatus = ds;
    }

    public function hit(hurt:int):void
    {
      
    }

    protected function generalAttack(creature:Creature, displayableStatus:DisplayableStatus):void
    {
      creatureHit = false;

      if(creature.position.distanceTo(position) != 1)
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

	  creature.hit(damage);
	  displayDamageMessage(damage);
	  creatureHit = true;
	}
      else
	{
	  missed(displayableStatus);
	}      
    }

    protected function missed(displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print("Missed!");
    }

    public function get name():String
    {
      return _name;
    }

    protected function displayDamageMessage(damage:int):void
    {
      displayableStatus.print(damage + " dmg by " + name);
    }
  }
}
