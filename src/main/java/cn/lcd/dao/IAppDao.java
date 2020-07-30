package cn.lcd.dao;

import cn.lcd.pojo.App;

import java.util.List;

public interface IAppDao {

    /*查找所有*/
    List<App> getAllApps();

    /*按照指定id查找用户*/
    App getAppById(int id);

    /*添加用户*/
    int insertApp(App app);

    /*删除用户*/
    int removeApp(int id);

    /*根据id数组进行批删除*/
    boolean deleteAppById(int[] ids);

    /*更新用户*/
    int updateApp(App app);

    int getLastId();

    int getCount();

}
