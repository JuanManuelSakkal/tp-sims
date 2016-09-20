class CopadosYAburridos {
	var puntosFelicidad
	var pago
	
	method trabajar (unSim) {
		unSim.ganarFelicidad(puntosFelicidad)
		unSim.ganarDinero(pago)
	}
}


class Copado inherits CopadosYAburridos {
	constructor(unosPuntosDeFelicidad, unPago) {
		puntosFelicidad = unosPuntosDeFelicidad
		pago = unPago
	}
}


class Aburrido inherits CopadosYAburridos {
	constructor(unosPuntosDeFelicidad, unPago) {
		puntosFelicidad = -unosPuntosDeFelicidad
		pago = unPago
	}
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
