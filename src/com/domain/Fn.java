package com.domain;

import java.util.List;

public class Fn {
    private Integer fno;
    private String fname;
    private String fhref;
    private String ftarget;
    private Integer flag;
    private Integer pno;

    private String yl1;
    private String yl2;

    private Fn fn;
    private List<Fn> children;  //装载当前菜单的子菜单/子按钮

    public Fn() {
    }

    public Fn(Integer fno, String fname, String fhref, String ftarget, Integer flag, Integer pno, String yl1, String yl2) {
        this.fno = fno;
        this.fname = fname;
        this.fhref = fhref;
        this.ftarget = ftarget;
        this.flag = flag;
        this.pno = pno;
        this.yl1 = yl1;
        this.yl2 = yl2;
    }

    public Integer getFno() {
        return fno;
    }

    public void setFno(Integer fno) {
        this.fno = fno;
    }

    public String getFname() {
        return fname;
    }

    public void setChildren(List<Fn> children) {
        this.children = children;
    }

    public List<Fn> getChildren() {
        return children;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getFhref() {
        return fhref;
    }

    public void setFhref(String fhref) {
        this.fhref = fhref;
    }

    public String getFtarget() {
        return ftarget;
    }

    public void setFtarget(String ftarget) {
        this.ftarget = ftarget;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public Integer getPno() {
        return pno;
    }

    public void setPno(Integer pno) {
        this.pno = pno;
    }

    public String getYl1() {
        return yl1;
    }

    public void setYl1(String yl1) {
        this.yl1 = yl1;
    }

    public String getYl2() {
        return yl2;
    }

    public void setYl2(String yl2) {
        this.yl2 = yl2;
    }

    public Fn getFn() {
        return fn;
    }

    public void setFn(Fn fn) {
        this.fn = fn;
    }
}
