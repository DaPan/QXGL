package com.dao;

import com.domain.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    public User findUserByNameAndPass(String uname,String upass);

    public long total(Map<String,Object> param);

    public List<User> findUserByPageAndFilter(Map<String,Object> param);

    public void saveUser(User user);

    public void deleteUser(Integer uno);

    public User findUserById(Integer uno);

    public void updateUser(User user);

    public void updatePwd(Integer uno, String newPass);
}
