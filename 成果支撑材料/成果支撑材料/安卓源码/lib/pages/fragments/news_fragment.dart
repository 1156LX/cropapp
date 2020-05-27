
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class NewsFragment extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _NewsFragmentState();
  }

}

class _NewsFragmentState extends BaseState<NewsFragment>{

  List<String> _newsTitles = [
    '江泽林委员：加强农村产业融合促进全面小康',
    '罗志军委员：多措并举稳定和扩大农民工就业',
    '推动全民阅读建设书香中国',
    '刘庆民委员：坚守“疫线”，逆风而上向阳而生',
    '全国夏收夏种气象服务启动',
    '“广东荔枝”专机专列甜蜜出发',
    '养猪“新基建”，助推生猪产业智能化发展',
    '河北确立生鲜乳价格3.4元至3.6元',
    '鸡蛋价格持续回落 仍将保持低位运行'
  ];

  List<String> _newsUrls = [
    'http://www.farmer.com.cn/2020/05/25/wap_99853720.html',
    'http://www.farmer.com.cn/2020/05/25/wap_99853713.html',
    'http://www.farmer.com.cn/2020/05/25/wap_99853712.html',
    'http://www.farmer.com.cn/2020/05/25/wap_99853682.html',
    'http://www.farmer.com.cn/2020/05/22/wap_99853458.html',
    'http://www.farmer.com.cn/2020/05/21/wap_99853354.html',
    'http://www.farmer.com.cn/2020/05/20/wap_99853154.html',
    'http://www.farmer.com.cn/2020/05/19/wap_99853080.html',
    'http://www.farmer.com.cn/2020/05/16/wap_99852981.html'
  ];

  List<String> _pics = [
    './images/banner1.png',
    './images/banner2.png',
    './images/banner3.png'];

  void _skipToNews(int index){
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => WebViewPage('新闻资讯',url: _newsUrls[index],)
    ));
  }

  String _getNowDate(){
    var now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 24),
            height: 180,
            child: Swiper(
              autoplay: true,
              autoplayDelay: 3000,
              itemCount: _pics.length,
              itemBuilder: (context,index) => _buildSinglePic(index),
              controller: SwiperController(),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView.builder(
                itemCount: _newsTitles.length,
                itemBuilder: (context,index) => Container(
                  width: double.infinity,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _skipToNews(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 220,
                              child: Text(_newsTitles[index],overflow: TextOverflow.ellipsis,),
                            ),
                            Text(_getNowDate())
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSinglePic(index){
//    return Container(
//      width: double.infinity,
//      height: 180,
//      child: FadeInImage.assetNetwork(
//        placeholder: 'images/pic_news_place_holder.png',
//        image: _pics[index],
//        fit: BoxFit.fill,),
//    );
    return Container(
      width: double.infinity,
      height: 180,
      child: Image.asset(_pics[index],fit: BoxFit.fill,)
    );
  }

}