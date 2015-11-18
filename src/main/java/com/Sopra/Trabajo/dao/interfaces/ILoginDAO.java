package com.Sopra.Trabajo.dao.interfaces;

public interface ILoginDAO {

	public String validate(String dni, String pass);
	public void logout();
}
