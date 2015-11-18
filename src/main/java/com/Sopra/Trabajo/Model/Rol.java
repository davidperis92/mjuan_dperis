package com.Sopra.Trabajo.Model;


import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "ROL")
public class Rol implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ROL_ID")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "generatorRol")  
	@SequenceGenerator(name = "generatorRol", sequenceName = "ROL_0_SEQ", allocationSize=1)  
	private int id;
	
	@Column(name="NOMBRE")
	private String nombre;
	
	
	@ManyToMany (cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	@JoinTable(name="ROL_PRIV", 
				joinColumns={@JoinColumn(name="ROL_ID")}, 
				inverseJoinColumns={@JoinColumn(name="PRIVILEGIO_ID")})
	private Set<Privilegio> privilegios = new HashSet<Privilegio>();
	
	
	public Rol() {
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

	public Set<Privilegio> getPrivilegios() {
		return privilegios;
	}

	public void setPrivilegios(Set<Privilegio> privilegios) {
		this.privilegios = privilegios;
	}

	public boolean getPrivilegio(String txt) 
	{		
		for(Privilegio i:privilegios)
			if(i.getNombre().equals(txt))return true;
		return false;
	}
	public Set<String> StringArray()
	{
		Set<String> txt = new HashSet<String>();
		for(Privilegio i:privilegios)
			txt.add(i.getNombre());
		
		return txt;
	}
	

}
