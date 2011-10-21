package
{
  public class Undead extends Enemy
  {
    public function Undead(gf:GraphicsFactory, ng:NumberGenerator):void
    {
      super(gf, SpriteType.UNDEAD, ng);
    }

    override public function get causesFear():Boolean
    {
      return true;
    }

    override public function get fearType():FearType
    {
      return FearType.FEAR;
    }
  }
}
