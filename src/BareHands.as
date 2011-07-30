package
{
  public class BareHands extends Weapon
  {
    public function BareHands():void
    {
      super(null, SpriteType.EMPTY);
      _name = "Bare hands";
      _power = 0;
    }
  }
}
