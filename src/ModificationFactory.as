package
{
  public class ModificationFactory
  {
    public static var modifications:Array = null;

    public static function getRandomModification(ng:NumberGenerator):Modification
    {
      setupModifications();

      return modifications[ng.getIntInRange(0, modifications.length - 1)];
    }

    private static function setupModifications():void
    {
      if(modifications != null)
	{
	  return;
	}

      modifications = [];
      var modification:Modification;

      // Blind
      modification = new Modification();
      modification.prefix = "a blind";
      modification.accuracy = new Modifier(2, 5);
      modification.lookDistance = new Modifier(1, 4);
      modifications.push(modification);

      // Crippled
      modification = new Modification();
      modification.prefix = "a crippled";
      modification.maxhp = new Modifier(3, 4);
      modification.power = new Modifier(3, 5);
      modification.accuracy = new Modifier(3, 5);
      modification.speed = new Modifier(1, 2);
      modifications.push(modification);

      // Lesser
      modification = new Modification();
      modification.prefix = "a lesser";
      modification.maxhp = new Modifier(3, 4);
      modification.power = new Modifier(3, 4);
      modifications.push(modification);

      // Drunk
      modification = new Modification();
      modification.prefix = "a drunk";
      modification.accuracy = new Modifier(1, 2);
      modification.lookDistance = new Modifier(3, 4);
      modification.speed = new Modifier(3, 4);
      modifications.push(modification);

      // Swift
      modification = new Modification();
      modification.prefix = "a swift";
      modification.speed = new Modifier(2, 1);
      modifications.push(modification);

      // Dire
      modification = new Modification();
      modification.prefix = "a dire";
      modification.power = new Modifier(5, 4);
      modification.accuracy = new Modifier(5, 4);
      modifications.push(modification);

      // Big eyed
      modification = new Modification();
      modification.prefix = "a bigeyed";
      modification.lookDistance = new Modifier(3, 2);
      modifications.push(modification);

      // Raging
      modification = new Modification();
      modification.prefix = "a raging";
      modification.power = new Modifier(5, 4);
      modification.accuracy = new Modifier(3, 4);
      modification.speed = new Modifier(2, 1);
      modification.lookDistance = new Modifier(3, 2);
      modifications.push(modification);

      // Fat
      modification = new Modification();
      modification.prefix = "a fat";
      modification.maxhp = new Modifier(3, 2);
      modification.speed = new Modifier(3, 4);
      modifications.push(modification);

      // Greater
      modification = new Modification();
      modification.prefix = "a greater";
      modification.maxhp = new Modifier(6, 5);
      modification.power = new Modifier(6, 5);
      modification.speed = new Modifier(6, 5);
      modifications.push(modification);
    }
  }
}
