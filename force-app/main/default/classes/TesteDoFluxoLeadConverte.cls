@IsTest
public with sharing class TesteDoFluxoLeadConverte 
{
    @isTest
    static void leadSemChaveTest()
    {
        // GIVEN
        Lead leadNovo = new Lead(LastName='Teste', Company='Teste', Status='New');
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', leadNovo);
        
        
        // WHEN
        Test.startTest();
        
        new LeadTriggerAfterInsertService().converterLeadCasoPossuaContaNaBase(new List<ILeadDomain>{
            leadDomain
        });
        Test.stopTest();
        // THEN
        System.assert(leadNovo.IsConverted == false, 'O lead não pode estar convertido quando vem Lead sem chave do active');
    }

    @isTest 
    static void leadComChaveTelefoneSemContaBaseTest()
    {
        // GIVEN
        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject());
        leadDomain.obterMapper().sobrenome = 'Teste Com Chave telefone sem conta na base';
        leadDomain.obterMapper().empresa = 'Teste Com Chave telefone sem conta na base';
        leadDomain.obterMapper().status = 'New';

        leadDomain.obterMapper().telefone = '85996289926';
        
        
        // WHEN;
        new LeadTriggerAfterInsertService().converterLeadCasoPossuaContaNaBase(new List<ILeadDomain>{
            leadDomain
        });
        // THEN
    }

    @isTest 
    static void leadComChaveTelefoneComContaBaseTest()
    {
        // GIVEN
        Account conta = new Account(Phone = '85996289926', Name='contaComChaveTelefone', Codigo__c = '1001');
        insert conta;

        ILeadDomain leadDomain = (ILeadDomain) C3C_DIContainer_Injector.newInstance('LeadDomain', Schema.getGlobalDescribe().get('Lead').newSObject(fflib_IDGenerator.generate(Lead.SObjectType)));
        leadDomain.obterMapper().sobrenome = 'Teste Com Chave telefone sem conta na base';
        leadDomain.obterMapper().empresa = 'Teste Com Chave telefone sem conta na base';
        leadDomain.obterMapper().status = 'New';

        leadDomain.obterMapper().telefone = '85996289926';
        
        
        // WHEN;
        new LeadTriggerAfterInsertService().converterLeadCasoPossuaContaNaBase(new List<ILeadDomain>{
            leadDomain
        });

        // THEN
        System.assert(leadDomain.obterMapper().convertido == true, 'O lead precisa estar convertido');
    }
}