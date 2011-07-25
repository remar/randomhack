package
{
  public class Player extends GameObject
  {
    private var HP:int;
    private var maxHP:int;
    private var playerpower:int;
    private var displayableStatus:DisplayableStatus;

    public function Player(gf:GraphicsFactory, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.PLAYER);

      displayableStatus = ds;
    }

    public function generateCharacter(numberGenerator:NumberGenerator):void
    {
      var roll:int = numberGenerator.getIntInRange(0, 2);

      maxhp = 14 - roll * 2;

      playerpower = 5;
    }

    public function attack(enemy:Enemy):void
    {
      enemy.hit(playerpower);
    }

    public function set maxhp(maxHP:int):void
    {
      this.maxHP = maxHP;
      HP = maxHP;
      displayableStatus.maxhp = maxhp;
      displayableStatus.hp = hp;
    }

    public function get maxhp():int
    {
      return maxHP;
    }

    public function get hp():int
    {
      return HP;
    }
  }
}
