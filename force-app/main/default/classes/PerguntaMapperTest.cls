@isTest
public without sharing class PerguntaMapperTest 
{
    @isTest
    public static void testeGetObjectName()
    {
        //WHEN
        String nomeDaAPIObjeto = new PerguntaMapper().getObjectName();

        //THEN
        System.assertEquals('Pergunta__c', nomeDaAPIObjeto, 'O nome do objeto deveria ser "Pergunta__c"');
    }

    @isTest
    public static void testeNewInstance()
    {
        //WHEN
        PerguntaMapper peguntaMpp = (PerguntaMapper) new PerguntaMapper().newInstance(Schema.getGlobalDescribe().get(
        	new PerguntaMapper().getObjectName()
        ).newSObject());

        //THEN
        System.assert(peguntaMpp != null, 'Deveria retornar uma instância de PerguntaMapper');
    }
}