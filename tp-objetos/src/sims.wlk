import relaciones.*
import objetos.*
import trabajos.*


class Sim {
    var sexo
    var edad
    var nivelDeFelicidad 
    var amigos = []
    var circuloDeAmigos = #{}
    var personalidad
    var dinero = 0
    var estadoDeAnimo = normal
    var sexoDePreferencia
    var trabajo = desocupado
    var pareja
    var conocimientos = #{}
    var relacionActual
    var relaciones = []
    
    constructor(unSexo, unaEdad, unaFelicidad, unaPersonalidad, unSexoDePreferencia) {
    	sexo = unSexo
    	edad = unaEdad
    	nivelDeFelicidad = unaFelicidad
    	personalidad = unaPersonalidad
    	sexoDePreferencia = unSexoDePreferencia
    }
    
    method ganarFelicidad(cuantaFelicidad) {
    	nivelDeFelicidad += cuantaFelicidad
    }
    
	method hacerseAmigoDe(amigo) {
        amigos.add(amigo)
        circuloDeAmigos.add(amigo)
        nivelDeFelicidad += self.valoracion(amigo)
    }
    
    method nivelDeFelicidad() {
        return nivelDeFelicidad
    }
    
    method dinero() {
        return dinero
    }
    
    method conocimientos() {
    	return conocimientos
    }
    
    method esAmigoDe(unSim) {
    	return unSim.amigos().contains(self)
    }
    
    method cuatroAmigosMasNuevos() {
    	return amigos.drop(amigos.size() - 4)
    }
    
    method cuatroAmigosMasAntiguos() {
    	return amigos.take(4)
    }
    
    method nuevaPareja(unSim) {
    	pareja = unSim
    }
    
    method pareja() {
    	return pareja
    }
    
    method amigos() {
        return amigos
    }
    
    method nuevoCirculoDeAmigos(unCirculoDeAmigos) {
    	circuloDeAmigos = unCirculoDeAmigos
    }
    
    method circuloDeAmigos() {
    	return circuloDeAmigos
    }
    
    method edad() {
        return edad
    }
    
    method relacion() {
    	return relacionActual
    }
    
    method relacionesPasadas() {
    	return relaciones
    }
    
    method popularidad() {
        return amigos.map({amigo => amigo.nivelDeFelicidad()}).sum()
    }
    
    method sexo() {
        return sexo
    }
    
    method sexoDePreferencia() {
        return sexoDePreferencia
    }
    
    method amigoMasValorado() {                         
    	return amigos.max({amigo => self.valoracion(amigo)})
    }
    
    method valoracion(amigo) {                                              
        return personalidad.valoracion(self, amigo)
    }
    
    method cambioDeAnimo(animoNuevo) {                         
       estadoDeAnimo.deshacerAccion(self)
       estadoDeAnimo = animoNuevo
       estadoDeAnimo.accion(self)
    }
    
    method leAtrae(unSim) {                      
        return (sexoDePreferencia == unSim.sexo()) && personalidad.atraccion(self,unSim)                    
    }
    
    method abrazarCorto(unSim) {
        abrazo.corto(self, unSim)
    }
    
    method abrazarProlongado(unSim) {
        abrazo.prolongado(self, unSim)
    }
    
    method agregarConocimiento(nuevoConocimiento) {
        conocimientos.add(nuevoConocimiento)
    }
    
    method conoce(unConocimiento) {
    	return conocimientos.contains(unConocimiento)
    }
    
    method trabajar() {
		trabajo.trabajar(self)
		personalidad.bonusFelicidad(self)
	}
	
	method ganarDinero (monto) {
		dinero += monto
	}

	method nivelDeConocedor() {
		return conocimientos.map({conocimiento => conocimiento.length()}).sum()
	}

	method trabajo() {
		return trabajo
	}
	
	method nuevoTrabajo(unTrabajo) {
		trabajo = unTrabajo
	}
    
    method olvidarseTodo() {
        conocimientos = #{}
    }
    
    method quienesLeAtraen(unosSims) {
    	return unosSims.filter({unSim => self.leAtrae(unSim)})
    }
    
    method nuevaRelacion(unaRelacion) {
    	relacionActual = unaRelacion
    }
    
    method empezarRelacionCon(unSim) {
    	new Relacion().iniciar(self, unSim)
    }
    
    method formaParteDe(unaRelacion) {
    	return unaRelacion.esMiembro(self)
    }
    
    method nuevaRelacionPasada(unaRelacionPasada) {
    	relaciones.add(unaRelacionPasada)
    }
    
    method terminarRelacionActual() {
    	if(relacionActual != null) {
    		relaciones.add(relacionActual)
    		self.nuevoCirculoDeAmigos(amigos)
    		relacionActual.terminar()
    		relacionActual = null
    		pareja.terminarRelacionActual()
    		pareja = null
    	}
    }
    
    method reestablecerRelacionCon(unSim) {
    	relaciones.find({relacion => relacion.esIntegrante(unSim)}).reestablecer()
    }
    
    method esElMasPopular() {
  		return self.popularidad() >= circuloDeAmigos.map({amigo => amigo.popularidad()}).max()
    }
    
    method leAgarranCelos(celos) {
        celos.accion(self)
    }
    
    method filtrarAmigosPorPlata() {
        amigos = amigos.filter({amigo => amigo.dinero() <= dinero})
    }
    
    method filtrarAmigosPorPopularidad() {
        amigos = amigos.filter({amigo => amigo.popularidad() <= self.popularidad()})
    }
    
    method filtrarAmigosPorPareja() {
        amigos = amigos.filter({amigo => ((pareja.amigos()).contains(amigo)).negate() && amigos.contains(amigo)})
    }
}