public without sharing class AlterarProprietarioOportunidadeService implements IAlterarProprietarioOportunidadeService
{
    public void mudarProprietarioOportunidade(Map<String, Object> mapaProprietarioComOportunidade)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Opportunity.SObjectType});

        List<IOportunidadeDomain> listaOportunidadeDomain = new List<IOportunidadeDomain>();

        for(String key : mapaProprietarioComOportunidade.keySet())
        {
            listaOportunidadeDomain.add((IOportunidadeDomain) C3C_DIContainer_Injector.newInstance('OportunidadeDomain', new Map<String, Object>{
                'idRegistro' => mapaProprietarioComOportunidade.get(key),
                'idProprietario' => key
            }));
        }

        for(IOportunidadeDomain opp : listaOportunidadeDomain)
        {
            uow.registerDirty(opp.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Oportunidade, err: '+e.getMessage());
        }
    }
}