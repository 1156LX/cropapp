package com.cropapp.dao;

import com.cropapp.entity.UserCrop;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserCropDao {
    //删除
    public void deleteCrop(int id);

    //id查询
    public UserCrop findById(int id);

    //添加
    public void addCrop(UserCrop userCrop);

    //更新
    public void updateCrop(UserCrop userCrop);

    //查询所有
    public List<UserCrop>allCrop();

    //名称查询
    public List<UserCrop> findByUser(int userId);
}
