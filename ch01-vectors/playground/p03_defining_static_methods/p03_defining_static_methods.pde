// static methods aren`t allowed
// by default in Processing

// see https://stackoverflow.com/questions/44250964/


class MyMath {
  static float add(float a, float b) {
    return 2+a+b;
  }
}

static class MyMath2 {
  static float add(float a, float b) {
    return 2+a+b;
  }
}
