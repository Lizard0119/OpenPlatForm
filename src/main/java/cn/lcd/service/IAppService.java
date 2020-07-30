package cn.lcd.service;

import cn.lcd.pojo.App;

import java.util.List;

public interface IAppService {

    /*查找所有*/
    List<App> getAllApps(int page,int limit);

    /*按照指定id查找用户*/
    App getAppById(int id);

    /*添加用户*/
    boolean insertApp(App app);

    /*删除用户*/
    boolean removeApp(int id);

    /*根据id数组进行批删除*/
    boolean deleteAppById(int[] ids);

    /*更新用户*/
    boolean updateApp(App app);

    int getLastId();

    int getCount();

}
