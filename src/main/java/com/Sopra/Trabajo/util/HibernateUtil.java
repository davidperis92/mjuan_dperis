package com.Sopra.Trabajo.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

	private static SessionFactory sessionFactory;

	private static void buildSessionFactory() {
		if(sessionFactory == null){
			try {
				// Create the SessionFactory from hibernate.cfg.xml
				sessionFactory = new Configuration().configure().buildSessionFactory();
			} catch (Throwable ex) {
				// Make sure you log the exception, as it might be swallowed
				ex.printStackTrace();


			}
		}	
	}

	public static SessionFactory getSessionFactory() {
		buildSessionFactory();
		return sessionFactory;
	}

	public static void shutdown() {
		// Close caches and connection pools
		getSessionFactory().close();
	}
	
	

}
