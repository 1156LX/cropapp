import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectDevicePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ConnectDeviceState();
  }

}

class _ConnectDeviceState extends BaseState<ConnectDevicePage>{

  var _controller = ScrollController();

  void _showConnectingDialog(){
    showDialog(
      context: context,
      child: Center(
        child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(horizontal: 32),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: LinearProgressIndicator(),
              ),
              Text('匹配中...',style: TextStyle(
                fontSize: 16,
                color: Colors.black
              ),)
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('连接设备'),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(24),
              child: Text('搜索附近设备',style: TextStyle(fontSize: 24),),
            ),
            _buildNearDevices(),
            Container(
              margin: EdgeInsets.all(24),
              child: Text('历史匹配设备',style: TextStyle(fontSize: 24),),
            ),
            _buildNearDevices()
          ],
        ),
      ),
    );
  }

  Widget _buildNearDevices(){
    return ListView.builder(
      shrinkWrap: true,
      controller: _controller,
      itemCount: 3,
      itemBuilder: (ctx,index) => Container(
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 28),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('hdjska-sbaj$index',style: TextStyle(fontSize: 16),),
            InkWell(
              onTap: _showConnectingDialog,
              child: Container(
                margin: EdgeInsets.only(left: 24),
                child: Text('立即匹配',style: TextStyle(fontSize: 16,color: Colors.red),),
              ),
            )
          ],
        ),
      ));
  }


}