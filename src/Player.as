package
{
  public class Player extends GameObject
  {
    private var gender:int;
    private var attract:int;

    private var name:String;
    private var prefix:String;

    private var HP:int;
    private var maxHP:int;
    private var playerPower:int;
    private var displayableStatus:DisplayableStatus;

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
	name = maleNames[numberGenerator.getIntInRange(0, maleNames.length - 1)];
      else
	name = femaleNames[numberGenerator.getIntInRange(0, femaleNames.length - 1)];

      var prefixes:Array = ["Careful", "Dire", "Fat", "Slim", "Old", "Mighty", "Swift",
			    "Stray", "Wimpy", "Hasty", "Lucky", "Dread", "Sharp", "Heavy",
			    "Smart", "Light", "Tall", "Short", "Lonely", "Happy", "Brave",
			    "Crazy", "Odd", "Little", "Mad", "Silent", "Sneaky", "One-eyed",
			    "Fearless", "Pajama"];

      prefix = prefixes[numberGenerator.getIntInRange(0, prefixes.length - 1)];

      displayableStatus.playername = name;
      displayableStatus.playerprefix = prefix;
    }

    public function attack(enemy:Enemy):void
    {
      enemy.hit(playerPower);
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
  }
}
