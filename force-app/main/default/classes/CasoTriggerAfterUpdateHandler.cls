public without sharing virtual class CasoTriggerAfterUpdateHandler extends TriggerHandlerBase
{
    // Exceptions
    public class CasoTriggerAfterUpdateHandlerException extends Exception{}

    //Construtores
    public CasoTriggerAfterUpdateHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<CasoDomain> listaCasoDomain = (List<CasoDomain>) DomainFactory.buildListDomainWithListSObject('CasoDomain',(List<SObject>) tp.newList);
        
        this.instanciaCasoTriggerAfterUpdateService.dispararTarefaNpsParaAssessor(listaCasoDomain);     
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private ICasoTriggerAfterUpdateService instanciaCasoTriggerAfterUpdateService
    {
        get
        {
            if(this.instanciaCasoTriggerAfterUpdateService == null)
                this.instanciaCasoTriggerAfterUpdateService = (ICasoTriggerAfterUpdateService) C3C_DIContainer_Injector.getInstance('CasoTriggerAfterUpdateService');

            return this.instanciaCasoTriggerAfterUpdateService;
        }
        set;
    }
}