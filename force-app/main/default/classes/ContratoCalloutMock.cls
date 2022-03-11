public without sharing class  ContratoCalloutMock extends CalloutContract
{    
    public ContratoCalloutMock(CalloutConfigDomain config)
    {
        super(config);
    }
    
    public override Object getReturn(System.HttpResponse response)
    {
        return response.getBody();
    }
}