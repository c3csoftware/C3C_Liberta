trigger EventTrigger on Event (before insert) 
{
    TriggerFactory.createTriggerDispatcher(Event.sObjectType);
}