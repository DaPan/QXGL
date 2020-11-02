package com.service.impl;

import com.dao.FnDao;
import com.domain.Fn;
import com.service.FnService;
import jdbc.JdbcFront;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FnServiceImpl implements FnService {
    private FnDao dao = new JdbcFront().createDaoImpl(FnDao.class);

    @Override
    public List<Fn> findFnAll() {
        List<Fn> fnList = dao.findFnAll();
        //将fnList中的菜单按照子父关系重新组装
        List<Fn> newFnList = reloadFn(fnList, -1);
        return newFnList;
    }

    @Override
    public void saveFn(Fn fn) {
        dao.saveFn(fn);
    }

    @Override
    public void deleteFn(Integer fno) {
        dao.deleteFn(fno);
    }

    @Override
    public void updateFn(Fn fn) {
        dao.updateFn(fn);
    }

    @Override
    public void setFns(Integer rno, String fnos) {
        dao.removeRelationshipByRole(rno);
        String[] fnoArray = fnos.split(",");
        for (String fno : fnoArray) {
            Map<String, Object> param = new HashMap<>();
            param.put("rno", rno);
            param.put("fno", Integer.parseInt(fno));
            dao.addRelationshipForRole(param);
        }
    }

    @Override
    public List<Integer> findLinkedFn(Integer rno) {
        return dao.findLinkedFns(rno);
    }

    @Override
    public List<Fn> findLoginUserMenus(Integer uno) {
        List<Fn> fns =  dao.findMenuByUser(uno);
        return reloadFn(fns, -1);
    }

    @Override
    public List<Fn> findLoginUserButtons(Integer uno) {
        return dao.findButtonByUser(uno);
    }

    @Override
    public List<Fn> findBaseFnAll() {
        return dao.findFnAll();
    }

    @Override
    public List<Fn> findFnsByUser(Integer uno) {
        return dao.findFnsByUser(uno);
    }

    /**
     *
     * @param source 装载零散的功能信息
     * @param pno 指定的是要组装的那一层功能信息的父级编号
     * @return  当前这一层组装好的功能信息（包含子信息）
     */
    private List<Fn> reloadFn(List<Fn> source,int pno) {
        List<Fn> newFnList = new ArrayList<>();//准备装载当前这一层组装好后的功能菜单
        for (Fn fn : source) {
            if (fn.getPno() == pno) {
                //找到了一个当前这层的功能
                if (fn.getFlag()==2) {
                    //当前功能是一个按钮，按钮没有子按钮
                }else{
                    //当前功能是一个菜单，菜单还需要装载子菜单
                    List<Fn> children = reloadFn(source, fn.getFno());
                    fn.setChildren(children);
                }
                newFnList.add(fn);
            }
        }
        return newFnList;
    }
}
