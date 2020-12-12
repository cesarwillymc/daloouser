import 'dart:math';

int convertColorHex(String color){
  return int.parse(color.replaceAll('#', '0xff'));
}
int random(min, max){
  var rn = new Random();
  return min + rn.nextInt(max - min);
}
double randomDouble(min, max){
  var rn = new Random();
  return min + rn.nextDouble() +  rn.nextInt(max - min);
}