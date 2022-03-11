trigger MembroEquipeTrigger on MembroEquipe__c (after insert, after update, after delete) 
{
    TriggerFactory.createTriggerDispatcher(MembroEquipe__c.sObjectType);
}