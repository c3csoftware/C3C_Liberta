public interface IRespostaSelector 
{
    List<SObject> obterRespostasPorListaIdPergunta(Set<String> idsPergunta); //Responsável por buscar uma lista de respostas por ids da pergunta
}