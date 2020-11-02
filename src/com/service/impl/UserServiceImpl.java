package com.service.impl;

import com.dao.UserDao;
import com.dao.impl.UserDaoImpl;
import com.domain.PageInfo;
import com.domain.User;
import com.service.UserService;

import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {
    private UserServiceImpl(){}
    private static UserServiceImpl service = new UserServiceImpl();
    public static UserServiceImpl getService(){
        return service;
    }

    private UserDao dao = UserDaoImpl.getDao();

    public User checkLogin(String uname, String upass) {
        return dao.findUserByNameAndPass(uname, upass);
    }

    public PageInfo findUserByPageAndFilter(Map<String, Object> param) {
        long total = dao.total(param);
        Integer row = (Integer) param.get("row");
        int maxPage = (int)Math.ceil(1.0*total/row);//向上取整
        maxPage = Math.max(1, maxPage);
        Integer page = (Integer) param.get("page");
        page = Math.min(page, maxPage);

        //数据库分页
        int start = (page-1)*row;
        int length = row;
        param.put("start", start);
        param.put("length", length);

        List<User> userList = dao.findUserByPageAndFilter(param);
        return new PageInfo(maxPage, userList);
    }

    @Override
    public void saveUser(User user) {
        dao.saveUser(user);
    }

    @Override
    public void userDelete(Integer uno) {
        dao.deleteUser(uno);
    }

    @Override
    public User findUserById(Integer uno) {
        return dao.findUserById(uno);
    }

    @Override
    public void userUpdate(User user) {
        dao.updateUser(user);
    }

    @Override
    public void deleteUsers(String unoStr) {
        String[] unoArray = unoStr.split(",");
        for (String uno : unoArray) {
            dao.deleteUser(Integer.parseInt(uno));
        }
    }

    @Override
    public void importUsers(List<User> users) {
        for (User user : users) {
            dao.saveUser(user);
        }
    }

    @Override
    public void updatePwd(Integer uno, String newPass) {
        dao.updatePwd(uno, newPass);
    }
}
