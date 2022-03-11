public class CalloutConfigDomain extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Config
    public override String getObjectName()
    {
        return 'Callout_Config_Sobj__c';
    }

    //Attribute
    @AuraEnabled public string recordId 
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
        }
    }
    
    @AuraEnabled public String token {get;set;}

    @AuraEnabled public String basicAuth 
    {
        get;
        set
        {
            this.basicAuth = value;
            this.setValueInRecord('Basic_Auth__c', value);
        }
    }
    @AuraEnabled public String endPoint 
    {
        get;
        set
        {
            this.endPoint = value;
            this.setValueInRecord('Endpoint__c', value);
        }
    }
    @AuraEnabled public Decimal intervaloDeExecucaoEmDias 
    {
        get;
        set
        {
            this.intervaloDeExecucaoEmDias = value;
            this.setValueInRecord('Intervalo_de_execucao_em_dias__c', value);
        }
    }
    @AuraEnabled public String method 
    {
        get;
        set
        {
            this.method = value;
            this.setValueInRecord('Method__c', value);
        }
    }
    @AuraEnabled public Decimal timeout 
    {
        get;
        set
        {
            this.timeout = value;
            this.setValueInRecord('Timeout__c', value);
        }
    }
    @AuraEnabled public String nomeDoServico 
    {
        get;
        set
        {
            this.nomeDoServico = value;
            this.setValueInRecord('Nome_do_servico__c', value);
        }
    }

    @AuraEnabled public String clientId 
    {
        get
        {
            return EncodingUtil.urlEncode(clientId,'UTF-8');
        }
        private set
        {
            this.clientId = value;
            this.setValueInRecord('Client_ID__c', value);
        }
    }
    @AuraEnabled public String clientSecret 
    {
        get{
            return EncodingUtil.urlEncode(clientSecret,'UTF-8');
        }
        private set
        {
            this.clientSecret = value;
            this.setValueInRecord('Client_Secret__c', value);
        }
    }

    public CalloutConfigDomain()
    {}

    private CalloutConfigDomain(SObject calloutConfig)
    {
        this.buildFromRecord(calloutConfig);
    }

    //Methods
    public Object newInstance(Object params)
    {
        this.initBuild();
        return new CalloutConfigDomain((SObject) params);
    }

    private void buildFromRecord(SObject calloutConfig)
    {
        this.record = calloutConfig;

        this.recordId = (String) calloutConfig.get('Id');

        if(calloutConfig.getSObject('Access_Token_Obj__r') != null)
            this.token = (String) calloutConfig.getSObject('Access_Token_Obj__r').get('Token__c');
        this.basicAuth = (String) calloutConfig.get('Basic_Auth__c');
        this.clientId = (String) calloutConfig.get('Client_ID__c');
        this.clientSecret = (String) calloutConfig.get('Client_Secret__c');
        this.endPoint = (String) calloutConfig.get('Endpoint__c');
        this.intervaloDeExecucaoEmDias = (Decimal) calloutConfig.get('Intervalo_de_execucao_em_dias__c');
        this.method = (String) calloutConfig.get('Method__c');
        this.timeout = (Decimal) calloutConfig.get('Timeout__c');
        this.nomeDoServico = (String) calloutConfig.get('Nome_do_servico__c');
    }
    
}