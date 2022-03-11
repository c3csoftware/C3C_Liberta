public without sharing class AtualizarEventoService implements IAtualizarEventoService
{
    //Exeptions 
    public class AtualizarEventoServiceException extends Exception {}

    public void atualizaAnalisadoBatchDeEvento(List<IEventDomain> listaEventDomain)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Event.SObjectType
        });
        
        for(IEventDomain evento : listaEventDomain)
        {
            uow.registerDirty(evento.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            throw new AtualizarEventoServiceException('400 - Ocorreu uma exceção ao tentar salvar a Tarefa, err: '+e.getMessage());
        } 
    }
}