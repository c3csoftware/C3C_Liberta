@isTest
public with sharing class EventRelationDomainTest 
{
    @isTest 
    static void testeNewInstancePassandoListaSobject()
    {
        new EventRelationDomain().newInstance(new List<SObject>{
            Schema.getGlobalDescribe().get(new EventRelationMapper().getObjectName()).newSObject()
        });
    }

    @isTest 
    static void testeNewInstancePassandoSObject()
    {
        EventRelationDomain even = (EventRelationDomain) new EventRelationDomain().newInstance(
            Schema.getGlobalDescribe().get(new EventRelationMapper().getObjectName()).newSObject()
        );

        even.atribuirNovoIdDoRegistro();
        even.obterMapper();
        even.obterRegistro();
    }

    @isTest 
    static void testeNewInstancePassandoEventRelationMapper()
    {
        new EventRelationDomain().newInstance(
            new EventRelationMapper()
        );
    }

    @isTest 
    static void testeNewInstancePassandoMap()
    {
        new EventRelationDomain().newInstance(new Map<String, Object>{
            'idEvento' => 'Teste',
            'idRelacao' => 'Teste'
        });
    }

    @isTest 
    static void testeNewInstancePassandoMapSemIdEvento()
    {
        new EventRelationDomain().newInstance(new Map<String, Object>{
            'idRegistro' => 'Teste'
        });
    }
}