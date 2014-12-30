part of ekans;

// Source : https://plus.google.com/+BrandonDonnelson/posts/2EbfCD1MrBz
class Snake {
  var queue = new Queue<boardBlock>();

  Snake(int snakeInitialSize){
    int x = 10;
    int y = 10; // Start at the top
    for(int i=0; i<snakeInitialSize; i++){
      boardBlock block = new boardBlock(x, y);
      block.paintObject(snakeColor);
      queue.add(block);
    }
  }

  // The game stops if there is a collision
  bool collision(boardBlock head){
    for(boardBlock block in queue){
      if(block.equity(head))
      return true;
    }
    return false;
  }

  // Growing snake, the food becomes the new head. Checking collision with food and be sure its not a wall
  bool eatFood(Function wallCollision, Function foodEaten){
    boardBlock beforeEating = queue.last;
    if(wallCollision(beforeEating)){ return false; }
    boardBlock afterEating = foodEaten(beforeEating);
    bool noCollision = !collision(afterEating);
    if(noCollision){
      afterEating.paintObject(snakeColor);
      queue.add(afterEating);
      if(!afterEating.equity(food)){
        boardBlock tail = queue.removeFirst();
        tail.clearBoard();
      } else {
        newFood();
      }
    }
    return noCollision;
  }

  // When the right movement key is pressed (is true), the X position changes +1
  // Here we consider (0,0) being the top left of the game board
  bool rightMovement(){
    var wallCollision = (boardBlock head){ return head.x == boardSizeX-1; };
    var foodEaten = (boardBlock beforeEating){
      int snakeXPosition = beforeEating.x+1;
      int snakeYPosition = beforeEating.y;
      return new boardBlock(snakeXPosition, snakeYPosition);
    };
    return eatFood(wallCollision, foodEaten);
  }

  // When the up movement key is pressed (is true), the Y position changes -1
  bool upMovement(){
    var wallCollision = (boardBlock head){ return head.y == 0; };
    var foodEaten = (boardBlock beforeEating){
      int snakeXPosition = beforeEating.x;
      int snakeYPosition = beforeEating.y-1;
      return new boardBlock(snakeXPosition, snakeYPosition);
    };
    return eatFood(wallCollision, foodEaten);
  }

  // When the left movement key is pressed (is true), the X position changes -1
  bool leftMovement(){
    var wallCollision = (boardBlock head){ return head.x == 0; };
    var foodEaten = (boardBlock beforeEating){
      int snakeXPosition = beforeEating.x-1;
      int snakeYPosition = beforeEating.y;
      return new boardBlock(snakeXPosition, snakeYPosition);
    };
    return eatFood(wallCollision, foodEaten);
  }

  // When the down movement key is pressed (is true), the Y position changes +1
  bool downMovement(){
    var wallCollision = (boardBlock head){ return head.y == boardSizeY-1; };
    var foodEaten = (boardBlock beforeEating){
      int snakeXPosition = beforeEating.x;
      int snakeYPosition = beforeEating.y+1;
      return new boardBlock(snakeXPosition, snakeYPosition);
    };
    return eatFood(wallCollision, foodEaten);
  }
}