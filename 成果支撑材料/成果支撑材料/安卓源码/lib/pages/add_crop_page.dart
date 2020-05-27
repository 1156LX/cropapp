import 'dart:convert';

import 'package:agri_helper/network/entity/crop_entity.dart';
import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'crop_detail_page.dart';


class AddCropPage extends StatefulWidget{

  final List<Data> crops = [];


  AddCropPage(List<Data> list){
    crops.clear();
    crops.addAll(list);
  }

  @override
  State<StatefulWidget> createState() {
    return _AddCropPageState();
  }

}

class _AddCropPageState extends BaseState<AddCropPage>{

  int _select = -1;

  void _onClickPic(int index){
    setState(() {
      if(index == _select){
        _select = -1;
      }else{
        _select = index;
      }
    });
  }

  void _onClickText(int index){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CropDetailPage(
            widget.crops[index].cropId,
            widget.crops[index].cropName,
            widget.crops[index].cropDescribe,
            widget.crops[index].cropGrowthEnvironment,
            widget.crops[index].cropCultivationTechniques,
            widget.crops[index].cropNutritiveValue,
            widget.crops[index].cropDiseaseControl,
            widget.crops[index].cropStorageMethod,
            widget.crops[index].cropImgUrl
        )));
  }

  void _addCrops(){
    if(_select == -1){
      showToast('请选择作物');
    }else{
      NetworkManager.getInstance()
          .addCrops(widget.crops[_select].cropId, _addCropsSuccess,_addCropsFailed );
    }
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

  String _getCrops(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择农作物'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: _addCrops)
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16,right: 16,top: 8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8),
          itemBuilder: _buildSingleCrop,
          itemCount: widget.crops.length,),
      ),
    );
  }

  Widget _buildSingleCrop(context,index) => Material(
    child: Container(
      child: PhysicalModel(
        color: Colors.white,
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () => _onClickPic(index),
              child: Container(
                height: 96,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                      placeholder: 'images/pic_news_place_holder.png',
                      image: widget.crops[index].cropImgUrl,
                      fit: BoxFit.fill,
                    ),
                    _select == index ? Center(
                      child: Icon(Icons.check,size: 64, color: Theme.of(context).primaryColor,),
                    ) : Container()
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => _onClickText(index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Text(widget.crops[index].cropName,style: TextStyle(fontSize: 18),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16,right: 16,bottom: 4),
                    child: Text(widget.crops[index].cropDescribe,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

}