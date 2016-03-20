require "bigdecimal"
require_relative 'reader'
require_relative 'camello'


class Camellodromo

attr_accessor :camellos, :cameyadrans_carrera, :vueltas, :yadrans_pista, :tabla_posiciones, :tablero

	def initialize(reader)
		#Datos propios del camellodromo. Son constantes, pero podrían cambiar para otra carrera
		@cameyadrans_carrera = 3210
		@vueltas = 5
		@yadrans_pista = cameyadrans_carrera/vueltas

		#Informacion propia de la carrera
		@tabla_posiciones = Hash.new("foo")

		@camellos = Hash.new("Este camello no existe")		

		reader.arreglo_camellos.each do |nombre,id|
			#nombre es realmente la abreviación, y id el espacio en memoria (puntero)
			camello = Camello.new(nombre,id)
			@camellos[id] = camello		
			@camellos[id].cameyadrans = reader.arreglo_datos.map{|ide,yadrans| yadrans if ide == id }.compact
			asign_x_vuelta(@camellos[id])
		end

		poblar_tablapos
		asignar_puntajes
	end
	#Lista de camellos
	#asigna puntaje a camellos y lugar
	#calcula cosas

	def asign_x_vuelta(camello)
		y_actual = BigDecimal.new("0")
		v_actual = 1
		t_actual = 0

		camello.cameyadrans.each do |segundo|
			t_actual = t_actual + 1
			if (y_actual < v_actual*yadrans_pista)
				y_actual += BigDecimal.new(segundo)			
			else
				camello.tiempos_xvueltas[y_actual.to_f] = t_actual 
				v_actual = v_actual + 1
			
			end
		end
		
		if(v_actual < vueltas+1 )
			# puts "#{camello.nombre} no termino la vuelta #{vueltas}"
			camello.tiempos_xvueltas[y_actual.to_f] = t_actual 
		end
		camello.tiempo_total = t_actual
		camello.calc_tiempos
	end


	def poblar_tablapos
		v_actual = 1

		while v_actual < vueltas+1
			arr_pos = []
			@camellos.each do |id,pos|
				arr_pos.push(id)
			end
			ordernar_tiempos(arr_pos, v_actual-1)

			@tabla_posiciones[v_actual] = arr_pos
			v_actual = v_actual + 1;
		end

	end

	# se ordenan los tiempos con bubble sort
	def ordernar_tiempos(arr,vpos)
		i = 1
		while i < arr.count-1
			j = 0
			while j < arr.count-1
				if @camellos[arr[j]].tiempos[vpos] > @camellos[arr[j+1]].tiempos[vpos]
					aux = arr[j]
					arr[j] = arr[j+1]
					arr[j+1] = aux
				end
				# puts "#{arr} #{j} #{@camellos[arr[j]].tiempos[vpos]} #{@camellos[arr[j]].id}  #{@camellos[arr[j+1]].tiempos[vpos]} #{@camellos[arr[j+1]].id} "
				j = j+1
			end
			i = i+1
			#puts "#{arr} #{i}"
		end

	end

	def asignar_puntajes
		@camellos.each do |id,pos|
			i = 1
			while i <= vueltas
				if id == tabla_posiciones[i][0] || @camellos[id].tiempos[i-1] == @camellos[tabla_posiciones[i][0]].tiempos[i-1]
					@camellos[id].puntajes.push(6)
					@camellos[id].posiciones[i-1] = 1
				elsif id == tabla_posiciones[i][1] || @camellos[id].tiempos[i-1] == @camellos[tabla_posiciones[i][1]].tiempos[i-1]
					@camellos[id].puntajes.push(4)
					@camellos[id].posiciones[i-1] = 2
				elsif id == tabla_posiciones[i][2] || @camellos[id].tiempos[i-1] == @camellos[tabla_posiciones[i][2]].tiempos[i-1]
					@camellos[id].puntajes.push(1)
					@camellos[id].posiciones[i-1] = 3
				else
					@camellos[id].puntajes.push(0)	
					@camellos[id].posiciones[i-1] = "no aplica"					
				end
				i = i+1
			end


		end

	end

	

end


