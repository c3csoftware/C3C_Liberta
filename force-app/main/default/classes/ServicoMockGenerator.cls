@isTest
public without sharing class  ServicoMockGenerator {
    public static Callout_Config_Sobj__c createCalloutConfig()
    {
        Callout_Config_Sobj__c config = new Callout_Config_Sobj__c();
        config.Id = fflib_IDGenerator.generate(Callout_Config_Sobj__c.SObjectType);
        config.Basic_Auth__c = '2020';
        config.Client_ID__c = 'ClientId';
        config.Client_Secret__c = '121' ;
        config.Timeout__c = 1200;
        config.Method__c = 'GET';
        config.Endpoint__c = 'https://asdasd';
        return config;

    }

    public static CalloutConfigDomain createCalloutConfigDomain()
    {
        Callout_Config_Sobj__c config = ServicoMockGenerator.createCalloutConfig();
        CalloutConfigDomain configDomain = (CalloutConfigDomain) C3C_DIContainer_Injector.newInstance('CalloutConfigDomain', config);
        return configDomain;
    }
}