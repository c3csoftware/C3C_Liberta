public without sharing class CadAcessoCallboxTriggerDispatcher extends TriggerDispatcherBase
{
    //Atributos para monitorar as execuções da trigger
    private static Boolean isAfterInsertProcessing = false;

    //
    //Atributos
    //

    //Resposável por executar a Handler no evento "after insert"
    public virtual override void afterInsert(TriggerParameters tp) 
    {
        System.debug('Chegou aq');
		if(!isAfterInsertProcessing) 
        {
			isAfterInsertProcessing = true;
			execute((TriggerHandlerBase) C3C_DIContainer_Injector.newInstance('CadAcessoCallboxTriggerHandler'), tp, TriggerParameters.TriggerEvent.afterInsert);
			isAfterInsertProcessing = false;
		}
		else execute(null, tp, TriggerParameters.TriggerEvent.afterInsert);
	}
}