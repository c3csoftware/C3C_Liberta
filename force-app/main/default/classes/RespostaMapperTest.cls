@isTest
public without sharing class RespostaMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String nomeDaAPIObjeto = new RespostaMapper().getObjectName();

        //THEN
        System.assertEquals('Resposta__c', nomeDaAPIObjeto, 'O nome do objeto deveria ser "Resposta__c"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        RespostaMapper peguntaMpp = (RespostaMapper) new RespostaMapper().newInstance(Schema.getGlobalDescribe().get(
        	new RespostaMapper().getObjectName()
        ).newSObject());

        //THEN
        System.assert(peguntaMpp != null, 'Deveria retornar uma instância de RespostaMapper');
    }
    
    @isTest
    public static void testeNewInstanceNull()
    {
        //WHEN
        RespostaMapper peguntaMpp = (RespostaMapper) new RespostaMapper().newInstance('');

        //THEN
        System.assert(peguntaMpp == null, 'Não deveria retornar uma instância de RespostaMapper');
    }
}