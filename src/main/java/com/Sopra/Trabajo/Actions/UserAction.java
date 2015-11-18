package com.Sopra.Trabajo.Actions;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.dao.CheckPrivilegeDAO;
import com.Sopra.Trabajo.dao.EmpleadoDAO;
import com.Sopra.Trabajo.dao.interfaces.IEmpleadoDAO;
import com.Sopra.Trabajo.util.HibernateUtil;
import com.opensymphony.xwork2.Action;

public class UserAction implements Action
{

	private String dni, nombre, apellidos, password, password2;
	private int rol, departamento, id;
	private static final Logger log = LogManager.getLogger(UserAction.class);
	
	private final IEmpleadoDAO iEmpleadoDAO = EmpleadoDAO.getInstance();
	
	private String error;
	
	private int action;

	
	public String execute() throws Exception 
	{		
		HttpSession session = ServletActionContext.getRequest().getSession();
		this.dni=(String) session.getAttribute("dni");
		
		this.error=null;
		String perm=null;
		
		switch(action)
		{
			case 0:session.setAttribute("forward","newUser");perm="ALT_USU";break;
			case 1:session.setAttribute("forward","remUser");perm="BAJ_USU";break;
			case 2:session.setAttribute("forward","modUser");perm="MOD_USU";break;
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
				if(perm.equals("MOD_USU"))
					if(CheckPrivilegeDAO.getInstance().checkPrivilege(dni, "AUT_USU"))
					{
						session.setAttribute("forward","modUser");
						return SUCCESS;
					}
				session.setAttribute("forward","menu");
				switch(action)
				{
					case 0:setError("Crear usuarios");break;
					case 1:setError("Eliminar usuarios");break;
					case 2:setError("Modificar usuarios");break;
				}
			}
			return ERROR;
		}
			
	}
	
	public String Add()
	{

		HttpSession session = ServletActionContext.getRequest().getSession();
		short existeEmpleado = iEmpleadoDAO.existsEmpleado(dni);
		
		if(existeEmpleado >= 0){
			if(existeEmpleado == 0){
				error = null;
				if(iEmpleadoDAO.addEmpleado(dni, nombre, apellidos, password, rol, departamento) < 0)//Añade el empleado
				{	
					setError("Se ha producido un error, vuelve a intentarlo");
				}
				else
					session.setAttribute("forward","menu");
			}
			else
			{
				setError("Este empleado ya existe");
			}
		}
		else
		{
			setError("Se ha producido un error, vuelve a intentarlo");
		}
		
		return SUCCESS;
	}
	
	public String Remove(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		
		error = null;
		if(!iEmpleadoDAO.deleteEmpleado(id))//Elimina el empleado
		{
			setError("Se ha producido un error, vuelve a intentarlo");
		}
		else{
			session.setAttribute("forward","menu");
			//log.info("empleado: " + id + " eliminado.");
		}
			
		return SUCCESS;
	}
	
	public String Get(){
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		error = null;
		Empleado emp = session.get(Empleado.class, id);
		if(emp == null){
			setError("Se ha producido un error, vuelve a intentarlo");
		}
		else{
			dni = emp.getDni();
			nombre = emp.getNombre();
			apellidos = emp.getApellidos();
			password = emp.getContraseña();
			rol = emp.getRol().getId();
			departamento = emp.getDepartamento().getId();
		}
			
		return SUCCESS;
	}
	
	public String Mod(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		
		error = null;
		if(!iEmpleadoDAO.updateEmpleado(id, dni, nombre, apellidos, password, rol, departamento))//Modifica el empleado
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
	
	
//Geters and Seters
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
	
	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidos() {
		return apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public int getRol() {
		return rol;
	}

	public void setRol(int rol) {
		this.rol = rol;
	}

	public int getDepartamento() {
		return departamento;
	}

	public void setDepartamento(int departamento) {
		this.departamento = departamento;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
	
	

}
