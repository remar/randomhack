package
{
  public interface GraphicsFactory
  {
    function getDrawable():Drawable;
    function getSprite(type:SpriteType):Sprite;
    function getTile(type:TileType, surrounding:Surrounding):Tile;
  }
}
