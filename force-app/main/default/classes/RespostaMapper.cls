public without sharing class RespostaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	public override String getObjectName()
    {
        return 'Resposta__c';
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

    @AuraEnabled public String resposta
    {
        get;
        set
        {
            this.resposta = value;
            this.setValueInRecord('Resposta__c', value);
        }
    }
    
    @AuraEnabled public Boolean habilitarColetaInformacoes
    {
        get;
        set
        {
            this.habilitarColetaInformacoes = value;
            this.setValueInRecord('HabilitarColetaInformacoes__c', value);
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

    @AuraEnabled public String pergunta
    {
        get;
        set
        {
            this.pergunta = value;
            this.setValueInRecord('Pergunta__c', value);
        }
    }
    
    public RespostaMapper()
    {}
    
    private RespostaMapper(SObject objResposta)
    {
        this.initBuild();
        this.construirDomainComSObject(objResposta);
        this.finishBuild();
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new RespostaMapper((SObject) params);

        return null;
    }
    
    public void construirDomainComSObject(SObject objResposta)
    {
        this.record = objResposta;
        
        this.recordId = (String) objResposta.get('Id');
        this.resposta = (String) objResposta.get('Resposta__c');
        this.habilitarColetaInformacoes = (Boolean) objResposta.get('HabilitarColetaInformacoes__c');
        this.ordem = (Decimal) objResposta.get('Ordem__c');
        this.status = (String) objResposta.get('Status__c');
        this.pergunta = (String) objResposta.get('Pergunta__c');
    }
}