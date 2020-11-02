package com.service;

import com.domain.PageInfo;
import com.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    public User checkLogin(String uname, String upass);
    public PageInfo findUserByPageAndFilter(Map<String, Object> param);

    public void saveUser(User user);

    public void userDelete(Integer uno);

    public User findUserById(Integer uno);

    public void userUpdate(User user);

    public void deleteUsers(String unoStr);

    public void importUsers(List<User> users);

    public void updatePwd(Integer uno, String newPass);
}
