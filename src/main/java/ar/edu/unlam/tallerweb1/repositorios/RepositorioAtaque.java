package ar.edu.unlam.tallerweb1.repositorios;

import java.util.List;

import ar.edu.unlam.tallerweb1.modelo.Ataque;

public interface RepositorioAtaque {

	List<Ataque> obtenerTodosLosAtaques();

	Ataque buscarAtaque(Long id);

}