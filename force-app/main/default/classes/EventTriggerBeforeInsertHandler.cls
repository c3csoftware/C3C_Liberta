public with sharing class EventTriggerBeforeInsertHandler extends TriggerHandlerBase
{
    public class EventTriggerBeforeInsertHandlerException extends Exception{}

    //Construtores
    public EventTriggerBeforeInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<IEventDomain> listaEventDomain = (List<IEventDomain>) C3C_DIContainer_Injector.newInstance('EventDomain',(List<SObject>) tp.newList);
        
        //this.instanciaEventTriggerBeforeInsertService.modificarProprietarioEventSemDono(listaEventDomain);
        this.instanciaEventTriggerBeforeInsertService.atualizarCamposDeEvento(listaEventDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private IEventTriggerBeforeInsertService instanciaEventTriggerBeforeInsertService
    {
        get
        {
            if(this.instanciaEventTriggerBeforeInsertService == null)
                this.instanciaEventTriggerBeforeInsertService = (IEventTriggerBeforeInsertService) C3C_DIContainer_Injector.getInstance('EventTriggerBeforeInsertService');

            return this.instanciaEventTriggerBeforeInsertService;
        }
        set;
    }
}