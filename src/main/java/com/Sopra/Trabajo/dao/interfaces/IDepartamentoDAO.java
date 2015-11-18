package com.Sopra.Trabajo.dao.interfaces;

import java.util.List;

import com.Sopra.Trabajo.Model.Departamento;

public interface IDepartamentoDAO {

	public List<Departamento> getDepartamentos();
	public short addDepartamento(String nombre);
	public short remDepartamento(int id);
	public short existDepartamento(String nombre);
	public Departamento getDepartamento(int id);
	public boolean updateDepartamento(int id, String nombre);
	public Long countDepartamentos();
	
}
