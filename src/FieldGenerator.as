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

    public function carveHole(x:int, y:int, size:int):void
    {
      for(var j:int = y - size;j <= y + size;j++)
	for(var i:int = x - size;i <= x + size;i++)
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

    public function carvePath(p1:Array, p2:Array, width:int):void
    {
      // Carve horizontal path
      if(p1[1] == p2[1])
	{
	  carveSimplePath(p1, p1[0] < p2[0] ? [+1, 0] : [-1, 0],
			  Math.abs(p1[0] - p2[0]) + 1, width);
	}

      // Carve vertical path
      else if(p1[0] == p2[0])
	{
	  carveSimplePath(p1, p1[1] < p2[1] ? [0, +1] : [0, -1],
			  Math.abs(p1[1] - p2[1]) + 1, width);
	}

      // Carve diagonal path
      else if(Math.abs(p1[0] - p2[0]) == Math.abs(p1[1] - p2[1]))
	{
	  carveSimplePath(p1, [(p2[0] - p1[0])/Math.abs(p1[0] - p2[0]),
			       (p2[1] - p1[1])/Math.abs(p1[1] - p2[1])],
			  Math.abs(p1[0] - p2[0]) + 1, width);
	}

      // Bresenhams
      else
	{
	  carveBresenhamPath(p1, p2, width);
	}
    }

    private function carveSimplePath(startPoint:Array, direction:Array,
					 length:int, width:int):void
    {
      var x:int = startPoint[0];
      var y:int = startPoint[1];

      for(var i:int = 0;i < length;i++)
	{
	  if(width == 1)
	    {
	      field.setTile(x, y, Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath([x, y],
			      [direction[1] != 0 ? -1 : 0,
			       direction[1] == 0 ? -1 : 0],
			      width, 1);
	    }
	  x += direction[0];
	  y += direction[1];
	}
    }

    private function carveBresenhamPath(startPoint:Array, endPoint:Array,
					width:int):void
    {
      var dx:int = Math.abs(endPoint[0] - startPoint[0]);
      var dy:int = Math.abs(endPoint[1] - startPoint[1]);
      var sx:int = startPoint[0] < endPoint[0] ? 1 : -1;
      var sy:int = startPoint[1] < endPoint[1] ? 1 : -1;
      var err:int = dx - dy;
      var dir:Array = err > 0 ? [0, -1] : [-1, 0];
      while(true)
	{
	  if(width == 1)
	    {
	      field.setTile(startPoint[0], startPoint[1], Tile.EMPTY);
	    }
	  else
	    {
	      carveSimplePath(startPoint, dir, width, 1);
	    }

	  if(startPoint[0] == endPoint[0] && startPoint[1] == endPoint[1])
	    {
	      break;
	    }

	  var e2:int = 2*err;
	  if(e2 > -dy)
	    {
	      err -= dy;
	      startPoint[0] += sx;
	    }
	  if(e2 < dx)
	    {
	      err += dx;
	      startPoint[1] += sy;
	    }
	}
    }
  }
}
