<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/gachapon.css"></link>
<link rel="stylesheet" href="css/gachapon.css"></link>
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="icon" type="image/x-icon" href="images/favicon.ico">
<title>Gachapon</title>
</head>
<body>
	<div class="fixed">
		<div class="header">
			<a href="home"><img class="pokemonLogo"
				src="images/pokemonLogo.png" alt="pokemonLogo"></a>
		<div class="datosDelUsuario">
			<h3 class="puntosUser">Tus puntos ${usuario.puntos}</h3>
			
			<c:if test="${not empty plan}">
				<h3 class="puntosUser">Tus tiradas gratis de ultraball ${usuario.tiradaUltraball}</h3>
				<h3 class="puntosUser">Tus tiradas gratis de masterball ${usuario.tiradaMasterball}</h3>
			</c:if>
			<h3 class="puntosUser">Tiradas hasta el proximo Epico ${tiradas}</h3>
		</div>
			
		</div>
		<c:if test="${!sessionScope.principiante}">
			<div class="container">
				<div class="center">
					<img class="pokemon" id="pokeball" alt="pokemon"
						src="images/Pokebola.png"> <img class="pokemon"
						id="superball" alt="pokemon" src="images/superball.png"> <img
						class="pokemon" id="ultraball" alt="pokemon"
						src="images/ultraball.png"> <img class="pokemon"
						id="masterball" alt="pokemon" src="images/master.png">
				</div>
			</div>
		</c:if>
		
		<c:if test="${sessionScope.principiante}">
			<div class="container">
				<div class="centrar">
					<img class="nestball"
						id="nestball" alt="pokemon" src="images/nestball.png">
				</div>
			</div>
		</c:if>

		<form:form class="centrar" method="POST" action="gachapon-resultado">
			<input class="boton-para-tirar" type="submit" name="monedas"
				id="tirar" value=""></input>
		</form:form>

		<c:if test="${not empty error}">
			<h4 class="text-center">
				<span>${error}</span>
			</h4>
			<br>
		</c:if>
		
		<button type="button" class="btn btn-primary margenBoton" data-toggle="modal" data-target="#myModal">
		  Probabilidades
		</button>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="myModalLabel">Título del Modal</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Cerrar">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <p>Pokeball (100): Comun 80% Raro 15% Epico 5%</p>
	            <p>Superball (500): Comun 60% Raro 30% Epico 10%</p>
	            <p>Ultraball (1000): Comun 30% Raro 50% Epico 20%</p>
	            <p>Masterball (10000): Comun 00% Raro 30% Epico 70%</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
		      </div>
		    </div>
		  </div>
		</div>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<script type="text/javascript" src="js/gacha.js"></script>
	
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	
</body>
</html>