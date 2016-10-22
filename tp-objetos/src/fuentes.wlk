class Libro{
	var capitulos = []
	constructor(unosCapitulos){
		capitulos = unosCapitulos
	}
	
	method capitulos(){
		return capitulos
	}
	
	method brindarInformacion(){
		return capitulos.anyOne()
	}
}

object tinelli{
	method brindarInformacion(){
		return "Toto"
	}
}

object rial{
	method brindarInformacion(){
		return "Escandalo"
	}
}