package proyecto;

import java.util.ArrayList;

import org.opt4j.core.genotype.IntegerGenotype;
import org.opt4j.core.problem.Decoder;

public class ProyectoDecoder implements Decoder<IntegerGenotype, ArrayList<Integer>>
{
	public ArrayList<Integer> decode(IntegerGenotype genotype)
	{
		int num1 = 0;
		int num2 = 0;
		int num3 = 0;
		boolean cambiado = false;
		ArrayList<Integer> phenotype = new ArrayList<Integer>();
		
		for(int i = 0; i < genotype.size(); i++)
		{
			switch(genotype.get(i))
			{
			case 1: ++num1; break;
			case 2: ++num2; break;
			case 3: ++num3; break;
			}
			phenotype.add(genotype.get(i));
		}
		
		while(num1 < 3 || num2 < 3 || num3 < 3)
		{

			for ( int j = 0; j < phenotype.size(); j++)
			{
				switch(phenotype.get(j))
				{
				
				case 1:
					if(num1 > 3)
					{
						if(num2 < 3) {phenotype.set(j, 2); num2++; cambiado = true;}
						else {phenotype.set(j, 3); num3++; cambiado = true;}
						num1--;
					}break;
				case 2:
					if(num2 > 3)
					{
						if(num1 < 3) {phenotype.set(j, 1); num1++; cambiado = true;}
						else {phenotype.set(j, 3); num3++; cambiado = true;}
						num2--;
					}break;
				case 3:
					if(num3 > 3)
					{
						if(num1 < 3) {phenotype.set(j, 1); num1++; cambiado = true;}
						else {phenotype.set(j, 2); num2++; cambiado = true;}
						num3--;
					}break;
				}
				if(cambiado) {cambiado = false; break;}
			}
		}
		
		return phenotype;
	}
}
