import objetos.*

class TrabajosQueAfectanLaMoral {
	var puntosFelicidad
	var pago
	
	constructor(unosPuntosDeFelicidad, unPago) {
		puntosFelicidad = unosPuntosDeFelicidad
		pago = unPago
	}
	
	method trabajar (unSim) {
		unSim.ganarFelicidad(puntosFelicidad)
		unSim.ganarDinero(pago)
		unSim.cambioDeAnimo(normal)
	}
}


//FIXME: ok, funciona, y lo resuelven sin repetir lógica. Bien por eso. 
//Pero estaría bueno que lo resuelvan sin depender de la redefinicion de constructores,
//dado que no es un elementro central del paradigma de objetos, y que es una solución poco flexible.
//Si el cáclulo tiene por ejemplo un if, ya esto no les va a andar. 
//Les propongo que lo lleven a la estructura de un template method (clase abstracta con métodos concretos que utilizan métodos abstractos), 
//como mostramos la clase pasada. 
class Copado inherits TrabajosQueAfectanLaMoral {
	constructor(unosPuntosDeFelicidad, unPago) = super(unosPuntosDeFelicidad, unPago)
}


class Aburrido inherits TrabajosQueAfectanLaMoral {
	constructor(unosPuntosDeFelicidad, unPago) = super(-unosPuntosDeFelicidad, unPago)
}

class AburridoHastaLaMuerte inherits TrabajosQueAfectanLaMoral {
	constructor(unosPuntosDeFelicidad, unPago) = super(-3 * unosPuntosDeFelicidad, unPago)
}

class MercenarioSocial inherits Mercenario {
	override method calcularSuma(unSim) {
		return 100 + 0.02 * unSim.dinero() + unSim.cantidadDeAmigos()
	}
}

class Mercenario {
	method trabajar(unSim) {
		unSim.ganarDinero(self.calcularSuma(unSim))
		unSim.cambioDeAnimo(normal)
	}
	
	method calcularSuma(unSim) {
		return 100 + 0.02 * unSim.dinero()
	}
}


object desocupado {
		method trabajar(unSim) {}
}
