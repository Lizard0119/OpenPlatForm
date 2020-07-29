package cn.lcd.service.impl;

import cn.lcd.dao.IUserDao;
import cn.lcd.pojo.User;
import cn.lcd.service.IUserService;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements IUserService {

    @Resource
    private IUserDao dao;

    @Override
    public List<User> getAllUsers(int page , int limit) {
        PageHelper.startPage(page, limit);
        return dao.getAllUsers();
    }

    @Override
    public User getUserById(int id) {
        return dao.getUserById(id);
    }

    @Override
    public boolean saveUser(User user) {
        return dao.saveUser(user)>0;
    }

    @Override
    public boolean removeUser(int id) {
        return dao.removeUser(id)>0;
    }

    @Override
    public boolean updateUser(User user) {
        return dao.updateUser(user)>0;
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
