trigger PendingServiceRoutingTrigger on PendingServiceRouting (after delete) 
{
    TriggerFactory.createTriggerDispatcher(PendingServiceRouting.sObjectType);
}