trigger InstanciaRespostaTrigger on InstanciaResposta__c (after insert, after update, after delete, before insert, before update, before delete) 
{
    TriggerFactory.createTriggerDispatcher(InstanciaResposta__c.sObjectType);
}