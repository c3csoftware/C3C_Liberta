@isTest
public with sharing class PedidoMapperTest 
{
    @isTest 
    static void testeNewInstancePassandoSobject()
    {
        PedidoMapper pedido = (PedidoMapper) new PedidoMapper().newInstance(Schema.getGlobalDescribe().get('Pedido__c').newSObject());

        System.assert(pedido != null, 'PedidoMapper não pode estar nulo');
        System.assert(pedido.getObjectName() == 'Pedido__c', 'O retorno do método getObjectName deve ser Pedido__c');
    }

    @isTest 
    static void testeNewInstancePassandoNull()
    {
        PedidoMapper pedido = (PedidoMapper) new PedidoMapper().newInstance('');

        System.assert(pedido == null, 'O pedido deveria estar nulo.');
    }
}