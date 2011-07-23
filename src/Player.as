package
{
  public class Player extends GameObject
  {
    private var playerpower:int;

    public function Player(gf:GraphicsFactory, position:Point):void
    {
      super(gf, SpriteType.PLAYER);
      this.position = position;

      playerpower = 5;
    }

    public function attack(enemy:Enemy):void
    {
      enemy.hit(playerpower);
    }
  }
}
