public without sharing class AtualizarTarefaService implements IAtualizarTarefaService
{
    public void atualizarWhatIdParaWhoId(String idRegistro)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{Task.SObjectType});

        ITaskDomain tarefaDomain = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', this.instaciaTaskSelector.obterTarefaPorId(idRegistro));
        TaskMapper tarefaMapper = tarefaDomain.obterMapper();
        
        if(tarefaMapper.relativo != null)
        {
            ILeadFilhoDomain leadFilhoDomain = (ILeadFilhoDomain) C3C_DIContainer_Injector.newInstance('LeadFilhoDomain', this.instaciaLeadFilhoSelector.obterLeadFilhoPorId(tarefaMapper.relativo));
            LeadFilhoMapper leadFilhoMapper = leadFilhoDomain.obterMapper();
            
            if(leadFilhoMapper != null)
            {
                tarefaDomain = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', new Map<String,Object>{
                    'idTask' => idRegistro,
                    'whoId' => leadFilhoMapper.lead,
                    'relativo' => ''
                });
            }
            else 
            {
                tarefaDomain = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', new Map<String,Object>{
                    'idTask' => idRegistro,
                    'relativo' => ''
                }); 
            }           

            TaskMapper tarefaMpp = tarefaDomain.obterMapper();
            tarefaMpp.status = 'Completed';
    
            uow.registerDirty(tarefaDomain.obterRegistro());
    
            try 
            {
                uow.commitWork();
            } 
            catch (Exception e) 
            {
                C3C_APP_ApplicationContext.addCriticalError('400', 'Ocorreu uma exceção ao tentar atualizar a Tarefa, err: '+e.getMessage());
            }
        }
    }

    //Selector
    public ITaskSelector instaciaTaskSelector 
    {
        get
        {
            if(this.instaciaTaskSelector == null)
                this.instaciaTaskSelector = (ITaskSelector) C3C_DIContainer_Injector.getInstance('TaskSelector');
            
            return this.instaciaTaskSelector;
        }
        set;
    }
    
    public ILeadFilhoSelector instaciaLeadFilhoSelector 
    {
        get
        {
            if(this.instaciaLeadFilhoSelector == null)
                this.instaciaLeadFilhoSelector = (ILeadFilhoSelector) C3C_DIContainer_Injector.getInstance('LeadFilhoSelector');
            
            return this.instaciaLeadFilhoSelector;
        }
        set;
    }
}