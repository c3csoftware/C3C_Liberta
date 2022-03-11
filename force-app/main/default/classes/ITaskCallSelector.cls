public interface ITaskCallSelector 
{
    List<SObject> buscarTarefasChamadasComIdProprietario(String idProprietario); //Responsável por buscar as tarefas do tipo "Chamada" com id do proprietário
}