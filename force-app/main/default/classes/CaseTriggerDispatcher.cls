public without sharing virtual class CaseTriggerDispatcher extends TriggerDispatcherBase
{
    //Atributos
    private static Boolean isBeforeInsertProcessing = false;
    private static Boolean isBeforeUpdateProcessing = false;
	private static Boolean isAfterUpdateProcessing = false;

    public override void bulkBefore() {}

    public virtual override void beforeInsert(TriggerParameters tp) 
    {
		if(!isBeforeInsertProcessing) 
        {
			isBeforeInsertProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('CasoTriggerBeforeInsertHandler'), tp, TriggerParameters.TriggerEvent.beforeInsert);
			isBeforeInsertProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.beforeInsert);
	}

	public virtual override void beforeUpdate(TriggerParameters tp) 
    {
		if(!isBeforeUpdateProcessing) 
        {
			isBeforeUpdateProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('CasoTriggerBeforeUpdateHandler'), tp, TriggerParameters.TriggerEvent.beforeUpdate);
			isBeforeUpdateProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.beforeUpdate);
	}

    public virtual override void afterUpdate(TriggerParameters tp) 
    {
		if(!isAfterUpdateProcessing) 
        {
			isAfterUpdateProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('CasoTriggerAfterUpdateHandler'), tp, TriggerParameters.TriggerEvent.afterUpdate);
			isAfterUpdateProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.afterUpdate);
	}

    public override void andFinally() {}
}