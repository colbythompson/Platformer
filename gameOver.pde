void gameOver() {
  background(skyBlue);
  endAnimation.show();
  fill(black);
  textSize(80);
  text("GAMEOVER", width/2, height*1/4);
  playAgainButton();
}

void playAgainButton() { //initiates restart of game
  playAgain.show();
  if (playAgain.clicked) {
    mode = PLAY;
    lives = lifeNum;
    reset();
  }
}
