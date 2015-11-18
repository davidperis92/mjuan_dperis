<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="com.Sopra.Trabajo.dao.interfaces.IRolDAO" %>
<%@page import="com.Sopra.Trabajo.dao.RolDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Rol"%>
<%@page import="java.util.List"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
<%
	IRolDAO iRolDAO = RolDAO.getInstance();
%>
<title>Posstage Stamp - Modificar rol</title>
</head>
<body ng-app="myApp" ng-controller="rolCtrl">
	<div align="center">
		<h1 >Modificar rol</h1>
		
		<div class="btn-group" uib-dropdown align="center" style="max-width: 160px;">
			<button id="single-button" type="button" class="btn btn-primary" uib-dropdown-toggle>
	        	<label>{{rolElegido}}</label> <span class="caret"></span><span style="margin-left: 10px;" class="badge"><% long count=iRolDAO.countRoles(); %><%=count%></span>
	      	</button>	
			<ul class="uib-dropdown-menu" role="menu" aria-labelledby="single-button">
				<% List<Rol> roles = iRolDAO.getRoles();
					for(int i=0; i<roles.size(); i++){
						String nombre = roles.get(i).getNombre();
						int id = roles.get(i).getId();				
						if(id>1)
							out.println("<li role='menuitem'><a href='#' ng-click='cambiarRol("+id+")'>"+ nombre + "</a></li>");
					}
				%>
			</ul>
		</div>
		<form id="formModRol" style="max-width: 800px;width: 100%;" method="post" action="redirect" class="form-inline">
			<div style="display: inline-block;" ng-hide="hideForm">
			<label  ng-hide="hideTF">NOMBRE:</label>
			</div>
			<input style="display: inline-block; max-width: 160px;" type="text" name="nombreTF" ng-model="nombreTF"  value={{nombre}} class="form-control" ng-hide="hideTF" style="text-align:middle;"/>
		
			<fieldset title="Permisos" ng-hide="hideForm">
				<table border="1" align="center" class="table">
					<tr align="center">
						<th class="success"><h3>USUARIO</h3></th>
						<td></td>
						<th class="info"><h3>ROL</h3></th>
						<td></td>
						<th class="danger"><h3>DEPARTAMENTO</h3></th>
					</tr>	
					<tr></tr>
					<tr align="center">
						<th><input type="checkbox" ng-model="AddUser" ng-checked="ChkAddUser"/>Alta</th>
						<td></td>
						<th><input type="checkbox" ng-model="AddRol" ng-checked="ChkAddRol"/>Alta</th>
						<td></td>
						<th><input type="checkbox" ng-model="AddDep" ng-checked="ChkAddDep"/>Alta</th>
					</tr>
					<tr></tr>
					<tr align="center">
						<th><input type="checkbox" ng-model="RemUser" ng-checked="ChkRemUser"/>Baja</th>
						<td></td>
						<th><input type="checkbox" ng-model="RemRol" ng-checked="ChkRemRol"/>Baja</th>
						<td></td>
						<th><input type="checkbox" ng-model="RemDep" ng-checked="ChkRemDep"/>Baja</th>
					</tr>
					<tr></tr>
					<tr align="center">
						<th><input type="checkbox" ng-model="ModUser" ng-checked="ChkModUser"/>Modificar</th>
						<td></td>
						<th><input type="checkbox" ng-model="ModRol" ng-checked="ChkModRol"/>Modificar</th>
						<td></td>
						<th><input type="checkbox" ng-model="ModDep" ng-checked="ChkModDep"/>Modificar</th>
					</tr>
					<tr></tr>
					<tr align="center">
						<th><input type="checkbox" ng-model="AutUser" ng-checked="ChkAutUser"/>Auto modificar</th>
						<td></td>
						<th><input type="checkbox" ng-model="AsgRol" ng-checked="ChkAsgRol"/>Asignar</th>
						<td></td>
						<th><input type="checkbox" ng-model="AsgDep" ng-checked="ChkAsgDep"/>Asignar</th>
					</tr>					
				</table>	
			</fieldset>
			<div>
				<input type="button" style="margin-right: 10px" value="Modificar rol" ng-click="addRol()" class="btn btn-primary"/>
				<input type="button" value="Cancelar" ng-click="cancelar()" class="btn btn-warning" />
			</div>
			
			<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
		</form>
	</div>
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('rolCtrl', function($scope, $http, $window) {
	    $scope.rolElegido= 'Seleccionar rol';

	    $scope.hideError = true;
	    $scope.hideTF = true;
	    $scope.hideForm = true;
	    $scope.addRol = function() {
	    	if($scope.nombreTF != null)
    		{
	        	$http({
		    	    method: 'post',
		    	    url: 'RolModAction', 
		    	    params: { 	PAddUser: $scope.AddUser, PAddRol: $scope.AddRol, PAddDep: $scope.AddDep,
		    	    			PRemUser: $scope.RemUser, PRemRol: $scope.RemRol, PRemDep: $scope.RemDep,
		    	    			PModUser: $scope.ModUser, PModRol: $scope.ModRol, PModDep: $scope.ModDep,
		    	    			PAutUser: $scope.AutUser, PAsgRol: $scope.AsgRol, PAsgDep: $scope.AsgDep,
		    	    			nombre: $scope.nombreTF, id: $scope.rol
		    	    		}
		    	})
		    	.success(function(response){
		    		$scope.hideError = false;
					$scope.error = response.error;
					if(response.error == null){
						post("formModRol");
					}
		    	});
    		}
	    	else
	    		{
	    			$scope.hideError = false;
					$scope.error = "No has introducido nombre de rol";
	    		}
	   }
	    //Evento al cambiar valor combobox
	    $scope.cambiarRol = function(idRol){
	    	$scope.rol = idRol;
	    	$scope.hideTF = false;
	    	$http({
	    	    method: 'post',
	    	    url: 'RolGetAction',
	    	    params: {  id: $scope.rol  }
	    	})
	    	.success(function(response){
				
	    		if(response.error == null){	    			
	    			$scope.nombre = response.nombre;
	    	    	$scope.rolElegido = response.nombre;

	    			$scope.ChkAddUser = response.PAddUser;	    			
	    			$scope.ChkAddRol = response.PAddRol;
	    			$scope.ChkAddDep = response.PAddDep;
	    			$scope.ChkRemUser = response.PRemUser;
	    			$scope.ChkRemRol = response.PRemRol;
	    			$scope.ChkRemDep = response.PRemDep;
	    			$scope.ChkModUser = response.PModUser;
	    			$scope.ChkModRol = response.PModRol;
	    			$scope.ChkModDep = response.PModDep;
	    			$scope.ChkAutUser = response.PAutUser;
	    			$scope.ChkAsgDep = response.PAsgDep;
	    			$scope.ChkAsgRol = response.PAsgRol;
	    			
	    			$scope.AddUser = response.PAddUser;	    			
	    			$scope.AddRol = response.PAddRol;
	    			$scope.AddDep = response.PAddDep;
	    			$scope.RemUser = response.PRemUser;
	    			$scope.RemRol = response.PRemRol;
	    			$scope.RemDep = response.PRemDep;
	    			$scope.ModUser = response.PModUser;
	    			$scope.ModRol = response.PModRol;
	    			$scope.ModDep = response.PModDep;
	    			$scope.AutUser = response.PAutUser;
	    			$scope.AsgDep = response.PAsgDep;
	    			$scope.AsgRol = response.PAsgRol;
	    			
	    			$scope.nombreTF = response.nombre;
	    			
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
				post("formModRol");
	    	});
	    }
	    
	});
	
	
	
	
	</script>
	
</body>
</html>