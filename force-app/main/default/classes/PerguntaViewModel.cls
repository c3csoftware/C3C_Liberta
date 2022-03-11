public without sharing class PerguntaViewModel implements C3C_DI_IProvider
{
    //Classe responsável por ser o modelo da pergunta para o front

    //Atributos
    @AuraEnabled
    public PerguntaMapper pergunta {get;set;}
    @AuraEnabled
    public List<RespostaViewModel> listaDeRespostas {get;set;}
    @AuraEnabled
    public List<ColetaInformacao> listIntanciaRespostaComInformacoes
    {
        get
        {
            if(this.listIntanciaRespostaComInformacoes == null)
                this.listIntanciaRespostaComInformacoes = new List<ColetaInformacao>();

            return this.listIntanciaRespostaComInformacoes;
        }
        set;
    }


    //RESPOSTAS RESPONDIDAS
    @AuraEnabled
    public String respostaAlternativa {get;set;}
    @AuraEnabled
    public List<String> listaRespostasMultiplaEscolhaSelecionadas 
    {
        get
        {
            if(this.listaRespostasMultiplaEscolhaSelecionadas == null)
                this.listaRespostasMultiplaEscolhaSelecionadas = new List<String>();

            return this.listaRespostasMultiplaEscolhaSelecionadas;
        }
        set;
    }
    @AuraEnabled
    public String respostaDissertativa {get;set;}
    @AuraEnabled 
    public String idRespostaRespondida {get;set;}

    //Construtores
    public PerguntaViewModel()
    {}

    private PerguntaViewModel(
        PerguntaMapper pergunta,
        List<RespostaMapper> listaDeRespostasDisponiveis,
        List<InstanciaRespostaMapper> listaDeRespostasRespondidas
    )
    {
        this.construirPerguntaViewModel(
            pergunta,
            listaDeRespostasDisponiveis,
            listaDeRespostasRespondidas
        );
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametro = (Map<String, Object>) params;

            return new PerguntaViewModel(
                (PerguntaMapper) mapaParametro.get('pergunta'), 
                (List<RespostaMapper>) mapaParametro.get('listaDeRespostasDisponiveis'), 
                (List<InstanciaRespostaMapper>) mapaParametro.get('listaDeRespostasRespondidas')
            );
        }

        return null;
    }

    private void construirPerguntaViewModel(
        PerguntaMapper pergunta,
        List<RespostaMapper> listaDeRespostasDisponiveis,
        List<InstanciaRespostaMapper> listaDeRespostasRespondidas
    )
    {
        //Armazena a pergunta no atributo
        this.pergunta = pergunta;

        //Mapa para organizar as respostas Respondidas pelo id da resposta
        Map<String, InstanciaRespostaMapper> mapaInstanciaRespostaPorResposta = new Map<String, InstanciaRespostaMapper>();
        //Lista que irá armazenar a lista de resposta view model organizadas
        List<RespostaViewModel> listaDeRespostas = new List<RespostaViewModel>();

        for(InstanciaRespostaMapper instanciaResposta : listaDeRespostasRespondidas)
        {
            if(pergunta.tipo == 'Dissertativa' || pergunta.tipo == 'Moeda')
                this.respostaDissertativa = instanciaResposta.respostaDissertativa;

            if(pergunta.tipo == 'Única escolha')
                this.respostaAlternativa = instanciaResposta.respostaAlternativa;

            if(pergunta.tipo == 'Múltipla escolha')
                this.listaRespostasMultiplaEscolhaSelecionadas.add(instanciaResposta.respostaAlternativa);
            else
                this.idRespostaRespondida = instanciaResposta.idRegistro;

            mapaInstanciaRespostaPorResposta.put(instanciaResposta.respostaAlternativa, instanciaResposta);
        }

        for(RespostaMapper respostaDisponivel : listaDeRespostasDisponiveis)
        {
            Boolean respondida = mapaInstanciaRespostaPorResposta.containsKey(respostaDisponivel.recordId);
            
            RespostaViewModel resposta = new RespostaViewModel(
                respostaDisponivel.resposta,
                respostaDisponivel.recordId
            );

            resposta.habilitarColetaInformacoes = respostaDisponivel.habilitarColetaInformacoes;

            if(respondida)
            {
                InstanciaRespostaMapper instanciaResposta = mapaInstanciaRespostaPorResposta.get(respostaDisponivel.recordId);

                if(pergunta.tipo != 'Dissertativa' || pergunta.tipo != 'Moeda')
                    resposta.idRespostaRespondida = instanciaResposta.idRegistro;
            
                if(respostaDisponivel.habilitarColetaInformacoes)
                    listIntanciaRespostaComInformacoes.add(new ColetaInformacao(resposta, instanciaResposta));
            }

            listaDeRespostas.add(resposta);
        }

        this.listaDeRespostas = listaDeRespostas;
        this.listIntanciaRespostaComInformacoes = listIntanciaRespostaComInformacoes;
    }

    //Classe responsável por organizar as respostas Respondidas com as disponíveis
    public class RespostaViewModel
    {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled 
        public String value {get;set;}
        @AuraEnabled 
        public String idRespostaRespondida {get;set;}
        @AuraEnabled 
        public Boolean habilitarColetaInformacoes 
        {
            get
            {
                if(this.habilitarColetaInformacoes == null)
                    this.habilitarColetaInformacoes = false;

                return this.habilitarColetaInformacoes;
            }
            set;
        }

        public RespostaViewModel(
            String label,
            String value
        )
        {
            this.label = label;
            this.value = value;
        }
    }

    public class ColetaInformacao
    {
        @AuraEnabled
        public RespostaViewModel resposta {get;set;}
        @AuraEnabled
        public InstanciaRespostaMapper instanciaRespostaMapper {get;set;}
        
        public ColetaInformacao(
            RespostaViewModel resposta,
            InstanciaRespostaMapper instanciaRespostaMapper
        )
        {
            this.resposta = resposta;
            this.instanciaRespostaMapper = instanciaRespostaMapper;
        }
    }
}