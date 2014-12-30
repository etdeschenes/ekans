part of ekans;

// Blocks composing the whole board
class boardBlock {
  int x;
  int y;

  boardBlock(int x, int y){
    this.x = x;
    this.y = y;
  }

  bool equity(Object object){
    if(object is boardBlock){
    return object.x == this.x && object.y == this.y;
    }
    return false;
  }

  // Color of the canvas and settings/style
  // Source : https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart:html.CanvasRenderingContext2D
  void clearBoard(){
    ctx.fillStyle = boardColor;
    ctx.fillRect(x*blockSize-1, y*blockSize-1, blockSize+2, blockSize+2);
  }

  void paintObject(String color){
    ctx.fillStyle = color;
    ctx.fillRect(x*blockSize, y*blockSize, blockSize, blockSize);
    ctx.strokeStyle = "";
    ctx.strokeRect(x*blockSize, y*blockSize, blockSize, blockSize);
    ctx.shadowColor = "";
    ctx.shadowOffsetY = 0;
    ctx.shadowBlur = 0;
  }
}
