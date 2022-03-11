@isTest
public without sharing class TipoTarefaMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String nomeDaAPIObjeto = new TipoTarefaMapper().getObjectName();

        //THEN
        System.assertEquals('TipoTarefa__c', nomeDaAPIObjeto, 'O nome do objeto deveria ser "TipoTarefa__c"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        TipoTarefaMapper tipoTarefaMpp = (TipoTarefaMapper) new TipoTarefaMapper().newInstance(Schema.getGlobalDescribe().get(
        	new TipoTarefaMapper().getObjectName()
        ).newSObject());

        //THEN
        System.assert(tipoTarefaMpp != null, 'Deveria retornar uma instância de TipoTarefaMapper');
    }
    
    @isTest
    public static void testeNewInstanceNull()
    {
        //WHEN
        Object tipoTarefaMpp = new TipoTarefaMapper().newInstance('');

        //THEN
        System.assert(tipoTarefaMpp == null, 'Não deveria retornar uma instância de TipoTarefaMapper');
    }
}