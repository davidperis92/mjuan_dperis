package com.Sopra.Trabajo.Actions;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

public class RedirectAction implements Action{
	
	private static final Logger log = LogManager.getLogger(RedirectAction.class);
	
	public String execute() throws Exception 
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
			String dni = (String) session.getAttribute("dni");
			String forward = (String) session.getAttribute("forward");
			if(dni == null)
				forward = "index";
			log.info("going to: " + forward);
			return forward;  
	}
	
	public void back()
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("forward","menu");
	}

	public static Logger getLog() {
		return log;
	}
	
	

}
