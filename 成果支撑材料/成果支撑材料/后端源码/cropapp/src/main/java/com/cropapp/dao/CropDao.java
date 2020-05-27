package com.cropapp.dao;

import com.cropapp.entity.Crop;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CropDao {

    //删除
    public void deleteCrop(int id);

    //id查询
    public Crop findById(int id);

    //添加
    public void addCrop(Crop crop);

    //更新
    public void updateCrop(Crop crop);

    //查询所有
    public List<Crop>allCrop();

    //名称查询
    public List<Crop>findByName(String name);
}
