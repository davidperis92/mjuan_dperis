<%@page import="com.Sopra.Trabajo.dao.DepartamentoDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Departamento"%>
<%@page import="java.util.List"%>
<%@page 

	import="com.Sopra.Trabajo.dao.DepartamentoDAO"
	import="com.Sopra.Trabajo.dao.interfaces.IDepartamentoDAO"
	import="com.Sopra.Trabajo.Model.Departamento"
	import="com.Sopra.Trabajo.dao.EmpleadoDAO"
	import="com.Sopra.Trabajo.Model.Empleado"
		
	%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="css/modUser.css" rel="stylesheet" type="text/css" />
	<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	
<script src= "js/functions.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	IDepartamentoDAO iDepartamentoDAO = DepartamentoDAO.getInstance();
%>
<title>PosstageStamp - Modificar departamento</title>
</head>
<body ng-app="myApp" style="text-align: center;" ng-controller="departCtrl">
	<div>
	<br>
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}} </p>
		
		
		<div class="btn-group" uib-dropdown  >
			   <button id="single-button" type="button" class="btn btn-primary" uib-dropdown-toggle>
			     <label>{{depElegido}}</label> <span class="caret"></span><span style="margin-left: 10px;" class="badge"><% long count=iDepartamentoDAO.countDepartamentos(); %><%=count%></span>
			   </button>
			   <ul class="uib-dropdown-menu" role="menu" aria-labelledby="single-button">
			   	<% 	List<Departamento> departamentos = iDepartamentoDAO.getDepartamentos();
					for(int i=0; i<departamentos.size(); i++){
						String nombre = departamentos.get(i).getNombre();
						int id = departamentos.get(i).getId();
						if(id>1)
							out.println("<li role='menuitem' ><a href='#' ng-click='cambiarDepartamento("+id+")'>"+ nombre + "</a></li>");
					}
				%>
			  
			   </ul>
		</div>
		<form id="formModDep" method="post" action="redirect" class="form-inline">
			
			<div class="form-group-sm" style="display: inline-block;">
				<label>Nombre: </label><input style="display: inline-block; max-width: 160px;" type="text" class="form-control" ng-model="nombre"/>
				<br>
			</div><div class="form-group-sm"><br>
			<input type="button" value="Modificar departamento" ng-click="modDept()" class="btn btn-primary"/>
			<input type="button" value="Cancelar" ng-click="backMenu()" class="btn btn-warning")/>	</div>		
		</form>
	</div>
	
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('departCtrl', function($scope, $http, $window) {
	    $scope.depElegido= 'Seleccionar departamento';
	    $scope.departamento=-1;
	    $scope.hideError=true;
	    $scope.modDept = function() 
	    {	
	   	   	$http({
		    	    method: 'post',
		    	    url: 'DeptModAction', 
		    	    params: { 	id: $scope.departamento,
		    	    			nombre: $scope.nombre}
		    	})
		    	.success(function(response){
		    		$scope.hideError = false;
					$scope.error = response.error;
					if(response.error == null){
						post("formModDep");
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
					post("formModDep");
				}
				});}
	    
	    $scope.cambiarDepartamento = function(idDep){
	    	$scope.departamento = idDep;
	    	$http({
	    	    method: 'post',
	    	    url: 'DeptGetAction',
	    	    params: {  id: $scope.departamento  }
	    	})
	    	.success(function(response){
				
	    		if(response.error == null){
	    			$scope.depElegido = response.nombre;
	    			$scope.id = response.id;
	    			$scope.nombre = response.nombre;
	    			$scope.hideError = true;
	    		}
	    		else{
	    			$scope.error = response.error;
	    			$scope.hideError = false;
	    		}
	    		
	    	});}
	    
	});
	</script>
</body>
</html>