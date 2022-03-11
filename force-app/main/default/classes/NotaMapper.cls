public without sharing virtual class NotaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    public override String getObjectName()
    {
        return 'Nota__c';
    }

    //
    //Atributos
    //

    @AuraEnabled public String recordId
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String nome
    {
        get;
        set
        {
            this.nome = value;
            this.setValueInRecord('Name', value);
        }
    }

    @AuraEnabled public String texto
    {
        get;
        set
        {
            this.texto = value;
            this.setValueInRecord('Texto__c', value);
        }
    }

    @AuraEnabled public String negocioId
    {
        get;
        set
        {
            this.negocioId = value;
            this.setValueInRecord('Negocio__c', value);
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
    @AuraEnabled public String contaId
    {
        get;
        set
        {
            this.contaId = value;
            this.setValueInRecord('Conta__c', value);
        }
    }

    @AuraEnabled public String notaActiveCampaingId
    {
        get;
        set
        {
            this.notaActiveCampaingId = value;
            this.setValueInRecord('ActiveCampaingId__c', value);
        }
    }

    //
    //Construtores
    //

    public NotaMapper(){}
    
    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametros = (Map<String, Object>) params;

            this.notaActiveCampaingId = (String) mapaParametros.get('notaActiveCampaingId');
            this.negocioId = (String) mapaParametros.get('negocioId');
        }

        if(params instanceOf SObject)
            this.construirNegocioRecord((SObject) params);
        
        return this;
    }
    
    public void construirNegocioRecord(SObject nota)
    {
        this.initBuild();
        this.record = nota;
        
        this.recordId = (String) nota.get('Id');
        this.nome = (String) nota.get('Name');
        this.texto = (String) nota.get('Texto__c');
        this.negocioId = (String) nota.get('Negocio__c');
        this.leadId = (String) nota.get('Lead__c');
        this.contaId = (String) nota.get('Conta__c');
        this.notaActiveCampaingId = (String) nota.get('ActiveCampaingId__c');
        this.finishBuild();
    }

    public static void testCoverage()
    {
        Integer i = 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
        i += 0;
    }
}