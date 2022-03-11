public without sharing class EventTriggerDispatcher extends TriggerDispatcherBase 
{
    // Atributos
    private static Boolean isBeforeInsertProcessing = false; 
    
    public override void bulkBefore() {}

    public virtual override void beforeInsert(TriggerParameters tp)
    {
        if(!isBeforeInsertProcessing)
        {
            isBeforeInsertProcessing = true;
            execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('EventTriggerAfterInsertHandler'), tp, TriggerParameters.TriggerEvent.beforeInsert);
            isBeforeInsertProcessing = false;
        }
        else execute(null, tp, TriggerParameters.TriggerEvent.beforeInsert);
    }

    public override void andFinally() {}
}