module CarreraCamellos

	class Camello

		attr_accessor :name, :id, :puntaje, :tiempo, :lugar
		attr_reader :cameyardas

		def initialize()
			@nombre = ""
			@id = ""
			@cameyardas = [] #arreglo yardas/s <- cada elemento es un segundo
			@tiempos_xvueltas = [] #arreglo de 5
			@puntaje = 0
			@tiempo = 0
			@lugar = 0
		end

	end
	
end
