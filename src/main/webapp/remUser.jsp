<%@page import="com.Sopra.Trabajo.dao.DepartamentoDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Departamento"%>
<%@page import="java.util.List"%>
<%@page 
	import="com.Sopra.Trabajo.dao.EmpleadoDAO"
	import="com.Sopra.Trabajo.Model.Empleado"
	import="com.Sopra.Trabajo.dao.interfaces.IEmpleadoDAO"	
	%>
	
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/remStyle.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%IEmpleadoDAO empleadoDAO = EmpleadoDAO.getInstance(); %>
<title>PosstageStamp - Eliminar Empleado</title>
</head>
<body ng-app="myApp" ng-controller="personCtrl">
	
	<div align="center" id="ScreenRem">
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
		<form id="formDeleteUser" method="post" action="redirect" class="form-inline" >
				<div id="fieldsContent">
					<div class="btn-group" uib-dropdown align="center" >
						<button id="single-button" type="button" class="btn btn-primary" uib-dropdown-toggle style="max-width: 2500px;">
				        	<label>{{EmpleadoElegido}}</label> <span class="caret"></span><span style="margin-left: 10px;" class="badge"><% long count=empleadoDAO.countEmpleados(); %><%=count%></span>
				      	</button>	
						<ul class="uib-dropdown-menu" role="menu" aria-labelledby="single-button">
							<% List<Empleado> empleados = empleadoDAO.getEmpleados();
								for(int i=0; i<empleados.size(); i++){
									String nombre = empleados.get(i).getNombre();
									int id = empleados.get(i).getId();
									String dni = empleados.get(i).getDni();
									if(id>1)
										out.println("<li role='menuitem'><a href='#' ng-click='cambiarEmpleado("+id+",\""+nombre+" - "+dni+"\")'>"+nombre+" - "+dni+"</a></li>");
								}
							%>
						</ul>			
					</div>					
					<div>
						<div>
							<input type="button" value="Eliminar empleado" ng-click="deleteUser()" class="btn btn-primary"/>
						</div>
						<div>
							<input type="button" value="Cancelar" ng-click="cancelar()" class="btn btn-warning"/>
						</div>
					</div>
				</div>
		
		</form>
	</div>
	
	<form id="formCancel" method="post" action="redirect" ></form>
	
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('personCtrl', function($scope, $http, $window) {
		$scope.id=null;
		$scope.EmpleadoElegido= 'Seleccionar empleado';
	    $scope.deleteUser = function() {
	    	if($scope.id!=null)
	    	{
		    	$http({
		    	    method: 'post',
		    	    url: 'UserRemoveAction', 
		    	    params: { 	id: $scope.id   }
		    	})
		    	.success(function(response){
					if(response.error == null){
						post("formDeleteUser");
					}
					else
					{
						$scope.hideError = false;
						$scope.error = response.error;
					}
		    	});
	    	}
	    	
	   }
	    $scope.cambiarEmpleado = function(idEmp, nombre)
	    {
	    	$scope.EmpleadoElegido = nombre;
	    	$scope.id=idEmp;
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