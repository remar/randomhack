package
{
  public class Weapon extends Item
  {
    protected var _power:int;

    public function Weapon(gf:GraphicsFactory, spriteType:int):void
    {
      super(gf, spriteType, "Weapon");
    }

    public function get power():int
    {
      return _power;
    }
  }
}
