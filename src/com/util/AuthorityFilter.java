package com.util;

import com.domain.Fn;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * 权限验证过滤器
 */
@WebFilter("/*")
public class AuthorityFilter implements Filter {
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
//        request.getRequestURL();    //http://localhost:8080/qxgl/login.do
//        request.getRequestURI();    //qxgl/login.do
//        request.getServletPath();   //login.do

        String reqStr = request.getServletPath();

        List<Fn> fns = (List<Fn>) request.getSession().getAttribute("fns");
        List<Fn> userFns = (List<Fn>) request.getSession().getAttribute("userFns");

        if (fns == null) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }

        for (Fn fn : fns) {
            if(fn.getFhref() != null && !"".equals(fn.getFhref()) && reqStr.indexOf(fn.getFhref()) != -1){
                //该请求在所有功能中，需要权限验证
                for (Fn ufn : userFns) {
                    if(ufn.getFhref() != null && !"".equals(ufn.getFhref()) && reqStr.indexOf(ufn.getFhref()) != -1){
                        //具有此次请求的权限，放过
                        filterChain.doFilter(servletRequest, servletResponse);
                        return;
                    }
                }
                //没有此次权限
                servletResponse.setContentType("text/html;charset=utf-8");
                servletResponse.getWriter().println("没有足够的权限");
                return;
            }
        }
        //此次请求不在功能列表中 ，不要验证 放过
        filterChain.doFilter(servletRequest, servletResponse);
    }
}
