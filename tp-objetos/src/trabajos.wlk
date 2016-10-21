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
