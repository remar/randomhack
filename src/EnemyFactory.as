package
{
  public class EnemyFactory
  {
    private var enemyClasses:Array = [Bat, Flea, Snake, Goblin, Mingbat, Undead, Mimic];

    public function getEnemy(level:int,
			     graphicsFactory:GraphicsFactory,
			     numberGenerator:NumberGenerator,
			     displayableStatus:DisplayableStatus):Enemy
    {
      var limit:int = Math.min((level * 5) / 3 + 2, enemyClasses.length - 1);
      var randomEnemy:int = numberGenerator.getIntInRange(0, limit);
      return new enemyClasses[randomEnemy](graphicsFactory, numberGenerator, displayableStatus);
    }
  }
}
