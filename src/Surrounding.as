package
{
  public class Surrounding
  {
    private var _east:TileType;
    private var _north:TileType;
    private var _west:TileType;
    private var _south:TileType;

    public function Surrounding(tiles:Array)
    {
      _east = tiles[0];
      _north = tiles[1];
      _west = tiles[2];
      _south = tiles[3];
    }

    public function get east():TileType
    {
      return _east;
    }

    public function get north():TileType
    {
      return _north;
    }

    public function get west():TileType
    {
      return _west;
    }

    public function get south():TileType
    {
      return _south;
    }
  }
}
