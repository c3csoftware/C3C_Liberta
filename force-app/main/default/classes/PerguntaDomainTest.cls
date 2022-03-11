@isTest
public without sharing class PerguntaDomainTest
{
	@isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        IPerguntaDomain perguntaDomain = (IPerguntaDomain) new PerguntaDomain().newInstance(Schema.getGlobalDescribe().get(
        	'Pergunta__c'
        ).newSObject());
        
        //THEN
        System.assert(perguntaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(perguntaDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoListSObject()
    {
        //WHEN
        List<IPerguntaDomain> listaPerguntaDomain = (List<IPerguntaDomain>) new PerguntaDomain().newInstance(new List<SObject>{Schema.getGlobalDescribe().get(
        	'Pergunta__c'
        ).newSObject()});
        
        //THEN
        System.assert(listaPerguntaDomain.size() > 0, 'A lista de dominios deveria vir pelo menos um ');
    }
}