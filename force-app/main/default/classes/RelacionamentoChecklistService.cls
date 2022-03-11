public class RelacionamentoChecklistService implements IRelacionamentoChecklistService 
{
    //
    //Métodos
    //

    //Responsável relacionar a resposta do checklist ao registro relacionado à tarefa
    public void relacionarRespostaChecklistComRelacionamentoTarefa(List<IInstanciaRespostaDomain> listaRespostas)
    {
        Map<String, TaskMapper> mapaTarefasPorId = new Map<String, TaskMapper>();
        List<String> listaIdTarefaChecklist = new List<String>();

        //Responsável por obter os ids das tarefas relacionadas ao checklist
        for(IInstanciaRespostaDomain instanciaResposta : listaRespostas)
        {
            InstanciaRespostaMapper instanciaRespostaMapper = instanciaResposta.obterMapper();

            listaIdTarefaChecklist.add(instanciaRespostaMapper.idTarefa);
        }

        //Responsável por buscar as tarefas relacionadas ao checklist, e coloca-las em um mapa
        for(ITaskDomain tarefaChecklist : this.instanciaBuscarInformacoesTarefaService.obterTarefaPorListId(listaIdTarefaChecklist))
        {
            TaskMapper tarefaChecklistMapper = tarefaChecklist.obterMapper();

            mapaTarefasPorId.put(tarefaChecklistMapper.recordId, tarefaChecklistMapper);
        }

        //Responsável por relacionar as instância resposta à Oportunidade, Conta, Caso ou Lead
        for(IInstanciaRespostaDomain instanciaResposta : listaRespostas)
        {
            InstanciaRespostaMapper instanciaRespostaMapper = instanciaResposta.obterMapper();

            TaskMapper tarefaChecklist = mapaTarefasPorId.containsKey(instanciaRespostaMapper.idTarefa) ? mapaTarefasPorId.get(instanciaRespostaMapper.idTarefa) : null;
            
            if(tarefaChecklist == null)
                continue;

            String nomeRegistroRelacionado;
            
            if(tarefaChecklist.relativo != null)
                nomeRegistroRelacionado = ((Id) tarefaChecklist.relativo).getSObjectType().getDescribe().getName();

            if(tarefaChecklist.whoId != null)
                nomeRegistroRelacionado = ((Id) tarefaChecklist.whoId).getSObjectType().getDescribe().getName();

            //Limpando referências antigas
            instanciaRespostaMapper.leadId = null;
            instanciaRespostaMapper.casoId = null;
            instanciaRespostaMapper.oportunidadeId = null;
            instanciaRespostaMapper.contaId = null;

            switch on nomeRegistroRelacionado {
                when 'Lead'
                {
                    instanciaRespostaMapper.leadId = tarefaChecklist.whoId;
                }
                when 'Case' 
                {
                    instanciaRespostaMapper.casoId = tarefaChecklist.relativo;
                }
                when 'Opportunity' 
                {
                    instanciaRespostaMapper.oportunidadeId = tarefaChecklist.relativo;
                }
                when 'Account' 
                {
                    instanciaRespostaMapper.contaId = tarefaChecklist.relativo;
                }
            }
        }
    }

    //
    //Atributos - Services
    //

    private IBuscarInformacoesTarefaService instanciaBuscarInformacoesTarefaService
    {
        get
        {
            if(this.instanciaBuscarInformacoesTarefaService == null)
                this.instanciaBuscarInformacoesTarefaService = (IBuscarInformacoesTarefaService) C3C_DIContainer_Injector.getInstance('BuscarInformacoesTarefaService');

            return this.instanciaBuscarInformacoesTarefaService;
        }
        set;
    }
}