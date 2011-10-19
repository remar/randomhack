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

    private var inventory:Inventory;

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

      inventory = new Inventory(displayableStatus);
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

    public function poison(poisonType:PoisonType):void
    {
      if(_poison != 0)
	return;

      var strength:int = [1, 2, 3][poisonType.Index];

      if(poisonType == PoisonType.POISON)
	{
	  displayableStatus.print("You were poisoned!");
	  _poison = strength * strength * 40;
	}
    }

    public function pickUp(item:Item):Boolean
    {
      if(item.needBottleToCarry())
	{
	  displayableStatus.print("Use a bottle to carry that");
	  return false;	  
	}

      if(inventory.full())
	{
	  displayableStatus.print("No room in inventory");
	  return false;
	}

      inventory.addItem(item);

      return true;
    }

    public function drop(itemController:ItemController):Item
    {
      var itemUnder:Item = itemController.getItemAtPosition(position);
      if(itemUnder && itemUnder.dropOnTopAllowed() == false)
	{
	  displayableStatus.print("There's no room to drop it");
	  return undefined;
	}

      var item:Item = inventory.removeSelectedItem();

      if(item)
	{
	  item.position = position;
	}
      else
	{
	  displayableStatus.print("Nothing to drop in this slot");
	}

      displayableStatus.print("Dropped " + item.name);
      return item;
    }

    public function useItem(field:Field, itemController:ItemController,
			    creatureController:CreatureController):void
    {
      var item:Item = inventory.getSelectedItem();
      if(item)
	{
	  item.useItem(this, field, itemController, creatureController, displayableStatus);
	  if(item.outOfCharges())
	    {
	      inventory.transformSelectedItem();
	    }
	  else if(item.isModified())
	    {
	      inventory.itemInInventoryIsModified();
	    }
	}
      else
	{
	  displayableStatus.print("No item to use in this slot");
	}
    }

    public function selectNextSlot():void
    {
      inventory.selectNextSlot();
    }

    public function selectPreviousSlot():void
    {
      inventory.selectPreviousSlot();
    }

    public function transformItems(transformer:Function):void
    {
      inventory.transformItems(transformer);
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
  }
}
