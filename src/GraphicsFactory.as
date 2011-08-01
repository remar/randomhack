package
{
  public interface GraphicsFactory
  {
    function setLevelType(levelType:int):void;
    function getDrawable():Drawable;
    function getSprite(spriteType:int):Sprite;
    function getTile(type:TileType, surrounding:Surrounding,
		     numberGenerator:NumberGenerator):Tile;
  }
}
