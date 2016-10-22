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
    var estadoCivil = soltero
    var conocimientos = #{}
    var relacionActual
    var relaciones = []
    var fuentesDeInformacion = []
    
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
    
    method perderFelicidad(cuantaFelicidad){
    	nivelDeFelicidad = (nivelDeFelicidad -= cuantaFelicidad).max(0)
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
    
    method pareja(){
    	return relacionActual.parejaDe(self)
    }
    
    method esAmigoDe(unSim) {
    	return unSim.amigos().contains(self)
    }
    
    method cantidadDeAmigos() {
    	return amigos.size()
    }
    
    method cuatroAmigosMasNuevos() {
    	return amigos.drop(self.cantidadDeAmigos() - 4)
    }
    
    method cuatroAmigosMasAntiguos() {
    	return amigos.take(4)
    }
    
    method nuevoEstadoCivil(unEstadoCivil){
    	estadoCivil = unEstadoCivil
    }
    
    method cumplirAnios(){
    	edad += 1
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
        return amigos.sum({amigo => amigo.nivelDeFelicidad()})
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
    
    method estadoDeAnimo() {
    	return estadoDeAnimo
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
    
    method difundir(unConocimiento) {
    	if(self.conoce(unConocimiento).negate()){
    		amigos.forEach({amigo => amigo.agregarConocimiento(unConocimiento)})
    	}	
    	conocimientos.add(unConocimiento)
    	
    }
    
    method esSecreto(unConocimiento){
    	return self.conoce(unConocimiento) && (amigos.all({amigo=> amigo.conoce(unConocimiento)})).negate()
    }
    
    method desparramarUnChisme(unConocimiento){
    	if(self.esChisme(unConocimiento)){
    		self.difundir(unConocimiento)
    	}
    }
    
    method esChisme(unConocimiento){
    	return amigos.any({amigo => amigo.esSecreto(unConocimiento)})
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
		return conocimientos.sum({conocimiento => conocimiento.length()})
	}
	
	method sabe(unConocimiento) {
		return self.conocimientos().contains(unConocimiento)
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
    
    method estadoCivil(){
    	return estadoCivil
    }
    
    method nuevaRelacion(unaRelacion) {
    	relacionActual = unaRelacion
    }
    
    method puedeTenerRelacion(){
    	estadoCivil.empezarRelacion()
    	if(edad <= 16){
    		error.throwWithMessage("Es menor")
    	}
     }
    
    method empezarRelacionCon(unSim) {
    	new Relacion().iniciar(self, unSim)
    	self.nuevoCirculoDeAmigos(relacionActual.circuloDeAmigos())
    	unSim.nuevoCirculoDeAmigos(relacionActual.circuloDeAmigos())
    }
    
    method formaParteDe(unaRelacion) {
    	return unaRelacion.esMiembro(self)
    }
    
    method nuevaRelacionPasada(unaRelacionPasada) {
    	relaciones.add(unaRelacionPasada)
    }
    
    method prestar(unMonto,unSim) {
    	if (self.lePuedePrestarA(unSim,unMonto)){
    		dinero -= unMonto
    		unSim.ganarDinero(unMonto)
    	}
    	else{
    		error.throwWithMessage("No puede prestarle.") 
    	}
    }
    
    method lePuedePrestarA(unSim,unMonto){	
    	return unMonto < dinero && unMonto <= self.dispuestoAPrestarA(unSim) && personalidad.lePrestaA(unSim,unMonto)
    }
    
    method dispuestoAPrestarA(unSim){
    	return 10* self.valoracion(unSim)
    	
    }

    method terminarRelacionActual() {
    	if(estadoCivil != soltero) {
    		relaciones.add(relacionActual)
    		self.nuevoCirculoDeAmigos(amigos)
    		self.nuevoEstadoCivil(soltero)
    		relacionActual.miembros().forEach({miembro => miembro.terminarRelacionActual()})
			relacionActual.terminar()
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
    
    method removerAmigosRicos() {
        amigos.removeAllSuchThat({amigo => amigo.dinero() > dinero})
    }

    method removerAmigosPopulares() {
        amigos.removeAllSuchThat({amigo => amigo.popularidad() > self.popularidad()})
    }
    
    method removerAmigosDePareja() {
        amigos.removeAllSuchThat({amigo => self.esAmigoDePareja(amigo) && amigos.contains(amigo)})
    }
    
    method esAmigoDePareja(unAmigo) {
    	return (self.pareja().amigos()).contains(unAmigo)
    }
    
    method brindarInformacion(){
    	return amigos.anyOne().conocimientos().find({conocimiento => self.esChisme(conocimiento)})
    }
    
    method obtenerInformacionDe(fuenteDeInformacion){
    	conocimientos.add(fuenteDeInformacion.brindarInformacion())
    }
    
    method agregarFuenteDeInformacion(fuenteDeInformacion){
    	fuentesDeInformacion.add(fuenteDeInformacion)
    }
    
    method seInforma(){
    	fuentesDeInformacion.forEach({fdi => self.obtenerInformacionDe(fdi)})
    }
    
    method fuentesDeInformacion(){
    	return fuentesDeInformacion
    }
}

class Vim inherits Sim {
	constructor(unSexo, unaEdad, unaFelicidad, unaPersonalidad, unSexoDePreferencia) = super (unSexo, 18, unaFelicidad, unaPersonalidad, unSexoDePreferencia)
	
	override method cumplirAnios(){}
}