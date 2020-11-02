package com.dao.impl;

import com.dao.RoleDao;
import com.domain.Role;
import jdbc.JdbcFront;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RoleDaoImpl implements RoleDao {
    @Override
    public long total(Map<String, Object> param) {
        String sql = "select count(*) from t_role where del = 1 ";

        Integer rno = (Integer) param.get("rno");
        if (rno != null) {
            sql += " and rno = #{rno} ";
        }
        String rname = (String) param.get("rname");
        if (rname != null && "".equals(rname)) {
            sql += " and rname like concat(#{rname},'%') ";
        }
        String description = (String) param.get("description");
        if (description != null && "".equals(description)) {
            sql += " and description like concat(#{description},'%') ";
        }
        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectOne(sql, long.class, param);
    }

    @Override
    public List<Role> findRoleByPageAndFilter(Map<String, Object> param) {
        String sql = "select * from t_role where del = 1 ";

        Integer rno = (Integer) param.get("rno");
        if (rno != null) {
            sql += " and rno = #{rno} ";
        }
        String rname = (String) param.get("rname");
        if (rname != null && !"".equals(rname)) {
            sql += " and rname like concat(#{rname},'%') ";
        }
        String description = (String) param.get("description");
        if (description != null && !"".equals(description)) {
            sql += " and description like concat(#{description},'%') ";
        }
        sql += " order by createtime desc ";
        sql += " limit #{start},#{length} ";

        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectList(sql,Role.class,param);
    }

    @Override
    public List<Role> findUnLinkedRoleForUser(Integer uno) {
        String sql = "select * from t_role where rno not in (select rno from t_user_role where uno = #{uno})";
        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectList(sql, Role.class, uno);
    }

    @Override
    public List<Role> findLinkedRoleForUser(Integer uno) {
        String sql = "select * from t_role where rno in (select rno from t_user_role where uno = #{uno})";
        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectList(sql, Role.class, uno);
    }

    @Override
    public void addRelationship(Integer uno, Integer rno) {
        Map<String,Integer> param = new HashMap<>();
        param.put("uno", uno);
        param.put("rno", rno);
        String sql = "insert into t_user_role values(#{uno},#{rno})";
        JdbcFront jdbc = new JdbcFront();
        jdbc.insert(sql, param);
    }

    @Override
    public void removeRelationshipByUser(Integer uno) {
        String sql = "delete from t_user_role where uno = #{uno}";
        JdbcFront jdbc = new JdbcFront();
        jdbc.delete(sql, uno);
    }


}
