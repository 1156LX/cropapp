
import 'dart:convert';
import 'dart:math';

import 'package:agri_helper/network/entity/crop_entity.dart';
import 'package:agri_helper/network/entity/plant_data_entity.dart';
import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/add_crop_page.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../manage_method_page.dart';

class MainFragment extends StatefulWidget{

  final List<Data> crops = [];

  MainFragment(List<Data> list){
    crops.clear();
    crops.addAll(list);
  }

  @override
  State<StatefulWidget> createState() {
    return _MainFragmentState();
  }
}

class _MainFragmentState extends BaseState<MainFragment> with AutomaticKeepAliveClientMixin<MainFragment>{

  int _internalTem = 0;
  int _outsideTem = 0;
  int _relativeHum = 0;
  int _lightValue = 0;
  double _co2Value = 0;
  int _o2Value = 0;

  TextStyle _dataTextStyle = TextStyle(
      fontSize: 20,
      color: Colors.black54,
      fontWeight: FontWeight.w300
  );

  List<PlantDataEntity> plantData = [];

  void _skipToManagerMethod(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ManageMethodPage(
          _internalTem < 30,_lightValue < 2000,_relativeHum > 35)
    ));
  }

  void _onSelectPage(index){
    setState(() {
      _internalTem = plantData[index].innerTem;
      _outsideTem = plantData[index].outsideTem;
      _relativeHum = plantData[index].relativeHum;
      _lightValue = plantData[index].lightLen;
      _co2Value = plantData[index].co2;
      _o2Value = plantData[index].o2;
    });
  }

  void _initData(int len){
    for(int i = 0; i < len; i++){
      _randomData();
    }
    if(plantData.length > 0){
      _onSelectPage(0);
    }
  }

  void _randomData(){
    var random = Random();
    var data = PlantDataEntity(
      random.nextInt(9) + 20,
      random.nextInt(8) + 23,
      random.nextInt(31) + 30,
      (random.nextInt(29) + 2) * 100,
      random.nextInt(5) + 19 + double.parse(random.nextDouble().toStringAsFixed(1)),
      (random.nextInt(7) + 2) * 100,
      );
    plantData.add(data);
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(MainFragment oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initData(widget.crops.length);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 220,
                    margin: EdgeInsets.only(top: 24),
                    child: widget.crops.length == 0 ?
                    Image.asset('images/ic_place_holder.png',fit: BoxFit.fill,) :
                    PageView.builder(
                      itemBuilder: _buildSinglePage,
                      itemCount: widget.crops.length,
                      onPageChanged: _onSelectPage,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('数据采集',style: _dataTextStyle,),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                      Expanded(
                        child: Text('室内温度:$_internalTem℃',style: _dataTextStyle,),
                        flex: 1,),
                      Expanded(
                        child: Text('室外温度:$_outsideTem℃',style: _dataTextStyle),
                        flex: 1,)
                    ],),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: Text('相对湿度:$_relativeHum%',style: _dataTextStyle,),
                          flex: 1,),
                        Expanded(
                          child: Text('光照强度:${_lightValue}lx',style: _dataTextStyle,),
                          flex: 1,)
                      ],),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 16),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          child: Text('O2浓度:$_co2Value%',style: _dataTextStyle,),
                          flex: 1,),
                        Expanded(
                          child: Text('CO2浓度:${_o2Value}ppm',style: _dataTextStyle,),
                          flex: 1,)
                      ],),
                  ),
                  Container(
                    child: RaisedButton(
                      onPressed: _skipToManagerMethod,
                      child: Text('推荐管理方法',style: _dataTextStyle,),
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSinglePage(context,index){
    return Container(
      width: double.infinity,
      height: 180,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: FadeInImage.assetNetwork(
              placeholder: 'images/pic_news_place_holder.png',
              image: widget.crops[index].cropImgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24,vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Theme.of(context).primaryColor
              ),
            ),
            child: Text('${widget.crops[index].cropName}',style: TextStyle(
                fontSize: 16
            ),),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}