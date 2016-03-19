require_relative 'reader'
require_relative 'camellodromo'
require_relative 'camello'

#pablosalgadom@gmail.com

#ARGV[0]
#inicializar reader pasandole el archivo

read = Reader.new(ARGV[0])

camellodromo_nacional = Camellodromo.new(read)

#-> 5 -> arreglo (nombre,id) -> arreglo gigante # hecho
#asignar lo que retorna el reader a camello #hecho
#-> while (count<5) <- creo 5 camellos y los asigno #hecho
#asginar los camellos a camellodromo #hecho
#-> calcula los tiempos, lugares y puntos # NO HECHO
#main imprime en pantalla #NO HECHO