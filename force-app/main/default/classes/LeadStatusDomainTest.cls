@isTest
public with sharing class LeadStatusDomainTest 
{
    @isTest 
    static void testeNewInstancePassandoList()
    {
        new LeadStatusDomain().newInstance(new List<SObject> {
            Schema.getGlobalDescribe().get(new LeadStatusMapper().getObjectName()).newSObject()
        });
    }
    @isTest 
    static void testeNewInstancePassandoSobject()
    {
        ILeadStatusDomain leadStatus = (ILeadStatusDomain) new LeadStatusDomain().newInstance(
            Schema.getGlobalDescribe().get(new LeadStatusMapper().getObjectName()).newSObject()
        );

        leadStatus.atribuirNovoIdDoRegistro();
        leadStatus.obterMapper();
        leadStatus.obterRegistro();
        leadStatus.pegarMasterLabel();
    }
    @isTest 
    static void testeNewInstancePassandoLeadStatusMapper()
    {
        new LeadStatusDomain().newInstance(new LeadStatusMapper());
    }
}