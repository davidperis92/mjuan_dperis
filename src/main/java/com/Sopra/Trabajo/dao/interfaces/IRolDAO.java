package com.Sopra.Trabajo.dao.interfaces;

import java.util.List;
import java.util.Set;

import com.Sopra.Trabajo.Model.Privilegio;
import com.Sopra.Trabajo.Model.Rol;

public interface IRolDAO {

	public List<Rol> getRoles();
	public short addRol(String nombre, Set<String> privis);
	public short remRol(int id);
	public short existRol(String nombre);
	public Rol getRol(int id);
	public boolean updateRol(int id, String nombre, Set<Privilegio> privis);
	public Long countRoles();
	
}
