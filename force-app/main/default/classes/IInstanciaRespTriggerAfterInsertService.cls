public interface IInstanciaRespTriggerAfterInsertService 
{
    void mudarStatusTarefaParaCompletado(List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain);
    void mudarStatusLeadParaPrimeiroContato(List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain);
    void mudarStatusCasoParaEncerrado(List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain);
}