Global class ObtencaoAtivaLeadService 
{
    webservice static void modificarProprietarioLeadSemDono(String idLead)
    {

        UserRole papelHunter = [SELECT Id FROM UserRole WHERE Name = 'Hunter'];
        UserRole papelExecutivoComercial = [SELECT Id FROM UserRole WHERE Name = 'Executivo Comercial'];

        if (UserInfo.getUserRoleId() == papelHunter.Id || UserInfo.getUserRoleId() == papelExecutivoComercial.Id)
        {
            fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
                LeadFilho__c.SObjectType
            });

            // ILeadDomain leadDomain = this.leadServiceInstance.obterLeadPorId(idLead);
            ILeadFilhoDomain leadFilhoDomain = ((ILeadFilhoService) C3C_DIContainer_Injector.getInstance('LeadFilhoService')).obterLeadFilhoPorIdDoRegistro(idLead);
            leadFilhoDomain.obterMapper().proprietario = UserInfo.getUserId();

            uow.registerDirty(leadFilhoDomain.obterRegistro());
    
            // this.gerarTarefaQualificaoLead(idLead);
    
            List<ITaskDomain> listaDeTarefas = new List<ITaskDomain>();
            ITaskDomain tarefa = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain');
            TaskMapper tarefaMapper = tarefa.obterMapper();

            // ITipoTarefaDomain tipoTarefaDomainLead = this.tipoTarefaServiceInstance.obterTipoTarefasPorTipoIgualQualificacaoLead();
			
            ITipoTarefaDomain tipoTarefaDomainLead = ((ITipoTarefaService) C3C_DIContainer_Injector.getInstance('TipoTarefaService')).obterTipoTarefasPorTipoIgualQualificacaoLead();
            
            tarefaMapper.proprietario = UserInfo.getUserId();
            tarefaMapper.assunto = 'Qualificação do Lead';
            tarefaMapper.tipoTarefa = tipoTarefaDomainLead.obterMapper().recordId;
            tarefaMapper.whoId = idLead;

            listaDeTarefas.add(tarefa);

            // this.inserirTarefaServiceInstance.criarListaDeTarefa(listaDeTarefas);  

            ((IInserirTarefaService) C3C_DIContainer_Injector.getInstance('InserirTarefaService')).criarListaDeTarefa(listaDeTarefas);

            try 
            {
                uow.commitWork();
            } 
            catch (Exception e) 
            {
                System.debug('400 - Ocorreu uma exceção ao tentar salvar a Tarefa, err: '+e.getMessage());
            }
        }
        else 
        {
            System.debug('Você não é hunter e nem executivo');
        }
    }


    private void gerarTarefaQualificaoLead(String idLead)
    {
        List<ITaskDomain> listaDeTarefas = new List<ITaskDomain>();
        ITaskDomain tarefa = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain');
        TaskMapper tarefaMapper = tarefa.obterMapper();

        ITipoTarefaDomain tipoTarefaDomainLead = this.tipoTarefaServiceInstance.obterTipoTarefasPorTipoIgualQualificacaoLead();

        tarefaMapper.proprietario = UserInfo.getUserId();
        tarefaMapper.assunto = 'Qualificação do Lead';
        tarefaMapper.tipoTarefa = tipoTarefaDomainLead.obterMapper().recordId;
        tarefaMapper.whoId = idLead;

        listaDeTarefas.add(tarefa);

        this.inserirTarefaServiceInstance.criarListaDeTarefa(listaDeTarefas);  
    }

    // Instâncias

    public IInserirTarefaService inserirTarefaServiceInstance 
    {
        get
        {
            if(this.inserirTarefaServiceInstance == null)
                this.inserirTarefaServiceInstance = (IInserirTarefaService) C3C_DIContainer_Injector.getInstance('InserirTarefaService');
            
            return this.inserirTarefaServiceInstance;
        }
        set;
    }

    private ILeadFilhoService leadFilhoServiceInstance
    {
        get
        {
            if(this.leadFilhoServiceInstance == null)
                this.leadFilhoServiceInstance = (ILeadFilhoService) C3C_DIContainer_Injector.getInstance('LeadFilhoService');

            return this.leadFilhoServiceInstance;
        }
        set;
    }

    public ITipoTarefaService tipoTarefaServiceInstance 
    {
        get
        {
            if(this.tipoTarefaServiceInstance == null)
                this.tipoTarefaServiceInstance = (ITipoTarefaService) C3C_DIContainer_Injector.getInstance('TipoTarefaService');
            
            return this.tipoTarefaServiceInstance;
        }
        set;
    }
}