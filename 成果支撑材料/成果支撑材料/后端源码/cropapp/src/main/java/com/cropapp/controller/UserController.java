package com.cropapp.controller;

import com.cropapp.dao.UserCropDao;
import com.cropapp.dao.UserDao;
import com.cropapp.entity.User;
import com.cropapp.entity.UserCrop;
import com.cropapp.until.ReMessageFactory;
import com.cropapp.until.ResponMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;

@Controller
public class UserController {

    @Autowired
    private UserCropDao userCropDao;
    @Autowired
    private UserDao userDao;

    //修改个人信息
    @RequestMapping(value = "/user", method = RequestMethod.PUT)
    @ResponseBody
    public ResponMessage<String> updateUser(User user) {
        System.out.println(user);
        User user1=userDao.findByName(user.getUserName());
        if(user1!=null){
            return ReMessageFactory.produceMessageFailure("用户名已被使用");
        }
        userDao.updateUser(user);
        return ReMessageFactory.produceMessageSuccess("更新成功");
    }

    //查看所有农作物
    @RequestMapping(value = "/usercrop", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<Collection<UserCrop>> findAllUsercrop(HttpServletRequest request) {
        User user= (User) request.getSession().getAttribute("user");
        Collection<UserCrop> userCrops = userCropDao.findByUser(user.getUserId());

        return ReMessageFactory.produceMessageSuccess(userCrops);
    }

    //通过id查看
    @RequestMapping(value = "/usercrop/findById", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<UserCrop> findById(int id) {
        UserCrop userCrop=userCropDao.findById(id);
        return ReMessageFactory.produceMessageSuccess(userCrop);
    }



    //添加农作物
    @RequestMapping(value = "/usercrop", method = RequestMethod.POST)
    @ResponseBody
    public ResponMessage<String> insertUser(UserCrop userCrop,HttpServletRequest request) {
        User user= (User) request.getSession().getAttribute("user");
        userCrop.setUserId(user.getUserId());
        System.out.println(userCrop);

        userCropDao.addCrop(userCrop);
        return ReMessageFactory.produceMessageSuccess("添加成功");
    }

    //删除农作物
    @RequestMapping(value = "/usercrop", method = RequestMethod.DELETE)
    @ResponseBody
    public ResponMessage<String> deleteUserCrop(int id) {
        userCropDao.deleteCrop(id);
        return ReMessageFactory.produceMessageSuccess("删除成功");
    }

    //更新农作物
    @RequestMapping(value = "/usercrop", method = RequestMethod.PUT)
    @ResponseBody
    public ResponMessage<String> updateUserCrop(UserCrop userCrop) {
        System.out.println(userCrop);
        userCropDao.updateCrop(userCrop);

        return ReMessageFactory.produceMessageSuccess("更新成功");
    }



}
