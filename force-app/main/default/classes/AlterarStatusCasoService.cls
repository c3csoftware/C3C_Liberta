public without sharing virtual class AlterarStatusCasoService implements IAlterarStatusCasoService
{
    public void mudarStatusCasoResolvidoParaEncerrado(Map<String, Object> mapaIdCasoComStatus)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Case.SObjectType});

        List<String> listaIdCasosParaAtualizar = new List<String>{};
        listaIdCasosParaAtualizar.addAll(mapaIdCasoComStatus.keySet());
        List<CasoDomain> listaCasoDomain = (List<CasoDomain>) DomainFactory.buildListDomainWithListSObject('CasoDomain', this.instanciaCasoSelector.obterCasoComStatusResolvidoPorIdsDoCaso(listaIdCasosParaAtualizar));
        
        for (CasoDomain casoDomain : listaCasoDomain)   
        {
            casoDomain.status = 'Encerrado';
            uow.registerDirty(casoDomain.record);
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Caso, err: '+e.getMessage());
        }
    }

    public ICasoSelector instanciaCasoSelector 
    {
        get
        {
            if(this.instanciaCasoSelector == null)
                this.instanciaCasoSelector = (ICasoSelector) C3C_DIContainer_Injector.getInstance('CasoSelector');
            
            return this.instanciaCasoSelector;
        }
        set;
    }
}