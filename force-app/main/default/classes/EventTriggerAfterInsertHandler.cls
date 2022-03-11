public without sharing class EventTriggerAfterInsertHandler extends TriggerHandlerBase 
{
    public class EventTriggerAfterInsertHandlerException extends Exception{}

    // Construtores
    public EventTriggerAfterInsertHandler() {}

    // Métodos
    public override void mainEntry(TriggerParameters tp)
    {
        System.debug('Tp.newList: '+ tp.newList);

        List<IEventDomain> listaEventDomain = (List<IEventDomain>) C3C_DIContainer_Injector.newInstance('EventDomain',(List<SObject>) tp.newList);

        this.eventTriggerAfterInsertServiceInstance.mudarStatusLeadParaEmAndamento(listaEventDomain);
        this.instanciaEventTriggerBeforeInsertService.atualizarCamposDeEvento(listaEventDomain);       
    }

    public override void inProgressEntry(TriggerParameters tp) {}

    public override void updateObjects() {}

    // Atributos de serviço

    private IEventTriggerAfterInsertService eventTriggerAfterInsertServiceInstance
    {
        get
        {
            if(this.eventTriggerAfterInsertServiceInstance == null)
                this.eventTriggerAfterInsertServiceInstance = (IEventTriggerAfterInsertService) C3C_DIContainer_Injector.getInstance('EventTriggerAfterInsertService');

            return this.eventTriggerAfterInsertServiceInstance;
        }
        set;
    }

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