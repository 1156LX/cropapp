
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/chart_page.dart';
import 'package:agri_helper/pages/visible_growth_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlantDetail extends StatefulWidget{

  final String loc;
  final int day;
  final String url;
  final String name;

  PlantDetail(this.loc,this.day,this.url,this.name);

  @override
  State<StatefulWidget> createState() {
    return _PlantDetailState();
  }
  
}

class _PlantDetailState extends BaseState<PlantDetail>{

  List<TextSpan> _buildTextSpans(){

    TextStyle style = TextStyle(
        color: Color(0XFF26A69A)
    );
    TextStyle normalStyle = TextStyle(
      fontSize: 14,
      color: Colors.black54
    );
    List<TextSpan> spans = [];
    spans.add(TextSpan(
      text: '2020年05月21日',
      style: style
    ));
    spans.add(TextSpan(
      text: '种植于',
      style: normalStyle
    ));
    spans.add(TextSpan(
      text: widget.loc,
      style: style
    ));
    spans.add(TextSpan(
        text: '，目前仍在正常生长，生长周期已达',
        style: normalStyle
    ));
    spans.add(TextSpan(
        text: '${widget.day}天',
        style: style
    ));
    spans.add(TextSpan(
      text: '，生长情况良好，可继续种植。',
      style: normalStyle
    ));
    return spans;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('种植详情',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16,right: 16,top: 12),
              child: Card(
                elevation: 2,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeInImage.assetNetwork(
                        placeholder: 'images/pic_news_place_holder.png',
                        image: widget.url,
                        fit: BoxFit.fill,
                        height: 180,
                        width: double.infinity,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        child: Text(widget.name,style: TextStyle(
                          fontSize: 18
                        ),),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.only(left: 8,right: 8,bottom: 8),
                          child: Text.rich(TextSpan(
                              text: '${widget.name}，该农作物于',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54
                              ),
                              children: _buildTextSpans()
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8,bottom: 16),
            child: Center(
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => VisibleGrowthPage(widget.url)));
                },
                child: Text('生长记录',style: TextStyle(color: Colors.white),),
                color: Theme.of(context).primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
  
}