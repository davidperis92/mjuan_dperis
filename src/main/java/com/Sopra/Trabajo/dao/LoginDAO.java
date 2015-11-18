package com.Sopra.Trabajo.dao;
  
import java.util.ArrayList;
import java.util.List;


import org.hibernate.Session;

import com.Sopra.Trabajo.Model.Empleado;
import com.Sopra.Trabajo.dao.interfaces.ILoginDAO;
import com.Sopra.Trabajo.util.HibernateUtil;
  
public enum LoginDAO implements ILoginDAO {  

	INSTANCE;
    
    public static LoginDAO getInstance(){
    	return INSTANCE;
    }
    
	@SuppressWarnings("unchecked")
	public String validate(String dni, String pass) {          
    
		List<Empleado> lista = new ArrayList<Empleado>();
    	Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try{
			session.beginTransaction();
			lista = (List<Empleado>) session.createQuery("FROM Empleado WHERE dni='"+dni+"' AND contraseña='"+pass+"'").list();
			if(!lista.isEmpty()){
				return "OK";
			}
			else{
				lista = session.createQuery("FROM Empleado WHERE dni='"+dni+"'").list();
				if(lista.isEmpty())
					return "No existe un usuario con ese DNI";
				else
					return "La contraseña es incorrecta";
			}
		}catch(Exception e){
			e.printStackTrace();
			//session.getTransaction().rollback();
		}
		return null;
    }
	public void logout()
	{
		 HibernateUtil.shutdown();
	}

}  

