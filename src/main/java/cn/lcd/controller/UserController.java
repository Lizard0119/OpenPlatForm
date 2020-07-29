package cn.lcd.controller;


import cn.lcd.pojo.User;
import cn.lcd.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {

    @Resource
//    @Autowired   基于类型，自动注入
    private IUserService ser;
    /*基于名称，自动注入*/
//
//    @GetMapping("/Users")
//    @ResponseBody
//    public ModelAndView getAllUsers(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int limit) {
//        List<User> list = ser.getAllUsers(page, limit);
//        return new ModelAndView("index", "list", list);
//    }

    @GetMapping("/UserLayUI")
    @ResponseBody
    public Map<String, Object> getLayUIData(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int limit) {

        Map<String, Object> map ;
        List<Object> list = new ArrayList<>();
        List<User> allList = ser.getAllUsers(page, limit);
        for (User u : allList) {
            map = new HashMap<>();
            map.put("id", u.getId());
            map.put("username", u.getUsername());
            map.put("password", u.getPassword());
            map.put("nickname", u.getNickname());
            map.put("address", u.getAddress());
            map.put("money", u.getMoney());
            if ( u.getState() == 1) {
                map.put("state", "正常");
            } else {
                map.put("state", "停用");
            }
            list.add(map);
        }

        Map<String, Object> map1 = new HashMap<>();
        map1.put("code", 0);
        map1.put("msg", 0);
        /*注意:list.size不行,因为这样每次都只会有5条数据    而需要的是所有*/
        map1.put("count", ser.getCount());
        map1.put("data", list);
        return map1;

    }


    @GetMapping("/saveUser")
    public String saveUser() {
        return "saveUser";
    }
}
