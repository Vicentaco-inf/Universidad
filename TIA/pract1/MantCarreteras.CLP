(deftemplate agrietamiento 0 100
	((ligero (10 1) (20 0))
	(medio (5 0) (25 1) (45 1) (55 0))
	(fuerte (50 0) (60 1))))

(deftemplate temperatura -10 90
	((fria (5 1) (10 0))
	(moderada (-5 0) (15 1) (40 1) (50 0))
	(calida (35 0) (45 1))))

(deftemplate necesidadReasfaltado 0 100
	((baja (z 10 25))
	(media (pi 15 60))
	(urgente (s 55 90))))

(deftemplate densidad-trafico 0 300
	((baja (z 20 80))
	(alta (s 120 250))))

(deffunction fuzzify (?fztemplate ?value ?delta)

        (bind ?low (get-u-from ?fztemplate))
        (bind ?hi  (get-u-to   ?fztemplate))

        (if (<= ?value ?low)
          then
            (assert-string
              (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
          else
            (if (>= ?value ?hi)
              then
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0))"
                               ?fztemplate (- ?hi ?delta) ?hi))
              else
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
                               ?fztemplate (max ?low (- ?value ?delta))
                               ?value (min ?hi (+ ?value ?delta)) ))
            )
        )
  )
(deftemplate carretera
	(slot id	(type SYMBOL))	;id carretera
	(slot LvlAgr    (type INTEGER))	;Nivel agrietamiento
	(slot Tmin	(type INTEGER))	;Temperatura min
	(slot Tmax	(type INTEGER))	;Temperatura max
	(slot cxh	(type INTEGER)) ;Coches por hora
	(slot PriorAs	(type FLOAT)))	;Prioridad Asfaltado

(defrule leerconsola
	(initial-fact)
	=>
	(printout t "Introduzca el identificador de la carretera" crlf)
	(bind ?c (read))
	(printout t "Introducza nivel de agrietamiento (en porcentaje 0-100%)" crlf)
	(bind ?p (read))
	(printout t "introduzca temperatura minima del asfalto" crlf)
	(bind ?min (read))
	(printout t "introduzca temperatura maxima del asfalto" crlf)
	(bind ?max (read))
	(printout t "introduzca la antidad de coches hora que pasan por la carretera" crlf)
	(bind ?chs (read))
	(assert (carretera(id ?c)(LvlAgr ?p)(Tmin ?min)(Tmax ?max)(cxh ?chs)(PriorAs -1.0))))

(defrule fuzzificacionCarretera
	?carret <- (carretera(id ?c)(LvlAgr ?p)(Tmin ?min)(Tmax ?max)(cxh ?chs)(PriorAs -1.0))
	=>
	;(bind ?aux (+ ?max ?min))
	;(bind ?b (/ ?aux 2))
	;(bind ?d (- ?max ?b))
	;(assert (temperatura (pi ?d ?b)))
	(assert (temperatura (?min 0)(?min 1)(?min 0)))
	(assert (temperatura (?max 0)(?max 1)(?max 0)))
	(assert (densidad-trafico (?chs 0)(?chs 1)(?chs 0)))
	(assert (agrietamiento (?p 0)(?p 1)(?p 0))))

(defrule altoTrafico
	(declare (salience 10))
	?g <-(densidad-trafico alta)
	=>
	(assert (necesidadReasfaltado very urgente))
	(retract ?g))

(defrule BajoTrafico
	(declare (salience 10))
	?g <-(densidad-trafico baja)
	=>
	(assert (necesidadReasfaltado more-or-less baja))
	(retract ?g))

(defrule deffuzyReasfaltar
	?f <- (necesidadReasfaltado baja or more-or-less baja or very baja or media or somewhat media or urgente or very urgente or extremely urgente)
	?carret <- (carretera(id ?c)(LvlAgr ?p)(Tmin ?min)(Tmax ?max)(cxh ?chs))
	=>
	(bind ?e (maximum-defuzzify ?f))        
	(modify ?carret (PriorAs ?e))
	(printout t "La prioridad de asfaltado de la carretera " ?c crlf)
	(printout t "es " ?e crlf)
	(retract ?f))
	

(defrule baja
	(declare (salience 10))
	(agrietamiento medio)
	(temperatura moderada)
	=>
	(printout t "6" crlf)
	(assert (necesidadReasfaltado baja)))

(defrule some_media
	(declare (salience 10))
	(agrietamiento fuerte)
	(temperatura moderada)
	=>
	(printout t "1" crlf)
	(assert (necesidadReasfaltado somewhat media)))

(defrule media
	(declare (salience 10))
	(agrietamiento ligero)
	(temperatura fria or calida)
	=>
	(printout t "2" crlf)
	(assert (necesidadReasfaltado media)))

(defrule urgente
	(declare (salience 10))
	(agrietamiento medio)
	(temperatura fria)
	=>
	(printout t "3" crlf)
	(assert (necesidadReasfaltado urgente)))

(defrule very_urgente
	(declare (salience 10))
	(agrietamiento medio)
	(temperatura calida)
	=>
	(printout t "5" crlf)
	(assert (necesidadReasfaltado very urgente)))

(defrule extr_urgente
	(declare (salience 10))
	(agrietamiento fuerte)
	(temperatura fria or calida)
	=>
	(printout t "4" crlf)
	(assert (necesidadReasfaltado extremely urgente)))






	
	