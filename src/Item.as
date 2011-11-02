package
{
  public class Item extends GameObject
  {
    protected var _name:String;

    public function Item(gf:GraphicsFactory, spriteType:SpriteType, name:String):void
    {
      super(gf);
      setSprite(spriteType);
      _name = name;
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
      return undefined;
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

    public function instantUse():Boolean
    {
      return false;
    }
  }
}
