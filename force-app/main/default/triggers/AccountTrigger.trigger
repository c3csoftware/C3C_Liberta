trigger AccountTrigger on Account (before insert, after insert, before update, after update) 
{
    TriggerFactory.createTriggerDispatcher(Account.sObjectType);
}