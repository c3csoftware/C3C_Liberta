public without sharing virtual class CasoTriggerBeforeUpdateHandler extends TriggerHandlerBase
{
    public class CasoTriggerBeforeUpdateHandlerException extends Exception{}

    //Construtores
    public CasoTriggerBeforeUpdateHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<CasoDomain> listaCasoDomain = (List<CasoDomain>) DomainFactory.buildListDomainWithListSObject('CasoDomain',(List<SObject>) tp.newList);

        this.instanciaCasoTriggerBeforeUpdateService.interarVezesQueCasoFoiReaberto(listaCasoDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private ICasoTriggerBeforeUpdateService instanciaCasoTriggerBeforeUpdateService
    {
        get
        {
            if(this.instanciaCasoTriggerBeforeUpdateService == null)
                this.instanciaCasoTriggerBeforeUpdateService = (ICasoTriggerBeforeUpdateService) C3C_DIContainer_Injector.getInstance('CasoTriggerBeforeUpdateService');

            return this.instanciaCasoTriggerBeforeUpdateService;
        }
        set;
    }
}