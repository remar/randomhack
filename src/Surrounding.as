package
{
  public class Surrounding
  {
    private var east:TileType;
    private var north:TileType;
    private var west:TileType;
    private var south:TileType;

    public function Surrounding(tiles:Array)
    {
      east = tiles[0];
      north = tiles[1];
      west = tiles[2];
      south = tiles[3];
    }

    public function getEast():TileType
    {
      return east;
    }

    public function getNorth():TileType
    {
      return north;
    }

    public function getWest():TileType
    {
      return west;
    }

    public function getSouth():TileType
    {
      return south;
    }
  }
}
