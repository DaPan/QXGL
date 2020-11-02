package com.service;

import com.domain.Fn;

import java.util.List;

public interface FnService {

    public List<Fn> findFnAll();

    public void saveFn(Fn fn);

    public void deleteFn(Integer fn);

    public void updateFn(Fn fn);

    public void setFns(Integer rno, String fnos);

    public List<Integer> findLinkedFn(Integer rno);

    public List<Fn> findLoginUserMenus(Integer uno);

    public List<Fn> findLoginUserButtons(Integer uno);

    public List<Fn> findBaseFnAll();

    public List<Fn> findFnsByUser(Integer uno);
}


