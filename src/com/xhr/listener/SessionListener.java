package com.xhr.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;

public class SessionListener implements HttpSessionListener, HttpSessionAttributeListener {

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        HttpSession session=httpSessionEvent.getSession();
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        HttpSession session=httpSessionEvent.getSession();
        ServletContext context=httpSessionEvent.getSession().getServletContext();
        Object object=context.getAttribute("count");
        int count=0;
        if (object!=null&&object.equals("")){
            count=Integer.parseInt(object.toString())-1;
        }
        context.setAttribute("count",count);
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent httpSessionBindingEvent) {
        String name=httpSessionBindingEvent.getName();
        if (name!=null&&name.equals("account")){
            ServletContext context=httpSessionBindingEvent.getSession().getServletContext();
            Object object=context.getAttribute("count");
            int count=0;
            if (object==null||object.equals("")){
                count=1;
            }else {
                count=Integer.parseInt(object.toString())+1;
            }
            context.setAttribute("count",count);
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent httpSessionBindingEvent) {

    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent httpSessionBindingEvent) {

    }
}
