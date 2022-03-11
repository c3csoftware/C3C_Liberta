public class LogHTTPRequestDomain extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Config
    public override String getObjectName()
    {
        return 'Log_HttpRequest__c';
    }
    
    //Atributtes
    @AuraEnabled public String recordId 
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
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
    @AuraEnabled public Decimal statusCode 
    {
        get;
        set
        {
            this.statusCode = value;
            this.setValueInRecord('Status_Code__c', value);
        }
    }
    @AuraEnabled public String requestJSON 
    {
        get;
        set
        {
            this.requestJSON = value;
            this.setValueInRecord('Request_JSON__c', value);
        }
    }
    @AuraEnabled public String responseJSON 
    {
        get;
        set
        {
            this.responseJSON = value;
            this.setValueInRecord('Response_JSON__c', value);
        }
    }


    public LogHTTPRequestDomain()
    {}

    private LogHTTPRequestDomain(SObject logHttpRequest)
    {
        this.buildFromRecord(logHttpRequest);
    }

    private LogHTTPRequestDomain(String status, Decimal statusCode, String requestJSON, String responseJSON)
    {
        this.status = status;
        this.statusCode = statusCode;
        this.requestJSON = requestJSON;
        this.responseJSON = responseJSON;
    }

    //Methods
    public Object newInstance(Object params)
    {
        this.initBuild();
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapParams = (Map<String, Object>) params;

            return new LogHTTPRequestDomain((String) mapParams.get('status'), (Decimal) mapParams.get('statusCode'), (String) mapParams.get('requestJSON'), (String) mapParams.get('responseJSON'));
        }

        return new LogHTTPRequestDomain((SObject) params);
    }

    private void buildFromRecord(SObject logHttpRequest)
    {
        this.record = logHttpRequest;

        this.recordId = (String) logHttpRequest.get('Id');
        this.status = (String) logHttpRequest.get('Status__c');
        this.statusCode = (Decimal) logHttpRequest.get('Status_Code__c');
        this.requestJSON = (String) logHttpRequest.get('Request_JSON__c');
        this.responseJSON = (String) logHttpRequest.get('Response_JSON__c');
    }
}