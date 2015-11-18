package com.Sopra.Trabajo.Actions;
import com.Sopra.Trabajo.dao.LoginDAO;
import com.Sopra.Trabajo.dao.interfaces.ILoginDAO;
import com.opensymphony.xwork2.Action;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;

public class LoginAction implements Action {
	private String dni;
	private String password;
	private String error;
	private ILoginDAO iLoginDAO = LoginDAO.getInstance();
	
	private static final Logger log = LogManager.getLogger(LoginAction.class);

	
	public String execute() throws Exception {		
		
		String res = iLoginDAO.validate(dni, password);
        if(res.equals("OK")){    
        
            HttpSession session = ServletActionContext.getRequest().getSession();
            session.setAttribute("forward","menu");
            session.setAttribute("dni",dni);
            session.setAttribute("password", password);
            log.info("login: "+ dni);
            
			return SUCCESS;
		}
        else{
        	setError(res);
        	return ERROR;
        }
	}
	
	public String logout() throws Exception {
		HttpSession session = ServletActionContext.getRequest().getSession();
		//iLoginDAO.logout();
		log.info("logout: "+ session.getAttribute("dni"));
		session.removeAttribute("dni");
		session.removeAttribute("password");  
		session.setAttribute("forward","index");
		return SUCCESS;    
	}
	
	public String getPassword() {
		return password;    
	}

	public void setPassword(String password) {
		this.password = password;    
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		log.error(error);
		this.error = error;
	}

	public static Logger getLog() {
		return log;
	}
	
	

}
