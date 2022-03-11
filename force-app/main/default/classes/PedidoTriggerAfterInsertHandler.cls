public without sharing virtual class PedidoTriggerAfterInsertHandler extends TriggerHandlerBase
{
    public class PedidoTriggerAfterInsertHandlerException extends Exception{}

    //Construtores
    public PedidoTriggerAfterInsertHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<PedidoDomain> listaProdutoMapper = PedidoDomainFactory.construirListaPedidoDomainAPartirListaSobject((List<SObject>) tp.newList);

        if (String.valueOf(tp.tEvent) == 'afterInsert')
            this.instanciaPedidoTriggerService.criarContasParaPedidos(listaProdutoMapper);
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