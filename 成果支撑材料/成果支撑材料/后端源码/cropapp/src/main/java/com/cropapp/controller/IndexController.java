package com.cropapp.controller;

import com.cropapp.dao.UserDao;
import com.cropapp.entity.User;
import com.cropapp.until.ReMessageFactory;
import com.cropapp.until.ResponMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class IndexController {
    @Autowired
    private UserDao userDao;

    //用户登录
    @RequestMapping(value = "/index/login", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<String> login(String username,String password,HttpServletRequest request) {
        User user=userDao.findByName(username);
        if(null==user){
            return ReMessageFactory.produceMessageNotFound("用户名不存在");
        }

        if(!user.getUserPassword().equals(password)){
            return ReMessageFactory.produceMessageNotFound("密码错误");
        }
        request.getSession().setAttribute("user",user);
        return ReMessageFactory.produceMessageSuccess("登录成功");
    }

    //用户注册
    @RequestMapping(value = "/index/register", method = RequestMethod.POST)
    @ResponseBody
    public ResponMessage<String> register(String username,String password) {
        //System.out.println(user);
        User user1=userDao.findByName(username);
        if(null!=user1){
            return ReMessageFactory.produceMessageFailure("用户名已被使用");
        }
        User user=new User();
        user.setUserName(username);
        user.setUserPassword(password);
        userDao.addUser(user);
        return ReMessageFactory.produceMessageSuccess("添加成功");
    }
}
