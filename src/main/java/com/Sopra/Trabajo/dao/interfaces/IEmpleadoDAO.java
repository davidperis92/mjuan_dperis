package com.Sopra.Trabajo.dao.interfaces;

import java.util.List;

import com.Sopra.Trabajo.Model.Empleado;

public interface IEmpleadoDAO {

	public short existsEmpleado(String dni);
	
	public short addEmpleado(String dni, String nombre, String apellidos, String password, int rol, int departamento);
	
	public List<Empleado> getEmpleados();
	
	public Empleado getEmpleado(String dni);
	
	public boolean deleteEmpleado(int id);
	
	public boolean updateEmpleado(int id, String dni, String nombre, String apellidos, String password, int rol, int departamento);
	
	public Long countEmpleados();
	
}
