package cn.lcd.controller;


import cn.lcd.pojo.App;
import cn.lcd.pojo.User;
import cn.lcd.service.IAppService;
import cn.lcd.service.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AppController {

    @Resource
    private IAppService ser;

    @GetMapping("/AppLayUI")
    @ResponseBody
    public Map<String, Object> getLayUIData(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "5") int limit) {

        Map<String, Object> map ;
        List<Object> list = new ArrayList<>();
        List<App> allApps = ser.getAllApps(page, limit);
        for (App u : allApps) {
            map = new HashMap<>();

            map.put("id", u.getId());
            map.put("corpName", u.getCorpName());
            map.put("appName", u.getAppName());
            map.put("appKey", u.getAppKey());
            map.put("appSecret", u.getAppSecret());
            map.put("redirectUrl", u.getRedirectUrl());
            map.put("linit", u.getLinit());
            map.put("description", u.getDescription());
            map.put("cusId", u.getCusId());
            map.put("state", u.getState());

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
        map1.put("count", ser.getCount());
        map1.put("data", list);
        return map1;
    }

    @GetMapping("/showApp")
    public String showApp() {
        return "showApp";
    }

    @GetMapping("/getAppById/{id}")
    @ResponseBody
    public App getAppById(@PathVariable int id) {
        return ser.getAppById(id);
    }

//    @GetMapping("/removeApp/{id}")
//    @ResponseBody
//    public String removeApp(@PathVariable int id) {
//        if (ser.removeApp(id)) {
//            return  "success";
//        }
//        return "failed";
//    }

    @PostMapping("/insertApp")
    @ResponseBody
    public String insertUser(App app) {
        if (ser.insertApp(app)) {
            return "success";
        }
        return "failed";
    }

    @GetMapping("/insertA")
    public String bbb() {
        return "insertApp";
    }
//
//    @PostMapping("/update")
//    @ResponseBody
//    public String update(App app) {
//        if (ser.updateApp(app)) {
//            return "success";
//        }
//        return "failed";
//    }
//
//    @GetMapping("/updateApp/{id}")
//    public String updateApp() {
//        return "updateApp";
//    }

}
