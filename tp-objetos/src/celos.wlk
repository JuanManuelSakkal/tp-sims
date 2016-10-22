
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