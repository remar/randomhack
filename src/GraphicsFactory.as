package
{
  public interface GraphicsFactory
  {
    function setLevelType(levelType:LevelType):void;
    function getDrawable():Drawable;
    function getSprite(spriteType:SpriteType):Sprite;
    function getTile(type:TileType, surrounding:Surrounding,
		     numberGenerator:NumberGenerator):Tile;
  }
}
