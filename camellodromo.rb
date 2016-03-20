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
		@tabla_posiciones = Hash.new("foo") # hash { vuelta, [array_posiciones relativas]}
		@tablero = Hash.new("foo") # hash { vuelta , hash {lugar, [array_camellos]} }

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

			if y_actual < v_actual*yadrans_pista
				y_actual += BigDecimal.new(segundo)			
			end

			if y_actual > v_actual*yadrans_pista
				#puts "#{t_actual} #{y_actual.to_f}"
				camello.tiempos_xvueltas[v_actual] = t_actual 
				v_actual = v_actual+1
				camello.finalizadas.push(true)
			end
		end
		
		if(y_actual < cameyadrans_carrera )
			#puts "#{camello.nombre} no termino la vuelta #{vueltas}"
			camello.tiempos_xvueltas[v_actual] = t_actual
			camello.finalizadas.push(false)
		end
		camello.tiempo_total = t_actual
		camello.calc_tiempos
		#puts "#{camello.tiempos} #{t_actual} #{y_actual.to_f}"
		camello.cameyadrans_totales = y_actual


	end


	def poblar_tablapos
		v_actual = 0

		while v_actual < vueltas
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
		while i < arr.count
			j = 0
			while j < arr.count-1
				#puts "#{camellos[arr[j]].tiempos} #{@camellos[arr[j+1]].tiempos}"
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
		count1 = 0
		count2 = 0
		@camellos.each do |id,pos|
			i = 0
			while i < vueltas
				if id == tabla_posiciones[i][0] || @camellos[id].tiempos[i] == @camellos[tabla_posiciones[i][0]].tiempos[i]
					@camellos[id].puntajes.push(6)
					@camellos[id].posiciones[i] = 1	
					count1 +=1				
				elsif id == tabla_posiciones[i][1] || @camellos[id].tiempos[i] == @camellos[tabla_posiciones[i][1]].tiempos[i]
					if count1 < 3
						@camellos[id].puntajes.push(4)
					else
						@camellos[id].puntajes.push(0)
					end
					@camellos[id].posiciones[i] = 2
					count2 +=1
				elsif id == tabla_posiciones[i][2] || @camellos[id].tiempos[i] == @camellos[tabla_posiciones[i][2]].tiempos[i]
					if count1+count2<3
						@camellos[id].puntajes.push(1)
					else
						@camellos[id].puntajes.push(0)
					end

					@camellos[id].posiciones[i] = 3
				else
					@camellos[id].puntajes.push(0)
					@camellos[id].posiciones[i] = nil								
				end
				i = i+1
			end			
		end		
	end


	def el_ganador(arr_ids)
		ganadores = []
		arr = arr_ids.sort
		camellos.each do |id,|
			if camellos[id].tiempos[vueltas-1] == arr[0]
				ganadores.push(camellos[id].id)
			end
		end

		return ganadores

	end


	

end


