package
{
  public class WaterShade extends Enemy
  {
    public function WaterShade(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf, SpriteType.WATER_SHADE, ng, ds);

      _name = "WaterShade";
      _prefix = "a";
      maxhp = 12;
      power = 4;
      accuracy = 5;
      lookDistance = 4;
      speed = 8;
      // tempid.drop=WATERPOOL;
    }

    override public function attackedWithFire(player:Player, ds:DisplayableStatus):void
    {
      generalAttackedWithFire(player, ds);
    }

    override public function die(itemController:ItemController,
				 displayableStatus:DisplayableStatus,
				 itemFactory:ItemFactory):void
    {
      var pool:Item = itemFactory.getItem(ItemType.WATER_POOL);
      pool.position = position;
      itemController.addItem(pool);

      generalDie(itemController, displayableStatus, itemFactory);
    }
  }
}
