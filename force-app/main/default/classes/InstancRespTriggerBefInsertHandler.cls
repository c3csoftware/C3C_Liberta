public with sharing class InstancRespTriggerBefInsertHandler extends TriggerHandlerBase
{
    //
    //Construtores
    //

    public InstancRespTriggerBefInsertHandler() {}

    //
    //Métodos
    //

    public override void mainEntry(TriggerParameters tp) 
    {
        List<InstanciaRespostaDomain> listaNovasInstanciaResposta = (List<InstanciaRespostaDomain>) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain',(List<SObject>) tp.newList);

        instanciaRelacionamentoChecklistService.relacionarRespostaChecklistComRelacionamentoTarefa(listaNovasInstanciaResposta);
    }

    //
    //Atributos - Services
    //

    private IRelacionamentoChecklistService instanciaRelacionamentoChecklistService
    {
        get
        {
            if(this.instanciaRelacionamentoChecklistService == null)
                this.instanciaRelacionamentoChecklistService = (IRelacionamentoChecklistService) C3C_DIContainer_Injector.getInstance('RelacionamentoChecklistService');

            return this.instanciaRelacionamentoChecklistService;
        }
        set;
    }
}