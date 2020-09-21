class GlobalState {
  int _myNumber = 0;

  int get getNumber => _myNumber;

  void addNumber() {
    _myNumber++;
    print(_myNumber);
  }
}
