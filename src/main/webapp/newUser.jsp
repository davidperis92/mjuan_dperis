<%@page import="com.Sopra.Trabajo.dao.DepartamentoDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Departamento"%>
<%@page import="java.util.List"%>
<%@page 
		import="com.Sopra.Trabajo.dao.RolDAO"
		import="com.Sopra.Trabajo.dao.EmpleadoDAO"
		import="com.Sopra.Trabajo.dao.CheckPrivilegeDAO"
		import="com.Sopra.Trabajo.dao.interfaces.ICheckPrivilegeDAO"
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
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
	

<%
	ICheckPrivilegeDAO privilegeDAO = CheckPrivilegeDAO.getInstance();
	boolean asiDepPriv, asiRolPriv;
	
	String dni = (String) session.getAttribute("dni");
	asiDepPriv = privilegeDAO.checkPrivilege(dni, "ASI_DEP");
	asiRolPriv = privilegeDAO.checkPrivilege(dni, "ASI_ROL");
%>




<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>POSSTAGE STAMP - Nuevo usuario</title>
</head>
<body ng-app="myApp" ng-controller="personCtrl" style="text-align: center; margin-top: 5%;">
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
		
		<form id="formAddUser" method="post" action="redirect" class="form-inline">
			<div id="fieldsContent">
				<div>
					<div>
						<span>DNI:</span>
					</div>
					<div>
						<input type="text" name="dni" ng-model="dni" maxlength="9" uib-tooltip="Introduce DNI con letra sin espacio ni guion" tooltip-trigger="focus" tooltip-placement="right" class="form-control"/>
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
						<input type="text" name="apellidos" ng-model="apellidos" class="form-control"/>
					</div>
				</div>
				<div>
					<div>
						<span>Contraseña:</span>
					</div>
					<div>
						<input type="password" id="contra" ng-model="password" name="contraseña"  class="form-control"/>
					</div>
				</div>
				<div>
					<div>
						<span>Vuelve a escribir la contraseña:</span>
					</div>
					<div>
						<input type="password" id="contra2" ng-model="password2" class="form-control"/>
					</div>
				</div>
				<div>
					<div>
						<span>Rol:</span>
					</div>
					<div>
						<select name="rol" ng-model="rol" convert-to-number <%if(!asiRolPriv){%>disabled<%}%>>
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
						<select name="departamento" ng-model="departamento" convert-to-number <%if(!asiDepPriv){%>disabled<%}%>>
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
				<div><br>
					<div><input type="button" value="Dar de alta" ng-click="addUser()" class="btn btn-primary"/></div>
					<div><input type="button" value="Cancelar" ng-click="cancelar()" class="btn btn-warning"/></div>
				</div>
			</div>
		</form>
	
	<form id="formCancel" method="post" action="redirect" >
	</form>
	
	<script>
	
	var app = angular.module('myApp', []);
	app.controller('personCtrl', function($scope, $http, $window) {
	    $scope.dni = "";
	    $scope.nombre = "";
	    $scope.apellidos = "";
	    $scope.password = "";
	    $scope.password2 = "";
	    $scope.rol = 0;
	    $scope.departamento = 0;
	    $scope.hideError = true;
	    $scope.error = "";
	    $scope.addUser = function() {
	    	var error2 = checkForm($scope.dni, $scope.nombre, $scope.apellidos, $scope.password,
	    			$scope.password2, $scope.rol, $scope.departamento);
	    	if(error2 == null){
		    	$http({
		    	    method: 'post',
		    	    url: 'UserAddAction', 
		    	    params: { 	dni: $scope.dni,
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
						post("formAddUser");
					}
		    	});
	    	}
	    	else{
	    		$scope.hideError = false;
				$scope.error = error2;
	    	}
	    	
	   }
	    
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