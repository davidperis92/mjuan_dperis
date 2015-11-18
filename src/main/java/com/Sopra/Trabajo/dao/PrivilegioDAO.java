package com.Sopra.Trabajo.dao;

import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Privilegio;
import com.Sopra.Trabajo.dao.interfaces.IPrivilegioDAO;
import com.Sopra.Trabajo.util.HibernateUtil;

public enum PrivilegioDAO implements IPrivilegioDAO 
{
	
	INSTANCE;

	public static PrivilegioDAO getInstance(){
		return INSTANCE;
	}
	
	
	public Privilegio get(String nombre)
	{
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try
		{
			session.beginTransaction();
			Privilegio pri=(Privilegio) session.createQuery("FROM Privilegio where nombre='"+nombre+"'").list().get(0);
			return (pri!=null)?pri:null;

		}catch(Exception e){
			return null;
		}
		
	}

}
