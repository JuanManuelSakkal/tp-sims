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
	}
}


class Copado inherits TrabajosQueAfectanLaMoral {
	constructor(unosPuntosDeFelicidad, unPago) = super(unosPuntosDeFelicidad, unPago)
}


class Aburrido inherits TrabajosQueAfectanLaMoral {
	constructor(unosPuntosDeFelicidad, unPago) = super(-unosPuntosDeFelicidad, unPago)
}


class Mercenario {
	method trabajar(unSim) {
		unSim.ganarDinero(self.calcularSuma(unSim))
	}
	
	method calcularSuma(unSim) {
		return 100 + 0.02 * unSim.dinero()
	}
}


object desocupado {
		method trabajar(unSim) {}
}
