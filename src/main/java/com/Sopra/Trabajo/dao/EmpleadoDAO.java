package com.Sopra.Trabajo.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Departamento;
import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.Model.Rol;
import com.Sopra.Trabajo.dao.interfaces.IEmpleadoDAO;
import com.Sopra.Trabajo.util.HibernateUtil;

public enum EmpleadoDAO implements IEmpleadoDAO{

	INSTANCE;
	
	public static EmpleadoDAO getInstance(){
		return INSTANCE;
	}
	
	
	public short existsEmpleado(String dni) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();
			if(session.createQuery("FROM Empleado where dni='"+dni+"'").list().isEmpty())
				return 0;
			
		}catch(Exception e){
			return -1;
		}
		return 1;
	}
	
	public short addEmpleado(String dni, String nombre, String apellidos, String password, int rol, int departamento){
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();
			Rol objrol = (Rol) session.createQuery("FROM Rol where id='"+ rol +"'").list().get(0);
			Departamento objDep = (Departamento) session.createQuery("FROM Departamento where id='"+ departamento +"'").list().get(0);
			
			Empleado emp = new Empleado();
			emp.setNombre(nombre);
			emp.setApellidos(apellidos);
			emp.setContraseña(password);
			emp.setDni(dni);
			emp.setRol(objrol);
			emp.setDepartamento(objDep);
			session.save(emp);
			return 1;
			
		}catch(Exception e){
			session.getTransaction().rollback();
			return -1;
		}
		finally{
			session.getTransaction().commit();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Empleado> getEmpleados(){
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		List<Empleado> empleados = null;
		try
		{
			session.beginTransaction();
			empleados = session.createQuery("FROM Empleado").list();
			
			return empleados;
			
		}catch(Exception e){
			session.getTransaction().rollback();
			return empleados;
		}
		
	}
	
	public Empleado getEmpleado(String dni){
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		Empleado empleado = null;
		try
		{
			session.beginTransaction();
			empleado = (Empleado) session.createQuery("FROM Empleado WHERE dni='"+dni+"'").list().get(0);
			
			return empleado;
			
		}catch(Exception e){
			session.getTransaction().rollback();
			return empleado;
		}

	}
	
 	public boolean deleteEmpleado(int id){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Empleado empleado = null;
		try
		{
			session.beginTransaction();
			empleado = session.get(Empleado.class, id);
			session.delete(empleado);
			return true;

		}catch(Exception e){
			session.getTransaction().rollback();
			return false;
		}
		finally{
			session.getTransaction().commit();
		}
	}
	
 	public boolean updateEmpleado(int id, String dni, String nombre, String apellidos, String password, int rol, int departamento){
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();
			Rol objrol = (Rol) session.createQuery("FROM Rol where id='"+ rol +"'").list().get(0);
			Departamento objDep = (Departamento) session.createQuery("FROM Departamento where id='"+ departamento +"'").list().get(0);
			
			Empleado emp = new Empleado();
			emp.setId(id);
			emp.setNombre(nombre);
			emp.setApellidos(apellidos);
			emp.setContraseña(password);
			emp.setDni(dni);
			emp.setRol(objrol);
			emp.setDepartamento(objDep);
			session.update(emp);
			return true;

		}catch(Exception e){
			session.getTransaction().rollback();
			return false;
		}
		finally{
			session.getTransaction().commit();
		}
	}
 	
 	public Long countEmpleados()
 	{
 		Session session = HibernateUtil.getSessionFactory().openSession();
 		session.beginTransaction();
 		
 		Query query = session.createQuery("select count(*) from Empleado");
 		Long count = (Long)query.uniqueResult();
 		
 		return count-1;
 	}
	
}
