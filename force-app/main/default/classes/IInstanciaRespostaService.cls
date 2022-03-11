public interface IInstanciaRespostaService 
{
    List<IInstanciaRespostaDomain> obterInstanciaRespostaPorIdTarefa(String idTarefa);
    List<IInstanciaRespostaDomain> criarOuAtualizarListaDeInstanciaResposta(List<IInstanciaRespostaDomain> listaDeInstanciaResposta);
    void deleteListaDeInstanciaResposta(List<IInstanciaRespostaDomain> listaDeInstanciaResposta);
    Boolean verificarPopAssessorRespondido(String idLead);
}