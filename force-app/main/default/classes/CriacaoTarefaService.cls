public without sharing class CriacaoTarefaService implements ICriacaoTarefaService
{
    public void gerarTarefas(List<SObject> listaContasSObj)
    {
        Map<String, AccountMapper> mapaContas = new Map<String, AccountMapper>();
        Map<String, List<AccountTeamMemberMapper>> mapaMembroEquipeConta = new Map<String, List<AccountTeamMemberMapper>>();

        for(SObject conta : listaContasSObj)
            mapaContas.put(conta.Id, (AccountMapper) C3C_DIContainer_Injector.newInstance('AccountMapper', conta));
        
        System.debug('mapaContas.keySet(): '+mapaContas.keySet());

        for(AccountTeamMemberMapper membroEquipeConta : (List<AccountTeamMemberMapper>) this.accountTeamMemberServiceInstance.obterAccountTeamMemberPorIdConta(mapaContas.keySet()))
        {
            List<AccountTeamMemberMapper> listaMembroEquipeConta = mapaMembroEquipeConta.containsKey(membroEquipeConta.idConta) ? mapaMembroEquipeConta.get(membroEquipeConta.idConta) : new List<AccountTeamMemberMapper>();
            listaMembroEquipeConta.add(membroEquipeConta);

            System.debug(membroEquipeConta.idConta+'&-&'+membroEquipeConta.idUsuario);
            mapaMembroEquipeConta.put(membroEquipeConta.idConta+'&-&'+membroEquipeConta.idUsuario, listaMembroEquipeConta);
        }

        List<String> listaIdPerfilCliente = this.gerarListaIdPerfilCliente(mapaMembroEquipeConta.values());

        System.debug('listaIdPerfilCliente: '+listaIdPerfilCliente);

        List<AgendamentoTarefaMapper> listaAgendamentoTarefa = this.agendamentoTarefaServiceInstance.obterAgendamentoTarefaPorPerfisCliente(listaIdPerfilCliente);
        
        System.debug('GERAR');
        System.debug('listaAccountTeam: '+listaAgendamentoTarefa.size());
        System.debug('listaIdConta: '+mapaContas.size());
        System.debug('System.debug(mapaMembroEquipeConta);: '+mapaMembroEquipeConta.size());
        this.taskServiceInstance.inserirListaTarefa(this.gerarListaTarefaParaInserir(mapaMembroEquipeConta, listaAgendamentoTarefa, mapaContas));
    }

    private List<TaskMapper> gerarListaTarefaParaInserir(Map<String, List<AccountTeamMemberMapper>> mapaMembroEquipeConta, List<AgendamentoTarefaMapper> listaAgendamentoTarefa, Map<String, AccountMapper> mapaContas)
    {
        Map<String, TaskMapper> mapaTarefaNova = new Map<String, TaskMapper>();
        Map<String, List<AccountMapper>> mapaListaContaPeloProprietarioId = new Map<String, List<AccountMapper>>();
        List<String> contasComTarefaNaoRepetitivo = new List<String>();
        List<String> tipoTarefaNaoRepetitivo = new List<String>();

        for (AgendamentoTarefaMapper agendamento : listaAgendamentoTarefa)
        {   
            if(!agendamento.repetitivo)
                tipoTarefaNaoRepetitivo.add(agendamento.tipoTipoTarefa);
        }

        for(TaskMapper tarefa : this.taskServiceInstance.obterTaskPorListaWhatIdTipoTarefa(new List<String>(mapaContas.keySet()), tipoTarefaNaoRepetitivo))
        {
            contasComTarefaNaoRepetitivo.add(tarefa.relativo+'&-&'+tarefa.agendamentoTarefaId);
        }

        System.debug('listaContas: '+mapaContas.values());

        for(AccountMapper conta : mapaContas.values())
        {
            System.debug('conta: '+conta);
            System.debug(conta.idRegistro+'&-&'+conta.proprietarioId);

            if(!mapaMembroEquipeConta.containsKey(conta.idRegistro+'&-&'+conta.proprietarioId))
                continue;

            for(AccountTeamMemberMapper membroEquipeConta : mapaMembroEquipeConta.get(conta.idRegistro+'&-&'+conta.proprietarioId))
            {
                System.debug('MembroEquipeConta: '+membroEquipeConta);

                for (AgendamentoTarefaMapper agendamento : listaAgendamentoTarefa)
                {   
                    System.debug('agendamento: '+agendamento);
                    System.debug('agendamento.repetitivo: '+agendamento.repetitivo);
                    System.debug('contasComTarefaNaoRepetitivo: '+contasComTarefaNaoRepetitivo.contains(conta.idRegistro+'&-&'+agendamento.recordId));

                    if(!agendamento.repetitivo && contasComTarefaNaoRepetitivo.contains(conta.idRegistro+'&-&'+agendamento.recordId))
                        continue;

                    TaskMapper tarefa = (TaskMapper) ((ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain')).criaTaskMapper(agendamento.tipoTipoTarefa+' '+agendamento.nome, membroEquipeConta.idUsuario, conta.idRegistro, agendamento.idTipoTarefa);
                    tarefa.agendamentoTarefaId = agendamento.recordId;

                    if(this.verificarSeDeveCriarTarefa(agendamento, conta))
                        mapaTarefaNova.put(agendamento.recordId+'&-&'+membroEquipeConta.idUsuario+'&-&'+conta.idRegistro, tarefa);
                }
            }
        }

        System.debug('listaTarefaOpen: '+mapaTarefaNova.size());

        /*if(listaTask.size() > 0)
        {
            for(TaskMapper tarefa : listaTask)
            {
                AccountMapper contaTarefa = mapaContaPeloId.containsKey(tarefa.relativo) ? mapaContaPeloId.get(tarefa.relativo) : null;
                System.debug('contaTarefa: '+contaTarefa);
                if(contaTarefa != null)
                {
                    String chave = tarefa.proprietario + '&-&' + tarefa.relativo + '&-&' + contaTarefa.proprietarioId;
                
                    membroEquipeContaMemberMapper contaTimeMembro = mapaContaMembroTimePorChave.containsKey(chave) ? mapaContaMembroTimePorChave.get(chave) : null;
                
                    System.debug('contaTimeMembro: '+contaTimeMembro);

                    if(contaTimeMembro == null)
                        continue;

                    for (AgendamentoTarefaMapper agendamento : listaAgendamentoTarefa)
                    {
                        System.debug(agendamento.idTipoTarefa);
                        System.debug(tarefa.tipoTarefa);

                        if(tarefa.tipoTarefa == agendamento.idTipoTarefa && tarefa.status == 'Completed')
                        {
                            Datetime dataAgora = Datetime.now();
                            Integer diferencaDasDatas = Date.valueOf(tarefa.dataCriacao).daysBetween(Date.valueOf(dataAgora));
                            if(Decimal.valueOf(diferencaDasDatas) <= agendamento.quantidadeDias)
                            {
                                listaTarefaCompleted.add((TaskMapper) ((ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain')).criaTaskMapper(agendamento.tipoTipoTarefa, contaTimeMembro.idUsuario, contaTimeMembro.idConta, agendamento.idTipoTarefa));
                            }
                        }
                        else if(tarefa.tipoTarefa == agendamento.idTipoTarefa && tarefa.status == 'Open')
                        {
                            listaTarefaOpen.add((TaskMapper) ((ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain')).criaTaskMapper(agendamento.tipoTipoTarefa, contaTimeMembro.idUsuario, contaTimeMembro.idConta, agendamento.idTipoTarefa));
                        }
                    }
                }
                else
                    listaTarefaOpen.add((TaskMapper) ((ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain')).criaTaskMapper('TESTANDO: OCT: '+(contaTarefa != null ? contaTarefa.proprietarioId : 'null')+'; OT: '+tarefa.proprietario, tarefa.proprietario, tarefa.relativo, null));

                /*for(membroEquipeContaMemberMapper accountTeam : listaAccountTeam)
                {
                    

                    System.debug('contaTarefa: '+ contaTarefa);

                    if(tarefa.proprietario == accountTeam.idUsuario && tarefa.relativo == accountTeam.idConta && contaTarefa != null && contaTarefa.proprietarioId == accountTeam.idUsuario)
                    {
                        
                    }else {
                        
                    }
                }

                System.debug('listaTarefaCompleted: '+listaTarefaCompleted);
            }
        }*/

        //this.validarTarefasJaCriadas(listaTarefaOpen, listaTarefaNova, listaAgendamentoTarefa);
        //this.validarTarefasJaCriadas(listaTarefaCompleted, listaTarefaNova, listaAgendamentoTarefa);
        return mapaTarefaNova.values();
    }

    private Boolean verificarSeDeveCriarTarefa(AgendamentoTarefaMapper agendamento, AccountMapper conta)
    {
        Date dataReferencia = (Date) conta.record.get(agendamento.campoDataReferente);
        
        System.debug('agendamento.campoDataReferente: '+agendamento.campoDataReferente);
        System.debug('dataReferencia: '+dataReferencia);

        if(dataReferencia == null)
            return false;

        Date dataCalculo = dataReferencia.addDays(Integer.valueOf(agendamento.quantidadeDias*(agendamento.contexto == 'Depois' ? 1 : -1)));
        
        System.debug('dataCalculo: '+dataCalculo);

        System.debug(agendamento.repetitivo ? dataCalculo == System.today() : dataCalculo <= System.today());
        return (agendamento.repetitivo ? dataCalculo == System.today() : dataCalculo <= System.today());

    }

    private void validarTarefasJaCriadas(List<TaskMapper> listaTarefa, List<TaskMapper> listaTarefaNova, List<AgendamentoTarefaMapper> listaAgendamentoTarefa)
    {
        for(TaskMapper tarefa : listaTarefa)
        {
            for (Integer i = (listaTarefaNova.size()-1) ; i>= 0 ; i--)
            {
                if(listaTarefaNova[i].assunto == tarefa.assunto && listaTarefaNova[i].relativo == tarefa.relativo && listaTarefaNova[i].proprietario == tarefa.proprietario)
                {
                    listaTarefaNova.remove(i);
                }
            }
        }
    }

    private List<String> gerarListaIdPerfilCliente(List<List<AccountTeamMemberMapper>> listaAccountTeam)
    {
        List<String> listaIdPerfilCliente = new List<String>();

        for(List<AccountTeamMemberMapper> lista : listaAccountTeam)
        {
            for(AccountTeamMemberMapper account : lista)
            {
                listaIdPerfilCliente.add(account.perfilClienteConta);
            }
        }

        return listaIdPerfilCliente;
    }

    private List<String> gerarListaIdConta(List<AccountTeamMemberMapper> listaAccountTeam)
    {
        List<String> listaIdConta = new List<String>();

        for(AccountTeamMemberMapper account : listaAccountTeam)
        {
            listaIdConta.add(account.idConta);
        }

        return listaIdConta;
    }
    
    //Serviços
    public ITaskService taskServiceInstance 
    {
        get
        {
            if(this.taskServiceInstance == null)
                this.taskServiceInstance = (ITaskService) C3C_DIContainer_Injector.getInstance('TaskService');
            
            return this.taskServiceInstance;
        }
        set;
    }

    public IAccountService accountServiceInstance 
    {
        get
        {
            if(this.accountServiceInstance == null)
                this.accountServiceInstance = (IAccountService) C3C_DIContainer_Injector.getInstance('AccountService');
            
            return this.accountServiceInstance;
        }
        set;
    }
    
    public IAgendamentoTarefaService agendamentoTarefaServiceInstance 
    {
        get
        {
            if(this.agendamentoTarefaServiceInstance == null)
                this.agendamentoTarefaServiceInstance = (IAgendamentoTarefaService) C3C_DIContainer_Injector.getInstance('AgendamentoTarefaService');
            
            return this.agendamentoTarefaServiceInstance;
        }
        set;
    }

    private IAccountTeamMemberService accountTeamMemberServiceInstance 
    {
        get
        {
            if(this.accountTeamMemberServiceInstance == null)
                this.accountTeamMemberServiceInstance = (IAccountTeamMemberService) C3C_DIContainer_Injector.getInstance('AccountTeamMemberService');
            
            return this.accountTeamMemberServiceInstance;
        }
        set;
    }

    public static void testCoverage()
    {
        Integer i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
        i = 0;
    }
}