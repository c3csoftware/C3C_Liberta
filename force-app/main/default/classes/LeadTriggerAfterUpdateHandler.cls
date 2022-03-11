public without sharing class LeadTriggerAfterUpdateHandler extends TriggerHandlerBase
{
    public class LeadTriggerAfterUpdateHandlerException extends Exception{}

    //Construtores
    public LeadTriggerAfterUpdateHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<ILeadDomain> listaLeadDomain = (List<ILeadDomain>) C3C_DIContainer_Injector.newInstance('LeadDomain',(List<SObject>) tp.newList);
        
        //this.leadTriggerAfterUpdateServiceInstance.passarDadosLeadParaConta(listaLeadDomain);
        this.instanciaConvertorLeadParaConta.converterLeadCasoPossuaContaNaBase(listaLeadDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private IConvertorLeadParaConta instanciaConvertorLeadParaConta
    {
        get
        {
            if(this.instanciaConvertorLeadParaConta == null)
                this.instanciaConvertorLeadParaConta = (IConvertorLeadParaConta) C3C_DIContainer_Injector.getInstance('ConvertorLeadParaConta');

            return this.instanciaConvertorLeadParaConta;
        }
        set;
    }

    private ILeadTriggerAfterUpdateService leadTriggerAfterUpdateServiceInstance
    {
        get
        {
            if(this.leadTriggerAfterUpdateServiceInstance == null)
                this.leadTriggerAfterUpdateServiceInstance = (ILeadTriggerAfterUpdateService) C3C_DIContainer_Injector.getInstance('LeadTriggerAfterUpdateService');

            return this.leadTriggerAfterUpdateServiceInstance;
        }
        set;
    }
}