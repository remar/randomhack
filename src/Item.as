package
{
  public class Item extends GameObject
  {
    protected var _name:String;
    protected var graphicsFactory:GraphicsFactory;

    public function Item(gf:GraphicsFactory, spriteType:SpriteType, name:String):void
    {
      super(gf, spriteType);
      _name = name;
      graphicsFactory = gf;
    }

    public function get name():String
    {
      return _name;
    }

    public function useItem(player:Player, field:Field, itemController:ItemController,
			    creatureController:CreatureController,
			    displayableStatus:DisplayableStatus):void
    {
      displayableStatus.print("You can't use this here");      
    }

    public function outOfCharges():Boolean
    {
      return false;
    }

    public function transformItem():Item
    {
      return new Item(graphicsFactory, SpriteType.EMPTY, _name);
    }

    public function needBottleToCarry():Boolean
    {
      return false;
    }

    public function dropOnTopAllowed():Boolean
    {
      return true;
    }

    public function canBeCarriedByEnemy():Boolean
    {
      return true;
    }

    public function isModified():Boolean
    {
      return false;
    }
  }
}
