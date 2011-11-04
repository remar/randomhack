package
{
  public class Sword extends Weapon
  {
    public function Sword(gf:GraphicsFactory)
    {
      super(gf, SpriteType.SWORD);
      _name = "no name";
      _power = 0;
    }

    public function generateNameAndPower(level:int, numberGenerator:NumberGenerator):void
    {
      var swordPrefixes:Array = ["a broken ", "a dull ", "a worn ", "a normal ",
				 "a sharp ", "a fine ", "a perfect "];
      var swordNames:Array = ["Knife", "Dagger", "Sword", "Scimitar", "Falchion",
			      "Longsword", "Duelblade", "Hardedge", "Royalsword", "Magesword",
			      "Masamune", "Razoredge", "Excalibur", "Polestar", "Doom sword"];
      var prefixModifier:Array = [-5, -3, -1, 0, 1, 3, 5];

      var sword:int = Math.min(numberGenerator.getIntInRange(0, int(level/3)),
			       swordNames.length - 1);
      var prefix:int = numberGenerator.getIntInRange(0, swordPrefixes.length - 1);

      _power = Math.max(sword * 2 + prefixModifier[prefix], 1);
      _name = swordPrefixes[prefix] + swordNames[sword];
    }
  }
}
