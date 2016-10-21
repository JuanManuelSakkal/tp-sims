class Relacion{
	var circuloDeAmigos = #{}
	var integrante1
	var integrante2
	var miembros = #{}
	var termino
	
	
	method iniciar(unSim, otroSim) {
		termino = false
		self.ponerEnRelacion(unSim)
		self.ponerEnRelacion(otroSim)
    	integrante1 = unSim
		integrante2 = otroSim

	}
	
	method ponerEnRelacion(unSim){
		unSim.puedeTenerRelacion()
		unSim.nuevaRelacion(self)
		unSim.amigos().forEach({amigo => circuloDeAmigos.add(amigo)})
		unSim.nuevoEstadoCivil(enPareja)
		miembros.add(unSim)
	}
	
	method funciona() {
		return integrante1.leAtrae(integrante2) && integrante2.leAtrae(integrante1)
	}
	
	method esMiembro(unSim) {
		return miembros.any({miembro => miembro == unSim})
	}
	
	method parejaDe(unSim){
		return miembros.find({miembro => miembro != unSim})
	}
	
	method sePudrioTodo() {
		return not(self.funciona()) && circuloDeAmigos.any({amigo => miembros.any({integrante => integrante.leAtrae(amigo)})})
	}
	
	method esIntegrante(unSim) {
		return integrante1 == unSim || integrante2 == unSim
	}
	
	method terminar() {
		miembros = []
		termino = true
	}
	
	method seTermino() {
		return termino
	}
	
	method circuloDeAmigos() {
		return circuloDeAmigos
	}
	
	method miembros() {
		return miembros
	}
	
	method reestablecer() {
		integrante1.terminarRelacionActual()
		integrante2.terminarRelacionActual()
		self.iniciar(integrante1, integrante2)
	}
}

object soltero{
	method empezarRelacion(){}
}

object enPareja{
	method empezarRelacion(){
		error.throwWithMessage("Ya esta en pareja") 
		
	}
}