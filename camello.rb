require "bigdecimal"
class Camello

	attr_accessor :nombre, :id, :puntaje, :tiempo_total, :lugar, :cameyadrans, :tiempos_xvueltas, :tiempos, :puntajes, :posiciones


	def initialize(nombre,id)
		@nombre = nombre
		@id = id
		@cameyadrans = [] #arreglo yadrans/s <- cada elemento es un segundo
		@tiempos_xvueltas = Hash.new("foo") #hash de 5. almacena tupla (tiempo, yadra)
		@tiempos = [] #tiempos a secas
		@puntajes = [] #puntaje por vuelta
		@tiempo_total = 0
		@posiciones = [] #lugar por vuelta
	end

	def yadrans_totales()
		time = BigDecimal.new("0")

		cameyadrans.each do |segundo|
			#puts "#{segundo}"
			time += BigDecimal.new(segundo)
			#puts "#{time}"
		end

		return time.to_f
	end

	def calc_tiempos()
		arr_keys = tiempos_xvueltas.keys
		arr_keys.each do |key|
			tiempos.push(tiempos_xvueltas[key])
		end
	end

	def calc_puntos()
		total = 0
		i = 0
		puntajes.each do |points|
			if i < 3
				total += points				
			end
		i = i + 1
		end
		return total
	end

end


