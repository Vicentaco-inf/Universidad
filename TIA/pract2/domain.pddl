;Problema Pract 2 Vicente Gras Mas
(define (domain MantCarretera)

; ####################  REQUIERIMIENTOS  #######################

(:requirements :strips :typing :durative-actions :fluents)

  ;CistAsfaltado es la cisterna de asfaltado 
  ;Compactadora es la compactadora de aplastado de asfalto

; ####################  TIPOS  #################################

(:types CistAsfaltado Compactadora Pavimentadora Tramo Cuadrilla)

; ####################  PREDICADOS  ############################

(:predicates

; #######  Posiciones de la maquinaria  ########################
; #######  y el personal y su disponibilidad  ##################

(CuadrillaEn ?c - Cuadrilla ?x - Tramo)
(DispCuadrilla ?c - Cuadrilla)

(CistAsfaltadoEn ?ca - CistAsfaltado ?x - Tramo)
(DispCistAsfaltado ?ca - CistAsfaltado)

(PavimentadoraEn ?p - Pavimentadora ?x - Tramo)
(DispPavimentadora ?p - Pavimentadora)

(CompactadoraEn ?co - Compactadora ?x - Tramo)
(DispCompactadora ?co - Compactadora)

; ######  hechos y necesidades de los tramos ##################

(TrCompactado ?t - Tramo)                ;Acciones asociadas a Compactar
(TrNecesitaCompactado ?t - Tramo)

(TrPavimentado ?t - Tramo)               ;Acciones asociadas a Pavimentar
(TrNecesitaPavimentado ?t - Tramo)

(TrAplastado ?t - Tramo)                 ;Acciones asociadas a Aplastar
(TrNecesitaAplastado ?t - Tramo)

(TrPintado ?t - Tramo)                   ;Acciones asociadas a Pintar
(TrNecesitaPintado ?t - Tramo)

(TrVallado ?t - Tramo)                   ;Acciones asociadas a Vallado
(TrNecesitaVallado ?t - Tramo)

(TrSenalizYIlum ?t - Tramo)              ;Acciones asociadas a Iluminacion
(TrNecesSenYIlum ?t - Tramo)             ;y señalizado

;######  Disponibilidad del tramo y conexion del grafo  ########

(Disponible ?t - Tramo)                 ;Tramo t esta disponible para usar
(TrConectados ?tx - Tramo ?ty - Tramo)  ;2 tramos estan conectados

)
(:functions

; ########  Funcion distancia entre tramos

(distance ?tx - Tramo ?ty - Tramo)

; ########  Costes de las acciones y coste total  ##############

(CosteCisterna)
(CostePavimentar)
(CosteCompactar)
(CosteTotal)

)

; ########  Acciones de transporte de cuadrillas y maquinaria  ######
; ################  entre tramos  ###################################

(:durative-action TransportarCuadrilla
    :parameters (?c - Cuadrilla ?tx ?ty - Tramo)
    :duration ( = ?duration (distance ?tx ?ty))
    :condition (and (at start(TrConectados ?tx ?ty))
                    (at start(CuadrillaEn ?c ?tx))
                    (at start(DispCuadrilla ?c))
                    (over all(Disponible ?tx))
                    (over all(Disponible ?ty))
               )
    :effect (and (at start (not (CuadrillaEn ?c ?tx)))
                 (at start(not (DispCuadrilla ?c)))
                 (at end(DispCuadrilla ?c))
                 (at end (CuadrillaEn ?c ?ty))
            )
)

(:durative-action TransportarCisterna
    :parameters (?ca - CistAsfaltado ?tx ?ty - Tramo)
    :duration ( = ?duration (*2 (distance ?tx ?ty)))
    :condition (and (at start(TrConectados ?tx ?ty))
                    (at start(CistAsfaltadoEn ?ca ?tx))
                    (at start(DispCistAsfaltado ?ca))
                    (over all(Disponible ?tx))
                    (over all(Disponible ?ty))
               )
    :effect (and (at start (not (CistAsfaltadoEn ?ca ?tx)))
                 (at start(not (DispCistAsfaltado ?ca)))
                 (at end(DispCistAsfaltado ?ca))
                 (at end (CistAsfaltadoEn ?ca ?ty))
            )
)

(:durative-action TransportarPavimentadora
    :parameters (?p - Pavimentadora ?tx ?ty - Tramo)
    :duration ( = ?duration (*2 (distance ?tx ?ty)))
    :condition (and (at start(TrConectados ?tx ?ty))
                    (at start(PavimentadoraEn ?p ?tx))
                    (at start(DispPavimentadora ?p))
                    (over all(Disponible ?tx))
                    (over all(Disponible ?ty))
               )
    :effect (and (at start (not (PavimentadoraEn ?p ?tx)))
                 (at start(not (DispPavimentadora ?p)))
                 (at end(DispPavimentadora ?p))
                 (at end (PavimentadoraEn ?p ?ty))
            )
)

(:durative-action TransportarCompactadora
    :parameters (?c - Compactadora ?tx ?ty - Tramo)
    :duration ( = ?duration (*2 (distance ?tx ?ty)))
    :condition (and (at start(TrConectados ?tx ?ty))
                    (at start(CompactadoraEn ?c ?tx))
                    (at start(DispCompactadora ?c))
                    (over all(Disponible ?tx))
                    (over all(Disponible ?ty))
               )
    :effect (and (at start (not (CompactadoraEn ?c ?tx)))
                 (at start(not (DispCompactadora ?c)))
                 (at end(DispCompactadora ?c))
                 (at end (CompactadoraEn ?c ?ty))
            )
)

; ######### Acciones de obras ###############################

(:durative-action Compactar
    :parameters(?t - Tramo)
    :duration ( = ?duration 250)
    :condition(and (at start(TrNecesitaCompactado ?t))
                   (at start(Disponible ?t))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start(not (TrNecesitaCompactado ?t)))
                 (at end(TrCompactado ?t))
                 (at end(Disponible ?t))
                 (at end(TrNecesitaPavimentado ?t))
            )
)

(:durative-action Pavimentar
    :parameters(?p - Pavimentadora ?ca - CistAsfaltado ?t - Tramo)
    :duration ( = ?duration 190)
    :condition(and (at start(TrNecesitaPavimentado ?t))
                   (at start(Disponible ?t))
                   (at start(TrCompactado ?t))
                   (over all(CistAsfaltadoEn ?ca ?t))
                   (at start(DispCistAsfaltado ?ca))
                   (over all(PavimentadoraEn ?p ?t))
                   (at start(DispPavimentadora ?p))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start (not (DispCistAsfaltado ?ca)))
                 (at start (not (DispPavimentadora ?p)))
                 (at end(not (TrNecesitaPavimentado ?t)))
                 (at end(TrPavimentado ?t))
                 (at end(Disponible ?t))
                 (at end(TrNecesitaAplastado ?t))
                 (at end (DispCistAsfaltado ?ca))
                 (at end (DispPavimentadora ?p))
                 (at end (increase (CosteTotal)(CosteCisterna)))
                 (at end (increase (CosteTotal)(CostePavimentar)))
            )
)

(:durative-action Aplastar
    :parameters(?c - Compactadora ?t - Tramo)
    :duration ( = ?duration 150)
    :condition(and (at start(TrNecesitaAplastado ?t))
                   (at start(Disponible ?t))
                   (at start(TrPavimentado ?t))
                   (over all(CompactadoraEn ?c ?t))
                   (at start(DispCompactadora ?c))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start (not (DispCompactadora ?c)))
                 (at end(not (TrNecesitaAplastado ?t)))
                 (at end(TrAplastado ?t))
                 (at end(Disponible ?t))
                 (at end(DispCompactadora ?c))
                 (at end (increase (CosteTotal)(CosteCompactar)))
            )
)

(:durative-action Pintar
    :parameters(?c - Cuadrilla ?t - Tramo)
    :duration ( = ?duration 30)
    :condition(and (at start(TrNecesitaPintado ?t))
                   (at start(Disponible ?t))
                   (at start(TrAplastado ?t))
                   (at start(DispCuadrilla ?c))
                   (over all(CuadrillaEn ?c ?t))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start (not (DispCuadrilla ?c)))
                 (at end(not (TrNecesitaPintado ?t)))
                 (at end(TrPintado ?t))
                 (at end(Disponible ?t))
                 (at end(DispCuadrilla ?c))
            )
)

(:durative-action Vallar
    :parameters(?c - Cuadrilla ?t - Tramo)
    :duration ( = ?duration 120)
    :condition(and (at start(TrNecesitaVallado ?t))
                   (at start(Disponible ?t))
                   (at start(TrAplastado ?t))
                   (at start(DispCuadrilla ?c))
                   (over all(CuadrillaEn ?c ?t))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start (not (DispCuadrilla ?c)))
                 (at end(not (TrNecesitaVallado ?t)))
                 (at end(TrVallado ?t))
                 (at end(Disponible ?t))
                 (at end(DispCuadrilla ?c))
            )
)

(:durative-action IluminarYSenalizar
    :parameters(?c - Cuadrilla ?t - Tramo)
    :duration ( = ?duration 70)
    :condition(and (at start(TrNecesSenYIlum ?t))
                   (at start(Disponible ?t))
                   (at start(TrAplastado ?t))
                   (at start(DispCuadrilla ?c))
                   (over all(CuadrillaEn ?c ?t))
              )
    :effect (and (at start (not (Disponible ?t)))
                 (at start (not (DispCuadrilla ?c)))
                 (at end(not (TrNecesSenYIlum ?t)))
                 (at end(TrSenalizYIlum ?t))
                 (at end(Disponible ?t))
                 (at end(DispCuadrilla ?c))
            )
)
)