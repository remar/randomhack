package
{
  public class Creature extends GameObject
  {
    // Find similarities in Player and Enemy, move here.
    private var numberGenerator:NumberGenerator;
    protected var displayableStatus:DisplayableStatus;

    public function Creature(gf:GraphicsFactory, ng:NumberGenerator, ds:DisplayableStatus):void
    {
      super(gf);
      numberGenerator = ng;
      displayableStatus = ds;
    }
  }
}
