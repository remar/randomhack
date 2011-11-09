package
{
  public class Mimic extends Enemy
  {
    public function Mimic(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.EMPTY, ng, ds);

      _name = "Mimic";
      maxhp = 10;
      power = 5;
      accuracy = 5;
      lookDistance = 2;
      speed = 2;

      setRandomSprite();
    }

    override public function die(itemController:ItemController,
				 displayableStatus:DisplayableStatus,
				 itemFactory:ItemFactory):void
    {
      var gold:Item = itemFactory.getItem(ItemType.GOLD);
      gold.position = position;
      itemController.addItem(gold);

      generalDie(itemController, displayableStatus, itemFactory);
    }


    private function setRandomSprite():void
    {
      var sprites:Array = [SpriteType.BITTER_BERRIES,
			   SpriteType.SWORD,
			   SpriteType.SWEET_BERRIES,
			   SpriteType.BOTTLE,
			   SpriteType.TORCH];
			   // SpriteType.pick,
			   // SpriteType.amulet,
			   // SpriteType.scroll,
			   // SpriteType.hid,
			   // SpriteType.key,
			   // SpriteType.chest,
			   // SpriteType.ankh,
			   // SpriteType.blackcard,
			   // SpriteType.blackarmor,
      setSprite(sprites[numberGenerator.getIntInRange(0, sprites.length - 1)]);
    }
  }
}
