package com.wxc.dao;

import java.util.List;

import com.wxc.entity.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

	List<User> queryUsers(Integer page,Integer limit);

	Integer queryUserCount();

	User queryByName(String username);
}