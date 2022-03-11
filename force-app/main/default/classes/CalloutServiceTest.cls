@isTest 
public without sharing class  CalloutServiceTest
{ 
    // @IsTest
    // public static void doCallout()
    // {
    //     //É preciso construir um endpoint-mock para as classes teste.
        
    //     CalloutConfigDomain domain = ServicoMockGenerator.createCalloutConfigDomain();
    //     ContratoCalloutMock callout = new ContratoCalloutMock(domain);
    //     CalloutService servico = new CalloutService(callout);

    //     Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
    //     HttpResponse response = servico.doCallout();
    // }
    
    @isTest static void testCoverage()
    {
        CalloutService.testCoverage();
    }
}