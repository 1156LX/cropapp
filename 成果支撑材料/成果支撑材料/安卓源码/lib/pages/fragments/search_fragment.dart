import 'package:agri_helper/network/entity/crop_entity.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/web_view_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../crop_detail_page.dart';

// ignore: must_be_immutable
class SearchFragment extends StatefulWidget{

  List<Data> crops = [];

  SearchFragment(this.crops);

  @override
  State<StatefulWidget> createState() {
    return _SearchFragment();
  }

}

class _SearchFragment extends BaseState<SearchFragment>{

  var _color = Color(0XEEE6F9F6);
  var _controller = TextEditingController();

  List<String> _searchHistory = ['白菜小','白芽','白豆芽','白菜小豆芽','白菜小豆芽'];
  List<String> _hotSearch = ['白豆芽','白菜芽','白豆芽','白菜小豆芽','白菜小豆芽'];

  List<Widget> _buildSearchHistory() => _buildHistory(_searchHistory);

  List<Widget> _buildHotSearch() => _buildHistory(_hotSearch);

  void _searchCrop(){
    var name = _controller.text;
    for(int i = 0; i < widget.crops.length; i++){
      if(widget.crops[i].cropName == name){
        _clickItem(i);
        return;
      }
    }
    var address = 'https://baike.baidu.com/item/' + name;
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => WebViewPage('搜索',url: address,)));
  }

  void _clickItem(index){
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('./images/bg_search.png'),
          fit: BoxFit.fill
        )
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 32,right: 32,top: 8,bottom: 24),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: '请输入农作物名称'
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: RaisedButton(
                      onPressed: _searchCrop,
                      color: _color,
                      child: Text('搜索',style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                    ),
                  )
                ],
              ),
//            Container(
//              width: double.infinity,
//              margin: EdgeInsets.only(top: 24,bottom: 8),
//              child: Text('历史搜索',style: TextStyle(
//                  fontSize: 16,
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold
//              ),),
//            ),
//            Wrap(
//              children: _buildSearchHistory(),
//            ),
//            Container(
//              width: double.infinity,
//              margin: EdgeInsets.only(top: 24,bottom: 8),
//              child: Text('热门搜索',style: TextStyle(
//                  fontSize: 16,
//                  color: Colors.black,
//                  fontWeight: FontWeight.bold
//              ),),
//            ),
//            Wrap(
//              children: _buildHotSearch(),
//            ),
            ],
          ),
        ),
      ),
    );
  }

  ///构建历史列表
  List<Widget> _buildHistory(List<String> list){
    List<Widget> result = [];
    list.forEach((s) => result.add(
      Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            margin: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: _color,
            ),
            child: Text(s),
          ),
          onTap: (){},
        ),
      )
    ));
    return result;
  }

}