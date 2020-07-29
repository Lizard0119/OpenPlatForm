package cn.lcd.service;

import cn.lcd.pojo.User;

import java.util.List;

public interface IUserService {

    List<User> getAllUsers(int page,int limit);

    /*按照指定id查找用户*/
    User getUserById(int id);

    /*添加用户*/
    boolean saveUser(User user);

    /*删除用户*/
    boolean removeUser(int id);

    /*更新用户*/
    boolean updateUser(User user);

    int getLastId();

    int getCount();

}
