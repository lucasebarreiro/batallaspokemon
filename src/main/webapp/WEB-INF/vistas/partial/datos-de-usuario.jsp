<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="home">

	<div class="contenedor">

		<div class="containerBox">

			<div class="boxFoto">
				<div class="perfil">
					<img id="imgPerfil" class="imagenPerfil"
						src="images/perfilBlanco.jpg"> <br> <input type="file"
						id="file" accept="image/*" />
					<p>Nombre usuario</p>
				</div>
				<div class="boxOpciones">
					<p></p>


				</div>

			</div>

			<div class="boxCentro">
				<form:form action="cambiar-usuario" method="POST"
					modelAttribute="datosLogin">
					<div class="form-group">
						<label for="usuario">Cambiar nombre de usuario:</label>
						<form:input path="usuario" id="usuario" type="text"
							class="form-control" />
					</div>
					<button type="submit" class="btn btn-primary">Aceptar</button>
				</form:form>
				<form:form action="cambiar-mail" method="POST"
					modelAttribute="datosLogin">
					<label for="email">Cambiar correo electronico</label>
					<form:input path="email" id="email" type="email"
						class="form-control" />
					<button type="submit" class="btn btn-primary">Aceptar</button>
				</form:form>
				<form:form action="cambiar-contrasenia" method="POST"
					modelAttribute="datosLogin">
					<label for="oldPassword">Antigua contrase�a</label>
					<form:input path="oldPassword" type="password" id="oldPassword"
						class="form-control" />
					<label for="password">Nueva contrase�a</label>
					<form:input path="password" type="password" id="password"
						class="form-control" />
					<button type="submit" class="btn btn-primary">Aceptar</button>
				</form:form>
				<br>
				<c:if test="${not empty error}">
					<h4>
						<span id="error">${error}</span>
					</h4>
					<br>
				</c:if>
				<c:if test="${not empty success}">
					<h4>
						<span id="success">${success}</span>
					</h4>
					<br>
				</c:if>
			</div>

		</div>


	</div>
</div>

<script type="text/javascript" src="js/datos-de-usuario.js"></script>


