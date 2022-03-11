public without sharing class InstanciaRespostaDomain implements IInstanciaRespostaDomain, C3C_DI_IProvider
{ 
    //Exception
    public class InstanciaRespostaDomainException extends Exception {}

    //Atributos
    private InstanciaRespostaMapper instanciaRespostaMapper 
    {
        get
        {
            if(this.instanciaRespostaMapper == null)
                this.instanciaRespostaMapper = (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper');

            return this.instanciaRespostaMapper;
        }
        set;
    }

    public Boolean leadConvertido 
    {
        get;
        private set;
    }

    public Boolean respostaPerguntaLeadConvertido 
    {
        get;
        private set;
    }

    //Contrutores
    public InstanciaRespostaDomain() 
    {}
    
    private InstanciaRespostaDomain(SObject instanciaRespostaSObject)
    {
        this.construirDomainComSObject(instanciaRespostaSObject);
    }

    private InstanciaRespostaDomain(Map<String, Object> mapaParametros)
    {
        this.construirDomainComMapa(mapaParametros);
    }

    private InstanciaRespostaDomain(InstanciaRespostaMapper instanciaResposta)
    {
        this.instanciaRespostaMapper = instanciaResposta;
    }

    public void atribuirNovoIdDoRegistro()
    {
        this.instanciaRespostaMapper.idRegistro = this.instanciaRespostaMapper.record.Id;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);

        if(params instanceOf SObject)
            return new InstanciaRespostaDomain((SObject) params);

        if(params instanceOf Map<String, Object>)
            return new InstanciaRespostaDomain((Map<String, Object>) params);

        if(params instanceOf InstanciaRespostaMapper)
            return new InstanciaRespostaDomain((InstanciaRespostaMapper) params);

        return null;
    }

    //Responsável por retornar a mapper
    public InstanciaRespostaMapper obterMapper()
    {
        return this.instanciaRespostaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.instanciaRespostaMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject instanciaRespostaSObject)
    {
        this.instanciaRespostaMapper = (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper', instanciaRespostaSObject);

        this.respostaPerguntaLeadConvertido = this.verificarPerguntaLeadConvertido();

        if(this.respostaPerguntaLeadConvertido)
            this.leadConvertido = this.verificarRespostaSelecionadaComoConvertido();
    }

    //Responsável por construir a domain com Map<String, Object>
    private void construirDomainComMapa(Map<String, Object> mapaParametros)
    {
        this.instanciaRespostaMapper = (InstanciaRespostaMapper) C3C_DIContainer_Injector.newInstance('InstanciaRespostaMapper', mapaParametros);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<InstanciaRespostaDomain> construirListaDomainComListaSObject(List<SObject> listainstanciaRespostasSObject)
    {
        List<InstanciaRespostaDomain> listaDeinstanciaRespostasDomain = new List<InstanciaRespostaDomain>();

        for(SObject instanciaRespostaSObject : listainstanciaRespostasSObject)
            listaDeinstanciaRespostasDomain.add(new InstanciaRespostaDomain(instanciaRespostaSObject));

        return listaDeinstanciaRespostasDomain;
    }

    private Boolean verificarPerguntaLeadConvertido()
    {
        if(obterMapper().perguntaRelacionada == 'Lead Convertido?')
        {
            return true;
        }
        else
        {
            return false;    
        }

        /* 
            Verificar se ordem da pergunta é 1
            E se o nome dela é igual a 'Lead convetido?'
            Se ambas forem verdadeira retornar true
            Se uma delas for false, retornar false
        */
    }

    private Boolean verificarRespostaSelecionadaComoConvertido()
    {
        
            if(obterMapper().respostaAlternativaValor == 'Convertido')
            {
                return true;
            }
            else if(obterMapper().respostaAlternativaValor == 'Não convertido')
            {
                return false;
            }
            else 
            {
                throw new InstanciaRespostaDomainException('Lead não pode ser convertido por falta de POP de conversão');
            }

            /* 
                Verificar se resposta é convertido ou não convertido
                Se não for nenhum dos dois fazer throw new InstanciaRespostaDomainException
                Se for convertido retorna true e se não for retorna false
            */
    }
}