public interface IPerguntaSelector 
{
    List<SObject> obterPerguntasPorTipoTarefa(String tipoTarefa); //Responsável por buscar uma lista de perguntas por tipo de tarefa
    List<SObject> buscarPerguntasComListaIds(Set<String> listaIdPerguntas); //Responsável por buscas uma lista de perguntas com lista de ids informada
}