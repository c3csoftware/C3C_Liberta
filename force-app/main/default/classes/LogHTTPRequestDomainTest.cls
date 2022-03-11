@isTest
public class LogHTTPRequestDomainTest {
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    @IsTest
    static void testeNewInstance()
    {
        Log_HttpRequest__c objeto = new Log_HttpRequest__c();
        Log_HttpRequest__c params = new Log_HttpRequest__c();
        
        Test.startTest();

        LogHTTPRequestDomain domain = (LogHTTPRequestDomain) C3C_DIContainer_Injector.newInstance('LogHTTPRequestDomain', objeto);
        Object teste = domain.newInstance(params);
        System.assertNotEquals(null, teste);

        Test.stopTest();
    }
	
    @IsTest
    static void testeBuild()
    {
        Log_HttpRequest__c teste = new Log_HttpRequest__c();
        
        Test.startTest();

        LogHTTPRequestDomain domain = (LogHTTPRequestDomain) C3C_DIContainer_Injector.newInstance('LogHTTPRequestDomain', teste);
        System.assertNotEquals(null, domain);

        Test.stopTest();
    }
    
    @IsTest
    static void testeGet()
    {
        Log_HttpRequest__c teste = new Log_HttpRequest__c();
        
        Test.startTest();

        LogHTTPRequestDomain domain = (LogHTTPRequestDomain) C3C_DIContainer_Injector.newInstance('LogHTTPRequestDomain', teste);
        Log_HttpRequest__c testeRecord = (Log_HttpRequest__c) domain.record;
        System.assertNotEquals(null, testeRecord);

        Test.stopTest();
    }
    
    @IsTest
    static void testeGetDecimal()
    {        
        Test.startTest();

        LogHTTPRequestDomain domain = (LogHTTPRequestDomain) C3C_DIContainer_Injector.newInstance('LogHTTPRequestDomain', new Map<String, Object>
        {
            'status' => null,
            'statusCode' => 1,
            'requestJSON' => null,
            'responseJSON' => null
        });
        Log_HttpRequest__c testeRecord = (Log_HttpRequest__c) domain.record;
        System.assertNotEquals(null, testeRecord);

        Test.stopTest();
    }
}