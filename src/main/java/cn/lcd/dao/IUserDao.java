package cn.lcd.dao;

import cn.lcd.pojo.User;

import java.util.List;

public interface IUserDao {

    /*查找所有用户*/
    List<User> getAllUsers();

    /*按照指定id查找用户*/
    User getUserById(int id);

    /*添加用户*/
    int saveUser(User user);

    /*删除用户*/
    int removeUser(int id);

    /*更新用户*/
    int updateUser(User user);

    int getLastId();

    int getCount();

}
