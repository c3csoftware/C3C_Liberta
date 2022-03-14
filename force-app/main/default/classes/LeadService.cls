public without sharing class LeadService implements ILeadService
{
    public LeadMapper inserirAtualizarLeadPorActiveCampaignId(String activeCampaignId, String nome, String sobrenome, String email, String empresa, String telefone) 
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Lead.SObjectType});

        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain');
        LeadMapper leadMapper = leadDomain.criarLead(activeCampaignId, nome, sobrenome, email, empresa, telefone);
        uow.registerUpsertUsingExternalId(leadMapper.record, 'ActiveCamp__Active_Campaign_Id__c');

        uow.commitWork();

        leadMapper.recordId = (String) leadMapper.record.get('Id');
        
        return leadMapper;
    }

    public LeadMapper obterLeadPorActiveCampaignId(String activeCampaignId)
    {
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain');

        return (LeadMapper) leadDomain.construirLeadMapper(this.leadSelectorInstance.obterLeadPorActiveCampaignId(activeCampaignId));
    }

    public ILeadDomain obterLeadPorId(String idLead)
    {
        return (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', (SObject)this.leadSelectorInstance.obterLeadPorIdDoLead(idLead));
    }

    //Selector
    public ILeadSelector leadSelectorInstance 
    {
        get
        {
            if(this.leadSelectorInstance == null)
                this.leadSelectorInstance = (ILeadSelector) C3C_DIContainer_Injector.getInstance('LeadSelector');
            
            return this.leadSelectorInstance;
        }
        set;
    }
}