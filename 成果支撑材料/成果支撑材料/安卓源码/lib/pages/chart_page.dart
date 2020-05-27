import 'package:agri_helper/pages/base_page.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class ChartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _ChartPageState();

}

class _ChartPageState extends BaseState<ChartPage>{

  var measures = Map<String,int>();

  void _onChanged(charts.SelectionModel model){
    setState(() {
      model.selectedDatum.forEach((f){
        measures[f.series.displayName] = (f.datum as GrowthSeriesSales).height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LineChart'),
      ),
      body: Column(
        children: createChildren(),
      ),
    );
  }

  List<Widget> createChildren(){
    List<Widget> children = [
      Container(
        width: double.infinity,
        height: 200,
        child: charts.LineChart(
          createSeries(),
          selectionModels: [
            charts.SelectionModelConfig(
                changedListener: _onChanged
            )
          ],
        ),
      ),
    ];
    measures.forEach((f,v){
      children.add(Text('$f:$v'));
    });
    return children;
  }

  List<charts.Series<GrowthSeriesSales,int>> createSeries(){
    final one = [
      GrowthSeriesSales(0, 0),
      GrowthSeriesSales(10, 1),
      GrowthSeriesSales(30, 2),
      GrowthSeriesSales(50, 3)
    ];
    final two = [
      GrowthSeriesSales(0, 0),
      GrowthSeriesSales(22, 1),
      GrowthSeriesSales(33, 2),
      GrowthSeriesSales(50, 3)
    ];
    return [
      charts.Series<GrowthSeriesSales,int>(
        data: one,
        id: 'one',
        domainFn: (datum,index) => datum.day,
        measureFn: (datum,num) => datum.height
      ),
      charts.Series<GrowthSeriesSales,int>(
          data: two,
          id: 'two',
          domainFn: (datum,index) => datum.day,
          measureFn: (datum,num) => datum.height
      ),
    ];
  }

}

class GrowthSeriesSales{

  int height;
  int day;

  GrowthSeriesSales(this.height,this.day);

}