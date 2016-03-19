
class Camello

	attr_accessor :nombre, :id, :puntaje, :tiempo_total, :lugar, :cameyadrans


	def initialize(nombre,id)
		@nombre = nombre
		@id = id
		@cameyadrans = [] #arreglo yadrans/s <- cada elemento es un segundo
		@tiempos_xvueltas = [] #arreglo de 5. Estaba pensando en hacerlo en un hash, pero en verdad es lo mismo xD
		@puntaje = 0
		@tiempo_total = 0
		@lugar = 0
	end

end


