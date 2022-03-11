public interface IInstanciaRespTriggerAfterUpdateService 
{
    void mudarStatusTarefaParaCompletado(List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain);
    void mudarStatusLeadParaPrimeiroContato(List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain);
}