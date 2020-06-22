package com.xhr.filter;

import com.xhr.util.BaseUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SessionFilter implements Filter {
    String urlPass;
    @Override
    public void init(FilterConfig config) throws ServletException {
        urlPass=config.getInitParameter("urlPass");
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request=(HttpServletRequest)req;
        HttpServletResponse response=(HttpServletResponse)resp;
        String url=request.getRequestURI();
        boolean state=false;//如果循环结束还是false说明没有匹配上白名单，true匹配上  匹配上就放行
        if(!BaseUtil.checkNull(urlPass)){
            String[] strs=urlPass.split(",");
            for(int i=0;i<strs.length;i++){
                if(url.contains(strs[i])){
                    state=true;
                    break;
                }
            }
        }

        if(state){
            chain.doFilter(req, resp);//放行
        }else{
            HttpSession session=request.getSession();
            Object account=session.getAttribute("account");
            String path=request.getContextPath();
            /*登陆界面和login方法不应该拦截
             * 1：配置路径时将其过滤
             * 2: 拦截了，看看是不是可以放行，如果是login的话直接放行
             * */

            if(account==null){
                response.sendRedirect(path+"/module/login.jsp");
            }else{
                chain.doFilter(req, resp);//放行
            }
        }
    }

    @Override
    public void destroy() {
    }
}
