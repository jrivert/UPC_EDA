time = Time.now
$fecha = time.strftime("%Y-%m-%d")
$clicos=3
$ElementosDeMatrizBi=8
$CantidadHabitaciones=$ElementosDeMatrizBi * $ElementosDeMatrizBi
def presentacion(cantHabitaciones)
	puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	puts "::                      PANDEMIA                      ::"
	puts "::   San Jose Memorial Hospital                       ::"
	puts "::   Fecha: " + $fecha + "                                ::"
	puts "::   Cantidad de habitaciones : " + $CantidadHabitaciones.to_s + "                    ::"
	puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
end

def solicitarModalidad()
	modalidad=""
	begin
		puts ""
		print "Por favor indicar si desea iniciar la infeccion con datos aleatorios a de forma manual [A/M]: "
		modalidad=gets.chomp	
		modalidad=modalidad.upcase
	end while modalidad!="A" && modalidad!="M"
	return modalidad
end 
def crearMatriz(cantidad)
	matriz=[]
	submatriz=[]
	for j in 0...cantidad
		for i in 0...cantidad
			submatriz.push(".")
		end
		matriz.push(submatriz)
		submatriz=[]
	end	
	return matriz
end	
def showMatriz(matriz)
	armarMatriz=""
	for j in 0...matriz.size
		armarMatriz=armarMatriz+"  "
		#Pinta cabecera numerico de matriz
		if j==0
			for i in 0...matriz[j].size
				armarMatriz=armarMatriz+"#{i +1} "	
			end	
			armarMatriz="  "+armarMatriz + "\n  "
		end	
			armarMatriz=armarMatriz + "#{j+1} "
		for i in 0...matriz[j].size
				armarMatriz=armarMatriz+"#{matriz[j][i]} "
		end
		armarMatriz=armarMatriz+"\n"
	end 
	return armarMatriz
end
def solicitarHabitacionInfectada(c)
		begin 
			print "Ingrese la habitacion Nro #{c} formato[c,f]: "
			respuesta=gets.chomp
			formato=/([1-8]{1}),([1-8]{1})/
			validarFormato=formato.match(respuesta)
		end while !validarFormato
		return respuesta					
end
def estadistica(ciclo,habitacionesInfectadas,muertos)
	puts ""
	puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	puts "                        ESTADISTICA                         "
	puts " Cliclo: #{ciclo}"
	puts " Habitaciones infectadas: #{habitacionesInfectadas}"
	puts " Cantidad  de habitaciones: #{$CantidadHabitaciones}"
	porc= ((habitacionesInfectadas.to_f / $CantidadHabitaciones.to_f)*100).round(2)
	puts " Porcentaje de infección #{porc}%"
	puts " Muertos en el ciclo: #{muertos}"
	puts ""
	puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::" 
end
def senbrarBacteriaAutomaticamente(matriz,n)
	for i in 1..n.to_i
		nroA=rand(1..8)
		nroB=rand(1..8)
		matriz[nroA-1][nroB-1]="*"
	end
	return matriz
end
#Como será una matriz de nxn solo se considera un numero para poder multiplicarlo por en mismo numero

#iniciamos la presentacion del sistmea
presentacion($CantidadHabitaciones)
#solicitamos la modalidad de iniciar infeccion 
matriz=crearMatriz($ElementosDeMatrizBi)
puts ""
puts showMatriz(matriz)
modalidad=solicitarModalidad()
if modalidad=="M"
	puts ""
	puts "::::  Iniciando proceso de infección manual  ::::"
	formato=/(\d{1})/
	begin
		puts ""
		print "Cuantos cuartos desea infectar: "
		respuesta= gets.chomp
		valFormato=formato.match(respuesta)

	end while !valFormato
	#Iniciar pedidos de cuartos infectados
	for i in 1..respuesta.to_i
		datoIngreso=solicitarHabitacionInfectada(i)
		cordenadas=datoIngreso.split(",")
		matriz[cordenadas[0].to_i-1][cordenadas[1].to_i-1]="*"
	end
	puts "::::::::::::::::::::::::::::::::::::::::::::::::"
	puts ""
	if respuesta.to_i==1
		puts "Bacteria(*) senbrada en una habitación."	
	else	
		puts "Bacterias(*) senbradas en #{respuesta} habitaciones."
	end	
	puts ""
	puts showMatriz(matriz)		
	estadistica(0,respuesta,0)
	

else
	puts ""
	puts "::::  Iniciando proceso de infección de forma automática  ::::"
	formato=/(\d{1})/
	begin
		puts ""
		print "Cuantos cuartos desea infectar de forma aleatoria: "
		respuesta= gets.chomp
		valFormato=formato.match(respuesta)

	end while !valFormato
	matriz1=senbrarBacteriaAutomaticamente(matriz,respuesta)
	puts ""
	puts showMatriz(matriz1)		
	estadistica(0,respuesta,0)
	
end	
