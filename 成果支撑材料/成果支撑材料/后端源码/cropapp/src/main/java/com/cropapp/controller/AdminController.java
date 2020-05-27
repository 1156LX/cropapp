package com.cropapp.controller;

import com.cropapp.dao.CropDao;
import com.cropapp.dao.UserDao;
import com.cropapp.entity.Crop;
import com.cropapp.entity.User;
import com.cropapp.until.ReMessageFactory;
import com.cropapp.until.ResponMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Collection;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private CropDao cropDao;

    @Autowired
    private UserDao userDao;

    //查看所有农作物
    @RequestMapping(value = "/crop", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<Collection<Crop>> findAllCrop() {
        Collection<Crop> crops = cropDao.allCrop();

        if (crops.isEmpty()) {
            return ReMessageFactory.produceMessageNotFound("查询失败");
        }

        return ReMessageFactory.produceMessageSuccess(crops);
    }

    //通过id查看
    @RequestMapping(value = "/crop/findById", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<Crop> CropfindById(int id) {
        Crop crop=cropDao.findById(id);
        return ReMessageFactory.produceMessageSuccess(crop);
    }

    //通过name查询
    @RequestMapping(value = "/crop/findByName", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<Collection<Crop>> CropfindByName(String name) {
        Collection<Crop> crops=cropDao.findByName(name);
        return ReMessageFactory.produceMessageSuccess(crops);
    }
    //添加农作物
    @RequestMapping(value = "/crop", method = RequestMethod.POST)
    @ResponseBody
    public ResponMessage<String> insertCrop(Crop crop) {
        cropDao.addCrop(crop);
        return ReMessageFactory.produceMessageFailure("添加成功");
    }

    //删除农作物
    @RequestMapping(value = "/crop", method = RequestMethod.DELETE)
    @ResponseBody
    public ResponMessage<String> deleteCrop(int id) {
        cropDao.deleteCrop(id);
        return ReMessageFactory.produceMessageFailure("删除成功");
    }

    //更新农作物
    @RequestMapping(value = "/crop", method = RequestMethod.PUT)
    @ResponseBody
    public ResponMessage<String> updateCrop(Crop crop) {
        cropDao.updateCrop(crop);
        return ReMessageFactory.produceMessageFailure("更新成功");
    }

    //查看所有用户
    @RequestMapping(value = "/user", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<Collection<User>> findAllUser() {
        Collection<User> users = userDao.allUser();

        if (users.isEmpty()) {
            return ReMessageFactory.produceMessageNotFound("查询失败");
        }

        return ReMessageFactory.produceMessageSuccess(users);
    }

    //通过id查看
    @RequestMapping(value = "/user/findById", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<User> UserfindById(int id) {
        User user=userDao.findById(id);
        return ReMessageFactory.produceMessageSuccess(user);
    }

    //通过name查询
    @RequestMapping(value = "/user/findByName", method = RequestMethod.GET)
    @ResponseBody
    public ResponMessage<User> UserfindByName(String name) {
        User user=userDao.findByName(name);
        if(user.equals(null)){
            return ReMessageFactory.produceMessageNotFound("用户名不存在");
        }
        return ReMessageFactory.produceMessageSuccess(user);
    }

    //添加用户
    @RequestMapping(value = "/user", method = RequestMethod.POST)
    @ResponseBody
    public ResponMessage<String> insertUser(User user) {
        System.out.println(user);
        User user1=userDao.findByName(user.getUserName());
        if(null!=user1){
            return ReMessageFactory.produceMessageFailure("用户名已被使用");
        }
        userDao.addUser(user);
        return ReMessageFactory.produceMessageSuccess("添加成功");
    }

    //删除用户
    @RequestMapping(value = "/user", method = RequestMethod.DELETE)
    @ResponseBody
    public ResponMessage<String> deleteUser(int id) {
        userDao.deleteUser(id);
        return ReMessageFactory.produceMessageSuccess("删除成功");
    }

    //更新用户
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


}
