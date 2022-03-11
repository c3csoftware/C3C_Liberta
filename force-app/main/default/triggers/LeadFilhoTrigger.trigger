trigger LeadFilhoTrigger on LeadFilho__c (before insert, after insert, before update, after update, before delete, after delete) 
{
    TriggerFactory.createTriggerDispatcher(LeadFilho__c.sObjectType);
}