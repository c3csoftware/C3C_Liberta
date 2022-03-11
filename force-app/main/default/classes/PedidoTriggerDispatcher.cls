public without sharing virtual class PedidoTriggerDispatcher extends TriggerDispatcherBase
{
    //Atributos
    private static Boolean isBeforeInsertProcessing = false;
    private static Boolean isAfterInsertProcessing = false;

    public override void bulkAfter() {}

	public virtual override void beforeInsert(TriggerParameters tp) 
    {
		if(!isBeforeInsertProcessing) 
        {
			isBeforeInsertProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('PedidoTriggerBeforeInsertHandler'), tp, TriggerParameters.TriggerEvent.beforeInsert);
			isBeforeInsertProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.beforeInsert);
	}
	
    public virtual override void afterInsert(TriggerParameters tp) 
    {
		if(!isAfterInsertProcessing) 
        {
			isAfterInsertProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('PedidoTriggerAfterInsertHandler'), tp, TriggerParameters.TriggerEvent.afterInsert);
			isAfterInsertProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.afterInsert);
	}
    
    public override void andFinally() {}
}