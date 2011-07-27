package
{
  public class FieldCarver
  {
    private var field:Field;

    public function FieldCarver(field:Field = null):void
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
      for(var j:int = p.y - size;j <= p.y + size;j++)
	for(var i:int = p.x - size;i <= p.x + size;i++)
	  field.setTile(new Point(i, j), TileType.EMPTY);
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
	      field.setTile(new Point(x, y), TileType.WATER);
	    }
	  width += numberGenerator.getIntInRange(-1, 1);
	  xOffset += numberGenerator.getIntInRange(-1, 1);
	}
    }

    public function carvePath(p1:Point, p2:Point, width:int):void
    {
      // Carve horizontal path
      if(p1.y == p2.y)
	{
	  carveSimplePath(p1, p1.x < p2.x ? [+1, 0] : [-1, 0],
			  Math.abs(p1.x - p2.x) + 1, width);
	}

      // Carve vertical path
      else if(p1.x == p2.x)
	{
	  carveSimplePath(p1, p1.y < p2.y ? [0, +1] : [0, -1],
			  Math.abs(p1.y - p2.y) + 1, width);
	}

      // Carve diagonal path
      else if(Math.abs(p1.x - p2.x)
	      == Math.abs(p1.y - p2.y))
	{
	  carveSimplePath(p1, [(p2.x - p1.x)
			       /Math.abs(p1.x - p2.x),
			       (p2.y - p1.y)
			       /Math.abs(p1.y - p2.y)],
			  Math.abs(p1.x - p2.x) + 1, width);
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
      var x:int = startPoint.x;
      var y:int = startPoint.y;

      for(var i:int = 0;i < length;i++)
	{
	  if(width == 1)
	    {
	      field.setTile(new Point(x, y), TileType.EMPTY);
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
      var current:Point = startPoint;
      var dx:int = Math.abs(endPoint.x - startPoint.x);
      var dy:int = Math.abs(endPoint.y - startPoint.y);
      var sx:Point = startPoint.x < endPoint.x ? new Point(1, 0) : new Point(-1, 0);
      var sy:Point = startPoint.y < endPoint.y ? new Point(0, 1) : new Point(0, -1);
      var err:int = dx - dy;
      var dir:Array = err > 0 ? [0, -1] : [-1, 0];
      while(true)
	{
	  if(width == 1)
	    {
	      field.setTile(current, TileType.EMPTY);
	    }
	  else
	    {
	      carveSimplePath(current, dir, width, 1);
	    }

	  if(current.x == endPoint.x && current.y == endPoint.y)
	    {
	      break;
	    }

	  var e2:int = 2*err;
	  if(e2 > -dy)
	    {
	      err -= dy;
	      current = current.add(sx);
	    }
	  if(e2 < dx)
	    {
	      err += dx;
	      current = current.add(sy);
	    }
	}
    }
  }
}
