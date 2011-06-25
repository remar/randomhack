package
{
  public class Field
  {
    private var width:int;
    private var height:int;

    private var field:Array;

    public function Field(width:int, height:int):void
    {
      this.width = width;
      this.height = height;
      clearField(TileType.BLOCK);
    }

    public function getWidth():int
    {
      return width;
    }

    public function getHeight():int
    {
      return height;
    }

    public function clearField(type:int):void
    {
      field = new Array(width);
      for(var x:int = 0;x < width;x++)
	{
	  field[x] = new Array(height);
	  for(var y:int = 0;y < height;y++)
	    {
	      setTile(x, y, type);
	    }
	}
    }

    public function setTile(x:int, y:int, type:int):void
    {
      if ((x < 0 || x >= width || y < 0 || y >= width) ||
	  (type == TileType.EMPTY && (x == 0 || x == width - 1 ||
				  y == 0 || y == height - 1)))
	{
	  return;
	}

      field[x][y] = [new TileType(type), null];
    }

    public function getTile(x:int, y:int):TileType
      {
	return field[x][y][0];
      }

    public function renderBackgroundTiles(graphicsFactory:GraphicsFactory):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      field[x][y][1] = graphicsFactory.getTile(field[x][y][0],
						       getSurrounding(x, y));
	    }
	}      
    }

    public function draw(drawable:Drawable):void
    {
      for(var y:int = 0;y < height;y++)
	{
	  for(var x:int = 0;x < width;x++)
	    {
	      var tile:Tile = field[x][y][1];
	      drawable.drawTile(tile, new Point(x * tile.getWidth(),
						y * tile.getHeight()));
	    }
	}
    }

    private function getSurrounding(x:int, y:int):Surrounding
    {
      var east:TileType = x + 1 < width ? field[x + 1][y][0] : new TileType(TileType.BLOCK);
      var north:TileType = y - 1 >= 0 ? field[x][y - 1][0] : new TileType(TileType.BLOCK);
      var west:TileType = x - 1 >= 0 ? field[x - 1][y][0] : new TileType(TileType.BLOCK);
      var south:TileType = y + 1 < height ? field[x][y + 1][0] : new TileType(TileType.BLOCK);
      return new Surrounding([east, north, west, south]);
    }
  }
}
