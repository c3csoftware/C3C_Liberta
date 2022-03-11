public without sharing class AlterarStatusLeadService implements IAlterarStatusLeadService
{
    //Apenas 
    public void mudarStatusLead(Map<String, Object> mapaIdLeadComStatus)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Lead.SObjectType});

        List<ILeadDomain> listaLeadDomain = new List<ILeadDomain>();

        for(String key : mapaIdLeadComStatus.keySet())
        {
            listaLeadDomain.add((ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', new Map<String, Object>{
                'idLead' => key,
                'status' => mapaIdLeadComStatus.get(key)
            }));
            System.debug('listaLeadDomain: ' + listaLeadDomain);
        }

        
        for(ILeadDomain lead : listaLeadDomain)
        {
            uow.registerDirty(lead.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Lead, err: '+e.getMessage());
        }
    }

    public void mudarStatusLeadNovoParaPrimeiroContato(Map<String, Object> mapaIdLeadComStatus)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Lead.SObjectType});

        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain');
        List<String> listaIdLeadsComStatus = new List<String>{};
        listaIdLeadsComStatus.addAll(mapaIdLeadComStatus.keySet());
        Map<String, LeadMapper> mapLeadMapperComStatusNovo = (Map<String,LeadMapper>) leadDomain.construirMapLeadMapper(this.leadSelectorInstance.obterLeadComStatusNovoPorIdsDoLead(listaIdLeadsComStatus));

        List<ILeadDomain> listaLeadDomain = new List<ILeadDomain>();

        for(String key : mapLeadMapperComStatusNovo.keySet())
        {
            listaLeadDomain.add((ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', new Map<String, Object>{
                'idLead' => key,
                'status' => mapaIdLeadComStatus.get(key)
            }));    
        }
        System.debug('listaLeadDomain: ' + listaLeadDomain);
        
        for(ILeadDomain lead : listaLeadDomain)
        {
            uow.registerDirty(lead.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Lead, err: '+e.getMessage());
        }
    }

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