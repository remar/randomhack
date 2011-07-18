package
{
  public class Player extends GameObject
  {
    private var field:Field;
    private var sprite:Sprite;

    public function Player(gf:GraphicsFactory, field:Field, position:Point):void
    {
      this.field = field;
      super(gf, SpriteType.PLAYER);
      this.position = position;
    }

      public function move(delta:Point, enemies:Array):void
      {
	  var newPosition:Point = position.add(delta);

	  var test:Function = function (enemy:Enemy, i:int, a:Array):Boolean
	      {
		  return enemy.position.equals(newPosition);
	      };

	  if(!enemies.some(test))
	      {
		  moveRelative(field, delta);
	      }
      }
  }
}
