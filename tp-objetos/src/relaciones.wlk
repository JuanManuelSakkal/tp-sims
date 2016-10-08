class Relacion{
	var circuloDeAmigos = #{}
	var integrante1
	var integrante2
	var miembros = #{}
	var termino
	
	//FIXME este método es bastante largo y complejo
	//no podrían delegarlo y partir el problema 
	//en subproblemas más chicos?
	method iniciar(unSim, otroSim) {
		termino = false
		//FIXME acá hay bastante código repetido. Noten que la mayoría de las 
		//cosas que hacen para un sim, las hacen también al otro
		self.ponerEnRelacion(unSim)
		self.ponerEnRelacion(otroSim)
    	integrante1 = unSim
		integrante2 = otroSim

	}
	
	method ponerEnRelacion(unSim){
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
	
}

object enPareja{}