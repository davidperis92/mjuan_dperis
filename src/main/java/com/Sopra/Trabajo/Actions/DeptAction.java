package com.Sopra.Trabajo.Actions;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.Sopra.Trabajo.Model.Departamento;
import com.Sopra.Trabajo.dao.CheckPrivilegeDAO;
import com.Sopra.Trabajo.dao.DepartamentoDAO;
import com.Sopra.Trabajo.dao.interfaces.IDepartamentoDAO;
import com.opensymphony.xwork2.Action;

public class DeptAction implements Action
{

	private String nombre;
	private String error;
	private int action;
	private String dni;
	private int id;
	
	private static final Logger log = LogManager.getLogger(DeptAction.class);
	private IDepartamentoDAO iDeptDAO = DepartamentoDAO.getInstance();

	public String execute() throws Exception 
	{		
		HttpSession session = ServletActionContext.getRequest().getSession();
		this.dni=(String) session.getAttribute("dni");
		
		String perm=null;
		
		switch(action)
		{
			case 0:session.setAttribute("forward","newDept");perm="ALT_DEP";break;
			case 1:session.setAttribute("forward","remDept");perm="BAJ_DEP";break;
			case 2:session.setAttribute("forward","modDept");perm="MOD_DEP";break;
			default:session.setAttribute("forward","menu");break;
		}
		 
		if(CheckPrivilegeDAO.getInstance().checkPrivilege(dni, perm))
			return SUCCESS;
		else
		{
			if(dni == null){
				session.setAttribute("forward", "index");
				return SUCCESS;
			}
			else{
				session.setAttribute("forward","menu");
				switch(action)
				{
					case 0:setError("Crear departamentos");break;
					case 1:setError("Eliminar departamentos");break;
					case 2:setError("Modificar departamentos");break;
				}
	
				return ERROR;
			}
		}
			
	}
	
	public String Add() throws Exception
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("forward","menu");
		short existeDepartamento = iDeptDAO.existDepartamento(nombre);
		if(existeDepartamento >= 0){
			if(existeDepartamento == 0){
				error = null;
				if(iDeptDAO.addDepartamento( nombre) < 0)//Añade el empleado
					setError("Se ha producido un error, vuelve a intentarlo");

				else{
					session.setAttribute("forward","menu");
					log.info("departamento: "+ nombre + " añadido.");
				}
			}
			else
				setError("Este departamento ya existe");			
		}
		else
			setError("Se ha producido un error, vuelve a intentarlo");
			
		
		return SUCCESS;
	}
	public String Rem() throws Exception
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("forward","menu");
		short existeDepartamento = iDeptDAO.existDepartamento(nombre);
		if(existeDepartamento == 0){
			
				error = null;
				if(iDeptDAO.remDepartamento(id) < 0)//Añade el empleado
					setError("Se ha producido un error, vuelve a intentarlo");
				else
					session.setAttribute("forward","menu");
		}
		else
			setError("ERROR, parece que el departamento ya ha sido eliminado ");
		
		return SUCCESS;
	}
	
	public String Get() throws Exception
	{
		Departamento dep = iDeptDAO.getDepartamento(id);
		error = null;
		
		if(dep == null)
			setError("Se ha producido un error, vuelve a intentarlo");
		else{
			nombre = dep.getNombre();
		}
		
		return SUCCESS;
	}
	
	public String Mod() throws Exception
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("forward","menu");
			
		error = null;
		if(!iDeptDAO.updateDepartamento(id, nombre))//Añade el empleado
			setError("Se ha producido un error, vuelve a intentarlo");
		else
			session.setAttribute("forward","menu");

		
		return SUCCESS;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		log.error(error);
		this.error = error;
	}
	

	public int getAction() {
		return action;
	}

	public void setAction(int action) {
		this.action = action;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNombre() {
		return nombre;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}
	

	public IDepartamentoDAO getiDeptDAO() {
		return iDeptDAO;
	}

	public void setiDeptDAO(IDepartamentoDAO iDeptDAO) {
		this.iDeptDAO = iDeptDAO;
	}

	public String getDni() {
		return dni;
	}

	public static Logger getLog() {
		return log;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
}
