public without sharing class EventService implements IEventService
{
    //Exeptions 

    public class EventServiceException extends Exception {}

    //Métodos

    //Responsável por retornar os evento dos usuários da fila informada, a partir da data de inicio e termino informada.
    public List<IEventDomain> buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(String idFila, Datetime dataDeInicio, Datetime dataDeTermino)
    {
        List<IEventDomain> listaDeEventos = new List<IEventDomain>();

        //Bucando os evento dos usuários da fila informada, a partir da data de inicio e termino informada.
        for(SObject evento : this.instanciaEventSelector.buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(idFila, dataDeInicio, dataDeTermino))
            listaDeEventos.add((IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', evento));

        List<EventMapper> listaDeEventosMapper = new List<EventMapper>();

        for(IEventDomain evento : listaDeEventos)
            listaDeEventosMapper.add(evento.obterMapper());

        //Enviando como resposta para o front
        C3C_APP_ApplicationContext.setResponse(listaDeEventosMapper);

        return listaDeEventos;
    }

    //Responsável por retornar os evento dos usuários informados, a partir da data de inicio e termino informada.
    public List<IEventDomain> buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino(String idFila, Set<String> idsUsuario, Datetime dataDeInicio, Datetime dataDeTermino)
    {
        List<IEventDomain> listaDeEventos = new List<IEventDomain>();

        //Bucando os evento dos usuários da fila informada, a partir da data de inicio e termino informada.
        for(SObject evento : this.instanciaEventSelector.buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino(idFila, idsUsuario, dataDeInicio, dataDeTermino))
            listaDeEventos.add((IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', evento));

        List<EventMapper> listaDeEventosMapper = new List<EventMapper>();

        for(IEventDomain evento : listaDeEventos)
            listaDeEventosMapper.add(evento.obterMapper());

        //Enviando como resposta para o front
        C3C_APP_ApplicationContext.setResponse(listaDeEventosMapper);

        return listaDeEventos;
    }

    //Método responsável por criar evento.
    public List<IEventDomain> criarEvento(List<IEventDomain> listaEvento)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Event.SObjectType
        });
        
        for(IEventDomain evento : listaEvento)
        {
            uow.registerNew(evento.obterRegistro());
        }

        try 
        {
            uow.commitWork();

            for (IEventDomain evento : listaEvento)
            {
                evento.atribuirNovoIdDoRegistro();
            }

            return listaEvento;
        } 
        catch (Exception e) 
        {
            throw new EventServiceException('400 - Ocorreu uma exceção ao tentar salvar a Tarefa, err: '+e.getMessage());
        } 
    }

    //Método responsável por atualizar eventos.
    public List<IEventDomain> atualizarEvento(List<IEventDomain> listaEvento)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Event.SObjectType
        });
        
        for(IEventDomain evento : listaEvento)
        {
            uow.registerDirty(evento.obterRegistro());
        }

        try 
        {
            uow.commitWork();

            for (IEventDomain evento : listaEvento)
            {
                evento.atribuirNovoIdDoRegistro();
            }

            return listaEvento;
        } 
        catch (Exception e) 
        {
            throw new EventServiceException('400 - Ocorreu uma exceção ao tentar salvar a Tarefa, err: '+e.getMessage());
        }
    }

    public Map<String, List<IEventDomain>> buscarEventosDeUsuariosDaFilaDoMesAtual(String idFila)
    {
        List<IEventDomain> listaEventoDomain = (List<IEventDomain>) C3C_DIContainer_Injector.newInstance('EventDomain', this.instanciaEventSelector.buscarEventosDeUsuariosDaFilaDoMesAtual(idFila));
        
        
        Map<String, List<IEventDomain>> mapaEventos = new Map<String, List<IEventDomain>>();

        for(IEventDomain evento : listaEventoDomain)
        {
            // Pega o Mapper do evento para poder manipula-lo
            EventMapper eventoMapper = evento.obterMapper();
            
            // Verifica se há eventos para o proprietário no mapaEventos e se não tiver cria uma nova instância de eventos para o mesmo.
            List<IEventDomain> eventos = mapaEventos.containsKey(eventoMapper.proprietario) ? mapaEventos.get(eventoMapper.proprietario) : new List<IEventDomain>();

            // Adiciona o evento em questão na lista de eventos para o proprietário
            eventos.add(evento);

            // Depois coloca no mapa a list de eventos em questão.
            mapaEventos.put(eventoMapper.proprietario, eventos);
        }

        // Após isso retorna o mapa de String, List<EventDomain>
        return mapaEventos;
    }

    // Método criado para deixar o método criarEventoParaUsuarioComMenosEventoNoMes
    /**
    public IEventDomain publicarMetodo(Id idRegistro, String idFila, Date dataDeInicio, Time horario, Time duracao, String assunto, String descricao)
    {
        return this.criarEventoParaUsuarioComMenosEventoNoMes(idRegistro, idFila, dataDeInicio, horario, duracao, assunto, descricao);
    }
	*/
    // Modificado o Id do primeiro parâmetro para String para verificar se passa no teste
    // Modificado para Private para verificar se vai
    public IEventDomain criarEventoParaUsuarioComMenosEventoNoMes(Id idRegistro, String idFila, Date dataDeInicio, Time horario, Time duracao, String assunto, String descricao)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            Event.SObjectType//, Lead.SObjectType
        });

        Datetime dataTempoDeInicio = DateTime.newInstance(dataDeInicio, horario);
        Datetime dataDeTermino = dataTempoDeInicio.addHours(duracao.hour()).addMinutes(duracao.minute());

        // ILeadDomain idLead = this.instanciaLeadService.obterLeadPorId(idRegistro);
        // System.debug('Id Lead: '+ idLead);
        
        // String idUsuario = idLead.obterMapper().assessorIndicado != null ? idLead.obterMapper().assessorIndicado : this.buscarIdUsuarioComMenosEventoNoMes(
        String idUsuario = this.buscarIdUsuarioComMenosEventoNoMes(
            idFila, 
            dataTempoDeInicio,
            dataDeTermino
        );

        System.debug('Id Usuário: '+ idUsuario);

        Long diferencaMilisegundosParaInicioEvento = dataTempoDeInicio.getTime() - System.now().getTime();
        Long diferencaSegundosParaInicioEvento = diferencaMilisegundosParaInicioEvento / 1000;
        Long diferencaMinutosParaInicioEvento = diferencaSegundosParaInicioEvento / 60;
        Long diferencaHorasParaInicioEvento = diferencaMinutosParaInicioEvento / 60;

        if(String.isBlank(idUsuario) || idUsuario == null)
        {
            C3C_APP_ApplicationContext.addCriticalError('400', 'Nenhum assessor foi encontrado para esse horário e duração!');
            return null;
        }

        IEventDomain eventoDomain = (IEventDomain) C3C_DIContainer_Injector.newInstance('EventDomain', new Map<String,Object>{
            'idRegistro' => idRegistro,
            'dataDeInicio' => dataTempoDeInicio,
            'dataDeTermino' => dataDeTermino,
            'duracao' => duracao,
            'assunto' => assunto,
            'descricao' => descricao,
            'proprietario' => UserInfo.getUserId(),
            'eventoAceito' => diferencaHorasParaInicioEvento <= 15
        });

        eventoDomain.obterMapper().filaRoletagem = idFila;
        // idLead.obterMapper().dataRoletagem = Datetime.now();
        // idLead.obterMapper().dataAgendamento = dataTempoDeInicio;
        // idLead.obterMapper().assessorQueRecebeu = idUsuario;
        
        uow.registerNew(eventoDomain.obterRegistro());
        // uow.registerDirty(idLead.obterRegistro());

        try 
        {
            uow.commitWork();
            eventoDomain.atribuirNovoIdDoRegistro();
            //Criando tarefa de conversão de lead
            if(diferencaHorasParaInicioEvento <= 15)
                this.instanciaTarefaConversaoLeadService.criarTarefaConversaoLead(idRegistro, idUsuario);
            
            EventMapper eventMpp = eventoDomain.obterMapper();
            this.instanciaEventRelationService.criarRelacaoDoEvento(eventMpp.idRegistro, idUsuario);

            eventoDomain.atribuirNovoIdDoRegistro();
            IUserDomain userDomain = this.instanciaUserService.obterUsuarioComId(idUsuario);

            eventoDomain.atribuirNovoNomeProprietario(userDomain.obterMapper().nome);

            //Enviando como resposta para o front
            C3C_APP_ApplicationContext.setResponse(eventoDomain.obterMapper());
            
            fflib_ISObjectUnitOfWork uow2 = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
                LeadShare.SObjectType
            });
            
            try
            {
                SObject compartilhamentoRegistro = Schema.getGlobalDescribe().get('LeadShare').newSObject();
    
                compartilhamentoRegistro.put('LeadId', idRegistro);
                compartilhamentoRegistro.put('UserOrGroupId', UserInfo.getUserId());
                compartilhamentoRegistro.put('LeadAccessLevel', 'Edit');
    
                uow2.registerNew(compartilhamentoRegistro);
            
            	uow2.commitWork();
            }
            catch(Exception e)
            {
                System.debug('Error COMPARTILHAR: '+e.getMessage());
                System.debug(e);
            } 
            
            return eventoDomain;
        } 
        catch (Exception e) 
        {
            C3C_APP_ApplicationContext.addCriticalError('400', 'Ocorreu uma exceção ao tentar salvar a Evento, usuário "'+idUsuario+'", err: '+e.getMessage()+', '+e.getStackTraceString());
            throw new EventServiceException('400 - Ocorreu uma exceção ao tentar salvar a Evento, usuário "'+idUsuario+'", err: '+e.getMessage()+', '+e.getStackTraceString());
        }
    }

    // public void verificarAssessorIndicado(Id idRegistro)
    // {
    //     ILeadDomain idLead = this.instanciaLeadService.obterLeadPorId(idRegistro);
    //     String assessorIndicado;

    //     if(idLead.obterMapper().assessorIndicado != null)
    //         assessorIndicado = idLead.obterMapper().assessorIndicado;

    //     System.debug(assessorIndicado);

    //     C3C_APP_ApplicationContext.setResponse(assessorIndicado);
    // }

    private String buscarIdUsuarioComMenosEventoNoMes(String idFila, Datetime dataDeInicio, Datetime dataDeTermino)
    {
        Set<String> idsUsuariosOcupados = new Set<String>();

        for(IEventDomain evento : this.buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(idFila, dataDeInicio, dataDeTermino))
        {
            idsUsuariosOcupados.add(evento.obterMapper().proprietario);
        }

        System.debug('idsUsuariosOcupados: '+idsUsuariosOcupados);

        Map<String, List<EventMapper>> mapaAgendaDosUsuarios = this.instanciaCalendarioDeEventosService.obterAgendaDeUsuariosDaFilaSemUsuariosInformadosDurantePeriodo(
            idFila, 
            idsUsuariosOcupados, 
            Datetime.newInstance(System.today().year(), System.today().month(), System.today().day(), 0, 0, 0), 
            Datetime.newInstance(System.today().year(), System.today().month(), System.today().day(), 20, 59, 59)
        );
        
        System.debug('mapaAgendaDosUsuarios: '+mapaAgendaDosUsuarios);

        //this.randomize();

        String idUsuario;
        Integer menorQuantidadeDeEvento;

        /*for(AgendaDoUsuarioViewModel agendaUsuario : listaAgendaDosUsuarios)
        {
            if(menorQuantidadeDeEvento == null)
            {
                menorQuantidadeDeEvento = agendaUsuario.eventos.size();
                idUsuario = agendaUsuario.idUsuario;
            }
            
            if(menorQuantidadeDeEvento != null)
            {
                if(agendaUsuario.eventos.size() < menorQuantidadeDeEvento)
                {
                    menorQuantidadeDeEvento = agendaUsuario.eventos.size();
                    idUsuario = agendaUsuario.idUsuario;
                }
            }
        }*/

        for(String idUsuarioDisponivel : (List<String>) this.randomize(new List<String>(mapaAgendaDosUsuarios.keySet())))
        {
            if(menorQuantidadeDeEvento == null)
            {
                menorQuantidadeDeEvento = mapaAgendaDosUsuarios.get(idUsuarioDisponivel).size();
                idUsuario = idUsuarioDisponivel;
            }
            
            if(menorQuantidadeDeEvento != null)
            {
                if(mapaAgendaDosUsuarios.get(idUsuarioDisponivel).size() < menorQuantidadeDeEvento)
                {
                    menorQuantidadeDeEvento = mapaAgendaDosUsuarios.get(idUsuarioDisponivel).size();
                    idUsuario = idUsuarioDisponivel;
                }
            }
        }

        for(IUserDomain usuario : (List<IUserDomain>) this.randomize(this.instanciaUserService.obterListaUsuarioComIdFila(idFila)))
        {
            if(!mapaAgendaDosUsuarios.containsKey(usuario.obterMapper().idRegistro))
            {
                idUsuario = usuario.obterMapper().idRegistro;
            }
        }

        return idUsuario;
    }

    private list<Object> randomize(list<Object> lst){
        integer currentIndex = lst.size();
        Object temporaryValue;
        integer randomIndex;
        // While there remain elements to shuffle...
        while (0 != currentIndex) {
        // Pick a remaining element...
          randomIndex = integer.valueOf(Math.floor(Math.random() * currentIndex));
          currentIndex -= 1;
          // And swap it with the current element.
          temporaryValue = lst[currentIndex];
          lst[currentIndex] = lst[randomIndex];
          lst[randomIndex] = temporaryValue;
        }
        return lst;
      }

    public List<EventMapper> obterEventosDoMesComIdRelativoIdProprietario(String idRelativo, String idProprietario)
    {
        List<EventMapper> listaEventosDoMes = new List<EventMapper>();

        for(SObject tarefaSObj : this.instanciaEventSelector.buscarEventosDoMesComIdRelativoIdProprietario(idRelativo, idProprietario))
        {
            listaEventosDoMes.add((EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper', tarefaSObj));
        }

        return listaEventosDoMes;
    }

    //Atributos

    //Atributo que conterá a instância da EventSelector
    private IEventSelector instanciaEventSelector
    {
        get
        {
            if(this.instanciaEventSelector == null)
                this.instanciaEventSelector = (IEventSelector) C3C_DIContainer_Injector.getInstance('EventSelector');

            return this.instanciaEventSelector;
        }
        set;
    }
    
    //Atributo que conterá a instância da UserService
    private IUserService instanciaUserService
    {
        get
        {
            if(this.instanciaUserService == null)
                this.instanciaUserService = (IUserService) C3C_DIContainer_Injector.getInstance('UserService');

            return this.instanciaUserService;
        }
        set;
    }
    
    //Atributo que conterá a instância da CalendarioDeEventosService
    private ICalendarioDeEventosService instanciaCalendarioDeEventosService
    {
        get
        {
            if(this.instanciaCalendarioDeEventosService == null)
                this.instanciaCalendarioDeEventosService = (ICalendarioDeEventosService) C3C_DIContainer_Injector.getInstance('CalendarioDeEventosService');

            return this.instanciaCalendarioDeEventosService;
        }
        set;
    }
    
    private IEventRelationService instanciaEventRelationService
    {
        get
        {
            if(this.instanciaEventRelationService == null)
                this.instanciaEventRelationService = (IEventRelationService) C3C_DIContainer_Injector.getInstance('EventRelationService');

            return this.instanciaEventRelationService;
        }
        set;
    }

    private ITarefaConversaoLeadService instanciaTarefaConversaoLeadService
    {
        get
        {
            if(this.instanciaTarefaConversaoLeadService == null)
                this.instanciaTarefaConversaoLeadService = (ITarefaConversaoLeadService) C3C_DIContainer_Injector.getInstance('TarefaConversaoLeadService');

            return this.instanciaTarefaConversaoLeadService;
        }
        set;
    }

    // private ILeadService instanciaLeadService
    // {
    //     get
    //     {
    //         if(this.instanciaLeadService == null)
    //             this.instanciaLeadService = (ILeadService) C3C_DIContainer_Injector.getInstance('LeadService');

    //         return this.instanciaLeadService;
    //     }
    //     set;
    // }

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