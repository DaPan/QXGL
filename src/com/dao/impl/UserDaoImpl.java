package com.dao.impl;

import com.dao.UserDao;
import com.domain.User;
import jdbc.JdbcFront;
import jdk.nashorn.internal.scripts.JD;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDaoImpl implements UserDao {
    private UserDaoImpl(){}
    private static UserDaoImpl dao;
    public static UserDaoImpl getDao(){
        if (dao == null) {
            synchronized ("dapan"){
                if (dao == null){
                    dao = new UserDaoImpl();
                }
            }
        }
        return dao;
    }

    public User findUserByNameAndPass(String uname, String upass) {
        String sql = "select * from t_user where uname=#{uname} and upass = #{upass} and del = 1";
        Map<String, Object> param = new HashMap<>();
        param.put("uname", uname);
        param.put("upass", upass);
        JdbcFront jdbc = new JdbcFront();
        //使用jdbc框架执行sql语句实现查找操作，将查询结果组成User类型对象，执行sql需要的参数在param集合中
        return jdbc.selectOne(sql, User.class, param);
    }

    public long total(Map<String, Object> param) {
        String sql = "select count(*) from t_user where del = 1 ";

        Integer uno = (Integer) param.get("uno");
        if (uno != null) {
            sql += " and uno = #{uno} ";
        }
        String uname = (String) param.get("uname");
        if(uname!=null && !"".equals(uname)){
            sql += " and uname like concat(#{uname},'%') ";
        }
        String sex = (String) param.get("sex");
        if(sex != null){
            sql += " and sex = #{sex} ";
        }

        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectOne(sql, long.class, param);

    }

    public List<User> findUserByPageAndFilter(Map<String, Object> param) {
        String sql = "select * from t_user where del = 1 ";

        Integer uno = (Integer) param.get("uno");
        if (uno != null) {
            sql += " and uno = #{uno} ";
        }
        String uname = (String) param.get("uname");
        if(uname!=null && !"".equals(uname)){
            sql += " and uname like concat(#{uname},'%') ";
        }
        String sex = (String) param.get("sex");
        if(sex != null){
            sql += " and sex = #{sex} ";
        }
        sql += " order by uno  ";
        sql += " limit #{start},#{length} ";

        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectList(sql, User.class, param);
    }

    @Override
    public void saveUser(User user) {
        String sql = "insert into t_user values(null,#{uname},#{upass},#{truename},#{sex},#{age},1,now(),#{yl1},#{yl2} ) ";
        JdbcFront jdbc = new JdbcFront();
        jdbc.insert(sql, user);
    }

    @Override
    public void deleteUser(Integer uno) {
        String sql = "update t_user set del = 2 where uno = #{uno}";
        JdbcFront jdbc = new JdbcFront();
        jdbc.update(sql, uno);
    }

    @Override
    public User findUserById(Integer uno) {
        String sql = "select * from t_user where uno = #{uno}";
        JdbcFront jdbc = new JdbcFront();
        return jdbc.selectOne(sql, User.class, uno);
    }

    @Override
    public void updateUser(User user) {
        String sql = "update t_user set uname=#{uname},truename=#{truename},age=#{age},sex=#{sex} where uno=#{uno}";
        JdbcFront jdbc = new JdbcFront();
        jdbc.update(sql, user);
    }

    @Override
    public void updatePwd(Integer uno, String newPass) {
        String sql = "update t_user set upass=#{newPass} where uno = #{uno}";
        JdbcFront jdbc = new JdbcFront();
        Map<String ,Object> param = new HashMap<>();
        param.put("uno", uno);
        param.put("newPass", newPass);
        jdbc.update(sql, param);
    }
}
