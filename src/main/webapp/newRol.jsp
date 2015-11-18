<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/modUser.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
<title>PosstageStamp - Nuevo rol</title>
</head>
<body ng-app="myApp" ng-controller="rolCtrl">

	<h1 align="center">Crear rol</h1>
	<div align="center">
	<form id="formNewRol" method="post" action="redirect" class="form-inline" style="max-width: 800px;width: 100%;">
		<span>NOMBRE:</span>
		<input  style="display: inline-block; max-width: 160px;" type="text" name="nombreTF" ng-model="nombreTF" class="form-control"/>
		
		<fieldset title="Permisos">
			<table border="1" align="center" class="table">
				<tr>
					<th class="success"><h3>USUARIO</h3></th>
					<td></td>
					<th class="info"><h3>ROL</h3></th>
					<td></td>
					<th class="danger"><h3>DEPARTAMENTO</h3></th>
				</tr>	
				<tr align="left">
					<th><input type="checkbox" ng-model="AddUser"/>Alta</th>
					<td></td>
					<th><input type="checkbox" ng-model="AddRol"/>Alta</th>
					<td></td>
					<th><input type="checkbox" ng-model="AddDep"/>Alta</th>
				</tr>
				<tr>
					<th><input type="checkbox" ng-model="RemUser"/>Baja</th>
					<td></td>
					<th><input type="checkbox" ng-model="RemRol"/>Baja</th>
					<td></td>
					<th><input type="checkbox" ng-model="RemDep"/>Baja</th>
				</tr>
				<tr>
					<th><input type="checkbox" ng-model="ModUser"/>Modificar</th>
					<td></td>
					<th><input type="checkbox" ng-model="ModRol"/>Modificar</th>
					<td></td>
					<th><input type="checkbox" ng-model="ModDep"/>Modificar</th>
				</tr>
				<tr>
					<th><input type="checkbox" ng-model="AutUser"/>Auto modificar</th>
					<td></td>
					<th><input type="checkbox" ng-model="AsgRol"/>Asignar</th>
					<td></td>
					<th><input type="checkbox" ng-model="AsgDep"/>Asignar</th>
				</tr>					
			</table>	
		</fieldset>
		<div id="fieldsContent">
			<div>
				<div><input type="button" value="Crear rol" ng-click="addRol()" class="btn btn-primary"/></div>
				<div><input type="button" value="Cancelar" ng-click="cancelar()" class="btn btn-warning"/></div>
			</div>
		</div>
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
	</form>
	</div>
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('rolCtrl', function($scope, $http, $window) {
	    $scope.hideError = true;
	    $scope.addRol = function() {
	    	if($scope.nombreTF != null)
    		{
	        	$http({
		    	    method: 'post',
		    	    url: 'RolAddAction', 
		    	    params: { 	PAddUser: $scope.AddUser, PAddRol: $scope.AddRol, PAddDep: $scope.AddDep,
		    	    			PRemUser: $scope.RemUser, PRemRol: $scope.RemRol, PRemDep: $scope.RemDep,
		    	    			PModUser: $scope.ModUser, PModRol: $scope.ModRol, PModDep: $scope.ModDep,
		    	    			PAutUser: $scope.AutUser, PAsgRol: $scope.AsgRol, PAsgDep: $scope.AsgDep,
		    	    			nombre: $scope.nombreTF
		    	    		}
		    	})
		    	.success(function(response){
		    		$scope.hideError = false;
					$scope.error = response.error;
					if(response.error == null){
						post("formNewRol");
					}
		    	});
    		}
	    	else
	    		{
	    			$scope.hideError = false;
					$scope.error = "No has introducido nombre de rol";
	    		}
	   }
	    
	    $scope.cancelar = function(){
	    	$http({
	    	    method: 'post',
	    	    url: 'BackMenu'
	    	})
	    	.success(function(response){
				post("formNewRol");
	    	});
	    }
	    
	});
	
	
	
	
	</script>
	
</body>
</html>