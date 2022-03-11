public without sharing class InserirOportunidadeService implements IInserirOportunidadeService 
{
    //Exeptions 
    public class InserirOportunidadeServiceException extends Exception {}

    public IOportunidadeDomain gerarOportunidadeComNome(String nome, String contaId)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Opportunity.SObjectType
        });
        
        IOportunidadeDomain oportunidadeDomain = (IOportunidadeDomain) C3C_DIContainer_Injector.newInstance('OportunidadeDomain', new Map<String,Object>{
            'nome' => nome,
            'chaveExterna' => nome,
            'contaId' => contaId,
            'fase' => 'Em negociação',
            'dataFechamento' => Date.today()
        });

        uow.registerUpsertUsingExternalId(oportunidadeDomain.obterRegistro(), 'ChaveExterna__c');

        try 
        {
            uow.commitWork();
            oportunidadeDomain.preencherNovoId();
            return oportunidadeDomain;
        } 
        catch (Exception e) 
        {
            throw new InserirOportunidadeServiceException('400 - Ocorreu uma exceção ao tentar salvar a Oportunidade, err: '+e.getMessage());
        }
    }
    
    public List<IOportunidadeDomain> gerarOportunidadePorListaDomain(List<IOportunidadeDomain> listaOportunidadeDomain)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Opportunity.SObjectType
        });
        
        List<String> chavesAtualizadas = new List<String>();

        for(IOportunidadeDomain oportunidadeDomain : listaOportunidadeDomain)
        {
            OportunidadeMapper oportunidadeMapper = oportunidadeDomain.obterMapper();
            if(chavesAtualizadas.contains(oportunidadeMapper.chaveExterna.toUppercase().trim()))
                continue;
            uow.registerUpsertUsingExternalId(oportunidadeDomain.obterRegistro(), 'ChaveExterna__c');
            chavesAtualizadas.add(oportunidadeMapper.chaveExterna.toUppercase().trim());
        }

        try 
        {
            uow.commitWork();
            for(IOportunidadeDomain oportunidadeDomain : listaOportunidadeDomain)
            {
                oportunidadeDomain.preencherNovoId();
            }
            return listaOportunidadeDomain;
        } 
        catch (Exception e) 
        {
            throw new InserirOportunidadeServiceException('400 - Ocorreu uma exceção ao tentar salvar a Oportunidade, err: '+e.getMessage());
        }
    }

    //Selector
    private ILeadFilhoSelector leadFilhoSelectorInstance
    {
        get
        {
            if(this.leadFilhoSelectorInstance == null)
                this.leadFilhoSelectorInstance = (ILeadFilhoSelector) C3C_DIContainer_Injector.getInstance('LeadFilhoSelector');

            return this.leadFilhoSelectorInstance;
        }
        set;
    }
}