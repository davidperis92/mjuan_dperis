package com.Sopra.Trabajo.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Departamento;
import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.dao.interfaces.IDepartamentoDAO;
import com.Sopra.Trabajo.util.HibernateUtil;

public enum DepartamentoDAO implements IDepartamentoDAO {

	INSTANCE;
	
	public static DepartamentoDAO getInstance(){
		return INSTANCE;
	}
	
	@SuppressWarnings("unchecked")
	public List<Departamento> getDepartamentos() {          
    
		List<Departamento> lista;
    	Session session = HibernateUtil.getSessionFactory().openSession();
		try{
			session.beginTransaction();
			lista = (List<Departamento>) session.createQuery("FROM Departamento").list();
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
	
	public short addDepartamento(String nombre){
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();			
			
			Departamento dept = new Departamento();
			dept.setNombre(nombre);
			session.save(dept);
			return 1;
			
		}catch(Exception e){
			session.getTransaction().rollback();
			return -1;
		}
		finally{
			session.getTransaction().commit();
		}		
	}
	public short remDepartamento(int id){
		
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();		
			@SuppressWarnings("unchecked")
			List<Empleado> empleados = session.createQuery("From Empleado e WHERE e.departamento.id = '"+id+"'").list();
			Departamento sinDep = session.get(Departamento.class, 0);
			for(Empleado e: empleados){
				e.setDepartamento(sinDep);
				session.update(e);
			}
			
			Departamento dept = session.get(Departamento.class, id);
			session.delete(dept);
			return 1;
			
		}catch(Exception e)
		{
			System.out.println(e);
			session.getTransaction().rollback();
			return -1;
		}
		finally{
			session.getTransaction().commit();
		}		
	}

	public short existDepartamento(String nombre) 
	{
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();
			if(session.createQuery("FROM Departamento where nombre='"+nombre+"'").list().isEmpty())
				return 0;
			
		}catch(Exception e){
			return -1;
		}
		return 1;
	}
	
	public Departamento getDepartamento(int id) {          
	    
		Departamento dep;
    	Session session = HibernateUtil.getSessionFactory().openSession();
		try{
			session.beginTransaction();
			dep = session.get(Departamento.class, id);
			
			if(dep != null){
				return dep;
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

	public boolean updateDepartamento(int id, String nombre) {
		
		Departamento dep;
    	Session session = HibernateUtil.getSessionFactory().openSession();
		try{
			session.beginTransaction();
			dep = new Departamento();
			dep.setId(id);
			dep.setNombre(nombre);
			session.update(dep);
			
			return true;
			
		}catch(Exception e){
			e.printStackTrace();
			session.getTransaction().rollback();
		}
		finally{
			session.getTransaction().commit();
		}		
		
		return false;
	}
	
	public Long countDepartamentos()
 	{
 		Session session = HibernateUtil.getSessionFactory().openSession();
 		session.beginTransaction();
 		
 		Query query = session.createQuery("select count(*) from Departamento");
 		Long count = (Long)query.uniqueResult();
 		
 		return count-2;
 	}
	
}
