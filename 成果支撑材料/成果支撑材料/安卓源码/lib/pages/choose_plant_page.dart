
import 'package:agri_helper/pages/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChoosePlantPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ChoosePlantPageState();
  }

}

class _ChoosePlantPageState extends BaseState{

  void _finish(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择农作物',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _finish,
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 4
          ),
          itemBuilder: (ctx,index) => Card(
            color: Colors.white,
            elevation: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('images/pic_place_holder.png',
                  width: double.infinity,
                  height: 80,
                  fit: BoxFit.fill,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('稻谷',style: TextStyle(fontSize: 14),),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 16,
                                color: Colors.blue,),
                              onTap: (){},
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          '农业经济中占比比较重要的农',
                          style: TextStyle(fontSize: 8),
                          maxLines: 2,),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}