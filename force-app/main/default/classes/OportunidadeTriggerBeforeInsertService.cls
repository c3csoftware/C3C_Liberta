public with sharing class OportunidadeTriggerBeforeInsertService implements IOportunidadeTriggerBeforeInsertService
{
    public void modificarProprietarioOportunidadeSemDono(List<IOportunidadeDomain> listaOportunidadeDomain)
    {
        GroupMapper leadSemDono = instanciaGroupService.obterGroupPorNome('Lead sem Dono');

        for(IOportunidadeDomain oportunidadeDomain : listaOportunidadeDomain)
        {
            //oportunidadeDomain.obterMapper().proprietario = leadSemDono.recordId;
        }

    }

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