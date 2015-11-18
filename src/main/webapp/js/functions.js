/**
 * 
 */


function checkForm(dni, nombre, apellidos, password, password2, rol, departamento){
	var error = null;
	if(dni.length < 9){
		error = "El DNI debe contener 9 caracteres";
		return error;
	}
	if(nombre.length < 1){
		error = "El campo de nombre esta vac�o";
		return error;
	}
	if(apellidos.length < 1){
		error = "El campo de apellidos esta vac�o";
		return error;
	}
	if(password.length < 3){
		error = "La contrase�a debe tener al menos 3 caracteres";
		return error;
	}
	if(password2 != password)
		error = "Las contrase�as deben coincidir";
	
	return error;
}
	
function post(nombreForm) {
    var form = document.getElementById(nombreForm);
    form.submit();
}
	
	
