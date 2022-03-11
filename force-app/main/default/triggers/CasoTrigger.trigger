trigger CasoTrigger on Case (before insert, before update, after update) 
{
    TriggerFactory.createTriggerDispatcher(Case.sObjectType);
}