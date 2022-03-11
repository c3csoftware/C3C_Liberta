trigger PedidoTrigger on Pedido__c (before insert, after insert) 
{
    TriggerFactory.createTriggerDispatcher(Pedido__c.sObjectType);
}