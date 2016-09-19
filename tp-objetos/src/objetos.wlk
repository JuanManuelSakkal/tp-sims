object celosPorPlata{
    method accion(unSim){
        unSim.filtrarAmigosPorPlata()
        unSim.darFelicidad(-10)
    }
}

object celosPorPopularidad{
    method accion(unSim){
        unSim.filtrarAmigosPorPopularidad()
        unSim.darFelicidad(-10)
    }
    
}

object celosPorPareja{
    method accion(unSim){
        unSim.filtrarAmigosPorPareja()
        unSim.darFelicidad(-10)
    }
    
}

object normal{
	method accion(unSim){}
	method deshacerAccion(unSim){}
}

object soniador{
    method accion(unSim){
        unSim.darFelicidad(1000)
        unSim.olvidarseTodo()
    }
    
    method deshacerAccion(unSim){
    	unSim.darFelicidad(-1000)
    }
}

object incomodo{
    method accion(unSim){
        unSim.darFelicidad(-200)
    }
    method deshacerAccion(unSim){
    	unSim.darFelicidad(200)
    }
}

object abrazo{
    
    method corto(abrazador,abrazado){
        abrazador.darFelicidad(2)
        abrazado.darFelicidad(4)
    }
    method prolongado(abrazador,abrazado){
        if(abrazado.leAtrae(abrazador)){
            abrazado.cambioDeAnimo(soniador)
        }
        else{
            abrazado.cambioDeAnimo(incomodo)
        }
    }
}

class Personalidad{
	method bonusFelicidad(unSim){}
}

object interesado inherits Personalidad{
    method valoracion(siMismo,otroSim){
        return (otroSim.amigos().map({amigo => amigo.dinero()}).sum())*0.1
    }
    
    method atraccion(siMismo,unSim){
        return unSim.dinero()>=siMismo.dinero()*2
    }
}

object superficial inherits Personalidad{
    method valoracion(siMismo,amigo){
        return 20*(amigo.popularidad())
    }
    
    method atraccion(siMismo,unSim){
        return 18<unSim.edad() && unSim.edad()<29&& unSim.popularidad() >= ((siMismo.amigos()).map({amigo => amigo.popularidad()})).max()
    }
}

object peleadoConLaVida inherits Personalidad{
    method valoracion(siMismo,amigo){
        return 0
    }
    
    method atraccion(siMismo,unSim){
        return unSim.nivelDeFelicidad()<200
    }
}

object buenazo inherits Personalidad{
    method valoracion(siMismo,amigo){
        return 0.5*siMismo.nivelDeFelicidad()
    }
    
    method atraccion(siMismo,unSim){
        return true
    }
    
    override method bonusFelicidad(unSim){
		if(unSim.amigos().all({amigo => amigo.trabajo() == unSim.trabajo()}))
		unSim.darFelicidad(unSim.nivelDeFelicidad() * 0.1 )
	}
}