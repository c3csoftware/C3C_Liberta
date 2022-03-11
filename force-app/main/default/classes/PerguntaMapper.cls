public without sharing class PerguntaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	public override String getObjectName()
    {
        return 'Pergunta__c';
    }
    
    //Atributos
    @AuraEnabled public String recordId
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
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
    
    @AuraEnabled public Boolean obrigatorio
    {
        get;
        set
        {
            this.obrigatorio = value;
            this.setValueInRecord('Obrigatorio__c', value);
        }
    }
    
    @AuraEnabled public Decimal ordem
    {
        get;
        set
        {
            this.ordem = value;
            this.setValueInRecord('Ordem__c', value);
        }
    }
    
    @AuraEnabled public String status
    {
        get;
        set
        {
            this.status = value;
            this.setValueInRecord('Status__c', value);
        }
    }
    
    @AuraEnabled public String tipo
    {
        get;
        set
        {
            this.tipo = value;
            this.setValueInRecord('Tipo__c', value);
        }
    }
    
    @AuraEnabled public String tipoTarefa
    {
        get;
        set;
    }

    @AuraEnabled public Boolean atualizarCampoSObject
    {
        get;
        set
        {
            this.atualizarCampoSObject = value;
            this.setValueInRecord('AtualizarCampoSObject__c', value);
        }
    }

    @AuraEnabled public String nomeAPICampoAtualizacaoCampo
    {
        get;
        set
        {
            this.nomeAPICampoAtualizacaoCampo = value;
            this.setValueInRecord('NomeAPICampoAtualizacaoCampo__c', value);
        }
    }

    @AuraEnabled public String nomeAPIObjetoAtualizacaoCampo
    {
        get;
        set
        {
            this.nomeAPIObjetoAtualizacaoCampo = value;
            this.setValueInRecord('NomeAPIObjetoAtualizacaoCampo__c', value);
        }
    }

    @AuraEnabled public String perguntaRelacionada
    {
        get;
        set
        {
            this.perguntaRelacionada = value;
            this.setValueInRecord('PerguntaRelacionada__c', value);
        }
    }
    
    @AuraEnabled public String respostaRelacionada
    {
        get;
        set
        {
            this.respostaRelacionada = value;
            this.setValueInRecord('RespostaRelacionada__c', value);
        }
    }

    @AuraEnabled public Boolean perguntaRelacionadaPergunta
    {
        get;
        set
        {
            this.perguntaRelacionadaPergunta = value;
            this.setValueInRecord('PerguntaRelacionadaPergunta__c', value);
        }
    }
    
    @AuraEnabled public String tipoTipoDeTarefa{get; set;}
    
    public PerguntaMapper()
    {}
    
    private PerguntaMapper(SObject objPergunta)
    {
        this.initBuild();
        this.construirDomainComSObject(objPergunta);
        this.finishBuild();
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new PerguntaMapper((SObject) params);

        return null;
    }
    
    public void construirDomainComSObject(SObject objPergunta)
    {
        this.record = objPergunta;
        
        this.recordId = (String) objPergunta.get('Id');
        this.pergunta = (String) objPergunta.get('Pergunta__c');
        this.obrigatorio = (Boolean) objPergunta.get('Obrigatorio__c');
        this.ordem = (Decimal) objPergunta.get('Ordem__c');
        this.status = (String) objPergunta.get('Status__c');
        this.tipo = (String) objPergunta.get('Tipo__c');
        this.tipoTarefa = (String) objPergunta.get('TipoTarefa__c');

        this.atualizarCampoSObject = (Boolean) objPergunta.get('AtualizarCampoSObject__c');
        this.nomeAPICampoAtualizacaoCampo = (String) objPergunta.get('NomeAPICampoAtualizacaoCampo__c');
        this.nomeAPIObjetoAtualizacaoCampo = (String) objPergunta.get('NomeAPIObjetoAtualizacaoCampo__c');

        this.perguntaRelacionada = (String) objPergunta.get('PerguntaRelacionada__c');
        this.respostaRelacionada = (String) objPergunta.get('RespostaRelacionada__c');
        this.perguntaRelacionadaPergunta = (Boolean) objPergunta.get('PerguntaRelacionadaPergunta__c');

        if(objPergunta.getSObject('TipoTarefa__r') != null)
            this.tipoTipoDeTarefa = (String) objPergunta.getSObject('TipoTarefa__r').get('Tipo__c');
    }
}