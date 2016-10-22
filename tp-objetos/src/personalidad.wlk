class Personalidad {
	method bonusFelicidad(unSim) {}
	 
	method lePrestaA(unSim,unMonto) {
		return true
	} 
	
}


object interesado inherits Personalidad {
    method valoracion(siMismo, otroSim) {
        return (otroSim.amigos().map({amigo => amigo.dinero()}).sum()) * 0.1
    }
    
    method atraccion(siMismo, unSim) {
        return unSim.dinero() >= siMismo.dinero() * 2
    }
    
    override method lePrestaA(unSim,unMonto){
    	return unMonto < unSim.dinero()
    }
}


object superficial inherits Personalidad {
    method valoracion(siMismo, amigo) {
        return 20 * (amigo.popularidad())
    }
    
    method atraccion(siMismo, unSim) {
        return 18 < unSim.edad() && unSim.edad() < 29 && unSim.popularidad() >= ((siMismo.amigos()).map({amigo => amigo.popularidad()})).max()
    }
}


object peleadoConLaVida inherits Personalidad {
    method valoracion(siMismo, amigo) {
        return 0
    }
    
    method atraccion(siMismo, unSim) {
        return unSim.nivelDeFelicidad() < 200
    }
}


object buenazo inherits Personalidad {
    method valoracion(siMismo, amigo) {
        return 0.5 * siMismo.nivelDeFelicidad()
    }
    
    method atraccion(siMismo, unSim) {
        return true
    }
    
    override method bonusFelicidad(unSim) {
		if(unSim.amigos().all({amigo => amigo.trabajo() == unSim.trabajo()}))
			unSim.ganarFelicidad(unSim.nivelDeFelicidad() * 0.1)
	}
}