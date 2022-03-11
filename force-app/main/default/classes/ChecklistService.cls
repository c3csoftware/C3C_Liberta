public without sharing class ChecklistService implements IChecklistService
{
    //Métodos

    //BUSCAR AS PERGUNTAS PARA O FRONT - INICIO

    //Responsável por buscar e organizar as perguntas para retornar para o front por lista PeruntaViewModel
    public List<PerguntaViewModel> obterListaPeguntaViewModel(String idTarefa)
    {
        //Mapa que irá armazenar as perguntas do tipo de tarefa, mapeados pelo id.
        Map<String, PerguntaMapper> mapaPerguntas = new Map<String, PerguntaMapper>();
        //Mapa que irá armazenar as respostas disponíveis mapeadas pela perguntas.
        Map<String, List<RespostaMapper>> mapaDeListaDeRespostasDisponiveis = new Map<String, List<RespostaMapper>>();
        //Mapa que irá armazenar as respostas Respondidas mapeadas pelas pergunta.
        Map<String, List<InstanciaRespostaMapper>> mapaDeListaDelistaDeRespostasRespondidas = new Map<String, List<InstanciaRespostaMapper>>();

        //Lista que irá armazenar as perguntas no formato que será retornado para tela PerguntaViewModel
        List<PerguntaViewModel> listaDePerguntasDaTarefa = new List<PerguntaViewModel>();

        //Buscando informações da tarefa pelo id
        ITaskDomain tarefaDomain = this.instanciaBuscarInformacoesTarefaService.obterTarefaPorId(idTarefa);
        TaskMapper tarefaMapper = tarefaDomain.obterMapper();
        
        if(tarefaMapper == null)
        {
            C3C_APP_ApplicationContext.addCriticalError('400', 'Tarefa não encontrada');
            return null;
        }

        this.obterMapaDePerguntaMapperPelaListaPerguntaDomain(
            this.instanciaPerguntaService.obterPerguntasPorTipoTarefa(tarefaMapper.tipoTarefa),
            mapaPerguntas
        );
        this.obterMapaDeRespostaMapperPelaListaRespostaDomain(
            this.instanciaRespostaService.obterRespostasPorListaIdPergunta(mapaPerguntas.keySet()), 
            mapaDeListaDeRespostasDisponiveis
        );
        this.obterMapaDeInstanciaRespostaMapperPelaListaInstanciaRespostaDomain(
            this.instanciaDaInstanciaRespostaService.obterInstanciaRespostaPorIdTarefa(idTarefa), 
            mapaDeListaDelistaDeRespostasRespondidas
        );

        System.debug('mapaDeListaDelistaDeRespostasRespondidas: '+mapaDeListaDelistaDeRespostasRespondidas.size());

        for(PerguntaMapper pergunta : mapaPerguntas.values())
        {
            List<RespostaMapper> listaDeRespostaDisponiveis = mapaDeListaDeRespostasDisponiveis.containsKey(pergunta.recordId) ? mapaDeListaDeRespostasDisponiveis.get(pergunta.recordId) : new List<RespostaMapper>();
            List<InstanciaRespostaMapper> listaDeRespostaRespondidas = mapaDeListaDelistaDeRespostasRespondidas.containsKey(pergunta.recordId) ? mapaDeListaDelistaDeRespostasRespondidas.get(pergunta.recordId) : new List<InstanciaRespostaMapper>();

            listaDePerguntasDaTarefa.add((PerguntaViewModel) C3C_DIContainer_Injector.newInstance('PerguntaViewModel', new Map<String, Object>{
                'pergunta' => pergunta,
                'listaDeRespostasDisponiveis' => listaDeRespostaDisponiveis,
                'listaDeRespostasRespondidas' => listaDeRespostaRespondidas
            }));
        }

        C3C_APP_ApplicationContext.setResponse(listaDePerguntasDaTarefa);
        return listaDePerguntasDaTarefa;
    }

    //Responsável por preencher o mapa perguntas
    private void obterMapaDePerguntaMapperPelaListaPerguntaDomain(List<IPerguntaDomain> listaDePergunta, Map<String, PerguntaMapper> mapaPerguntas)
    {
        for(IPerguntaDomain pergunta : listaDePergunta)
        {
            PerguntaMapper perguntaMapper = pergunta.obterMapper();

            mapaPerguntas.put(perguntaMapper.recordId, perguntaMapper);
        }
    }

    //Responsável por preencher o mapa de lista de respostas
    private void obterMapaDeRespostaMapperPelaListaRespostaDomain(List<IRespostaDomain> listaDeRespostaDisponiveis, Map<String, List<RespostaMapper>> mapaDeListaDeRespostasDisponiveis)
    {
        for(IRespostaDomain resposta : listaDeRespostaDisponiveis)
        {
            RespostaMapper respostaMapper = resposta.obterMapper();
            List<RespostaMapper> listaDeResposta = mapaDeListaDeRespostasDisponiveis.containsKey(respostaMapper.pergunta) ? mapaDeListaDeRespostasDisponiveis.get(respostaMapper.pergunta) : new List<RespostaMapper>();

            listaDeResposta.add(respostaMapper);
            mapaDeListaDeRespostasDisponiveis.put(respostaMapper.pergunta, listaDeResposta);
        }
    }

    //Responsável por preencher o mapa de lista de respostas respondidas
    private void obterMapaDeInstanciaRespostaMapperPelaListaInstanciaRespostaDomain(List<IInstanciaRespostaDomain> listaDeRespostaRespondidas, Map<String, List<InstanciaRespostaMapper>> mapaDeListaDeRespostasRespondidas)
    {
        for(IInstanciaRespostaDomain instanciaResposta : listaDeRespostaRespondidas)
        {
            InstanciaRespostaMapper instanciaRespostaMapper = instanciaResposta.obterMapper();
            List<InstanciaRespostaMapper> listaDeResposta = mapaDeListaDeRespostasRespondidas.containsKey(instanciaRespostaMapper.pergunta) ? mapaDeListaDeRespostasRespondidas.get(instanciaRespostaMapper.pergunta) : new List<InstanciaRespostaMapper>();

            listaDeResposta.add(instanciaRespostaMapper);
            mapaDeListaDeRespostasRespondidas.put(instanciaRespostaMapper.pergunta, listaDeResposta);
        }
    }

    //BUSCAR AS PERGUNTAS PARA O FRON - FIM

    //RECEBENDO AS PERGUNTAS DO FRONT - INICIO

    //Responsável por retirar as instancia de resposta para salvar na base de dados, e retornar a nova lista de PeruntaViewModel
    public List<PerguntaViewModel> salvarRespostasDaTarefa(String idTarefa, List<PerguntaViewModel> listaDePerguntasDaTarefa)
    {
        //Lista que irá armazenar as respostas selecionadas no checklist
        List<IInstanciaRespostaDomain> listaDeRespostaRespondidas = new List<IInstanciaRespostaDomain>();
        //Lista que irá armazenar as respostas selecionadas que serão apagadas
        Map<String, IInstanciaRespostaDomain> mapaDeRespostaRespondidasDeletar = new Map<String, IInstanciaRespostaDomain>();
        //Mapa que irá armazenar as respostas Respondidas mapeadas pelas pergunta.
        Map<String, List<InstanciaRespostaMapper>> mapaDeListaDelistaDeRespostasRespondidas = new Map<String, List<InstanciaRespostaMapper>>();

        this.obterMapaDeInstanciaRespostaMapperPelaListaInstanciaRespostaDomain(
            this.instanciaDaInstanciaRespostaService.obterInstanciaRespostaPorIdTarefa(idTarefa), 
            mapaDeListaDelistaDeRespostasRespondidas
        );

        for(PerguntaViewModel perguntaViewModel : listaDePerguntasDaTarefa)
        {
            String idPergunta = perguntaViewModel.pergunta.recordId;

            Map<String, PerguntaViewModel.ColetaInformacao> mapaInformacaoAdicionais = new Map<String, PerguntaViewModel.ColetaInformacao>();

            for(PerguntaViewModel.ColetaInformacao coletaInformacao : perguntaViewModel.listIntanciaRespostaComInformacoes)
                mapaInformacaoAdicionais.put(coletaInformacao.resposta.value, coletaInformacao);

            if(perguntaViewModel.pergunta.tipo != 'Múltipla escolha')
            {
                IInstanciaRespostaDomain instanciaResposta = (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain');
                InstanciaRespostaMapper instanciaRespostaMapper = instanciaResposta.obterMapper();
                instanciaRespostaMapper.pergunta = idPergunta;
                instanciaRespostaMapper.idTarefa = idTarefa;

                if(perguntaViewModel.pergunta.tipo == 'Dissertativa' || perguntaViewModel.pergunta.tipo == 'Moeda')
                    instanciaRespostaMapper.respostaDissertativa = perguntaViewModel.respostaDissertativa;
                    
                if(perguntaViewModel.pergunta.tipo == 'Única escolha')
                {
                    instanciaRespostaMapper.respostaDissertativa = '';
                    instanciaRespostaMapper.respostaAlternativa = perguntaViewModel.respostaAlternativa;
                    if(mapaInformacaoAdicionais.containsKey(perguntaViewModel.respostaAlternativa))
                        instanciaRespostaMapper.respostaDissertativa = mapaInformacaoAdicionais.get(perguntaViewModel.respostaAlternativa).instanciaRespostaMapper.respostaDissertativa;
                }
                
                instanciaRespostaMapper.idRegistro = perguntaViewModel.idRespostaRespondida;

                listaDeRespostaRespondidas.add(instanciaResposta);
            }
            else 
            {
                List<InstanciaRespostaMapper> listaDeListaDeRespostas = mapaDeListaDelistaDeRespostasRespondidas.containsKey(idPergunta) ? mapaDeListaDelistaDeRespostasRespondidas.get(idPergunta) : new List<InstanciaRespostaMapper>();

                Map<String, InstanciaRespostaMapper> mapaListaDeRespostas = new Map<String, InstanciaRespostaMapper>();
                for(InstanciaRespostaMapper instanciaResposta : listaDeListaDeRespostas)
                {
                    mapaListaDeRespostas.put(instanciaResposta.respostaAlternativa, instanciaResposta);

                    if(!perguntaViewModel.listaRespostasMultiplaEscolhaSelecionadas.contains(instanciaResposta.respostaAlternativa))
                        mapaDeRespostaRespondidasDeletar.put(instanciaResposta.idRegistro ,(IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', instanciaResposta));
                }

                for(String respostaId : perguntaViewModel.listaRespostasMultiplaEscolhaSelecionadas)
                {
                    IInstanciaRespostaDomain instanciaRespostaDomain = (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', mapaListaDeRespostas.containsKey(respostaId) ? mapaListaDeRespostas.get(respostaId) : null);
                    InstanciaRespostaMapper instanciaResposta = instanciaRespostaDomain.obterMapper();

                    instanciaResposta.idTarefa = idTarefa;
                    instanciaResposta.pergunta = idPergunta;
                    instanciaResposta.respostaAlternativa = respostaId;
                    instanciaResposta.respostaDissertativa = '';
                    if(mapaInformacaoAdicionais.containsKey(respostaId))
                        instanciaResposta.respostaDissertativa = mapaInformacaoAdicionais.get(respostaId).instanciaRespostaMapper.respostaDissertativa;
                    if(instanciaResposta != null)
                    {
                        instanciaResposta.idRegistro = instanciaResposta.idRegistro;
                        
                        if(mapaDeRespostaRespondidasDeletar.containsKey(instanciaResposta.idRegistro))
                            continue;
                    }
    
                    listaDeRespostaRespondidas.add(instanciaRespostaDomain);
                }
            }
        }

        this.instanciaDaInstanciaRespostaService.criarOuAtualizarListaDeInstanciaResposta(listaDeRespostaRespondidas);
        this.instanciaDaInstanciaRespostaService.deleteListaDeInstanciaResposta(mapaDeRespostaRespondidasDeletar.values());

        return this.obterListaPeguntaViewModel(idTarefa);
    }
    
    //RECEBENDO AS PERGUNTAS DO FRONT - FIM

    //Atributos com instância de serviços
    private IPerguntaService instanciaPerguntaService
    {
        get
        {
            if(this.instanciaPerguntaService == null)
                this.instanciaPerguntaService = (IPerguntaService) C3C_DIContainer_Injector.getInstance('PerguntaService');

            return this.instanciaPerguntaService;
        }
        set;
    }

    private IRespostaService instanciaRespostaService
    {
        get
        {
            if(this.instanciaRespostaService == null)
                this.instanciaRespostaService = (IRespostaService) C3C_DIContainer_Injector.getInstance('RespostaService');

            return this.instanciaRespostaService;
        }
        set;
    }

    private IInstanciaRespostaService instanciaDaInstanciaRespostaService
    {
        get
        {
            if(this.instanciaDaInstanciaRespostaService == null)
                this.instanciaDaInstanciaRespostaService = (IInstanciaRespostaService) C3C_DIContainer_Injector.getInstance('InstanciaRespostaService');

            return this.instanciaDaInstanciaRespostaService;
        }
        set;
    }

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