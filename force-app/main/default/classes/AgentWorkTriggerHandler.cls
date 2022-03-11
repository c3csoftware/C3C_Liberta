public without sharing class AgentWorkTriggerHandler extends TriggerHandlerBase
{
    public class AgentWorkTriggerHandlerException extends Exception{}

    //Construtores
    public AgentWorkTriggerHandler() {}

    //Métodos
    public override void mainEntry(TriggerParameters tp) 
    {
        List<IAgentWorkDomain> agentWorkDomainNew = (List<IAgentWorkDomain>) C3C_DIContainer_Injector.newInstance('AgentWorkDomain', (List<SObject>) tp.newList);

        if (String.valueOf(tp.tEvent) == 'beforeInsert')
        {
            this.agentWorkTriggerServiceInstance.gerarTarefa(agentWorkDomainNew);
        }
    }
    
    public override void inProgressEntry(TriggerParameters tp) {}
    
    public override void updateObjects() {}

    //Atributos de serviço
    private IAgentWorkTriggerService agentWorkTriggerServiceInstance
    {
        get
        {
            if(this.agentWorkTriggerServiceInstance == null)
                this.agentWorkTriggerServiceInstance = (IAgentWorkTriggerService) C3C_DIContainer_Injector.getInstance('AgentWorkTriggerService');

            return this.agentWorkTriggerServiceInstance;
        }
        set;
    }
    
}