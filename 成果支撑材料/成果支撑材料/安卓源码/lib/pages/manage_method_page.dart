
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/choose_plant_page.dart';
import 'package:agri_helper/pages/connect_device_page.dart';
import 'package:agri_helper/pages/device_control_page.dart';
import 'package:agri_helper/pages/plant_detail_page.dart';
import 'package:flutter/material.dart';

class ManageMethodPage extends StatefulWidget{

  final bool isUpTem;
  final bool isUpLight;
  final bool isAddWater;


  ManageMethodPage(this.isUpTem, this.isUpLight, this.isAddWater);

  @override
  State<StatefulWidget> createState() {
    return _ManagerMethodPageState();
  }

}

class _ManagerMethodPageState extends BaseState<ManageMethodPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('管理方法',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 180,
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Image.asset('images/pic_news_place_holder.png',fit: BoxFit.fill,),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Theme.of(context).primaryColor
                        ),
                      ),
                      child: Text('水稻',style: TextStyle(
                          fontSize: 16
                      ),),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 16),
                child: PhysicalModel(
                  color: Colors.white,
                  shadowColor: Colors.black26,
                  elevation: 8,
                  borderRadius: BorderRadius.circular(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 24,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildSuggestionCell('提高温度',widget.isUpTem),
                          _buildSuggestionCell('降低温度',!widget.isUpTem)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildSuggestionCell('增强光照',widget.isUpLight),
                          _buildSuggestionCell('减弱光照',!widget.isUpLight)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildSuggestionCell('增加水分',widget.isAddWater),
                          _buildSuggestionCell('减少水分',!widget.isAddWater)
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          _buildSuggestionCell('蜂鸣器报警',false),
                          _buildSuggestionCell('关闭警报',false)
                        ],
                      ),
                      Container(
                        height: 32,
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: RaisedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => ConnectDevicePage())
                  ),
                  color: Theme.of(context).primaryColor,
                  child: Text('远程遥控'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCell(String msg,bool isDeep){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      margin: EdgeInsets.only(right: 4,top: 8),
      color: isDeep ? Theme.of(context).primaryColor : Color.fromARGB(255, 230, 249, 246),
      child: Text(msg,style: TextStyle(
        fontSize: 16
      ),),
    );
  }

}