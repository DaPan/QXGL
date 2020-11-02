package com.dao;

import com.domain.Role;

import java.util.List;
import java.util.Map;

public interface RoleDao {
    public long total(Map<String ,Object> param);

    public List<Role> findRoleByPageAndFilter(Map<String, Object> param);

    public List<Role> findUnLinkedRoleForUser(Integer uno);

    public List<Role> findLinkedRoleForUser(Integer uno);

    public void addRelationship(Integer uno, Integer rno);

    public void removeRelationshipByUser(Integer uno);
}
