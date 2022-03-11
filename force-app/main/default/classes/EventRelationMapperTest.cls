@isTest
public with sharing class EventRelationMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String  nomeDaAPIObjeto = new EventRelationMapper().getObjectName();
        
        //THEN
        System.assertEquals('EventRelation', nomeDaAPIObjeto, 'O nome do objeto deveria ser "EventRelation"');
    }
    
    @isTest
    public static void testNewInstance()
    {
        //WHEN
        EventRelationMapper EventRelationMpp = (EventRelationMapper) new EventRelationMapper().newInstance(Schema.getGlobalDescribe().get(
        	new EventRelationMapper().getObjectName()
        ).newSObject());
        
        //THEN
        System.assert(EventRelationMpp != null, 'Deveria retornar uma instância de EventRelationMapper');
    }

    @isTest
    public static void testNewInstancePassandoMap()
    {
        //WHEN
        EventRelationMapper EventRelationMpp = (EventRelationMapper) new EventRelationMapper().newInstance( new Map<String, Object> {
            'idEvento' => 'teste',
            'idRelacao' => 'teste'
        } );
    }

    @isTest
    public static void testNewInstancePassandoMapSemIdEvento()
    {
        //WHEN
        EventRelationMapper EventRelationMpp = (EventRelationMapper) new EventRelationMapper().newInstance( new Map<String, Object> {
            'idRegistro' => 'teste'
        } );
    }
}