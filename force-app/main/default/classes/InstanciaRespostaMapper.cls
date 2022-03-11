public without sharing class InstanciaRespostaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider 
{
    //Método que define o objeto no qual a Mapper é relacionado
    public override String getObjectName()
    {
        return 'InstanciaResposta__c';
    }

    //Atributos
    @AuraEnabled public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    //Atributos
    @AuraEnabled public String idTarefa
    {
        get;
        set
        {
            this.idTarefa = value;
            this.setValueInRecord('idTarefa__c', value);
        }
    }
    
    @AuraEnabled public String pergunta
    {
        get;
        set
        {
            this.pergunta = value;
            this.setValueInRecord('Pergunta__c', value);
        }
    }
    
    @AuraEnabled public String respostaDissertativa
    {
        get;
        set
        {
            this.respostaDissertativa = value;
            this.setValueInRecord('RespostaDissertativa__c', value);
        }
    }
    
    @AuraEnabled public String respostaAlternativa
    {
        get;
        set
        {
            this.respostaAlternativa = value;
            this.setValueInRecord('RespostaAlternativa__c', value);
        }
    }

    @AuraEnabled public String leadRelacionado
    {
        get;
        set
        {
            this.leadRelacionado = value;
            this.setValueInRecord('Lead__c', value);
        }
    }

    @AuraEnabled public Decimal ordemPergunta
    {
        get;
        set
        {
            this.ordemPergunta = value;
            this.setValueInRecord('Pergunta__r.Ordem__c', value);
        }
    }

    @AuraEnabled public String respostaRelacionada
    {
        get;
        set
        {
            this.respostaRelacionada = value;
            this.setValueInRecord('Pergunta__r.RespostaRelacionada__c', value);
        }
    }

    @AuraEnabled public String perguntaRelacionada
    {
        get;
        set
        {
            this.perguntaRelacionada = value;
            this.setValueInRecord('Pergunta__r.Pergunta__c', value);
        }
    }
    
    @AuraEnabled public String respostaAlternativaValor {get;set;}

    @AuraEnabled public String casoId
    {
        get;
        set
        {
            this.casoId = value;
            this.setValueInRecord('Caso__c', value);
        }
    }
    
    @AuraEnabled public String contaId
    {
        get;
        set
        {
            this.contaId = value;
            this.setValueInRecord('Conta__c', value);
        }
    }

    @AuraEnabled public String leadId
    {
        get;
        set
        {
            this.leadId = value;
            this.setValueInRecord('Lead__c', value);
        }
    }

    @AuraEnabled public String oportunidadeId
    {
        get;
        set
        {
            this.oportunidadeId = value;
            this.setValueInRecord('Oportunidade__c', value);
        }
    }

    //Construtores
    public InstanciaRespostaMapper()
    {}
    
    private InstanciaRespostaMapper(SObject instanciaRespostaSObject)
    {
        //Sinalizando que iniciou a construção da instância para não preencher o record pelo "setValueInRecord"
        this.initBuild();
        this.construirDomainComSObject(instanciaRespostaSObject);
        this.finishBuild();
    }

    private InstanciaRespostaMapper(
        String idRegistro,
        String pergunta,
        String respostaAlternativa,
        String respostaDissertativa
    )
    {
        this.idRegistro = idRegistro;
        this.pergunta = pergunta;
        this.respostaAlternativa = respostaAlternativa;
        this.respostaDissertativa = respostaDissertativa;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new InstanciaRespostaMapper((SObject) params);

        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametros = (Map<String, Object>) params;

            return new InstanciaRespostaMapper(
                (String) mapaParametros.get('idRegistro'),
                (String) mapaParametros.get('pergunta'),
                (String) mapaParametros.get('respostaAlternativa'),
                (String) mapaParametros.get('respostaDissertativa')
            );
        }

        return null;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject instanciaRespostaSObject)
    {
        this.record = instanciaRespostaSObject;

        this.idRegistro = (String) instanciaRespostaSObject.get('Id');
        this.idTarefa = (String) instanciaRespostaSObject.get('idTarefa__c');
        this.pergunta = (String) instanciaRespostaSObject.get('Pergunta__c');
        this.respostaDissertativa = (String) instanciaRespostaSObject.get('RespostaDissertativa__c');
        this.respostaAlternativa = (String) instanciaRespostaSObject.get('RespostaAlternativa__c');
        this.respostaAlternativaValor = (String) instanciaRespostaSObject.get('RespostaAlternativaValor__c');
        System.debug(LoggingLevel.ERROR, 'Resposta Alternativa Valor: ' + respostaAlternativaValor);
        this.leadRelacionado = (String) instanciaRespostaSObject.get('Lead__c');

        if(instanciaRespostaSObject.getSObject('Pergunta__r') != null)
            this.ordemPergunta = (Decimal) instanciaRespostaSObject.getSObject('Pergunta__r').get('Ordem__c');

        if(instanciaRespostaSObject.getSObject('Pergunta__r') != null)
            this.respostaRelacionada = (String) instanciaRespostaSObject.getSObject('Pergunta__r').get('RespostaRelacionada__c');
        

        if(instanciaRespostaSObject.getSObject('Pergunta__r') != null)
            this.perguntaRelacionada = (String) instanciaRespostaSObject.getSObject('Pergunta__r').get('Pergunta__c');

        this.casoId = (String) instanciaRespostaSObject.get('Caso__c');
        this.contaId = (String) instanciaRespostaSObject.get('Conta__c');
        this.leadId = (String) instanciaRespostaSObject.get('Lead__c');
        this.oportunidadeId = (String) instanciaRespostaSObject.get('Oportunidade__c');
    }
}