global without sharing class AgendamentoTarefaNpsBatch implements Database.Batchable<SObject> 
{
    
    global List<SObject> start(Database.BatchableContext BC)
    {
        // Datetime d = Datetime.now().addHours(-1);
        return instanciaAccountSelector.buscarContasComPesquisaParaHoje();
    }
    
    global void execute(Database.BatchableContext BC, List<SObject> scope)
    {
        try
        {
            
        }
        catch(Exception e)
        {
            System.debug('e: ' + e.getMessage());
            System.abortJob(bc.getJobId());
        }
    }

    global void finish(Database.BatchableContext BC){}

    public IAccountSelector instanciaAccountSelector 
    {
        get
        {
            if(this.instanciaAccountSelector == null)
                this.instanciaAccountSelector = (IAccountSelector) C3C_DIContainer_Injector.getInstance('AccountSelector');
            
            return this.instanciaAccountSelector;
        }
        set;
    }
   
}
