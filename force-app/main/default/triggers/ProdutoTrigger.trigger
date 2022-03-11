trigger ProdutoTrigger on Produto__c (before insert, before update) 
{
	TriggerFactory.createTriggerDispatcher(Produto__c.sObjectType);
}