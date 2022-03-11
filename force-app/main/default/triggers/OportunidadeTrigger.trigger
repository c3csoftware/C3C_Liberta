trigger OportunidadeTrigger on	Opportunity (before insert) 
{
    TriggerFactory.createTriggerDispatcher(Opportunity.sObjectType);
}