package com.Sopra.Trabajo.Model;


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;



import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="PRIVILEGIO")
public class Privilegio implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="PRIVILEGIO_ID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "generatorPri")  
	@SequenceGenerator(name = "generatorPri", sequenceName = "PRI_0_SEQ", allocationSize=1)  
	private int id;
	
	@Column(name="NOMBRE")
	private String nombre;
	
	@ManyToMany(mappedBy = "privilegios", fetch = FetchType.EAGER)  
	private Set<Rol> rol = new HashSet<Rol>();
		
	
	public Set<Rol> getRol() {
		return rol;
	}

	public void setRol(Set<Rol> rol) {
		this.rol = rol;
	}
	public void addRol(Rol rol)
	{
		this.rol.add(rol);
	}

	public Privilegio() {
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
