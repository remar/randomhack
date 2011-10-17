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

    public function attack(player:Player, displayableStatus:DisplayableStatus):void
    {
      forEachEnemy(function (enemy:Enemy):void {enemy.attack(player, displayableStatus);});
    }

    public function removeDeadEnemies(itemController:ItemController,
				      graphicsFactory:GraphicsFactory,
				      displayableStatus:DisplayableStatus):void
    {
      enemies = enemies.filter(function (enemy:Enemy, i:int, a:Array):Boolean
			       {
				 if(enemy.isDead())
				   {
				     enemy.die(itemController,
					       displayableStatus,
					       graphicsFactory);
				   }
				 return enemy.isDead() === false;
			       });
    }

    public function moveEnemies(field:Field, playerPosition:Point, itemController:ItemController):void
    {
      forEachEnemy(function (enemy:Enemy):void {enemy.move(field, playerPosition, enemies, itemController);});
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
