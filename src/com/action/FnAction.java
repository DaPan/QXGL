package com.action;

import com.domain.Fn;
import com.service.FnService;
import com.service.impl.FnServiceImpl;
import mymvc.RequestMapping;
import mymvc.RequestParam;
import mymvc.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public class FnAction {

    private FnService service = new FnServiceImpl();

    @RequestMapping("fnList.do")
    @ResponseBody
    public List<Fn> fnList() {
        return service.findFnAll();
    }

    @RequestMapping("fnAdd.do")
    @ResponseBody
    public void FnAdd(Fn fn) {
        service.saveFn(fn);
    }

    @RequestMapping("fnDelete.do")
    @ResponseBody
    public void fnDelete(@RequestParam("fno") Integer fno) {
        service.deleteFn(fno);
    }

    @RequestMapping("fnUpdate.do")
    @ResponseBody
    public void fnUpdate(Fn fn) {
        service.updateFn(fn);
    }

    @RequestMapping("setFns.do")
    @ResponseBody
    public String setFns(@RequestParam("rno") Integer rno,@RequestParam("fnos") String fnos){
        service.setFns(rno, fnos);
        return "分配成功";
    }

    @RequestMapping("linkedFns.do")
    @ResponseBody
    public List<Integer> linkedFns(@RequestParam("rno") Integer rno) {
        return service.findLinkedFn(rno);
    }

    @RequestMapping("userMenus.do")
    @ResponseBody
    public List<Fn> userMenus(HttpServletRequest request){
       return (List<Fn>) request.getSession().getAttribute("userMenus");
    }

    @RequestMapping("userButtons.do")
    @ResponseBody
    public List<Fn> userButtons(HttpServletRequest request) {
        return (List<Fn>) request.getSession().getAttribute("userButtons");
    }
}
