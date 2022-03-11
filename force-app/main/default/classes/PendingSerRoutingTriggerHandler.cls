public without sharing class PendingSerRoutingTriggerHandler extends TriggerHandlerBase
{
    public class PendingSerRoutingTriggerHandlerException extends Exception{}

    //
    //Construtores
    //

    public PendingSerRoutingTriggerHandler() {}

    //
    //Métodos
    //

    public override void mainEntry(TriggerParameters tp) 
    {
        System.debug('CAIU AQ HEIN BORA LÁ');
        List<PendingServiceRoutingDomain> listaRoteamentosPendentes = new List<PendingServiceRoutingDomain>();

        for(SObject roteamentoPendente : tp.oldList)
            listaRoteamentosPendentes.add((PendingServiceRoutingDomain) C3C_DIContainer_Injector.newInstance('PendingServiceRoutingDomain', roteamentoPendente));

        //this.instancePendingServiceRoutingService.regraAtribuicaoProprietarioRegistroListaLead(listaRoteamentosPendentes);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //
    //Atributos
    //

    private IPendingServiceRoutingService instancePendingServiceRoutingService
    {
        get
        {
            if(this.instancePendingServiceRoutingService == null)
                this.instancePendingServiceRoutingService = (IPendingServiceRoutingService) C3C_DIContainer_Injector.getInstance('PendingServiceRoutingService');

            return this.instancePendingServiceRoutingService;
        }
        set;
    }
}