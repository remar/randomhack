package
{
  public class CreatureController
  {
    private var enemies:Array;
    private var itemFactory:ItemFactory;

    public function CreatureController(itemFactory:ItemFactory)
    {
      enemies = [];
      this.itemFactory = itemFactory;
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

    public function attack(player:Player):void
    {
      forEachEnemy(function (enemy:Enemy):void {enemy.attack(player);});
    }

    public function removeDeadEnemies(itemController:ItemController,
				      displayableStatus:DisplayableStatus):void
    {
      enemies = enemies.filter(function (enemy:Enemy, i:int, a:Array):Boolean
			       {
				 if(enemy.isDead())
				   {
				     enemy.die(itemController,
					       displayableStatus,
					       itemFactory);
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

    public function getFearLevelAtPosition(position:Point):FearType
    {
      var fearType:FearType = FearType.NO_FEAR;

      for(var y:int = -2;y <= 2;y++)
	{
	  for(var x:int = -2;x <= 2;x++)
	    {
	      var enemy:Enemy = getEnemyAtPosition(position.add(new Point(x, y)));
	      if(enemy && enemy.causesFear && enemy.fearType.Index > fearType.Index)
		{
		  fearType = enemy.fearType;
		}
	    }
	}

      return fearType;
    }

    public function harmFireWeakCreatures(player:Player, displayableStatus:DisplayableStatus):void
    {
      for(var y:int = -1;y <= 1;y++)
	{
	  for(var x:int = -1;x <= 1;x++)
	    {
	      var enemy:Enemy = getEnemyAtPosition(player.position.add(new Point(x, y)));
	      if(enemy)
		{
		  enemy.attackedWithFire(player, displayableStatus);
		}
	    }
	}
    }

    private function forEachEnemy(fun:Function):void
    {
      enemies.forEach(function (enemy:Enemy, i:int, a:Array):void {fun(enemy);});
    }    
  }
}
