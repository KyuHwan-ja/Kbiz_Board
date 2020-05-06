package com.mnet.exam.common;

import java.util.Collections;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter { 
	
	protected Log log = LogFactory.getLog(LoggerInterceptor.class); 
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception { 
	
		if (log.isDebugEnabled()) { 
			
			log.debug(" ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼ START ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼"); 
			
			log.debug("\t■ Request URI \t: " + request.getRequestURI()); 
			
			
			@SuppressWarnings({ "unchecked", "unused" })
			SortedMap<String, String[]> sMap = Collections.synchronizedSortedMap(new TreeMap<String, String[]>(request.getParameterMap()));
			
			synchronized (sMap) {
				
				for(String key : sMap.keySet()) {
			
					String[] value = sMap.get(key);
					
					for(int i=0; i<value.length; i++) {
						log.debug("\t■ Request Param : " + key + " = " + value[i]);
					}
					
				}
			}
			
		} 

		return super.preHandle(request, response, handler); 
	}
	
	@Override 
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception { 
		
		if (log.isDebugEnabled()) { 
		
			log.debug("▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲  END  ▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲\n"); 
		} 
	} 
}


