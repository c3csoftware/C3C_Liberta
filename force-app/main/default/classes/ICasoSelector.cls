public interface ICasoSelector 
{
    List<SObject> buscarCasosDeOrigemAssessor(String origem); //Responsável por retornar os casos com origem assessor
    List<SObject> obterCasoComStatusResolvidoPorIdsDoCaso(List<String> idsCaso); //Responsável por obter casos com status Resolvido;
}