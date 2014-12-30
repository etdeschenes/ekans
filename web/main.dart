// Connect Dart with HTML https://www.dartlang.org/docs/tutorials/connect-dart-html/
// Canvas tutorial http://billmill.org/static/canvastutorial/index.html
library ekans;

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'dart:collection';

part 'controls.dart';
part 'ekans.dart';
part 'blocks.dart';

const int snakeSpeed = 70; // Time in milliseconds between each snake movement
const int snakeSize = 3; // Size of the snake at the launch of the game
const int boardSizeX = 60; // Number of block on the X axis for the game board
const int boardSizeY = 30; // Number of block on the Y axis for the game board
const int blockSize = 23; //Size of a single block that compose the entire board

const String snakeColor = "#022400"; // Color of the snake canvas
const String foodColor = "#9FE69B"; // Color of the food canvas
const String boardColor="#338A2E"; // The background color of the board canvas

void main() {
  // Initialising the size of the board and the background color with canvas
  // Source : https://api.dartlang.org/apidocs/channels/dev/dartdoc-viewer/dart:html.CanvasElement
  canvas.width=boardSizeX*blockSize;
  canvas.height=boardSizeY*blockSize;
  ctx.fillStyle = boardColor;
  ctx.fillRect(0, 0, boardSizeX*blockSize, boardSizeY*blockSize);

  snake = new Snake(snakeSize);
  snakeDirection = Direction.RIGHT;

  movementDelay();
  controlInput();
  newFood();
}

// How much time between each snake's movement
//Source : https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:async.Timer
void movementDelay(){
  void snakeMovement(Timer timer){
  bool moved = true;
  switch (snakeDirection) {
    case Direction.RIGHT:
    moved = snake.rightMovement(); break;
    case Direction.LEFT:
    moved = snake.leftMovement(); break;
    case Direction.UP:
    moved = snake.upMovement(); break;
    case Direction.DOWN:
    moved = snake.downMovement(); break;
  }
  if(!moved){ timer.cancel(); }
  }
  timer = new Timer.periodic(const Duration(milliseconds: snakeSpeed), snakeMovement);
}

// Food will appear randomly on the board
// Source : http://shailen.github.io/blog/2012/12/10/random-dart-nextbool-nextint-and-nextdouble/
void newFood(){
  int x = randomGenerator.nextInt(boardSizeX); // Random generation on the X axis
  int y = randomGenerator.nextInt(boardSizeY); // Random generation on the Y axis
  food = new boardBlock(x, y); // Food spawns on a new block of the board
  food.paintObject(foodColor);
}

// This is to avoid reverse gearing while controlling the snake (the player can't move backwards, only forward)
// Source : https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/dart:html.KeyboardEvent
void controlInput(){
  void keyPress(Direction direction, Direction opposite){
  if(snakeDirection != opposite)
  snakeDirection = direction;
  }

 // This will detect a direction assigned to an arrow key and its opposite direction. It is part of the process to avoid reverse gearing.
 void keysListener(Event event){
  if(event is KeyboardEvent){
    KeyboardEvent kEvent = event;
    switch(kEvent.keyCode){
      case KeyCode.UP:
      keyPress(Direction.UP, Direction.DOWN); break;
      case KeyCode.DOWN:
      keyPress(Direction.DOWN, Direction.UP); break;
      case KeyCode.LEFT:
      keyPress(Direction.LEFT, Direction.RIGHT); break;
      case KeyCode.RIGHT:
      keyPress(Direction.RIGHT, Direction.LEFT); break;
    }
  }
  }
  window.onKeyDown.listen(keysListener);
}

// Initialize game elements and board
boardBlock food;
Snake snake;
Direction snakeDirection;
Random randomGenerator = new Random();
Timer timer;

// To query HTML5 canvas object
// Source : https://api.dartlang.org/apidocs/channels/be/dartdoc-viewer/dart:html.CanvasRenderingContext2D
CanvasElement canvas = query("canvas");
CanvasRenderingContext2D ctx = canvas.context2D;