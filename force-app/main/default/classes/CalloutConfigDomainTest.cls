@isTest
public class  CalloutConfigDomainTest {

    @IsTest
    static void testeNewInstance()
    {
        Callout_Config_Sobj__c objeto = new Callout_Config_Sobj__c();
        Callout_Config_Sobj__c params = new Callout_Config_Sobj__c();
        
        Test.startTest();

        CalloutConfigDomain domain = (CalloutConfigDomain) C3C_DIContainer_Injector.newInstance('CalloutConfigDomain', objeto);
        Object teste = domain.newInstance(params);
        System.assertNotEquals(null, teste);

        Test.stopTest();
    }

    @isTest
    static void testResponse()
    {
        //*Given
        Callout_Config_Sobj__c config = ServicoMockGenerator.createCalloutConfig();
        //*When
        CalloutConfigDomain domain = (CalloutConfigDomain) C3C_DIContainer_Injector.newInstance('CalloutConfigDomain', config);
        //*Then
        System.Assert( domain.record.get('Client_ID__c') == EncodingUtil.urlEncode('ClientId','UTF-8'), 'Test failed when ClientId: ' + EncodingUtil.urlEncode('ClientId','UTF-8'));
    }

    @isTest
    static void testGet()
    {
        //*Given
        Callout_Config_Sobj__c config = ServicoMockGenerator.createCalloutConfig();
        //*When
        CalloutConfigDomain domain = (CalloutConfigDomain) C3C_DIContainer_Injector.newInstance('CalloutConfigDomain', config);
        //*Then
        System.Assert( domain.record.get('Client_Secret__c') == EncodingUtil.urlEncode('121','UTF-8'), 'Test failed when secret: ' + EncodingUtil.urlEncode('121','UTF-8')  );
    }
}