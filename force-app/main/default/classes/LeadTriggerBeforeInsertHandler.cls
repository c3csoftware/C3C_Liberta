public with sharing class LeadTriggerBeforeInsertHandler extends TriggerHandlerBase
{
    public class LeadTriggerBeforeInsertHandlerException extends Exception{}

    //Construtores
    public LeadTriggerBeforeInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<ILeadDomain> listaLeadDomain = (List<ILeadDomain>) C3C_DIContainer_Injector.newInstance('LeadDomain',(List<SObject>) tp.newList);
        
        this.leadTriggerBeforeInsertServiceInstance.modificarProprietarioLeadSemDono(listaLeadDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private ILeadTriggerBeforeInsertService leadTriggerBeforeInsertServiceInstance
    {
        get
        {
            if(this.leadTriggerBeforeInsertServiceInstance == null)
                this.leadTriggerBeforeInsertServiceInstance = (ILeadTriggerBeforeInsertService) C3C_DIContainer_Injector.getInstance('LeadTriggerBeforeInsertService');

            return this.leadTriggerBeforeInsertServiceInstance;
        }
        set;
    }
}