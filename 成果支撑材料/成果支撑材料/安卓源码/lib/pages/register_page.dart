
import 'dart:convert';
import 'dart:ffi';

import 'package:agri_helper/network/network_manager.dart';
import 'package:agri_helper/pages/base_page.dart';
import 'package:agri_helper/pages/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget{

  final bool findPsw;

  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }

  RegisterPage({this.findPsw : false});

}

class _RegisterState extends BaseState<RegisterPage>{

  bool _isShowPsw = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pswController = TextEditingController();

  TextStyle _inputTextStyle = TextStyle(
    fontSize: 12,
    color: Colors.black
  );

  void _register(){
    if(_pswController.text.isNotEmpty && _nameController.text.isNotEmpty){
      print('reigster:');
      NetworkManager.getInstance().register(
          _nameController.text,
          _pswController.text,
          _registerSuccess,
          _registerFailed);
    }
  }

  void _registerSuccess(data){
    var entity = json.decode(data);
    if(entity['code'] == 200){
      showToast('注册成功！');
      Navigator.pop(context);
    }else{
      showToast(entity['message']);
    }
  }
  
  void _registerFailed(msg){
    showToast('网络异常！');
    print('resiter error :$msg');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.findPsw ? '找回密码' : '注册',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg_login.png'),
            fit: BoxFit.fill
          )
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 128,left: 32,right: 32),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/ic_input_number.png',width: 32,height: 32,),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 8),
                            hintText: '请输入您的手机号',
                            hintStyle: _inputTextStyle
                        ),
                      ),
                    ),

                  ],
                ),
                _buildDividingLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/ic_input_psw.png',width: 32,height: 32,),
                    Expanded(
                      child: TextFormField(
                        controller: _pswController,
                        obscureText: _isShowPsw,
                        decoration: InputDecoration(
                            border: InputBorder.none,
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
                            ),
                          hintText: widget.findPsw ? '请输入你的新密码' : '请输入你的密码',
                          hintStyle: _inputTextStyle,
                          contentPadding: EdgeInsets.only(left: 8,top: 16)
                        ),
                      ),
                    ),
                  ],
                ),
                _buildDividingLine(),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Image.asset('images/ic_input_verify.png',width: 32,height: 32,),
//                    Expanded(
//                      child: TextField(
//                        decoration: InputDecoration(
//                            border: InputBorder.none,
//                            contentPadding: EdgeInsets.only(left: 8),
//                            hintText: '请输入验证码',
//                            hintStyle: _inputTextStyle
//                        ),
//                      ),
//                    ),
//                    new Material(
//                      color: Color(0XFFB7E2DB),
//                      child: InkWell(
//                        child: Container(
//                          margin: EdgeInsets.symmetric(horizontal: 4),
//                          child: Text('获取验证码'),
//                        ),
//                        onTap: (){},
//                      ),
//                    )
//                  ],
//                ),
//                _buildDividingLine(),
                Container(
                  width: double.infinity,
                  height: 42,
                  margin: EdgeInsets.only(top: 48,left: 32,right: 32),
                  child: RaisedButton(
                    onPressed: _register,
                    disabledColor: Colors.grey,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(widget.findPsw ? '确认修改' : '注册'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
                widget.findPsw ? Container() : Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 24,bottom: 24),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: Text('已有账号，快去登录',style: _inputTextStyle,),
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDividingLine(){
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.black,
    );
  }

}