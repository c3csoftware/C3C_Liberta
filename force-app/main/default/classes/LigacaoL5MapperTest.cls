@isTest
public with sharing class LigacaoL5MapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        // WHEN
        string nomeDaAPIObjeto = new LigacaoL5Mapper().getObjectName();

        // THEN
        System.assertEquals('LigacoesL5__c', nomeDaAPIObjeto, 'O nome do objeto deveria ser "LigacaoL5"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        LigacaoL5Mapper LigacaoL5Mpp = (LigacaoL5Mapper) new LigacaoL5Mapper().newInstance(Schema.getGlobalDescribe().get(
            new LigacaoL5Mapper().getObjectName()
        ).newSObject());

        // THEN
        System.assert(LigacaoL5Mpp != null, 'Deveria retornar uma instância de LigacaoL5Mapper');
    }

    @isTest
    public static void testeNewInstanceNull()
    {
        // WHEN
        LigacaoL5Mapper LigacaoL5Mpp = (LigacaoL5Mapper) new LigacaoL5Mapper().newInstance('');

        // THEN
        System.assert(LigacaoL5Mpp == null, 'Não deveria retornar uma instância de LigacaoL5Mapper');
    }
}