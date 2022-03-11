public with sharing virtual class CasoTriggerBeforeInsertHandler extends TriggerHandlerBase
{
    // Exceptions
    public class CasoTriggerBeforeInsertHandlerException extends Exception{}

    //Construtores
    public CasoTriggerBeforeInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<CasoDomain> listaCasoDomain = (List<CasoDomain>) DomainFactory.buildListDomainWithListSObject('CasoDomain',(List<SObject>) tp.newList);
        
        this.instanciaCasoTriggerBeforeInsertService.atualizarCampoAssessor(listaCasoDomain);

        this.instanciaManipuladorCasoPorFilaService.orquestrarFilaParaDefinirProprietarioCaso(listaCasoDomain);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private ICasoTriggerBeforeInsertService instanciaCasoTriggerBeforeInsertService
    {
        get
        {
            if(this.instanciaCasoTriggerBeforeInsertService == null)
                this.instanciaCasoTriggerBeforeInsertService = (ICasoTriggerBeforeInsertService) C3C_DIContainer_Injector.getInstance('CasoTriggerBeforeInsertService');

            return this.instanciaCasoTriggerBeforeInsertService;
        }
        set;
    }

    private IManipuladorCasoPorFilaService instanciaManipuladorCasoPorFilaService
    {
        get
        {
            if (this.instanciaManipuladorCasoPorFilaService == null)
                this.instanciaManipuladorCasoPorFilaService = (IManipuladorCasoPorFilaService) C3C_DIContainer_Injector.getInstance('ManipuladorCasoPorFilaService');
            
            return this.instanciaManipuladorCasoPorFilaService;
        }
        set;
    }
}