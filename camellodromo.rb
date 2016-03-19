
require_relative 'reader'
require_relative 'camello'


class Camellodromo

	def initialize(reader)
		@camellos = Hash.new("Este camello no existe")

		reader.arreglo_camellos.each do |nombre,id|
			camello = Camello.new(nombre,id)
			@camellos[id] = camello		
			@camellos[id].cameyadrans = reader.arreglo_datos.map{|ide,yadrans| yadrans if ide == id }.compact


		end
	end
	#Lista de camellos
	#asigna puntaje a camellos y lugar
	#calcula cosas


end


