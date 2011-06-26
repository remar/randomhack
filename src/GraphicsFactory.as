package
{
  public interface GraphicsFactory
  {
    function getDrawable():Drawable;
    function getSprite(spriteType:int):Sprite;
    function getTile(type:TileType, surrounding:Surrounding):Tile;
  }
}
