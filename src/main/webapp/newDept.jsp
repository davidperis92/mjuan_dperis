<%@page import="com.Sopra.Trabajo.dao.DepartamentoDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Departamento"%>
<%@page import="java.util.List"%>
<%@page 
	import="com.Sopra.Trabajo.dao.DepartamentoDAO"
	import="com.Sopra.Trabajo.dao.interfaces.IDepartamentoDAO"
	import="com.Sopra.Trabajo.Model.Departamento"
	import="com.Sopra.Trabajo.dao.interfaces.IDepartamentoDAO"
		
	%>


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
	
<title>PosstageStamp - Nuevo departamento</title>
</head>
<body ng-app="myApp" ng-controller="departCtrl">
	<div id="Screen">
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
		
		<form id="formAddDept" method="post" action="redirect" class="form-inline">
			<div id="fieldsContent">
				<div>
					<div><label>Nombre de departamento:</label></div>
					<div><input type="text" name="nombre" ng-model="nombre"/></div>
				</div>
			
				<div>
						<div><input type="button" value="Crear departamento" ng-click="addDept()" class="btn btn-primary"/></div>
						<div><input type="button" value="Cancelar" ng-click="backMenu()" class="btn btn-warning")/></div>
				</div>
			</div>
		</form>
		<div>
		<form id="formCancel" method="post" action="redirect" >
		</form></div>
	</div>
	
	
	
	<script>
	
	var app = angular.module('myApp', []);
	app.controller('departCtrl', function($scope, $http, $window) {
	    $scope.hideError=true;
	    $scope.addDept = function() 
	    {	
	   	   	$http({
		    	    method: 'post',
		    	    url: 'DeptAddAction', 
		    	    params: { 	nombre: $scope.nombre	}
		    	})
		    	.success(function(response){
		    		$scope.hideError = false;
					$scope.error = response.error;
					if(response.error == null){
						post("formAddDept");
					}
		    	});
	    	}
	   
		
	    $scope.backMenu = function() {
	    	$http({
	    	    method: 'post',
	    	    url: 'BackMenu'
	    	})
	    	.success(function(response){				
				if(response.error == null){
					post("formAddDept");
				}
				});}
	});
	
	
	
	
	</script>
	
</body>
</html>