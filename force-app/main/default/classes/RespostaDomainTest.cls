@isTest
public without sharing class RespostaDomainTest
{
	@isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        IRespostaDomain perguntaDomain = (IRespostaDomain) new RespostaDomain().newInstance(Schema.getGlobalDescribe().get(
        	'Resposta__c'
        ).newSObject());
        
        //THEN
        System.assert(perguntaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(perguntaDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoListSObject()
    {
        //WHEN
        List<IRespostaDomain> listaRespostaDomain = (List<IRespostaDomain>) new RespostaDomain().newInstance(new List<SObject>{Schema.getGlobalDescribe().get(
        	'Resposta__c'
        ).newSObject()});
        
        //THEN
        System.assert(listaRespostaDomain.size() > 0, 'A lista de dominios deveria vir pelo menos um ');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoNull()
    {
        //WHEN
        Object listaRespostaDomain = new RespostaDomain().newInstance('');
        
        //THEN
        System.assert(listaRespostaDomain == null, 'A lista de dominios deveria vir null');
    }
}