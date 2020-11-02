package com.service;

import com.domain.PageInfo;
import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleService {
    public PageInfo findRoleByPageAndFilter(Map<String ,Object> param);

    public List<Role> findUnLinkedRoleForUser(Integer uno);

    public List<Role> findLinkedRoleForUser(Integer uno);

    public void setRoles(Integer uno, String rnos);
}
