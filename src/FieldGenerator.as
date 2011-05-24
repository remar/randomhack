package
{
  public class FieldGenerator
  {
    private var field:Field;

    public function FieldGenerator(field:Field = null):void
    {
      if(field != null)
	{
	  setField(field);
	}
    }

    public function setField(field:Field):void
    {
      this.field = field;
    }

    public function carveHole(p:Point, size:int):void
    {
      for(var j:int = p.getY() - size;j <= p.getY() + size;j++)
	for(var i:int = p.getX() - size;i <= p.getX() + size;i++)
	  field.setTile(i, j, Tile.EMPTY);
    }

    public function createPool(numberGenerator:NumberGenerator):void
    {
      var lines:int = numberGenerator.getIntInRange(3, 8);
      var width:int = numberGenerator.getIntInRange(3, 12);
      var xOffset:int = numberGenerator.getIntInRange(0, field.getWidth()- 1 - width);
      var yOffset:int = numberGenerator.getIntInRange(0, field.getHeight()- 1 - lines);

      for(var y:int = yOffset;y <= yOffset + lines;y++)
	{
	  for(var x:int = xOffset;x <= xOffset + width;x++)
	    {
	      field.setTile(x, y, Tile.WATER);
	    }
	  width += numberGenerator.getIntInRange(-1, 1);
	  xOffset += numberGenerator.getIntInRange(-1, 1);
	}
    }

    public function carvePath(p1:Point, p2:Point, width:int):void
    {
      // Carve horizontal path
      if(p1.getY() == p2.getY())
	{
	  carveSimplePath(p1, p1.getX() < p2.getX() ? [+1, 0] : [-1, 0],
			  Math.abs(p1.getX() - p2.getX()) + 1, width);
	}

      // Carve vertical path
      else if(p1.getX() == p2.getX())
	{
	  carveSimplePath(p1, p1.getY() < p2.getY() ? [0, +1] : [0, -1],
			  Math.abs(p1.getY() - p2.getY()) + 1, width);
	}

      // Carve diagonal path
      else if(Math.abs(p1.getX() - p2.getX())
	      == Math.abs(p1.getY() - p2.getY()))
	{
	  carveSimplePath(p1, [(p2.getX() - p1.getX())
			       /Math.abs(p1.getX() - p2.getX()),
			       (p2.getY() - p1.getY())
			       /Math.abs(p1.getY() - p2.getY())],
			  Math.abs(p1.getX() - p2.getX()) + 1, width);
	}

      // Bresenhams
      else
	{
	  carveBresenhamPath(p1, p2, width);
	}
    }

    private function carveSimplePath(startPoint:Point, direction:Array,
					 length:int, width:int):void
    {
      var x:int = startPoint.getX();
      var y:int = startPoint.getY();

      for(var i:int = 0;i < length;i++)
	{
	  if(width == 1)
	    {
	      field.setTile(x, y, Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath(new Point(x, y),
			      [direction[1] != 0 ? -1 : 0,
			       direction[1] == 0 ? -1 : 0],
			      width, 1);
	    }
	  x += direction[0];
	  y += direction[1];
	}
    }

    private function carveBresenhamPath(startPoint:Point, endPoint:Point,
					width:int):void
    {
      var x:int = startPoint.getX();
      var y:int = startPoint.getY();
      var dx:int = Math.abs(endPoint.getX() - startPoint.getX());
      var dy:int = Math.abs(endPoint.getY() - startPoint.getY());
      var sx:int = startPoint.getX() < endPoint.getX() ? 1 : -1;
      var sy:int = startPoint.getY() < endPoint.getY() ? 1 : -1;
      var err:int = dx - dy;
      var dir:Array = err > 0 ? [0, -1] : [-1, 0];
      while(true)
	{
	  if(width == 1)
	    {
	      field.setTile(x, y, Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath(new Point(x, y), dir, width, 1);
	    }

	  if(x == endPoint.getX() && y == endPoint.getY())
	    {
	      break;
	    }

	  var e2:int = 2*err;
	  if(e2 > -dy)
	    {
	      err -= dy;
	      x += sx;
	    }
	  if(e2 < dx)
	    {
	      err += dx;
	      y += sy;
	    }
	}
    }
  }
}
