public interface IEventTriggerAfterInsertService 
{
    void mudarStatusLeadParaEmAndamento(List<IEventDomain> listaEventDomain);
}