package com.cropapp.entity;
import javax.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name="crop")
public class Crop {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int cropId;
    private  String cropName;
    private String cropDescribe;
    private String cropBaiduUrl;
    private String cropImgUrl;
    private String cropGrowthEnvironment;
    private String cropCultivationTechniques;
    private String cropNutritiveValue;
    private String cropDiseaseControl;
    private String cropStorageMethod;
}
