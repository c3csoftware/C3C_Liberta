public without sharing class TarefaConversaoLeadService implements ITarefaConversaoLeadService
{

    //
    //Métodos
    //

    //Responsável por criar a tarefa para conversão do lead
    public void criarTarefaConversaoLead(String idLead, String idResponsavelTarefa)
    {
        TipoTarefaMapper tipoTarefa = this.instanciaTipoTarefaService.obterTipoTarefaComNome('Conversão Lead').obterMapper();
        TaskMapper tarefa = TaskMapperFactory.construirMapper('Conversão de Lead', idResponsavelTarefa, idLead, tipoTarefa.recordId);

        this.instanciaTaskService.inserirListaTarefa(new List<TaskMapper>{tarefa});
    }

    //Responsável por criar uma lista de tarefas para conversão do lead
    public void criarListaTarefasConversaoLead(List<Map<String, Object>> listaDadosParaCriarTarefas)
    {
        List<TaskMapper> listaTarefas = new List<TaskMapper>();
        
        TipoTarefaMapper tipoTarefa = this.instanciaTipoTarefaService.obterTipoTarefaComNome('Conversão Lead').obterMapper();

        for(Map<String, Object> dadosParaCriarTarefas : listaDadosParaCriarTarefas)
        {
            listaTarefas.add(TaskMapperFactory.construirMapper(
                'Conversão de Lead', 
                (String) dadosParaCriarTarefas.get('idResponsavelTarefa'), 
                (String) dadosParaCriarTarefas.get('idLead'), 
                tipoTarefa.recordId
            ));
        }

        this.instanciaTaskService.inserirListaTarefa(listaTarefas);
    }

    //
    //Atributos - Service
    //

    private ITaskService instanciaTaskService
    {
        get
        {
            if(this.instanciaTaskService == null)
                this.instanciaTaskService = (ITaskService) C3C_DIContainer_Injector.getInstance('TaskService');

            return this.instanciaTaskService;
        }
        set;
    }

    private ITipoTarefaService instanciaTipoTarefaService
    {
        get
        {
            if(this.instanciaTipoTarefaService == null)
                this.instanciaTipoTarefaService = (ITipoTarefaService) C3C_DIContainer_Injector.getInstance('TipoTarefaService');

            return this.instanciaTipoTarefaService;
        }
        set;
    }
}