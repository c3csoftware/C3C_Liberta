public with sharing virtual class PedidoTriggerService implements IPedidoTriggerService
{
    /**
     * Método responsável por vincular Pediso a Contas cadastradas na base de Dados 
     * 
     * @param Lista de PedidoDomain.
     */
    public void vincularPedidosAsContas(List<PedidoDomain> listaPedidoDomain)
    {
        // Variáveis de manipulação
        List<PedidoDomain> listaPedidoDomainCpfOuCnpjTratado = new List<PedidoDomain>();
        List<String> listIdChaveExterno = new List<String>();
        Map<String, IContaDomain> mapContaDomainPorIdChaveExterna = new Map<String, IContaDomain>();

        // Iteração para formatar o CPF ou CNPJ na máscara e adicionar na Lista de PedidoDomain tratado e na lista de idChaveExterna.
        for (PedidoDomain pedidoDomain : listaPedidoDomain)
        {
            String cpfOuCnpjFormatado = pedidoDomain.formatarCpfOuCnpj(pedidoDomain.cpfCnpj);
            pedidoDomain.cpfCnpj = cpfOuCnpjFormatado;

            listaPedidoDomainCpfOuCnpjTratado.add(pedidoDomain);
            listIdChaveExterno.add(cpfOuCnpjFormatado);
        } 

        // Iteração sobre as contas que possuem o idChaveExterna equivalente ao CPF ou CNPj da lista de PedidoDomain.
        for (SObject conta : this.instanciaContaSelector.obterContasPorIdsChaveExterna(listIdChaveExterno))
        {
            IContaDomain contaDomain = (IContaDomain) C3C_DIContainer_Injector.newInstance('ContaDomain', conta);
            mapContaDomainPorIdChaveExterna.put(contaDomain.obterMapper().idChaveExterna, contaDomain);
        }

        for (PedidoDomain pedidoDomain : listaPedidoDomain)
        {
            String cpfOuCnpjPedido = pedidoDomain.cpfCnpj;

            if (mapContaDomainPorIdChaveExterna.get(cpfOuCnpjPedido) != null)
            {
                pedidoDomain.conta = mapContaDomainPorIdChaveExterna.get(cpfOuCnpjPedido).obterMapper().recordId;
            }
        }
    }

    /**
     * Método utilizado para criar contas para pedidos que não possui conta na base ainda. 
     * ====================================
     * @param Lista de PedidoDomain
     * @return Nada, ele apenas realiza o procedimento.
     */
    public void criarContasParaPedidos(List<PedidoDomain> listaPedidoDomain)
    {

        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Pedido__c.SObjectType, Account.SObjectType});

        for (PedidoDomain pedidoDomain : listaPedidoDomain) 
        {
            if (pedidoDomain.conta == null)
            {
                ContaMapper contaMpp = ContaDomainFactory.criarContaDomain(pedidoDomain.nome, pedidoDomain.cpfCnpj, pedidoDomain.email, pedidoDomain.telefone, true);

                uow.registerNew(contaMpp.record);
                // Informa um erro de que não pode modificar os dados no After Insert
                
                // uow.registerRelationship(contaMpp.record, Account.Pedido__r.Id, pedidoDomain.record);
            }
        }

        uow.commitWork();
    }

    //Instancias
    private IContaSelector instanciaContaSelector
    {
        get
        {
            if(this.instanciaContaSelector == null)
                this.instanciaContaSelector = (IContaSelector) C3C_DIContainer_Injector.getInstance('ContaSelector');

            return this.instanciaContaSelector;
        }
        set;
    }
}