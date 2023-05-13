package ar.edu.unlam.tallerweb1.servicios;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import ar.edu.unlam.tallerweb1.exceptions.NombreExistenteException;
import ar.edu.unlam.tallerweb1.exceptions.SpriteNoIngresadoException;
import ar.edu.unlam.tallerweb1.modelo.*;
import ar.edu.unlam.tallerweb1.repositorios.RepositorioPokemon;

@Service("servicioPokemon")
@Transactional
public class ServicioPokemonImpl implements ServicioPokemon {

	private RepositorioPokemon repositorioPokemon;
	private ServicioAtaquePokemon servicioAtaquePokemon;
	private ServicioAtaque servicioAtaque;
	private ServletContext servletContext;

	@Autowired
	public ServicioPokemonImpl(RepositorioPokemon repositorioPokemon, ServicioAtaquePokemon servicioAtaquePokemon,
			ServicioAtaque servicioAtaque, ServletContext servletContext) {
		this.repositorioPokemon = repositorioPokemon;
		this.servicioAtaquePokemon = servicioAtaquePokemon;
		this.servicioAtaque = servicioAtaque;
		this.servletContext = servletContext;
	}

	@Override
	public void guardarPokemon(Pokemon pokemon, List<Long> ataques, MultipartFile frente, MultipartFile dorso)
			throws IOException, NombreExistenteException, SpriteNoIngresadoException {
		if (frente.isEmpty() | dorso.isEmpty()) {
			throw new SpriteNoIngresadoException("No ha ingresado los dos sprites del pokemon");
		}
		validarPokemon(pokemon, frente, dorso, "");
		this.repositorioPokemon.guardarPokemon(pokemon);
		ataques.forEach(x -> this.servicioAtaquePokemon
				.guardarAtaque(new AtaquePokemon(this.servicioAtaque.buscarAtaque(x), pokemon)));
	}

	@Override
	public void modificarPokemon(Pokemon pokemon, List<Long> ataques, MultipartFile frente, MultipartFile dorso,
			String nombreAnterior) throws IOException, NombreExistenteException {
		validarPokemon(pokemon, frente, dorso, nombreAnterior);
		this.repositorioPokemon.modificarPokemon(pokemon);
		List<Ataque> aprendidos = this.servicioAtaquePokemon.obtenerListaDeAtaquePokemon(pokemon.getId());
		Long ataque;
		for (Ataque aprendido : aprendidos) {
			ataque = verificarAtaqueOlvidado(aprendido, ataques);
			if (ataque == null) {
				this.servicioAtaquePokemon.borrarAtaquePokemon(aprendido.getId(), pokemon.getId());
			} else {
				ataques.remove(ataque);
			}
		}
		ataques.forEach(x -> this.servicioAtaquePokemon
				.guardarAtaque(new AtaquePokemon(this.servicioAtaque.buscarAtaque(x), pokemon)));
	}

	public Long verificarAtaqueOlvidado(Ataque aprendido, List<Long> ataques) {
		for (Long ataque : ataques) {
			if (ataque == aprendido.getId()) {
				return ataque;
			}
		}
		return null;
	}

	private void validarPokemon(Pokemon pokemon, MultipartFile frente, MultipartFile dorso, String nombreAnterior)
			throws IOException, NombreExistenteException {
		if (nombreAnterior.equals(pokemon.getNombre())
				|| this.repositorioPokemon.buscarPokemonPorNombre(pokemon.getNombre()) == null) {
			try {
				if (!frente.isEmpty()) {
					guardarImagen(frente, pokemon.getNombre());
					pokemon.setImagenFrente(frente.getOriginalFilename());
				}
				if (!dorso.isEmpty()) {
					guardarImagen(dorso, pokemon.getNombre());
					pokemon.setImagenDorso(dorso.getOriginalFilename());
				}
			} catch (IOException ex) {
				throw new IOException("No se pudo guardar los archivos");
			}
		} else {
			pokemon.setNombre(nombreAnterior);
			throw new NombreExistenteException("El nombre del pokemon ya existe");
		}
	}

	public void guardarImagen(MultipartFile imagen, String nombrePokemon) throws IOException {
		String fileName = imagen.getOriginalFilename();
		String uploadDir = servletContext.getRealPath("") + "images/sprites/" + nombrePokemon;
		Path uploadPath = Paths.get(uploadDir);
		System.out.println(uploadDir);
		if (!Files.exists(uploadPath)) {
			Files.createDirectories(uploadPath);
		}
		InputStream inputStream = imagen.getInputStream();
		Path filePath = uploadPath.resolve(fileName);
		Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
	}

	@Override
	public Pokemon buscarPokemon(Long id) {
		Pokemon pokemon = this.repositorioPokemon.buscarPokemon(id);
		pokemon.setAtaques(this.servicioAtaquePokemon.obtenerListaDeAtaquePokemon(id));
		return pokemon;
	}

	@Override
	public Pokemon buscarPokemonPorNombre(String nombre) {
		return this.repositorioPokemon.buscarPokemonPorNombre(nombre);
	}

	@Override
	public List<Pokemon> obtenerTodosLosPokemons() {
		return this.repositorioPokemon.obtenerTodosLosPokemons();
	}

	@Override
	public void borrarPokemon(Long id) {
		this.repositorioPokemon.borrarPokemon(id);
	}

}
