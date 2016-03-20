require_relative 'reader'
require_relative 'camellodromo'
require_relative 'camello'

#pablosalgadom@gmail.com

#ARGV[0]
#inicializar reader pasandole el archivo
puts "Bienvenid@ al simulador del Derby del Gran Camejockey de las 3210 cameyardas del Camellodromo de Chantiago"

read = Reader.new(ARGV[0])

camellodromo_nacional = Camellodromo.new(read)
puts ""

#MAS ELEGANTE CON CASE REVISAR LUEGO
puts "Ganadores 3 primeras vueltas"
i = 0
while i < 3
	puts "Vuelta #{i+1}"
	count1 = 0
	count2 = 0
	puts "1er lugar:"
	
	camellodromo_nacional.camellos.each do |nombre,|
		#puts "#{camellodromo_nacional.camellos[nombre].posiciones}"
		if camellodromo_nacional.camellos[nombre].posiciones[i] == 1
			puts "#{camellodromo_nacional.camellos[nombre].nombre}"
			count1 += 1
		end
	end


	if count1<3
		puts "2do lugar:"
		camellodromo_nacional.camellos.each do |nombre,|
			if camellodromo_nacional.camellos[nombre].posiciones[i] == 2
				puts "#{camellodromo_nacional.camellos[nombre].nombre}"
				count2 +=1
			end
		end
	end

	if count1+count2<3
		puts "3er lugar:"
		camellodromo_nacional.camellos.each do |nombre,|
			if camellodromo_nacional.camellos[nombre].posiciones[i] == 3
				puts "#{camellodromo_nacional.camellos[nombre].nombre}"
			end
		end
	end

	
	puts ""
i = i + 1
end

puts ""
puts "Puntajes por camello"
camellodromo_nacional.camellos.each do |nombre,|
	puts "#{camellodromo_nacional.camellos[nombre].nombre} #{camellodromo_nacional.camellos[nombre].puntajes[0..2]} #{camellodromo_nacional.camellos[nombre].calc_puntos} "	
end

puts ""
puts "Ganador:"
finalizaron = []

camellodromo_nacional.camellos.each do |nombre,|
	if camellodromo_nacional.camellos[nombre].finalizadas[camellodromo_nacional.vueltas-1]
		finalizaron.push(camellodromo_nacional.camellos[nombre].tiempos[camellodromo_nacional.vueltas-1])
	end
	#puts "#{camellodromo_nacional.camellos[nombre].nombre} #{camellodromo_nacional.camellos[nombre].tiempo_total} #{camellodromo_nacional.camellos[nombre].puntajes}"
end

if finalizaron.count != 0
	winners = camellodromo_nacional.el_ganador(finalizaron)
	winners.each do |id|
		puts "El ganador es #{camellodromo_nacional.camellos[id].nombre} "
	end
else
	puts "Nadie finalizo la carrera."
end

camellodromo_nacional.camellos.each do |id,|
puts "#{camellodromo_nacional.camellos[id].cameyadrans_totales.to_f}"

end
#Falta calcularlo! es el con mayor puntaje o el que termina la carrera?

#puts "#{camellodromo_nacional.tabla_posiciones}"

#-> 5 -> arreglo (nombre,id) -> arreglo gigante # hecho
#asignar lo que retorna el reader a camello #hecho
#-> while (count<5) <- creo 5 camellos y los asigno #hecho
#asginar los camellos a camellodromo #hecho
#-> calcula los tiempos, lugares y puntos # hecho
#main imprime en pantalla # hecho
#calcular ganador #NO HECHO