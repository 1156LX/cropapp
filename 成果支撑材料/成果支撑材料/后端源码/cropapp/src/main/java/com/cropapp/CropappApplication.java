package com.cropapp;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.cropapp.dao")
public class CropappApplication {

    public static void main(String[] args) {
        SpringApplication.run(CropappApplication.class, args);
    }

}
