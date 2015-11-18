<!DOCTYPE html>
<html>
<head>
	<script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js" ></script>
	<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.14.3/ui-bootstrap-tpls.js" ></script>
	
	<script src= "js/functions.js" ></script>
	<link rel="stylesheet" type="text/css" href="css/style.css" /> 
	
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
</head>
	<body ng-app="myApp" ng-controller="personCtrl">
	
	
		<div   align="center">
			<p/>			
			<form method="post" id="formLogin" action="redirect" >
				<table >
					<tr >
						<td align="right">
							<label>DNI: </label>
						</td>
						<td></td>
						<td>
						 	<input type=text maxlength="9" ng-model="dni" name="dni" uib-tooltip="Introduce DNI con letra sin espacio ni guion" tooltip-trigger="focus" tooltip-placement="right" class="form-control">
						</td>
					</tr>
					
					<tr>
						<td align="right">
						<br>
							<label>Contrase&ntilde;a: </label>  
						</td>
						<td></td>
						<td ><br>
							 <input type="password" ng-model="password" name="password" class="form-control">
						</td>
					</tr>
				</table>
				<p/><br>
				<input type="button" ng-click="login()" value="Login" class="btn btn-primary" ></input>
			</form>
		</div>
		<p  style="color:red" ng-hide="hideError" class="alert alert-danger" align="center">{{error}}</p>
		<script>
			var app = angular.module('myApp', ['ui.bootstrap']);
			app.controller('personCtrl', function($scope, $http, $window) {
			    $scope.dni = "";
			    $scope.password = "";
			    $scope.hideError = true;
			    $scope.error = "";
			    $scope.login = function() {
			    	$http({
			    	    method: 'post',
			    	    url: 'LoginAction', 
			    	    params: { dni: $scope.dni,
			    	    		password: $scope.password}
			    	})
			    	.success(function(response){			    		
	    				if(response.error == null){
	    					post("formLogin");
	    				}
	    				else
    					{
	    					$scope.hideError = false;
		    				$scope.error = response.error;
    					}
			    	});
 			    }
			});
		
			
			</script> 
		
		
	</body>
	
	
	
</html>