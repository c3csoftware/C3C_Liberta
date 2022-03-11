public without sharing virtual class PedidoTriggerBeforeInsertHandler extends TriggerHandlerBase
{
    public class PedidoTriggerBeforeInsertHandlerException extends Exception{}

    //Construtores
    public PedidoTriggerBeforeInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<PedidoDomain> listaProdutoMapper = PedidoDomainFactory.construirListaPedidoDomainAPartirListaSobject((List<SObject>) tp.newList);

        if (String.valueOf(tp.tEvent) == 'beforeInsert')
            this.instanciaPedidoTriggerService.vincularPedidosAsContas(listaProdutoMapper);
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private IPedidoTriggerService instanciaPedidoTriggerService
    {
        get
        {
            if(this.instanciaPedidoTriggerService == null)
                this.instanciaPedidoTriggerService = (IPedidoTriggerService) C3C_DIContainer_Injector.getInstance('PedidoTriggerService');

            return this.instanciaPedidoTriggerService;
        }
        set;
    }
}