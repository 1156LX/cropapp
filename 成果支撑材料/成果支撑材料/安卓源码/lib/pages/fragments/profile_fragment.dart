import 'dart:convert';
import 'dart:math';

import 'package:agri_helper/network/entity/crop_entity.dart';
import 'package:agri_helper/network/entity/user_crop_entity.dart';
import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/add_crop_page.dart';
import 'package:agri_helper/pages/crop_detail_page.dart';
import 'package:agri_helper/pages/plant_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agri_helper/pages/base_page.dart';

// ignore: must_be_immutable
class ProfileFragment extends StatefulWidget{

  List<Data> crops = [];
  List<Data> userData = [];
  VoidCallback onPress;

  ProfileFragment(this.crops,this.userData,this.onPress);

  @override
  State<StatefulWidget> createState() {
    return _ProfileFragment();
  }

}

class _ProfileFragment extends BaseState<ProfileFragment> with AutomaticKeepAliveClientMixin<ProfileFragment>{

  bool _isEdit = false;
  var loc = [
    '四川省内江市花园基地研究中心',
    '四川省绵阳市涪城区蔬菜园种植地',
    '四川省成都市金牛区莱利村',
    '四川省自贡市作物研究基地',
    '四川省隆昌市农作物实验田'];

  int _getDay(){
    var time = DateTime(2020,5,21);
    var now = DateTime.now();
    var duration = now.difference(time);
    return duration.inDays;
  }

  void _clickItem(index){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            PlantDetail(loc[index % loc.length],_getDay(),
                widget.userData[index].cropImgUrl,widget.userData[index].cropName)));
  }



  void _onLongPressed(){
    setState(() {
      _isEdit = !_isEdit;
    });
  }

  void _onDeleteItem(int index){
    setState(() {
      widget.userData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('种植详情',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: _isEdit ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: _onLongPressed,
        ) : null,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Expanded(child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.userData.length,
                itemBuilder: (context,index) => _buildSingleItem(index),
              ),
            )),
            Container(
              margin: EdgeInsets.only(top: 12),
              child: RaisedButton(
                onPressed: widget.onPress,
                child: Text('添加作物'),
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSingleItem(index) => Material(
    color: Colors.white,
    child: InkWell(
      onTap: (){
        _clickItem(index);
      },
      onLongPress: _onLongPressed,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 4,right: 8,top: 16,bottom: 16),
                color: Colors.white,
                width: 84,
                height: 51,
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/pic_news_place_holder.png',
                  image: widget.userData[index].cropImgUrl,),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(widget.userData[index].cropName,style: TextStyle(
                              fontSize: 20
                          ),),
                          _isEdit ? IconButton(
                            icon: Icon(Icons.clear,color: Colors.red,),
                            onPressed: () => _onDeleteItem(index),
                          ) : Container(),
                        ],
                      ),
                      Text(loc[index % loc.length],style: TextStyle(
                          fontSize: 16
                      ),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: 1,
          )
        ],
      ),
    ),
  );

  @override
  bool get wantKeepAlive => true;

}