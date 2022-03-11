public without sharing class AlterarProprietarioLeadService implements IAlterarProprietarioLeadService
{
    public void mudarProprietarioLead(Map<String, Object> mapaProprietarioComLead)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Lead.SObjectType});

        List<ILeadDomain> listaLeadDomain = new List<ILeadDomain>();

        for(String key : mapaProprietarioComLead.keySet())
        {
            listaLeadDomain.add((ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', new Map<String, Object>{
                'idRegistro' => mapaProprietarioComLead.get(key),
                'idProprietario' => key
            }));
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
}