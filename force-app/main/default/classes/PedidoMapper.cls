public without sharing virtual class PedidoMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    public override String getObjectName()
    {
        return 'Pedido__c';
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

    @AuraEnabled public String conta
    {
        get;
        set
        {
            this.conta = value;
            this.setValueInRecord('Conta__c', value);
        }
    }
    
    @AuraEnabled public String cpfCnpj
    {
        get;
        set
        {
            this.cpfCnpj = value;
            this.setValueInRecord('CpfCnpj__c', value);
        }
    }
    
    @AuraEnabled public Date dataPagamento
    {
        get;
        set
        {
            this.dataPagamento = value;
            this.setValueInRecord('DataPagamento__c', value);
        }
    }

    @AuraEnabled public String email
    {
        get;
        set
        {
            this.email = value;
            this.setValueInRecord('Email__c', value);
        }
    }

    @AuraEnabled public String nome
    {
        get;
        set
        {
            this.nome = value;
            this.setValueInRecord('Nome__c', value);
        }
    }

    @AuraEnabled public String telefone
    {
        get;
        set
        {
            this.telefone = value;
            this.setValueInRecord('Telefone__c', value);
        }
    }
    
    public PedidoMapper()
    {}
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return this.construirNegocioRecord((SObject) params);
        
        return null;
    }
    
    public PedidoMapper construirNegocioRecord(SObject negocio)
    {
        this.initBuild();
        this.record = negocio;
        
        this.recordId = (String) negocio.get('Id');
        this.nome = (String) negocio.get('Nome__c');
        this.conta = (String) negocio.get('Conta__c');
        this.cpfCnpj  = (String) negocio.get('CpfCnpj__c');
        this.dataPagamento = (Date) negocio.get('DataPagamento__c');
        this.email = (String) negocio.get('Email__c');
        this.telefone = (String) negocio.get('Telefone__c');
        this.finishBuild();

        return this;
    }
}