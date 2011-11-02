package
{
  public class Creature extends GameObject
  {
    // Find similarities in Player and Enemy, move here.
    protected var numberGenerator:NumberGenerator;
    protected var displayableStatus:DisplayableStatus;

    protected var creatureHit:Boolean;
    protected var _power:int;
    protected var accuracy:int;

    protected var _name:String;

    protected var _hp:int;
    protected var _maxhp:int;

    public function Creature(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf);
      numberGenerator = ng;
      displayableStatus = ds;
    }

    public function hit(hurt:int):void
    {
      hp -= hurt;
    }

    public function set hp(_hp:int):void
    {
      this._hp = Math.min(_maxhp, _hp);

      hpSet();
    }

    public function get hp():int
    {
      return _hp;
    }

    public function set maxhp(_maxhp:int):void
    {
      this._maxhp = _maxhp;
      hp = _maxhp;
      maxhpSet();
    }

    public function get maxhp():int
    {
      return _maxhp;
    }

    public function isDead():Boolean
    {
      return hp <= 0;
    }

    protected function hpSet():void
    {
      // Override in subclass
    }

    protected function maxhpSet():void
    {
      // Override in subclass
    }

    public function moveRelative(field:Field, delta:Point, objects:Array):void
    {
      if(field.getTile(position.add(delta)) != TileType.EMPTY)
	{
	  return;
	}

      var newPosition:Point = position.add(delta);

      var test:Function = function (object:GameObject, i:int, a:Array):Boolean
	                  {
			    return object.position.equals(newPosition);
			  };

      if(!objects.some(test))
	{
	  position = position.add(delta);
	}
    }

    protected function generalAttack(creature:Creature):void
    {
      creatureHit = false;

      if(creature.position.distanceTo(position) != 1)
	{
	  return;
	}

      if(hitsCreature())
	{
	  var damage:int = Math.min(numberGenerator.getIntInRange(0, attackPower - 1), 999);

	  // Struggle
	  if(damage == 0 && struggle())
	    {
	      damage = 1;
	    }

	  if(damage == 0)
	    {
	      missed();
	      return;
	    }

	  creature.hit(damage);
	  displayDamageMessage(damage);
	  creatureHit = true;
	}
      else
	{
	  missed();
	}      
    }

    protected function missed():void
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

    protected function set power(_power:int):void
    {
      this._power = _power;
    }

    protected function get attackPower():int
    {
      return _power;
    }

    protected function hitsCreature():Boolean
    {
      return true;
    }

    protected function struggle():Boolean
    {
      return false;
    }
  }
}
