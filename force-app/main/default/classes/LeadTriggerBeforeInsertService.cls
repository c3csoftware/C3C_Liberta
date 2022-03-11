public without sharing virtual class LeadTriggerBeforeInsertService implements ILeadTriggerBeforeInsertService
{
    public void modificarProprietarioLeadSemDono(List<ILeadDomain> listaLeadDomain)
    {
        GroupMapper leadSemDono = instanciaGroupService.obterGroupPorNome('Lead sem Dono');

        for(ILeadDomain leadDomain : listaLeadDomain)
        {
            // Verificação para o caso de o Lead está sendo criado pelo Webhook - Id Webhook
            System.debug('LeadTriggerBeforeInsertService -> Lead CriadoPorId: '+ leadDomain.obterMapper().criadoPorId );
            if (leadDomain.obterMapper().record.get('CreatedById') == '0058G000000IWuNQAW' )
                continue;

            leadDomain.obterMapper().proprietario = leadSemDono.recordId;
        }
    }

    // Instâncias
    public IGroupService instanciaGroupService 
    {
        get
        {
            if(this.instanciaGroupService == null)
                this.instanciaGroupService = (IGroupService) C3C_DIContainer_Injector.getInstance('GroupService');
            
            return this.instanciaGroupService;
        }
        set;
    }
}