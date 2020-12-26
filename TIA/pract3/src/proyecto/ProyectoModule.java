package proyecto;

import org.opt4j.core.problem.ProblemModule;

public class ProyectoModule extends ProblemModule 
{

	@Override
	protected void config() 
	{
		// mostrará errores mientras ProyectoCreator, ProyectoDecoder y ProyectoEvaluator no estén completos
		bindProblem(ProyectoCreator.class, ProyectoDecoder.class, ProyectoEvaluator.class);
	}

}
//Generations  -> Numero de generaciones a realizar
//Alpha        -> Numero de individuos de la poblacion inicial
//Mu           -> Numero de padres que se seleccionaran en cada iteracion
//Lambda       -> Numero de hijos que se generaran en cada iteracion
//CrossoverRate-> Probabilidad de que dos padres se crucen