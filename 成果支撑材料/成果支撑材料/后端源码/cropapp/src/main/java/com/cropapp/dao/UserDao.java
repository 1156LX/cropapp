package com.cropapp.dao;

import com.cropapp.entity.User;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserDao {
    //删除用户
    public void deleteUser(int id);

    //id查询用户
    public User findById(int id);

    //添加用户
    public void addUser(User user);

    //修改信息
    public void updateUser(User user);

    //查询所有用户
    public List<User> allUser();

    //用户名查询
    public User findByName(String username);
}
