public without sharing class RespostaPesquisaService implements IRespostaPesquisaService
{
    //Exception
    public class RespostaPesquisaServiceException extends Exception {}
    
	public void inserirRespostaPesquisaPorBot(List<IRespostaPesquisaDomain> listaDeRespostaPesquisa)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            RespostaPesquisa__c.SObjectType
        });
        
        for (IRespostaPesquisaDomain respostaPesquisa : listaDeRespostaPesquisa)        
            uow.registerNew(respostaPesquisa.obterRegistro());   
                
        try 
        {
        	uow.commitWork();            
        } 
        catch(Exception e) 
        {
            throw new RespostaPesquisaServiceException('Ocorreu uma exceção ao tentar salvar a Resposta Pesquisa, err: ' + e.getMessage());
        }
    }
}