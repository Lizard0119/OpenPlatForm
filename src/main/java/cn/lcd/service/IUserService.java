package cn.lcd.service;

import cn.lcd.pojo.User;

import java.util.List;

public interface IUserService {

    List<User> getAllUsers(int page,int limit);

    /*按照指定id查找用户*/
    User getUserById(int id);

    /*添加用户*/
    boolean insertUser(User user);

    /*删除用户*/
    boolean removeUser(int id);

    /*根据id数组进行批删除*/
    boolean deleteUsersById(int[] ids);

    /*更新用户*/
    boolean updateUser(User user);

    int getLastId();

    int getCount();

}
