package com.cropapp.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="usercrop")
@Data
public class UserCrop {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int userId;
    private int cropId;
    private double height;
    private String date;//种植日期
    private String temperature;//温度
    private String humidity;//湿度
    private String place;//种植地点
    private String precipitation;//降水量
    private String co2;//CO2浓度
    private String o2;//O2浓度
    private String n2;//N2浓度

}

