import 'dart:math';

import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VisibleGrowthPage extends StatefulWidget{

  final String url;

  VisibleGrowthPage(this.url);

  @override
  State<StatefulWidget> createState() {
    return _VisibleGrowthPageState();
  }

}

class _VisibleGrowthPageState extends BaseState<VisibleGrowthPage>{

  var measures = Map<String,int>();
  final List<GrowthSeriesSales> temp = [];
  final List<GrowthSeriesSales> height = [];
  final List<GrowthSeriesSales> hum = [];

  void _onChanged(charts.SelectionModel model){
    setState(() {
      model.selectedDatum.forEach((f){
        measures[f.series.displayName] = (f.datum as GrowthSeriesSales).height;
      });
    });
  }

  void _initData(){
    var random = Random();
    for(int i = 1; i < 31; i++){
      temp.add(GrowthSeriesSales(random.nextInt(9) + 22, i));
      height.add(GrowthSeriesSales(random.nextInt(120) + 30 , i));
      hum.add(GrowthSeriesSales(random.nextInt(30) + 30, i));
    }
  }


  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可视化生长'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16,right: 16,top: 16),
          child: Column(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'images/pic_news_place_holder.png',
                image: widget.url,
                fit: BoxFit.fill,
                height: 180,
                width: double.infinity,
              ),
              Container(
                width: double.infinity,
                height: 250,
                margin: EdgeInsets.all(16),
                child: Container(
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
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _createChildren(),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _createChildren(){
    List<Widget> children = [];
    measures.forEach((k,v) => children.add(Text('$k:$v')));
    return children;
  }

  List<charts.Series<GrowthSeriesSales,int>> createSeries(){
    return [
      charts.Series<GrowthSeriesSales,int>(
          data: temp,
          id: '温度',
          domainFn: (datum,index) => datum.day,
          measureFn: (datum,num) => datum.height
      ),
      charts.Series<GrowthSeriesSales,int>(
          data: height,
          id: '高度',
          domainFn: (datum,index) => datum.day,
          measureFn: (datum,num) => datum.height
      ),
      charts.Series<GrowthSeriesSales,int>(
          data: hum,
          id: '湿度',
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