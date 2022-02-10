class Repository {
  int counter = 0;

  int loadCounter() => counter;

  void addToCounter() {
    counter = counter + 1;
  }

  void makeCounterZero() {
    counter = 0;
  }
}
