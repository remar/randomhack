package
{
  public class Consumable extends Item
  {
    protected var _power:int;
    protected var _eaten:Boolean

    public function Consumable(gf:GraphicsFactory, type:SpriteType, name:String):void
    {
      super(gf, type, name);
      _eaten = false;
    }

    public function get power():int
    {
      return _power;
    }

    override public function outOfCharges():Boolean
    {
      return _eaten;
    }

    override public function useItem(player:Player, field:Field,
				     itemController:ItemController,
				     creatureController:CreatureController,
				     displayableStatus:DisplayableStatus):void
    {
      player.eat(this);
      _eaten = true;
    }
  }
}
