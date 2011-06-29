package
{
  public class FieldInputHandler
  {
    private var tileWidth:int;
    private var tileHeight:int;
    public function FieldInputHandler(tileWidth:int, tileHeight:int):void
    {
      this.tileWidth = tileWidth;
      this.tileHeight = tileHeight;
    }

    public function mousePressRelativeToPlayer(mousePos:Point,
					       playerPos:Point):Point
    {
      if(mousePos.getX() < 0 || mousePos.getY() < 0)
	return new Point(0, 0);

      var xdiff:int = mousePos.getX()/tileWidth - playerPos.getX();
      var ydiff:int = mousePos.getY()/tileHeight - playerPos.getY();

      var angle:Number = Math.atan(-ydiff/Math.abs(xdiff));

      var xComponent:int = 0;
      var yComponent:int = 0;

      if(angle > -Math.PI/3 && angle < Math.PI/3)
	{
	  xComponent = sign(xdiff);
	}
 
      if(angle > Math.PI/6 || angle < -Math.PI/6)
	{
	  yComponent = sign(ydiff);
	}

      return new Point(xComponent, yComponent);
    }

    public function sign(x:int):int
    {
      if (x < 0)
	return -1;
      else
	return 1;
    }
  }
}
