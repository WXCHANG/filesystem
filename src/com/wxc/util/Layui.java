package com.wxc.util;

import java.util.HashMap;
import java.util.List;

public class Layui  extends HashMap<String, Object> {

    public static Layui data(Integer count,List<?> data){
        Layui r = new Layui();
        r.put("code", 0);
        r.put("msg", "查询成功！");
        r.put("count", count);
        r.put("data", data);
        r.put("limit", 10);
        return r;
    }
}
