import 'dart:convert';

import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/material.dart';

class CropDetailPage extends StatefulWidget{

  final int cropId;
  final String name;
  final String describe;
  final String growthEnvironment;
  final String cultivationTech;
  final String nutritiveValue;
  final String diseaseControl;
  final String storageMethod;
  final String url;


  CropDetailPage(
      this.cropId,
      this.name,
      this.describe,
      this.growthEnvironment,
      this.cultivationTech,
      this.nutritiveValue,
      this.diseaseControl,
      this.storageMethod,
      this.url);

  @override
  State<StatefulWidget> createState() {
    return _CropDetailPageState();
  }

}

class _CropDetailPageState extends BaseState<CropDetailPage>{

  var _tipsTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold
  );

  var _contentTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.black54
  );

  void _addCrop(){
    NetworkManager.getInstance()
        .addCrops(widget.cropId, _addCropsSuccess,_addCropsFailed );
  }

  void _addCropsSuccess(String data){
    var entity = json.decode(data);
    if(entity['code'] == 200){
      showToast('添加成功！');
      Navigator.of(context).pop(1);
    }else{
      showToast(entity['message']);
    }
  }

  void _addCropsFailed(String msg){
    showToast(msg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCropPic(),
            _buildCropIntroduce(),
            _buildCropCharacter('详情',widget.describe),
            _buildCropCharacter('生长环境', widget.growthEnvironment),
            _buildCropCharacter('栽培技术', widget.cultivationTech),
            _buildCropCharacter('营养价值', widget.nutritiveValue),
            _buildCropCharacter('灾害防控', widget.diseaseControl),
            _buildCropCharacter('存储方法', widget.storageMethod),
            _buildBottomButton()
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() => Center(
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: RaisedButton(
        onPressed: _addCrop,
        child: Text('添加该作物',style: TextStyle(color: Colors.white),),
        color: Theme.of(context).primaryColor,
      ),
    ),
  );

  Widget _buildCropPic(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      height: 200,
      width: double.infinity,
      child: FadeInImage.assetNetwork(
        placeholder: 'images/pic_news_place_holder.png',
        image: widget.url,
        fit: BoxFit.fill,),
    );
  }

  Widget _buildCropIntroduce() => Container(
    margin: EdgeInsets.symmetric(horizontal: 32),
    child: Text(widget.name,style: _tipsTextStyle,),
  );

  Widget _buildCropCharacter(String title,String content) => Container(
    margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 2,
              height: 16,
              color: Colors.red,
              margin: EdgeInsets.only(right: 8),
            ),
            Text(title,style: _tipsTextStyle,)
          ],
        ),
        Text('     $content',style: _contentTextStyle,)
      ],
    ),
  );

}