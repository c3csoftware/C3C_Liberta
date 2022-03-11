public without sharing class ItemReguaAgendamentoTarefaViewModel implements C3C_DI_IProvider 
{
    //
    //Atributos
    //

    @AuraEnabled public DataAgendamentoTarefaViewModel agendamentosTarefa {get;set;}
    @AuraEnabled 
    public List<TaskMapper> tarefasConta 
    {
        get
        {
            if(this.tarefasConta == null)
                this.tarefasConta = new List<TaskMapper>();
            return this.tarefasConta;
        }
        set;
    }

    //
    //Construtores
    //

    public ItemReguaAgendamentoTarefaViewModel()
    {}

    //Responsável por criar a instância passando dataAgendamento e informacoes de tarefa
    private ItemReguaAgendamentoTarefaViewModel(DataAgendamentoTarefaViewModel agendamentosTarefa, List<TaskMapper> tarefasConta)
    {
        this.agendamentosTarefa = agendamentosTarefa;
        this.tarefasConta = tarefasConta;
    }

    //
    //Métodos
    //
    
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParams = (Map<String, Object>) params;

            return new ItemReguaAgendamentoTarefaViewModel(
                (DataAgendamentoTarefaViewModel) mapaParams.get('agendamentosTarefa'),
                (List<TaskMapper>) mapaParams.get('tarefasConta')
            );
        }

        return null;
    }
}