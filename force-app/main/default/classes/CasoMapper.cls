public without sharing virtual class CasoMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    public override String getObjectName()
    {
        return 'Case';
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

    @AuraEnabled public String assessorQueRequisitou
    {
        get;
        set
        {
            this.assessorQueRequisitou = value;
            this.setValueInRecord('AssessorQueRequisitouCaso__c', value);
        }
    }

    @AuraEnabled public Datetime dataFechamento
    {
        get;
        set
        {
            this.dataFechamento = value;
            this.setValueInRecord('ClosedDate', value);
        }
    }

    @AuraEnabled public String proprietario
    {
        get;
        set
        {
            this.proprietario = value;
            this.setValueInRecord('OwnerId', value);
        }
    }

    @AuraEnabled public String origem
    {
        get;
        set
        {
            this.origem = value;
            this.setValueInRecord('Origin', value);
        }
    }

    @AuraEnabled public String status
    {
        get;
        set
        {
            this.status = value;
            this.setValueInRecord('Status', value);
        }
    }

    @AuraEnabled public String categoria
    {
        get;
        set
        {
            this.categoria = value;
            this.setValueInRecord('CategoriaAtendimento__c', value);
        }
    }

    @AuraEnabled public String numeroCaso
    {
        get;
        set
        {
            this.numeroCaso = value;
            this.setValueInRecord('CaseNumber', value);
        }
    }

    @AuraEnabled public String subCategoria
    {
        get;
        set
        {
            this.subCategoria = value;
            this.setValueInRecord('TipoAtendimento__c', value);
        }
    }

    @AuraEnabled public Decimal vezesCasosReaberto
    {
        get;
        set
        {
            this.vezesCasosReaberto = value;
            this.setValueInRecord('VezesCasoReaberto__c', value);
        }
    }

    public CasoMapper()
    {}
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return this.construirCasoMapperRecord((SObject) params);
        
        return null;
    }
    
    public CasoMapper construirCasoMapperRecord(SObject caso)
    {
        this.initBuild();
        this.record = caso;
        
        this.recordId = (String) caso.get('Id');
        this.assessorQueRequisitou = (String) caso.get('AssessorQueRequisitouCaso__c');
        this.dataFechamento = (Datetime) caso.get('ClosedDate');
        this.proprietario = (String) caso.get('OwnerId');
        this.origem = (String) caso.get('Origin');
        this.status = (String) caso.get('Status');
        this.categoria = (String) caso.get('CategoriaAtendimento__c');
        this.subCategoria = (String) caso.get('TipoAtendimento__c');
        this.numeroCaso = (String) caso.get('CaseNumber');
        this.vezesCasosReaberto = (Decimal) caso.get('VezesCasoReaberto__c');
        this.finishBuild();

        return this;
    }
}