public without sharing class ListaActiveCampaignService implements IListaActiveCampaignService
{
	public void inserirAtualizarListaActivePorIdListaComNomeFila(String idLista, String nomeLista)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{ListaActiveCampaign__c.SObjectType});
        
        IListaActiveCampaignDomain listaActiveDomain = (IListaActiveCampaignDomain) C3C_DIContainer_Injector.newInstance('ListaActiveCampaignDomain');
        uow.registerUpsertUsingExternalId((listaActiveDomain.criarListaActiveCampaignPorIdLista(idLista, nomeLista, listaActiveDomain.tratarNomeListaActiveCampaign(nomeLista))).record, 'IdLista__c');

        uow.commitWork();
    }

    public List<ListaActiveCampaignMapper> obterListaActivePorIdsLista(Set<String> idsLista)
    {
        IListaActiveCampaignDomain listaActiveCampaignDomain = (IListaActiveCampaignDomain) C3C_DIContainer_Injector.newInstance('ListaActiveCampaignDomain');
        
        return (List<ListaActiveCampaignMapper>) listaActiveCampaignDomain.construirListListaActiveCampaignMapper(this.listaActiveCampaignSelectorInstance.obterListaActivePorIdsLista(idsLista));
    }

    //Selector
    public IListaActiveCampaignSelector listaActiveCampaignSelectorInstance 
    {
        get
        {
            if(this.listaActiveCampaignSelectorInstance == null)
                this.listaActiveCampaignSelectorInstance = (IListaActiveCampaignSelector) C3C_DIContainer_Injector.getInstance('ListaActiveCampaignSelector');
            
            return this.listaActiveCampaignSelectorInstance;
        }
        set;
    }
}