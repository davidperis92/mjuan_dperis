package com.Sopra.Trabajo.dao;

import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.Model.Privilegio;

import com.Sopra.Trabajo.dao.interfaces.ICheckPrivilegeDAO;
import com.Sopra.Trabajo.util.HibernateUtil;

public enum CheckPrivilegeDAO implements ICheckPrivilegeDAO
{
	INSTANCE;
	
	public static CheckPrivilegeDAO getInstance(){
		return INSTANCE;
	}
	
	public boolean checkPrivilege(String dni, String privilege)
	{
		Session session = HibernateUtil.getSessionFactory().openSession();
		try
		{
			session.beginTransaction();
			Empleado emp = (Empleado) session.createQuery("FROM Empleado where dni='"+dni+"'").list().get(0);
			
			for(Privilegio i:emp.getRol().getPrivilegios())
			{	
				if(i.getNombre().equals(privilege))
					return true;
			}
			return false;
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
			session.getTransaction().rollback();
			return false;
		}
	
	}

}
