package proyecto;

import java.util.ArrayList;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class ProyectoEvaluator implements Evaluator<ArrayList<Integer>>
{
	public Objectives evaluate (ArrayList<Integer> phenotype)
	{
		int Coste = 0;
		int Prod = 0;
		for (int i = 0; i < phenotype.size(); i++)
		{
			Coste += Data.matrizCostes[phenotype.get(i) - 1][i];
			Prod  += Data.matrizProductividad[phenotype.get(i) - 1][i];
		}
		Objectives objectives = new Objectives();
		objectives.add("Valor Coste-MIN", Sign.MIN, Coste);
		objectives.add("Valor de Prod-MAX", Sign.MAX, Prod);
		return objectives;
	}
}
