public without sharing class PendingServiceRoutingTriggerDispatcher extends TriggerDispatcherBase
{
    //
    //Atributos
    //

    private static Boolean iAfterDeleteProcessing = false;

    public override void bulkAfter() {}
	
    public virtual override void afterUpdate(TriggerParameters tp) 
    {
		if(!iAfterDeleteProcessing) 
        {
			iAfterDeleteProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('PendingSerRoutingTriggerHandler'), tp, TriggerParameters.TriggerEvent.afterDelete);
			iAfterDeleteProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.afterDelete);
	}
    
    public override void andFinally() {}
    
}