package com.Sopra.Trabajo.dao;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;




import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.Model.Privilegio;
import com.Sopra.Trabajo.Model.Rol;
import com.Sopra.Trabajo.dao.interfaces.IRolDAO;
import com.Sopra.Trabajo.util.HibernateUtil;

public enum RolDAO implements IRolDAO{

	INSTANCE;
	
	public static RolDAO getInstance(){
		return INSTANCE;
	}

	@SuppressWarnings("unchecked")
	public List<Rol> getRoles() {          
    
		List<Rol> lista;
    	Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			lista = (List<Rol>) session.createQuery("FROM Rol").list();
			if(!lista.isEmpty()){
				return lista;
			}
			else{
				return null;
			}
		}catch(Exception e){
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		return null;
    }
	public short addRol(String nombre, Set<String> privis){
		
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try
		{
			session.beginTransaction();			
			
			Rol rol = new Rol();
			rol.setNombre(nombre);
			Set<Privilegio> p = new HashSet<Privilegio>();
			for(String i: privis)
			{
				Privilegio pri=PrivilegioDAO.getInstance().get(i);
				pri.addRol(rol);
				p.add(pri);
			}
			
			rol.setPrivilegios(p);			
			session.save(rol);
	
			return 1;
			
		}catch(Exception e){
			
			session.getTransaction().rollback();
			return -1;
		}
		finally{
			session.getTransaction().commit();
		}		
	}
	public short remRol(int id){
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try
		{
			session.beginTransaction();			
			@SuppressWarnings("unchecked")
			List<Empleado> empleados = session.createQuery("From Empleado e WHERE e.rol.id = '"+id+"'").list();
			Rol sinRol = session.get(Rol.class, 0);
			for(Empleado e: empleados){
				e.setRol(sinRol);
				session.update(e);
			}
			
			Rol rol = session.get(Rol.class, id);
			rol.setPrivilegios(null);
			session.update(rol);
			session.delete(rol);
			return 1;
			
		}catch(Exception e)
		{
			
			session.getTransaction().rollback();
			return -1;
		}
		finally{
			session.getTransaction().commit();
		}		
	}

	public short existRol(String nombre) {
		
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try
		{
			session.beginTransaction();
			if(session.createQuery("FROM Rol where nombre='"+nombre+"'").list().isEmpty())
				return 0;
			
		}catch(Exception e){
			return -1;
		}
		return 1;
	}

	public Rol getRol(int id) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Rol rol = null;
		
		try
		{
			session.beginTransaction();
			rol = (Rol) session.get(Rol.class,id);			
			
			return rol;
			
		}catch(Exception e){
			session.getTransaction().rollback();
			return rol;
		}

	}

	public boolean updateRol(int id, String nombre, Set<Privilegio> privis) 
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Rol rol = null;
		try
		{
			session.beginTransaction();
			rol = (Rol) session.get(Rol.class,id);	
			rol.setNombre(nombre);
			rol.setPrivilegios(privis);
			session.update(rol);
			return true;
		}
		catch(Exception e)
		{
			
			session.getTransaction().rollback();
			return false;
		}
		finally
		{
			session.getTransaction().commit();
		}		
	}
	
	public Long countRoles()
 	{
 		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
 		session.beginTransaction();
 		
 		Query query = session.createQuery("select count(*) from Rol");
 		Long count = (Long)query.uniqueResult();
 		
 		return count-2;
 	}
	
	
}
