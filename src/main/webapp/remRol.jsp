<%@page import="com.Sopra.Trabajo.dao.RolDAO"%>
<%@page import="com.Sopra.Trabajo.Model.Rol"%>
<%@page import="java.util.List"%>
<%@page 
	import="com.Sopra.Trabajo.dao.RolDAO"
	import="com.Sopra.Trabajo.Model.Rol"
		
	%>
<%@page import="com.Sopra.Trabajo.dao.interfaces.IRolDAO" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
	IRolDAO iRolDAO = RolDAO.getInstance();
%>
<title>PosstageStamp - Eliminar rol</title>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<link href="css/remStyle.css" rel="stylesheet" type="text/css" />
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
</head>
<body ng-app="myApp" ng-controller="departCtrl">
	<div align="center" id="ScreenRem">
		<h1 >Eliminar rol</h1>
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger">{{error}}</p>
		<form id="formRemDep" method="post" action="redirect" class="form-inline">
			<div id="fieldsContent">
				<div class="btn-group" uib-dropdown align="center">
					<button id="single-button" type="button" class="btn btn-primary" uib-dropdown-toggle style="max-width: 250px;">
			        	<label>{{rolElegido}}</label> <span class="caret"></span><span style="margin-left: 10px;" class="badge"><% long count=iRolDAO.countRoles(); %><%=count%></span>
			      	</button>	
					<ul class="uib-dropdown-menu" role="menu" aria-labelledby="single-button">
						<% List<Rol> roles = iRolDAO.getRoles();
							for(int i=0; i<roles.size(); i++){
								String nombre = roles.get(i).getNombre();
								int id = roles.get(i).getId();				
								if(id>1)
									out.println("<li role='menuitem'><a href='#' ng-click='cambiarRol("+id+",\""+nombre+"\")'>"+ nombre + "</a></li>");
							}
						%>
					</ul>			
				</div>						
				<div >
					<div>
						<input type="button" value="Eliminar rol" ng-click="remRol()" class="btn btn-primary"/>
					</div>
					<div>
						<input type="button" value="Cancelar" ng-click="backMenu()" class="btn btn-warning")/>
					</div>
				</div>	
			</div>		
		</form>
	</div>
	
	<script>
	
	var app = angular.module('myApp', ['ui.bootstrap']);
	app.controller('departCtrl', function($scope, $http, $window) {
	    $scope.hideError=true;
	    $scope.id=null;
	    $scope.rolElegido= 'Seleccionar rol';
	    
	    $scope.remRol = function() 
	    {	
	    	if($scope.id!=null)
	    	{
		   	   	$http({
			    	    method: 'post',
			    	    url: 'RolRemAction', 
			    	    params: { 	id: $scope.id	}
			    	})
			    	.success(function(response){
			    		$scope.hideError = false;
						$scope.error = response.error;
						if(response.error == null){
							post("formRemDep");
						}
			    	});
	    	}
	    }
	    $scope.cambiarRol = function(idRol, nombre)
	    {	    	
	    	$scope.rolElegido = nombre;
	    	$scope.id=idRol;
	    }
		
	    $scope.backMenu = function() {
	    	$http({
	    	    method: 'post',
	    	    url: 'BackMenu'
	    	})
	    	.success(function(response){				
				if(response.error == null){
					post("formRemDep");
				}
				});}
	});
	</script>
</body>
</html>