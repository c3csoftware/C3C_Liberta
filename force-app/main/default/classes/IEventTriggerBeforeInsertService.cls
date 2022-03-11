public interface IEventTriggerBeforeInsertService 
{
    void atualizarCamposDeEvento(List<IEventDomain> listaEventos); //Responsável por obter uma lista de eventos e atualizar os campos
}