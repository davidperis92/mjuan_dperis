<%@page import="com.Sopra.Trabajo.dao.DepartamentoDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Departamento"%>
<%@page import="java.util.List"%>
<%@page 
		import="com.Sopra.Trabajo.dao.RolDAO"
		import="com.Sopra.Trabajo.dao.EmpleadoDAO"
		import="com.Sopra.Trabajo.dao.interfaces.IEmpleadoDAO"
		import="com.Sopra.Trabajo.dao.interfaces.ICheckPrivilegeDAO"
		import="com.Sopra.Trabajo.dao.CheckPrivilegeDAO"
		import="com.Sopra.Trabajo.Model.Empleado"
		import="com.Sopra.Trabajo.Model.Rol"
	%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/modUser.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	
<script src= "js/functions.js"></script>
<%
	IEmpleadoDAO empleadoDAO = EmpleadoDAO.getInstance();
	ICheckPrivilegeDAO privilegeDAO = CheckPrivilegeDAO.getInstance();

	boolean modUsuPriv, autoPriv=false, asiDepPriv, asiRolPriv;
	
	String dni = (String) session.getAttribute("dni");
	if(dni == null){
		String redirectURL = "/PostageStamp/index.jsp";
	    response.sendRedirect(redirectURL);
	    return;
	}

	Empleado empleado = empleadoDAO.getEmpleado(dni);
	modUsuPriv = privilegeDAO.checkPrivilege(dni, "MOD_USU");
	if(!modUsuPriv)
		autoPriv = privilegeDAO.checkPrivilege(dni, "AUT_USU");
	if(autoPriv)
	{
		asiDepPriv = false;
		asiRolPriv = false;
	}
	else
	{
		asiDepPriv = privilegeDAO.checkPrivilege(dni, "ASI_DEP");
		asiRolPriv = privilegeDAO.checkPrivilege(dni, "ASI_ROL");
	}

%>
<script type="text/javascript">

	var hideSelectEmpGlobal = <%= !modUsuPriv %>;
	var hideFormGlobal = <%= !autoPriv %>;
	var hideFieldsGlobal = !hideFormGlobal;
	if(!hideFormGlobal){
		var dniG = '<%= empleado.getDni() %>';
		var nombreG = '<%= empleado.getNombre() %>';
		var apellidosG = '<%= empleado.getApellidos() %>';
		var contraG = '<%= empleado.getContraseña() %>';
		var rolG = '<%= empleado.getRol().getId() %>';
		var departG = '<%= empleado.getDepartamento().getId() %>';
	}
	
</script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>PosstageStamp - Modificar empleado</title>
</head>
<body ng-app="myApp" style="text-align: center;" margin-top: 20px" ng-controller="personCtrl"  <%if(!modUsuPriv && autoPriv){ %>onload="cambiarAutoEmpleado()"<%}%>>
	
	<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
	<%if(modUsuPriv){ %>
	<div class="btn-group" uib-dropdown is-open="status.isopen" ng-hide="hideSelectEmpleado">
      <button id="single-button" type="button" class="btn btn-primary" uib-dropdown-toggle ng-disabled="disabled">
        <label>{{EmpleadoElegido}}</label> <span class="caret"></span><span style="margin-left: 10px;" class="badge"><% long count=empleadoDAO.countEmpleados(); %><%=count%></span>
      </button>
      <ul   class="uib-dropdown-menu" role="menu" aria-labelledby="single-button">
        <% 	List<Empleado> empleados = empleadoDAO.getEmpleados();
			for(int i=0; i<empleados.size(); i++){
				String nombre = empleados.get(i).getNombre();
				int id = empleados.get(i).getId();
				String dni2 = empleados.get(i).getDni();
				if(id>1)
					out.println("<li role='menuitem' ><a href='#' ng-click='cambiarEmpleado("+id+")'>"+ nombre +"  "+ dni2 + "</a></li>");
			}
		%>
        
      </ul>
    </div>
	
	<!-- <select name="empleado" ng-model="empleado" class="uib-dropdown-menu" convert-to-number ng-hide="hideSelectEmpleado" ng-change=cambiarEmpleado()>
		<% /*	List<Empleado> empleados = empleadoDAO.getEmpleados();
			for(int i=0; i<empleados.size(); i++){
				String nombre = empleados.get(i).getNombre();
				int id = empleados.get(i).getId();
				String dni2 = empleados.get(i).getDni();
				if(id!=0)
					out.println("<option value="+ id +">"+ nombre +"  "+ dni2 + "</option>");
			}
		*/ %>
	</select>	-->
	<%} %>

	<form id="formModUser" method="post" action="redirect" class="form-inline">
		<div ng-hide="hideForm" id="fieldsContent">
			<div>
				<div>
					<span>DNI:</span>
				</div>
				<div>
					<input type="text" name="dni" ng-model="dni" maxlength="9" tooltip-trigger="focus" tooltip-placement="right" ng-disabled="hideFields" class="form-control" uib-tooltip="DNI con letra sin espacio ni guion"/>
				</div>
			</div>
			<div>
				<div>
					<span>Nombre:</span>
				</div>
				<div>
					<input type="text" name="nombre" ng-model="nombre" class="form-control"/>
				</div>
			</div>
			<div>
				<div>
					<span>Apellidos:</span>
				</div>
				<div>	
					<input type="text" name="apellidos" autocomplete="off" ng-model="apellidos" class="form-control"/>
				</div>
			</div>
			<div>
				<div>
					<span>Contraseña:</span>
				</div>
				<div>	
					<input type="password" id="contra" autocomplete="off" ng-model="password" class="form-control" name="contraseña"  uib-tooltip="Minimo 3 caracteres" tooltip-trigger="focus" tooltip-placement="right"/>
				</div>
			</div>
			<div>
				<div>
					<span>Vuelve a escribir la contraseña:</span>
				</div>
				<div>
					<input type="password" id="contra2" autocomplete="off" ng-model="password2" class="form-control"/>
				</div>
			</div>
			<div>
				<div>
					<span>Rol:</span>
				</div>
				<div>
					<select name="rol" ng-model="rol" convert-to-number  <%if(!asiRolPriv){%>disabled<%}%>>
						<% List<Rol> roles = RolDAO.getInstance().getRoles();
							for(int i=0; i<roles.size(); i++){
								String nombre = roles.get(i).getNombre();
								int id = roles.get(i).getId();
								if(id!=1)
									out.println("<option value="+ id +">"+ nombre + "</option>");
							}
						%>
					</select>
				</div>
			</div>
			<div>
				<div>
					<span>Departamento:</span>
				</div>
				<div>
					<select name="departamento" ng-model="departamento" convert-to-number  <%if(!asiDepPriv){%>disabled<%}%>>
						<% List<Departamento> departamentos = DepartamentoDAO.getInstance().getDepartamentos();
							for(int i=0; i<departamentos.size(); i++){
								String nombre = departamentos.get(i).getNombre();
								int id = departamentos.get(i).getId();
								if(id != 1)
									out.println("<option value="+ id +">"+ nombre + "</option>");
							}
						%>
					</select>
				</div>
			</div>
			
		</div>
			<div>
				<input type="button" value="Actualizar empleado" ng-click="modUser()" ng-hide="hideForm" class="btn btn-primary" class="btn btn-primary"/>
				<input type="button" value="Cancelar" ng-click="cancelar()" class="btn btn-warning"/>
			</div>
	</form>
	
	<form id="formCancel" method="post" action="redirect" ></form>
	

	
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('personCtrl', function($scope, $http, $window) {
		$scope.EmpleadoElegido= 'Seleccionar empleado';

	    $scope.dni = $window.dniG;
	    $scope.nombre = $window.nombreG;
	    $scope.apellidos = $window.apellidosG;
	    $scope.password = $window.contraG;
	    $scope.password2 = $window.contraG;
	    $scope.rol = $window.rolG;
	    $scope.departamento = $window.departG;
	    $scope.hideError = true;
	    $scope.hideForm = $window.hideFormGlobal;
	    $scope.hideSelectEmpleado = $window.hideSelectEmpGlobal;
	    $scope.hideFields = $window.hideFieldsGlobal;
	    $scope.error = "";
	    //Boton modificar usuario
	    $scope.modUser = function() {
	    	var error2 = checkForm($scope.dni, $scope.nombre, $scope.apellidos, $scope.password,
	    			$scope.password2, $scope.rol, $scope.departamento);
	    	if(error2 == null){
		    	$http({
		    	    method: 'post',
		    	    url: 'UserModAction', 
		    	    params: { 	id: $scope.empleado,
		    	    			dni: $scope.dni,
		    	    			nombre: $scope.nombre,
		    	    			apellidos: $scope.apellidos,
		    	    			password: $scope.password,
		    	    			password2: $scope.password2,
		    	    			rol: $scope.rol,
		    	    			departamento: $scope.departamento
		    	    		}
		    	})
		    	.success(function(response){
		    		$scope.hideError = false;
					$scope.error = response.error;
					if(response.error == null){
						post("formModUser");
					}
		    	});
	    	}
	    	else{
	    		$scope.hideError = false;
				$scope.error = error2;
	    	}
	    	
	    }
	    
	  //Evento al cambiar valor combobox
	    $scope.cambiarEmpleado = function(idEmp){
		  	$scope.empleado = idEmp;
	    	$http({
	    	    method: 'post',
	    	    url: 'UserGetAction',
	    	    params: {  id: $scope.empleado  }
	    	})
	    	.success(function(response){
				
	    		if(response.error == null){
	    			$scope.EmpleadoElegido = response.nombre +" - "+ response.dni;
	    			$scope.dni = response.dni;
	    			$scope.nombre = response.nombre;
	    			$scope.apellidos = response.apellidos;
	    			$scope.password = response.password;
	    		    $scope.password2 = response.password;
	    			$scope.rol = response.rol;
	    			$scope.departamento = response.departamento;
	    			$scope.hideError = true;
	    			$scope.hideForm = false;
	    			$scope.hideFields = false;
	    		}
	    		else{
	    			$scope.error = response.error;
	    			$scope.hideError = false;
	    		}
	    		
	    	});
	    }
	  //Cuando solo se puede editar a si mismo
	    $scope.cambiarAutoEmpleado = function(){
	    	$http({
	    	    method: 'post',
	    	    url: 'UserGetAction',
	    	    params: {  id: empleado  }
	    	})
	    	.success(function(response){
				
	    		if(response.error == null){
	    			$scope.dni = response.dni;
	    			$scope.nombre = response.nombre;
	    			$scope.apellidos = response.apellidos;
	    			$scope.password = response.password;
	    		    $scope.password2 = response.password;
	    			$scope.rol = response.rol;
	    			$scope.departamento = response.departamento;
	    			$scope.hideError = true;
	    			$scope.hideForm = false;
	    			$scope.hideFields = false;
	    		}
	    		else{
	    			$scope.error = response.error;
	    			$scope.hideError = false;
	    		}
	    		
	    	});
	    }
	    	
	    //Boton cancelar
	    $scope.cancelar = function(){
	    	$http({
	    	    method: 'post',
	    	    url: 'BackMenu'
	    	})
	    	.success(function(response){
				post("formCancel");
	    	});
	    }
	    
	});
	
	
	
	
	</script>
	
	
	
</body>
</html>