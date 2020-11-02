package com.action;

import com.domain.PageInfo;
import com.domain.Role;
import com.service.RoleService;
import com.service.impl.RoleServiceImpl;
import mymvc.RequestMapping;
import mymvc.RequestParam;
import mymvc.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleAction {

    private RoleService service = new RoleServiceImpl();

    @RequestMapping("roleList.do")
    @ResponseBody
    public PageInfo roleList(@RequestParam("rno") Integer rno, @RequestParam("rname") String rname, @RequestParam("description") String description, @RequestParam("row") Integer row, @RequestParam("page") Integer page) {
        Map<String, Object> param = new HashMap<>();
        param.put("rno", rno);
        param.put("rname", rname);
        param.put("description", description);
        param.put("page", page);
        param.put("row", row);

        return service.findRoleByPageAndFilter(param);
    }

    @RequestMapping("unLinkedRole.do")
    @ResponseBody
    public List<Role> unLinkedRole(@RequestParam("uno") Integer uno) {
        return service.findUnLinkedRoleForUser(uno);
    }

    @RequestMapping("linkedRole.do")
    @ResponseBody
    public List<Role> linkedRole(@RequestParam("uno") Integer uno) {
        return service.findLinkedRoleForUser(uno);
    }

    @RequestMapping("setRole.do")
    @ResponseBody
    public String setRoles(@RequestParam("uno") Integer uno, @RequestParam("rnos") String rnos) {
        System.out.println(rnos);
        service.setRoles(uno, rnos);
        return "设置成功";
    }
}
