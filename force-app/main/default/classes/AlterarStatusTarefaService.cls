public without sharing class AlterarStatusTarefaService implements IAlterarStatusTarefaService
{
    public void mudarStatusTask(Map<String, Object> mapaIdTaskComStatus)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Task.SObjectType});

        List<ITaskDomain> listaTaskDomain = new List<ITaskDomain>();

        for(String key : mapaIdTaskComStatus.keySet())
        {
            listaTaskDomain.add((ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', new Map<String, Object>{
                'idTask' => key,
                'status' => mapaIdTaskComStatus.get(key)
            }));
        }

        for(ITaskDomain task : listaTaskDomain)
        {
            uow.registerDirty(task.obterRegistro());
        }

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            System.debug('400 - Ocorreu uma exceção ao tentar salvar a Task, err: '+e.getMessage());
        }
    }
}