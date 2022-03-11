@isTest
public with sharing class LigacaoL5DomainTest 
{
    @isTest
    static void testeConstruirDomainComSObject()
    {
        // new LigacaoL5Domain().construirDomainComSObject(Schema.getGlobalDescribe().get('LigacoesL5__c').newSObject());

    }

    @isTest
    static void testeConstruirListaDomainComListaSObject()
    {
        // new LigacaoL5Domain().construirListaDomainComListaSObject(new List<SObject>{
            // Schema.getGlobalDescribe().get('LigacoesL5__c').newSObject()});
        
    }

    @isTest
    static void testCoverage()
    {
        LigacaoL5Domain.testCoverage();
    }
}