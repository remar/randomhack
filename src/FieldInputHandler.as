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

      // if it's further along one axis than the other, move in that
      // direcion, otherwise the other

      var xdiff:int = mousePos.getX()/tileWidth - playerPos.getX();
      var ydiff:int = mousePos.getY()/tileHeight - playerPos.getY();

      if(Math.abs(xdiff) > Math.abs(ydiff))
	{
	  return new Point(xdiff / Math.abs(xdiff), 0);
	}
      else
	{
	  return new Point(0, ydiff / Math.abs(ydiff));	  
	}
    }
  }
}
