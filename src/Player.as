package
{
  public class Player extends GameObject
  {
    private var gender:int;
    private var attract:int;

    private var _name:String;
    private var _prefix:String;

    private var HP:int;
    private var maxHP:int;
    private var playerPower:int;
    private var displayableStatus:DisplayableStatus;

    private var _weapon:Weapon;

    private var _poison:int;

    private static const INVENTORY_SIZE:int = 8;
    private var _inventory:Array;

    public function Player(gf:GraphicsFactory, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.PLAYER);

      displayableStatus = ds;
    }

    public function generateCharacter(numberGenerator:NumberGenerator):void
    {
      generateGender(numberGenerator);
      generateNameAndPrefix(numberGenerator);

      var roll:int = numberGenerator.getIntInRange(0, 2);

      maxhp = 14 - roll * 2;

      playerpower = 1 + roll;

      weapon = new BareHands();

      _inventory = new Array(INVENTORY_SIZE);

      displayableStatus.inventory = ["","","","","","","",""];
    }

    private function generateGender(numberGenerator:NumberGenerator):void
    {
      if(numberGenerator.getIntInRange(0, 1) === 0)
	gender = Gender.MALE;
      else
	gender = Gender.FEMALE;

      if(numberGenerator.getIntInRange(0, 3) === 0)
	attract = gender;
      else
	{
	  if(gender === Gender.MALE)
	    attract = Gender.FEMALE;
	  else
	    attract = Gender.MALE;
	}
    }

    private function generateNameAndPrefix(numberGenerator:NumberGenerator):void
    {
      var maleNames:Array = ["Zaia", "Claus", "Zero", "Juno", "Typhoon", "Bart", "Glen",
			     "Jan", "Lancen", "Flip", "Regal", "Zelos", "Kain", "Johns",
			     "Thud", "Go", "Yuka", "Kevin", "Hargar", "Bertil", "Bluefly",
			     "Rain", "Milktoast", "Foon", "Indalecio", "Snipe", "Willy",
			     "Mork", "Wrack", "Oni", "Boggy", "Oscar", "Dave", "Petri",
			     "Tommy", "Chris", "Alastor", "Edvin", "Stephan", "Alex",
			     "Rafael", "Leonardo", "Ridley", "Scorpion", "Ion", "Spadge",
			     "Volehunter", "Icarus", "Pit", "Mike"];
      var femaleNames:Array = ["Shadow", "Viper", "Lucia", "Kaja", "Sonia", "Anki",
			       "Ansaksie", "Angelica", "Sami", "Bertha", "Storm", "Isa",
			       "Lulu", "Crash", "Dawn", "Ursula", "Sei", "Vateilika",
			       "Schala", "Ellen", "Tia", "Precis", "Destina", "Rena",
			       "Raze", "Maze", "Juni", "Estrella", "Petra", "Miney",
			       "Diana", "Liese", "Idun", "April", "Vela", "Chaos",
			       "Leda", "Airan", "Radan", "Nova", "Anna-Lisa", "Hera",
			       "Andromeda", "Seeker", "Zuneia", "Iosa", "Miriam",
			       "Marina", "Nameless", "Fuzzy"];

      if(gender === Gender.MALE)
	_name = maleNames[numberGenerator.getIntInRange(0, maleNames.length - 1)];
      else
	_name = femaleNames[numberGenerator.getIntInRange(0, femaleNames.length - 1)];

      var prefixes:Array = ["Careful", "Dire", "Fat", "Slim", "Old", "Mighty", "Swift",
			    "Stray", "Wimpy", "Hasty", "Lucky", "Dread", "Sharp", "Heavy",
			    "Smart", "Light", "Tall", "Short", "Lonely", "Happy", "Brave",
			    "Crazy", "Odd", "Little", "Mad", "Silent", "Sneaky", "One-eyed",
			    "Fearless", "Pajama"];

      _prefix = prefixes[numberGenerator.getIntInRange(0, prefixes.length - 1)];

      displayableStatus.playername = _name;
      displayableStatus.playerprefix = _prefix;
    }

    public function attack(enemy:Enemy, numberGenerator:NumberGenerator):void
    {
      var damage:int = Math.min(numberGenerator.getIntInRange(0, playerPower + _weapon.power),
				999);

      displayableStatus.print("");

      if(damage == 0)
	{
	  displayableStatus.print("You missed");
	  return;
	}

      enemy.hit(damage);
      displayableStatus.print("You deal " + damage + " dmg");
    }

    public function move(field:Field, delta:Point, objects:Array):void
    {
      moveRelative(field, delta, objects);
      dealPoisonDamage();
    }

    public function hit(hurt:int):void
    {
      hp = Math.max(hp - hurt, 0);
    }

    public function poison(strength:int):void
    {
      if(_poison != 0)
	return;

      if(strength == PoisonType.POISON)
	{
	  displayableStatus.print("You were poisoned!");
	  _poison = strength * strength * 40;
	}
    }

    public function pickUp(item:Item):Boolean
    {
      var freeSpot:int = getFreeSpot();

      if(freeSpot === -1)
	return false;

      _inventory[freeSpot] = item;
      displayableStatus.print("Picked up " + item.name);

      updateInventoryDisplay();

      return true;
    }

    public function isDead():Boolean
    {
      return HP <= 0;
    }

    public function get name():String
    {
      return _name;
    }

    public function get prefix():String
    {
      return _prefix;
    }

    public function set maxhp(maxHP:int):void
    {
      this.maxHP = maxHP;
      hp = maxHP;
      displayableStatus.maxhp = maxhp;
    }

    public function get maxhp():int
    {
      return maxHP;
    }

    public function set hp(HP:int):void
    {
      this.HP = HP;
      displayableStatus.hp = hp;
    }

    public function get hp():int
    {
      return HP;
    }

    public function set playerpower(playerPower:int):void
    {
      this.playerPower = playerPower;
      displayableStatus.playerpower = playerPower;
    }

    public function set weapon(_weapon:Weapon):void
    {
      this._weapon = _weapon;
      displayableStatus.weapon = _weapon.name;
    }

    private function dealPoisonDamage():void
    {
      if(_poison == 0)
	return;

      if(_poison % 10 == 0)
	{
	  hit(1);
	  displayableStatus.print("1 dmg by poison");
	}

      _poison--;

      if(_poison == 0)
	{
	  displayableStatus.print("The poison wears out");
	}
    }

    private function getFreeSpot():int
    {
      var freeSpot:int = -1;

      for(var i:int = 0;i < INVENTORY_SIZE;i++)
	{
	  if(_inventory[i] === undefined)
	    {
	      freeSpot = i;
	      break;
	    }
	}

      return freeSpot;
    }

    private function updateInventoryDisplay():void
    {
      displayableStatus.inventory = _inventory.map(itemToString);
    }

    private function itemToString(item:Item, i:int, a:Array):String
      {
	return item ? item.name : "---";
      } 
  }
}
