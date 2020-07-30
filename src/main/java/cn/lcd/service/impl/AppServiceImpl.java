package cn.lcd.service.impl;

import cn.lcd.dao.IAppDao;
import cn.lcd.pojo.App;
import cn.lcd.service.IAppService;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class AppServiceImpl implements IAppService {


    @Resource
    private IAppDao dao;

    @Override
    public List<App> getAllApps(int page, int limit) {
        PageHelper.startPage(page, limit);
        return dao.getAllApps();
    }

    @Override
    public App getAppById(int id) {
        return dao.getAppById(id);
    }

    @Override
    public boolean insertApp(App app) {
        return dao.insertApp(app)>0;
    }

    @Override
    public boolean removeApp(int id) {
        return dao.removeApp(id)>0;
    }

    @Override
    public boolean deleteAppById(int[] ids) {
        return dao.deleteAppById(ids);
    }

    @Override
    public boolean updateApp(App app) {
        return dao.updateApp(app)>0;
    }

    @Override
    public int getLastId() {
        return dao.getLastId();
    }

    @Override
    public int getCount() {
        return dao.getCount();
    }
}
