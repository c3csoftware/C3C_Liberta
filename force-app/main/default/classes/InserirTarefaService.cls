public without sharing class InserirTarefaService implements IInserirTarefaService
{
    //Responsável por criar uma lista de instancia de Tarefa
    public void criarListaDeTarefa(List<ITaskDomain> listaDeTarefa)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Task.SObjectType
        });

        for(ITaskDomain tarefa : listaDeTarefa)
        {
            tarefa.obterMapper().dataVencimento = System.today();

            uow.registerNew(tarefa.obterRegistro());
            // uow.registerUpsert(tarefa.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Tarefa, err: '+e.getMessage());
        }
    }
}