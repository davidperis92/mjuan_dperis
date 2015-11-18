<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="org.apache.struts2.ServletActionContext"
		 import="com.Sopra.Trabajo.dao.EmpleadoDAO"
		 import="com.Sopra.Trabajo.Model.Privilegio"
		 import="com.Sopra.Trabajo.util.HibernateUtil"
		 import=" java.util.Set"

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
	<link rel="stylesheet" type="text/css" href="css/menu.css" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PostageStamp - Menu</title>


</head>
<body>


	<div ng-app="menuAPP" ng-controller="menuCntrl">
	<div align="left"><h2>Usuario:
	<label><% session = ServletActionContext.getRequest().getSession();
				String param = (String)session.getAttribute("dni");
			  out.print(param); %></label>
	</h2><button type="button" class="btn btn-primary" ng-model="singleModel"  ng-click=logout()>Desconectar</button></div>
	<hr>
	<%
		String currentDNI = (String)session.getAttribute("dni");
		Set<String> priv =  EmpleadoDAO.getInstance().getEmpleado(currentDNI).getRol().StringArray();
	%>

	<form method="post" id="menuForm" action="redirect" class="form-inline">
	
		<%	if(priv.contains("ALT_USU") ||priv.contains("AUT_USU") ||priv.contains("AUT_USU") ||priv.contains("MOD_USU")){%>
		<div align="center"><h2>USUARIOS</h2></div>
		<p>	<div  align="center" role="empleado">
			<%	if(priv.contains("ALT_USU")){%>	
			<input type="button" ng-click="create_User()" value="Alta empleado"  class="btn btn-primary"/>					
			<%}if(priv.contains("BAJ_USU")){%>
			<input type="button" ng-click="remove_user()" value="Baja empleado"  class="btn btn-danger"/>
			<%}if(priv.contains("MOD_USU") || priv.contains("AUT_USU")){%>
			<input type="button" ng-click="modify_user()" value="Modificar empleado"  class="btn btn-warning"/>
			<%}%></div>
		</p>
		<%}%>
		<%	if(priv.contains("ALT_ROL") ||priv.contains("BAJ_ROL") ||priv.contains("MOD_ROL")){%>
		<hr>
		<div align="center"><h2>ROL</h2></div>
		<p><div role="rol" align="center">
			<%	if(priv.contains("ALT_ROL")){%>
			<input type="button" ng-click="create_rol()" value="Crear rol"  class="btn btn-primary"/>
			<%}	if(priv.contains("BAJ_ROL")){%>
			<input type="button" ng-click="remove_rol()" value="Eliminar rol"  class="btn btn-danger"/>
			<%}	if(priv.contains("MOD_ROL")){%>
			<input type="button" ng-click="modify_rol()" value="Modificar rol"  class="btn btn-warning"/>
			<%}%></div>
		</p>
		<%}%>
		<hr>
		<%	if(priv.contains("ALT_DEP") ||priv.contains("BAJ_DEP") ||priv.contains("MOD_DEP")){%>
		<div align="center"><h2>DEPARTAMENTOS</h2></div>
		<p><div role="departamento" align="center">
			<%	if(priv.contains("ALT_DEP")){%>
			<input type="button" ng-click="create_dept()" value="Crear departamento"  class="btn btn-primary"/>
			<%}	if(priv.contains("BAJ_DEP")){%>
			<input type="button" ng-click="remove_dept()" value="Eliminar departamento"  class="btn btn-danger"/>
			<%}	if(priv.contains("MOD_DEP")){%>
			<input type="button" ng-click="modify_dept()" value="Modificar departamento" class="btn btn-warning"/>
			<%}%></div>
		</p>
		<%}%>
	
	</form>	
	<h1><p  style="color:red" ng-hide="hideError" align="center" class="alert alert-danger">No tienes privilegios para {{error}}</p></h1>
	</div>
	
	
	<script>
		var app = angular.module('menuAPP', []);
		app.controller('menuCntrl', function($scope, $http, $window, $location) {
			$scope.dni = "";
		    $scope.hideError=true;
		    $scope.dniTF= true;
		    $scope.error = "";
 //////////////USUARIOS/////////////////////
		    $scope.create_User = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'UserAction',
		    	    params: { action: 0}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
 
		    $scope.remove_user = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'UserAction',
		    	    params: { action: 1}
		    	})
		    	.success(function(response){		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.modify_user = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'UserAction',
		    	    params: { action: 2}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    
//////////////ROLES/////////////////////
		    $scope.create_rol = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'RolAction',
		    	    params: { action: 0}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.remove_rol = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'RolAction',
		    	    params: { action: 1}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.modify_rol = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'RolAction',
		    	    params: { action: 2}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
//////////////DEPARTAMENTOS/////////////////////
		    $scope.create_dept = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'DeptAction',
		    	    params: { action: 0}
		    	})
		    	.success(function(response){
		    		
					
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.remove_dept = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'DeptAction',
		    	    params: { action: 1}
		    	})
		    	.success(function(response){
		    		
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.modify_dept = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'DeptAction',
		    	    params: { action: 2}
		    	})
		    	.success(function(response){
		    		
					if(response.error == null){
						post("menuForm");
					}
					else
					{
						$scope.error = response.error; 
	    				$scope.hideError=false;
					}});}
		    $scope.logout = function() {
		    	$http({
		    	    method: 'post',
		    	    url: 'LogoutAction'
		    	})
		    	.success(function(response){
		    		
					if(response.error == null){
						post("menuForm");
					}
					});}
		});
		
	
	</script>

</body>
</html>