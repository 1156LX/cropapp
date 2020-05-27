import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/material.dart';

class DeviceControlPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _DeviceControlPageState();
  }

}

class _DeviceControlPageState extends BaseState<DeviceControlPage>{

  var _controller = ScrollController();

  var _pics = [
    './images/ic_fan.png',
    './images/ic_camera.png',
    './images/ic_fertilizer.png',
    './images/ic_tempture.png',
    './images/ic_water_plant.png',
    './images/ic_co2.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备控制',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              _buildTop(),
              _buildFunction()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop(){
    return Container(
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
    );
  }

  Widget _buildFunction(){
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: GridView.builder(
        controller: _controller,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4),
        itemBuilder: (ctx,index) => Image.asset(_pics[index]),
        itemCount: _pics.length,
      ),
    );
  }

}