class Celos {
	method perderFelicidad(unSim){
		unSim.perderFelicidad(10)
	}
}

object celosPorPlata inherits Celos {
    method accion(unSim) {
        unSim.removerAmigosRicos()
        
        self.perderFelicidad(unSim)
    }
}


object celosPorPopularidad inherits Celos{
    method accion(unSim) {
        unSim.removerAmigosPopulares()
        self.perderFelicidad(unSim)
    }
}


object celosPorPareja inherits Celos{
    method accion(unSim) {
        unSim.removerAmigosDePareja()
        self.perderFelicidad(unSim)
    }
}


object normal {
	method accion(unSim) {}
	method deshacerAccion(unSim) {}
}


object soniador {
    method accion(unSim) {
        unSim.ganarFelicidad(1000)
        unSim.olvidarseTodo()
    }
    
    method deshacerAccion(unSim) {
    	unSim.perderFelicidad(1000)
    }
}


object incomodo {
    method accion(unSim) {
        unSim.perderFelicidad(200)
    }
    method deshacerAccion(unSim) {
    	unSim.ganarFelicidad(200)
    }
}


object abrazo {
    method corto(abrazador, abrazado) {
        abrazador.ganarFelicidad(2)
        abrazado.ganarFelicidad(4)
    }
    
    method prolongado(abrazador, abrazado) {
        if(abrazado.leAtrae(abrazador)) {
            abrazado.cambioDeAnimo(soniador)
        }
        else {
            abrazado.cambioDeAnimo(incomodo)
        }
    }
}


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

class Libro{
	var capitulos = []
	constructor(unosCapitulos){
		capitulos = unosCapitulos
	}
	
	method brindarInformacion(){
		return capitulos.anyOne()
	}
}

class Tinelli{
	method brindarInformacion(){
		return "Toto"
	}
}

class Rial{
	method brindarInformacion(){
		return "Escandalo"
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