package com.service.impl;

import com.dao.RoleDao;
import com.dao.impl.RoleDaoImpl;
import com.domain.PageInfo;
import com.domain.Role;
import com.service.RoleService;

import java.util.List;
import java.util.Map;

public class RoleServiceImpl implements RoleService {
    private RoleDao dao = new RoleDaoImpl();

    @Override
    public PageInfo findRoleByPageAndFilter(Map<String, Object> param) {
        long total = dao.total(param);
        int row = (int) param.get("row");
        int maxPage = (int) (total%row == 0 ? total/row : total/row +1);
        maxPage = Math.max(1, maxPage);

        int page = (int) param.get("page");
        page = Math.min(page, maxPage);

        int start = (page-1)*row;
        int length = row;
        param.put("start", start);
        param.put("length", length);
        List<Role> roles = dao.findRoleByPageAndFilter(param);
        return new PageInfo(maxPage, roles);
    }

    @Override
    public List<Role> findUnLinkedRoleForUser(Integer uno) {
        return dao.findUnLinkedRoleForUser(uno);
    }

    @Override
    public List<Role> findLinkedRoleForUser(Integer uno) {
        return dao.findLinkedRoleForUser(uno);
    }

    @Override
    public void setRoles(Integer uno, String rnos) {
        dao.removeRelationshipByUser(uno);
        String[] rnoArray = rnos.split(",");
        if (rnoArray.length == 0) {
            return;
        }

        for (String rno : rnoArray) {
            int $rno = Integer.parseInt(rno);
            dao.addRelationship(uno, $rno);
        }
    }
}
