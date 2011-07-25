package
{
  public class CreatureController
  {
    private var enemies:Array;

    public function CreatureController()
    {
      enemies = [];
    }

    public function addEnemy(enemy:Enemy):void
    {
      enemies.push(enemy);
    }

    public function getEnemies():Array
    {
      return enemies;
    }

    public function drawEnemies(drawable:Drawable):void
    {
      forEachEnemy(function (enemy:Enemy):void {enemy.draw(drawable);});
    }

    public function removeDeadEnemies(objects:Array, graphicsFactory:GraphicsFactory):void
    {
      enemies = enemies.filter(function (enemy:Enemy, i:int, a:Array):Boolean
			       {
				 if(enemy.isDead())
				   objects.push(new Blood(graphicsFactory, enemy.position));
				 return enemy.isDead() === false;
			       });
    }

    public function moveEnemies(field:Field, playerPosition:Point):void
    {
      forEachEnemy(function (enemy:Enemy):void {enemy.move(field, playerPosition, enemies);});
    }

    public function getEnemyAtPosition(position:Point):Enemy
    {
      var enemy:Enemy = null;

      var fun:Function = function (e:Enemy):void { if(e.position.equals(position)) enemy = e;};

      forEachEnemy(fun);

      return enemy;
    }

    private function forEachEnemy(fun:Function):void
    {
      enemies.forEach(function (enemy:Enemy, i:int, a:Array):void {fun(enemy);});
    }    
  }
}
