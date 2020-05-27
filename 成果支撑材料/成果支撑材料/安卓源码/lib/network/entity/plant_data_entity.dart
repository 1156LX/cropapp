class PlantDataEntity{

  int innerTem;
  int outsideTem;
  int relativeHum;
  int lightLen;
  double co2;
  int o2;

  PlantDataEntity(this.innerTem, this.outsideTem, this.relativeHum,
      this.lightLen, this.co2, this.o2);


  void printAllData(){
    print('innerTem:$innerTem,outside:$outsideTem,rltHum:$relativeHum,lightLen:$lightLen' +
    'co2:$co2,o2:$o2');
  }

}