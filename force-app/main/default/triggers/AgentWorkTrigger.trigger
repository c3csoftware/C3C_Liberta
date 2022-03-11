trigger AgentWorkTrigger on AgentWork (before insert) 
{
    TriggerFactory.createTriggerDispatcher(AgentWork.sObjectType);
}