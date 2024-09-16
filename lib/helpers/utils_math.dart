extension DoubleExtension on double {
  double get roundTo0dot5 {
    if(this == toInt()){
      return this;
    } else if (this <= (toInt() + 0.5)) {
      return toInt() + 0.5;
    } else {
      return toInt() + 1.0;
    }
  }

  double get roundTo0dot1 {
    if (this > (toInt())) {
      return toInt() + 1.0;
    }else{
      return this;
    }
  }

}
