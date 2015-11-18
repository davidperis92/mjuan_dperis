package com.Sopra.Trabajo.Actions;

import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.Sopra.Trabajo.Model.Privilegio;
import com.Sopra.Trabajo.Model.Rol;
import com.Sopra.Trabajo.dao.CheckPrivilegeDAO;
import com.Sopra.Trabajo.dao.PrivilegioDAO;
import com.Sopra.Trabajo.dao.RolDAO;
import com.Sopra.Trabajo.dao.interfaces.IPrivilegioDAO;
import com.Sopra.Trabajo.dao.interfaces.IRolDAO;
import com.opensymphony.xwork2.Action;

public class RolAction implements Action
{

	private String dni, error, nombre;
	private int action, id;
	private boolean PAddUser, PAddRol, PAddDep, PRemUser, PRemRol, PRemDep, PModUser, PModRol, PModDep, PAutUser, PAsgDep, PAsgRol;

	private static final Logger log = LogManager.getLogger(RolAction.class);
	
	private final IRolDAO iRolDao = RolDAO.getInstance();
	

	public String execute() throws Exception 
	{		
		HttpSession session = ServletActionContext.getRequest().getSession();
		this.dni=(String) session.getAttribute("dni");
		
		String perm=null;
		
		switch(action)
		{
			case 0:session.setAttribute("forward","newRol");perm="ALT_ROL";break;
			case 1:session.setAttribute("forward","remRol");perm="BAJ_ROL";break;
			case 2:session.setAttribute("forward","modRol");perm="MOD_ROL";break;
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
				switch(action)
				{
					case 0:setError("Crear roles");break;
					case 1:setError("Eliminar roles");break;
					case 2:setError("Modificar roles");break;
				}
				return ERROR;
			}
		}
			
	}
	
	public String Add() throws Exception
	{
		
		HttpSession session = ServletActionContext.getRequest().getSession();
		Set<String> privis = new HashSet<String>();
		if(PAddUser)privis.add("ALT_USU");
		if(PAddDep)privis.add("ALT_DEP");
		if(PAddRol)privis.add("ALT_ROL");
		if(PRemUser)privis.add("BAJ_USU");
		if(PRemRol)privis.add("BAJ_ROL");
		if(PRemDep)privis.add("BAJ_DEP");
		if(PModUser)privis.add("MOD_USU");
		if(PModRol)privis.add("MOD_ROL");
		if(PModDep)privis.add("MOD_DEP");
		if(PAutUser)privis.add("AUT_USU");
		if(PAsgDep)privis.add("ASI_DEP");
		if(PAsgRol)privis.add("ASI_ROL");

		session.setAttribute("forward","menu");
		short existerol = iRolDao.existRol(nombre);
		if(existerol < 1){
			if(existerol == 0){
				error = null;
				if(iRolDao.addRol( nombre, privis) < 0)//Añade el empleado
				{
					setError("Se ha producido un error, vuelve a intentarlo");
				}
				else{
					log.info("rol: "+ nombre + " añadido");
					session.setAttribute("forward","menu");
				}
			}
			else
				setError("Este rol ya existe");
		}
		else
			setError("Se ha producido un error, vuelve a intentarlo");

		return SUCCESS;
	}
	public String Rem() throws Exception
	{
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setAttribute("forward","menu");
		short existerol = iRolDao.existRol(nombre);
		try{
			if(existerol == 0){
				error = null;
				if(iRolDao.remRol(id) < 0)
					setError("Se ha producido un error, vuelve a intentarlo");
				else{
					log.info("Se ha eliminado el rol: "+nombre);
					session.setAttribute("forward","menu");
				}
			}
			else
				setError("ERROR, parece que el rol ya ha sido eliminado");
		}catch(Exception e){
			log.error(e.getMessage());
			setError("Se ha producido un error, vuelve a intentarlo");
		}
		
		return SUCCESS;
	}
	
	public String Mod(){
		HttpSession session = ServletActionContext.getRequest().getSession();		
		error = null;
		
		Set<Privilegio> privis = new HashSet<Privilegio>();
		IPrivilegioDAO priDAO = PrivilegioDAO.getInstance();
		if(PAddUser)privis.add(priDAO.get("ALT_USU"));
		if(PAddDep)privis.add(priDAO.get("ALT_DEP"));
		if(PAddRol)privis.add(priDAO.get("ALT_ROL"));
		if(PRemUser)privis.add(priDAO.get("BAJ_USU"));
		if(PRemRol)privis.add(priDAO.get("BAJ_ROL"));
		if(PRemDep)privis.add(priDAO.get("BAJ_DEP"));
		if(PModUser)privis.add(priDAO.get("MOD_USU"));
		if(PModRol)privis.add(priDAO.get("MOD_ROL"));
		if(PModDep)privis.add(priDAO.get("MOD_DEP"));
		if(PAutUser)privis.add(priDAO.get("AUT_USU"));
		if(PAsgDep)privis.add(priDAO.get("ASI_DEP"));
		if(PAsgRol)privis.add(priDAO.get("ASI_ROL"));
		
		
		if(!iRolDao.updateRol(id, nombre, privis))//Modifica el empleado
		{
			setError("Se ha producido un error, vuelve a intentarlo");
		}
		else
		{
			session.setAttribute("forward","menu");			
			log.info("empleado: " + id + " modificado");
		}
			
		return SUCCESS;
	}
	
	
	
	public String Get(){
		
		error = null;
		Rol rol = iRolDao.getRol(id);
		if(rol == null)
			error = "Se ha producido un error, vuelve a intentarlo";
		else{			
			nombre = rol.getNombre();
			
			PAddUser = rol.getPrivilegio("ALT_USU");
			PAddRol= rol.getPrivilegio("ALT_ROL"); 
			PAddDep= rol.getPrivilegio("ALT_DEP");
			PRemUser= rol.getPrivilegio("BAJ_USU");
			PRemRol= rol.getPrivilegio("BAJ_ROL");
			PRemDep= rol.getPrivilegio("BAJ_DEP"); 
			PModUser= rol.getPrivilegio("MOD_USU");
			PModRol= rol.getPrivilegio("MOD_ROL"); 
			PModDep= rol.getPrivilegio("MOD_DEP"); 
			PAutUser= rol.getPrivilegio("AUT_USU"); 
			PAsgDep= rol.getPrivilegio("ASI_DEP"); 
			PAsgRol= rol.getPrivilegio("ASI_ROL");

		}
			
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
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}


	public boolean isPAddUser() {
		return PAddUser;
	}

	public void setPAddUser(boolean pAddUser) {
		PAddUser = pAddUser;
	}

	public boolean isPAddRol() {
		return PAddRol;
	}

	public void setPAddRol(boolean pAddRol) {
		PAddRol = pAddRol;
	}

	public boolean isPAddDep() {
		return PAddDep;
	}

	public void setPAddDep(boolean pAddDep) {
		PAddDep = pAddDep;
	}

	public boolean isPRemUser() {
		return PRemUser;
	}

	public void setPRemUser(boolean pRemUser) {
		PRemUser = pRemUser;
	}

	public boolean isPRemRol() {
		return PRemRol;
	}

	public void setPRemRol(boolean pRemRol) {
		PRemRol = pRemRol;
	}

	public boolean isPRemDep() {
		return PRemDep;
	}

	public void setPRemDep(boolean pRemDep) {
		PRemDep = pRemDep;
	}

	public boolean isPModUser() {
		return PModUser;
	}

	public void setPModUser(boolean pModUser) {
		PModUser = pModUser;
	}

	public boolean isPModRol() {
		return PModRol;
	}

	public void setPModRol(boolean pModRol) {
		PModRol = pModRol;
	}

	public boolean isPModDep() {
		return PModDep;
	}

	public void setPModDep(boolean pModDep) {
		PModDep = pModDep;
	}

	public boolean isPAutUser() {
		return PAutUser;
	}

	public void setPAutUser(boolean pAutUser) {
		PAutUser = pAutUser;
	}

	public boolean isPAsgDep() {
		return PAsgDep;
	}

	public void setPAsgDep(boolean pAsgDep) {
		PAsgDep = pAsgDep;
	}

	public boolean isPAsgRol() {
		return PAsgRol;
	}

	public void setPAsgRol(boolean pAsgRol) {
		PAsgRol = pAsgRol;
	}


}
