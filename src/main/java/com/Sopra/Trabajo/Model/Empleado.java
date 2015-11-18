package com.Sopra.Trabajo.Model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "EMPLEADO")
public class Empleado implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="EMPLEADO_ID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "generator")  
	@SequenceGenerator(name = "generator", sequenceName = "EMP_0_SEQ", allocationSize=1)  
	private int id;
	
	@Column(name="NOMBRE")
	private String nombre;
	
	@Column(name="APELLIDOS")
	private String apellidos;
	
	@Column(name="DNI")
	private String dni;
	
	@Column(name="CONTRASEÑA")
	private String contraseña;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "DEPARTAMENTO_ID")
	private Departamento departamento;
	
	@ManyToOne(optional = false)
	@JoinColumn(name = "ROL_ID")
	private Rol rol;
	
	public Empleado() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getDni() {
		return dni;
	}
	public void setDni(String dni) {
		this.dni = dni;
	}
	public String getContraseña() {
		return contraseña;
	}
	public void setContraseña(String contraseña) {
		this.contraseña = contraseña;
	}
	public Departamento getDepartamento() {
		return departamento;
	}
	public void setDepartamento(Departamento departamento) {
		this.departamento = departamento;
	}
	public Rol getRol() {
		return rol;
	}
	public void setRol(Rol rol) {
		this.rol = rol;
	}

}
