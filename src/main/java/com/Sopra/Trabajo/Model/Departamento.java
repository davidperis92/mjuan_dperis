package com.Sopra.Trabajo.Model;

import java.io.Serializable;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;



@Entity
@Table(name = "DEPARTAMENTO")
public class Departamento implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="DEPARTAMENTO_ID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "generator")  
	@SequenceGenerator(name = "generator", sequenceName = "DEP_0_SEQ", allocationSize=1)  
	private int id;
	
	@Column(name="NOMBRE")
	private String nombre;
	
	
	public Departamento() {
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


}
