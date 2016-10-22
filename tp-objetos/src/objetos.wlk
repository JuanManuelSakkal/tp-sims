


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


