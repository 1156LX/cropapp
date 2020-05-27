import 'dart:convert';

import 'package:agri_helper/network/entity/crop_entity.dart';
import 'package:agri_helper/network/entity/user_crop_entity.dart';
import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/fragments/main_fragment.dart';
import 'package:agri_helper/pages/fragments/news_fragment.dart';
import 'package:agri_helper/pages/fragments/profile_fragment.dart';
import 'package:agri_helper/pages/fragments/search_fragment.dart';
import 'package:agri_helper/pages/manage_method_page.dart';
import 'package:flutter/material.dart';

import 'add_crop_page.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }

}

class _MainPageState extends BaseState<MainPage>{

  var _selectedIndex = 1;
  final _controller = PageController(initialPage: 1);


  static TextStyle _bottomTitleStyle = TextStyle(
    color: Colors.black
  );

  List<Data> _crops = [];
  List<Data> userData = [];

  void _queryUserCrops(){
    NetworkManager.getInstance()
        .queryUserCrops(_queryUserCropsSuccess, _queryUserCropsFailed);
  }

  void _addCrop(){
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddCropPage(_crops)))
        .then((value){
      if(value == 1){
        _queryUserCrops();
      }
    });
  }

  void _queryUserCropsSuccess(String data){
    var entity = UserCropEntity.fromJson(json.decode(data));
    if(entity.code == 200){
      setState(() {
        userData.clear();
        entity.data.forEach((element) {
          print('id:${element.cropId}');
          _crops.forEach((value) {
            if(element.cropId == value.cropId){
              userData.add(value);
            }
          });
        });
      });
    }else{
      showToast(entity.message);
    }
  }

  void _queryUserCropsFailed(String msg){
    showToast(msg);
    print('queryfailed:$msg');
  }

  void _queryCrops(){
    NetworkManager.getInstance().queryCrops(
        _queryCropsSuccess,
        _queryCropsFailed);
  }

  void _queryCropsSuccess(String data){
    var entity = CropEntity.fromJson(json.decode(data));
    if(entity.code == 200){
      setState(() {
        _crops = entity.data;
      });
      _queryUserCrops();
    }else{
      showToast(entity.message);
    }
  }

  void _queryCropsFailed(msg){
    showToast(msg);
  }

  List<BottomNavigationBarItem> _bottomBarItems = [
    BottomNavigationBarItem(
        icon: Image.asset('images/ic_bottom_bar_news.png',width: 32,height: 32,),
        title: Text('咨询',style: _bottomTitleStyle,)),
    BottomNavigationBarItem(
        icon: Image.asset('images/ic_bottom_bar_main.png',width: 32,height: 32,),
        title: Text('首页',style: _bottomTitleStyle,)),
    BottomNavigationBarItem(
        icon: Image.asset('images/ic_bottom_bar_search.png',width: 32,height: 32,),
        title: Text('搜索',style: _bottomTitleStyle,)),
    BottomNavigationBarItem(
        icon: Image.asset('images/ic_bottom_bar_profile.png',width: 32,height: 32,),
        title: Text('我的',style: _bottomTitleStyle,))
  ];

  void _select(int index){
    _controller.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  void initState() {
    super.initState();
    _queryCrops();
  }

  AppBar _getCurrentAppBar(){
    String title = '';
    switch(_selectedIndex){
      case 0:
        title = '资讯';
        break;
      case 1:
        return null;
        break;
      case 2:
        title = '搜索';
        break;
      case 3:
        title = '种植列表';
        return null;
        break;
      default:
        return null;
    }
    return AppBar(
      title: Text(title,style: TextStyle(color: Colors.white),),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getCurrentAppBar(),
//      body: _getCurrentFragment(),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          NewsFragment(),
          MainFragment(userData),
          SearchFragment(_crops),
          ProfileFragment(_crops,userData,_addCrop)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems,
        iconSize: 32,
        onTap: _select,
        currentIndex: _selectedIndex,
      ),
    );
  }

}