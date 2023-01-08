package com.flora.music.domain;

import lombok.Data;

import java.io.Serializable;

/**
 * @Author qinxiang
 * @Date 2022/12/29-下午10:54
 */
@Data
public class Admin implements Serializable {
    private Integer id;
    private String name;
    private String password;
}
