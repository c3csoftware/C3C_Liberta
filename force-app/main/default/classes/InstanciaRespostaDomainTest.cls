@isTest
public without sharing class InstanciaRespostaDomainTest
{
	@isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        IInstanciaRespostaDomain perguntaDomain = (IInstanciaRespostaDomain) new InstanciaRespostaDomain().newInstance(Schema.getGlobalDescribe().get(
        	'InstanciaResposta__c'
        ).newSObject());
        
        //THEN
        System.assert(perguntaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(perguntaDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoListSObject()
    {
        //WHEN
        List<IInstanciaRespostaDomain> listaInstanciaRespostaDomain = (List<IInstanciaRespostaDomain>) new InstanciaRespostaDomain().newInstance(new List<SObject>{Schema.getGlobalDescribe().get(
        	'InstanciaResposta__c'
        ).newSObject()});
        
        //THEN
        System.assert(listaInstanciaRespostaDomain.size() > 0, 'A lista de dominios deveria vir pelo menos um ');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoMapStringObject()
    {
        //WHEN
        IInstanciaRespostaDomain mapInstanciaRespostaDomain = (IInstanciaRespostaDomain) new InstanciaRespostaDomain().newInstance(new Map<String, Object>{'' => ''});
        
        //THEN
        System.assert(mapInstanciaRespostaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
    }
}