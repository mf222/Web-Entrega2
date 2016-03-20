class Reader

	attr_reader  :cantidad_camellos, :arreglo_camellos, :arreglo_datos

	def initialize(path)
		@file = File.new(path, 'r')
		@cantidad_camellos = 0
		@arreglo_camellos = []
		@arreglo_datos = []

		read_file
	
	end

	def read_file()
		@cantidad_camellos = Integer(@file.gets)
		linea_camellos = @file.gets.delete("\t")
		linea_gigante = ''
        @file.each_line do |linea|
        	linea_gigante << linea.delete(' ').delete("\t")
        end		
   		get_data(linea_camellos,linea_gigante)
#aqui lee las lineas del archivo y las separa

	end

	def get_data(linea_camellos,linea_gigante)
		counter = 0
		counter2 = 0
# hace los splits
		arreglo_muchoscamellos = linea_camellos.split(";")
		arreglo_muchosdatos = linea_gigante.split(",")

		while counter2 < arreglo_muchoscamellos.size-1 do
			lineacamellos = arreglo_muchoscamellos[counter2].split(",").collect{|x| x.strip }
			@arreglo_camellos.push(lineacamellos)
			counter2+=1
		end

		while counter < arreglo_muchosdatos.size do
			@arreglo_datos.push([arreglo_muchosdatos[counter],arreglo_muchosdatos[counter+1]])
			counter+=2
		end
		
	end


end