
(define (problem ProblemaAResolver)
  (:domain MantCarretera)
  (:objects
				Cuad1 - Cuadrilla
				Cuad2 - Cuadrilla
				Cuad3 - Cuadrilla
				Cuad4 - Cuadrilla

				CistAsf1 - CistAsfaltado
				CistAsf2 - CistAsfaltado

				Pav1 - Pavimentadora
				Pav2 - Pavimentadora

				Compact - Compactadora

				T1 - Tramo
				T2 - Tramo
				T3 - Tramo
				T4 - Tramo
				T5 - Tramo

  )
  (:init

    ; ############# Posiciones y atributos cuadrillas  ####################

		(CuadrillaEn Cuad1 T1)
		(CuadrillaEn Cuad2 T1)
		(CuadrillaEn Cuad3 T5)
		(CuadrillaEn Cuad4 T5)
		(DispCuadrilla Cuad1)
		(DispCuadrilla Cuad2)
		(DispCuadrilla Cuad3)
		(DispCuadrilla Cuad4)
		
		; ############# Posiciones y atributos Cisterna asfaltado #############

		(CistAsfaltadoEn CistAsf1 T1)
		(CistAsfaltadoEn CistAsf2 T1)
		(DispCistAsfaltado CistAsf1)
		(DispCistAsfaltado CistAsf2)
		
		; ############# Posiciones y atributos Pavimentadoras #################

		(PavimentadoraEn Pav1 T2)
		(PavimentadoraEn Pav2 T2)
		(DispPavimentadora Pav1)
		(DispPavimentadora Pav2)

		; ############# Posiciones y atributos Compactadoras ##################

		(CompactadoraEn Compact T5)
		(DispCompactadora Compact)

		; ############# Grafo entre tramos y disponibilidades de tramos #######

		(Disponible T1)
		(Disponible T2)
		(Disponible T3)
		(Disponible T4)
		(Disponible T5)
		(TrConectados T1 T2)
		(TrConectados T2 T1)
		(TrConectados T2 T4)
		(TrConectados T4 T2)
		(TrConectados T2 T3)
		(TrConectados T3 T2)
		(TrConectados T3 T5)
		(TrConectados T5 T3)
		(TrConectados T4 T5)
		(TrConectados T5 T4)

		;############# Necesidades y estados de los Tramos ####################

		(TrNecesitaCompactado T1)
		(TrNecesitaCompactado T2)
		(TrCompactado T3)
		(TrCompactado T4)
		(TrCompactado T5)

		(TrNecesitaPavimentado T1)
		(TrNecesitaPavimentado T2)
		(TrNecesitaPavimentado T3)
		(TrNecesitaPavimentado T4)
		(TrNecesitaPavimentado T5)

		(TrNecesitaAplastado T1)
		(TrNecesitaAplastado T2)
		(TrNecesitaAplastado T3)
		(TrNecesitaAplastado T4)
		(TrNecesitaAplastado T5)

		(TrNecesitaVallado T1)
		(TrNecesitaVallado T2)
		(TrNecesitaVallado T3)
		(TrNecesitaVallado T4)
		(TrNecesitaVallado T5)

		(TrNecesitaPintado T1)
		(TrNecesitaPintado T2)
		(TrNecesitaPintado T3)
		(TrNecesitaPintado T4)
		(TrNecesitaPintado T5)

		(TrNecesSenYIlum T3)
		(TrNecesSenYIlum T4)
		(TrNecesSenYIlum T5)

		; ################# Costes de desplazamiento entre tramos y uso de maq ############

		(= (distance T1 T2) 5)
		(= (distance T2 T1) 5)
		(= (distance T2 T4) 4)
		(= (distance T4 T2) 4)
		(= (distance T2 T3) 6)
		(= (distance T3 T2) 6)
		(= (distance T3 T5) 7)
		(= (distance T5 T3) 7)
		(= (distance T4 T5) 6)
		(= (distance T5 T4) 6)
		(= (CosteCisterna) 25)
		(= (CostePavimentar) 30)
		(= (CosteCompactar) 35)
		(= (CosteTotal ) 0)


  )
  (:goal 
	
	; ################### Estado Tramos objetivo ######################################
	
		(and
					(TrCompactado T1)
					(TrCompactado T2)
					(TrCompactado T3)
					(TrCompactado T4)
					(TrCompactado T5)

					(TrPavimentado T1)
					(TrPavimentado T2)
					(TrPavimentado T3)
					(TrPavimentado T4)
					(TrPavimentado T5)

					(TrAplastado T1)
					(TrAplastado T2)
					(TrAplastado T3)
					(TrAplastado T4)
					(TrAplastado T5)

					(TrPintado T1)
					(TrPintado T2)
					(TrPintado T3)
					(TrPintado T4)
					(TrPintado T5)

					(TrVallado T1)
					(TrVallado T2)
					(TrVallado T3)
					(TrVallado T4)
					(TrVallado T5)

					(TrSenalizYIlum T3)
					(TrSenalizYIlum T4)
					(TrSenalizYIlum T5)

; ############### Posicion objetivo de Cuadrillas y maquinaria ##############

					(CuadrillaEn Cuad1 T1)
					(CuadrillaEn Cuad2 T5)
					(CuadrillaEn Cuad4 T5)

					(CistAsfaltadoEn CistAsf1 T1)
					(CistAsfaltadoEn CistAsf2 T3)

					(CompactadoraEn Compact T5)

  ))


(:metric minimize (+ (* 0.2 (total-time))  (* 0.5 (CosteTotal))))

)

