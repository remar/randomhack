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
    }
  }
}
