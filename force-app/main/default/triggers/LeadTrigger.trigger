trigger LeadTrigger on Lead (before insert, after insert, before delete, after update, before update) 
{
    TriggerFactory.createTriggerDispatcher(Lead.sObjectType);
}