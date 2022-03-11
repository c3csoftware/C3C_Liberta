public without sharing class InstanciaRespostaTriggerDispatcher extends TriggerDispatcherBase 
{
    // Atributos
    private static Boolean isAfterInsertProcessing = false; 
    private static Boolean isAfterUpdateProcessing = false; 
    private static Boolean isBeforeInsertProcessing = false; 
    private static Boolean isBeforeUpdateProcessing = false; 
    
    public override void bulkBefore() {}

    public virtual override void beforeInsert(TriggerParameters tp)
    {
        if(!isBeforeInsertProcessing)
        {
            isBeforeInsertProcessing = true;
            execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('InstancRespTriggerBefInsertHandler'), tp, TriggerParameters.TriggerEvent.beforeInsert);
            isBeforeInsertProcessing = false;
        }
        else execute(null, tp, TriggerParameters.TriggerEvent.beforeInsert);
    }

    public virtual override void afterInsert(TriggerParameters tp)
    {
        if(!isAfterInsertProcessing)
        {
            isAfterInsertProcessing = true;
            execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('InstancRespTriggerAfterInsertHandler'), tp, TriggerParameters.TriggerEvent.afterInsert);
            isAfterInsertProcessing = false;
        }
        else execute(null, tp, TriggerParameters.TriggerEvent.afterInsert);
    }

    public virtual override void beforeUpdate(TriggerParameters tp)
    {
        if(!isBeforeUpdateProcessing)
        {
            isBeforeUpdateProcessing = true;
            execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('InstancRespTriggerBefUpdateHandler'), tp, TriggerParameters.TriggerEvent.beforeUpdate);
            isBeforeUpdateProcessing = false;
        }
        else execute(null, tp, TriggerParameters.TriggerEvent.beforeUpdate);
    }

    public virtual override void afterUpdate(TriggerParameters tp)
    {
        if(!isAfterUpdateProcessing)
        {
            isAfterUpdateProcessing = true;
            execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('InstancRespTriggerAfterUpdateHandler'), tp, TriggerParameters.TriggerEvent.afterUpdate);
            isAfterUpdateProcessing = false;
        }
        else execute(null, tp, TriggerParameters.TriggerEvent.afterUpdate);
    }


    public override void andFinally() {}
}