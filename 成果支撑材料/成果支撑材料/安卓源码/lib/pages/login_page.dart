import 'dart:convert';

import 'package:agri_helper/network/entity/login_entity.dart';
import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/chart_page.dart';
import 'package:agri_helper/pages/main_page.dart';
import 'package:agri_helper/pages/register_page.dart';
import 'package:flutter/material.dart';

///登录页面
class LoginPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends BaseState<LoginPage>{

  TextEditingController _nameController = TextEditingController();
  TextEditingController _pswController = TextEditingController();
  bool _isShowPsw = false;

  TextStyle _inputStyle = TextStyle(
    fontSize: 14,
    color: Colors.black
  );

  void _login(){
    print(_nameController.text);
    NetworkManager.getInstance().login(
      _nameController.text.trim(),
      _pswController.text,
      _loginSuccess,
      _loginFailed);
  }

  void _loginSuccess(String data){
    var entity = LoginEntity.fromJson(json.decode(data));
    if(entity.code == 200){
      showToast('登录成功！');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (ctx) => MainPage()
          ), (route) => false);
    }else{
      showToast(entity.message);
    }
  }

  void _loginFailed(msg){
    showToast(msg);
  }

  void _forgetPsw(){
    Navigator.push(context,MaterialPageRoute(builder: (ctx) => RegisterPage(
      findPsw: true,
    )));
  }

  void _register(){
    Navigator.push(context,MaterialPageRoute(builder: (ctx) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/bg_login.png',),
              fit: BoxFit.fill)
        ),
        child: Container(
          margin: EdgeInsets.only(top: 128,left: 32,right: 32),
          child: Column(
            children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      margin: EdgeInsets.only(right: 8,bottom: 4),
                      child: Image.asset(
                        'images/ic_input_number.png', width: 32,height: 32,),
                    ),
                    Expanded(child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: _inputStyle,
                        hintText: '请输入你的手机号'
                      ),
                    ))
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black,
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    margin: EdgeInsets.only(right: 8,bottom: 4),
                    child: Image.asset(
                      'images/ic_input_psw.png', width: 32,height: 32,),
                  ),
                Expanded(child: TextFormField(
                  controller: _pswController,
                  obscureText: _isShowPsw,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入你的密码',
                    hintStyle: _inputStyle,
                    suffixIcon: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            _isShowPsw = !_isShowPsw;
                          });
                        },
                        child: Icon(
                          _isShowPsw ? Icons.visibility : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ),
                ))
//                  Icon(Icons.remove_red_eye,color: Colors.black,size: 32,),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 48,left: 32,right: 32),
                child: RaisedButton(
                  onPressed: _login,
                  disabledColor: Colors.grey,
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('登录'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Text('忘记密码',style: _inputStyle,),
                        onTap: _forgetPsw,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 28,
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    Material(
                      child: InkWell(
                        child: Text('快速注册',style: _inputStyle,),
                        onTap: _register,
                      ),
                      color: Colors.transparent,
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

}