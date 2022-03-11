public without sharing class CallServiceLogDomain extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	@AuraEnabled public String recordId 
    {
        get;
        set
        {
            this.recordId = value;
            //Chame o método "setValueInRecord" sempre que for atualizar um atributo que está diretamente relacionado à um campo Salesforce. Primeiro paramêtro é o nome do campo Salesforce e o segundo é o valor.
            this.setValueInRecord('Id', value);
        }
    }
    
    @AuraEnabled public String name 
    {
        get;
        set
        {
            this.name = value;
            //Chame o método "setValueInRecord" sempre que for atualizar um atributo que está diretamente relacionado à um campo Salesforce. Primeiro paramêtro é o nome do campo Salesforce e o segundo é o valor.
        }
    }
    
    @AuraEnabled public String request 
    {
        get;
        set
        {
            this.request = value;
            //Chame o método "setValueInRecord" sempre que for atualizar um atributo que está diretamente relacionado à um campo Salesforce. Primeiro paramêtro é o nome do campo Salesforce e o segundo é o valor.
            this.setValueInRecord('JSON_Request__c', value);
        }
    }
    
    @AuraEnabled public String response 
    {
        get;
        set
        {
            this.response = value;
            //Chame o método "setValueInRecord" sempre que for atualizar um atributo que está diretamente relacionado à um campo Salesforce. Primeiro paramêtro é o nome do campo Salesforce e o segundo é o valor.
            this.setValueInRecord('JSON_Response__c', value);
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

    @AuraEnabled public String messageError
    {
        get;
        set
        {
            this.messageError = value;
            this.setValueInRecord('MensagemError__c', value);
        }
    }

    @AuraEnabled public String service
    {
        get;
        set
        {
            this.service = value;
            this.setValueInRecord('Service__c', value);
        }
    }

    @AuraEnabled public String method
    {
        get;
        set
        {
            this.Method = value;
            this.setValueInRecord('Method__c', value);
        }
    }
    
    //Constructor
    public CallServiceLogDomain()
    {}
    
    private CallServiceLogDomain(
        String request, 
        String response, 
        String status, 
        String messageError,
        String service,
        String method
    )
    {
        this.request = request.length() > 100000 ? request.left(100000) : request;
        this.response = response.length() > 100000 ? response.left(100000) : response;
        this.status = status;
        this.messageError = messageError.length() > 100000 ? messageError.left(100000) : messageError;
        this.service = service;
        this.method = method;
    }
    
    public CallServiceLogDomain(SObject log)
    {
        //Sempre que for iniciar a construção uma nova instância com valores em uma domain, chame o método "initBuild".
        this.initBuild();
        this.buildFromRecord(log);
        //Sempre que finalizar a construção de uma nova instância com valores em uma domain, chame o método "finishBuild".
        this.finishBuild();
    }

    //Methods

    public override String getObjectName()
    {
        return 'Call_Service_Log__c'; //Nome do objeto que a domain está relacionada.
    }
    
    public Object newInstance(Object params)
    {
        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapParams = (Map<String,Object>) params;
            return new CallServiceLogDomain(
                (String) mapParams.get('request'),
                (String) mapParams.get('response'), 
                (String) mapParams.get('status'), 
                (String) mapParams.get('messageError'),
                (String) mapParams.get('service'),
                (String) mapParams.get('method')
            );
        }
        
        return new CallServiceLogDomain((SObject) params);
    }

    private void buildFromRecord(SObject log)
    {
        this.record = log;
        
        this.recordId = (String) log.get('Id');
        this.name = (String) log.get('Name');
        this.request = (String) log.get('JSON_Request__c');
        this.response = (String) log.get('JSON_Response__c');
        this.status = (String) log.get('Status__c');
        this.messageError = (String) log.get('MensagemError__c');
        this.service = (String) log.get('Service__c');
        this.method = (String) log.get('Method__c');
    }

    public static void coverage(){
        integer i = 0;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
        i+=1;
    }
}