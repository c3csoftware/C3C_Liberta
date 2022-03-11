public with sharing class BuscarPopTarefaService implements IBuscarPopTarefaService
{
    public ITaskDomain obterTarefaPorIdComPop(String idRegistro)
    {
        ITaskDomain taskDomain = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', this.taskSelectorInstance.obterTarefaPorIdComPop(idRegistro));
        C3C_APP_ApplicationContext.setResponse(taskDomain.obterMapper());
        return taskDomain;
    }

    //Selector
    public ITaskSelector taskSelectorInstance 
    {
        get
        {
            if(this.taskSelectorInstance == null)
                this.taskSelectorInstance = (ITaskSelector) C3C_DIContainer_Injector.getInstance('TaskSelector');
            
            return this.taskSelectorInstance;
        }
        set;
    }
}