package
{
  public interface GraphicsFactory
  {
    function setLevelType(levelType:int):void;
    function getDrawable():Drawable;
    function getSprite(spriteType:SpriteType):Sprite;
    function getTile(type:TileType, surrounding:Surrounding,
		     numberGenerator:NumberGenerator):Tile;
  }
}
