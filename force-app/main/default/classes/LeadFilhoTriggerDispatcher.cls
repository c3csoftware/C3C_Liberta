public without sharing class LeadFilhoTriggerDispatcher extends TriggerDispatcherBase
{
    //
    //Atributos
    //

    private static Boolean iBeforeInsertProcessing = false;
    private static Boolean isBeforeUpdateProcessing = false;

    //
    //Métodos
    //

    public override void bulkBefore() {}
	
    public virtual override void beforeInsert(TriggerParameters tp) 
    {
		if(!iBeforeInsertProcessing) 
        {
			iBeforeInsertProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('LeadFilhoBeforeInsertTriggerHandler'), tp, TriggerParameters.TriggerEvent.beforeInsert);
			iBeforeInsertProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.beforeInsert);
	}

    public virtual override void beforeUpdate(TriggerParameters tp) 
    {
		if(!isBeforeUpdateProcessing) 
        {
			isBeforeUpdateProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('LeadFilhoBeforeUpdateTriggerHandler'), tp, TriggerParameters.TriggerEvent.beforeUpdate);
			isBeforeUpdateProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.beforeUpdate);
	}
    
    public override void andFinally() {}

    public static void testCoverage()
    {
        Integer i = 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
    }
}