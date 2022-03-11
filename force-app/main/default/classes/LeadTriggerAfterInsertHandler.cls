public with sharing virtual class LeadTriggerAfterInsertHandler extends TriggerHandlerBase
{
    public class LeadTriggerAfterInsertHandlerException extends Exception{}

    //Construtores
    public LeadTriggerAfterInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<ILeadDomain> listaLeadDomain = (List<ILeadDomain>) C3C_DIContainer_Injector.newInstance('LeadDomain',(List<SObject>) tp.newList);
        
        this.instanciaLeadAssessorService.criarTarefaConversaoLeadQuandoCriadoPerfilAssessorLiberta(listaLeadDomain);
        //this.instanciaConvertorLeadParaConta.converterLeadCasoPossuaContaNaBase(listaLeadDomain);
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

    private ILeadAssessorService instanciaLeadAssessorService
    {
        get
        {
            if(this.instanciaLeadAssessorService == null)
                this.instanciaLeadAssessorService = (ILeadAssessorService) C3C_DIContainer_Injector.getInstance('LeadAssessorService');

            return this.instanciaLeadAssessorService;
        }
        set;
    }
}