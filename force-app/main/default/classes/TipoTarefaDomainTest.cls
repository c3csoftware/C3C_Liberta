@isTest
public without sharing class TipoTarefaDomainTest
{
	@isTest
    public static void testeNewInstanceEnviandoSObject()
    {
        //WHEN
        ITipoTarefaDomain tipoTarefaDomain = (ITipoTarefaDomain) new TipoTarefaDomain().newInstance(Schema.getGlobalDescribe().get(
        	'TipoTarefa__c'
        ).newSObject());
        
        //THEN
        System.assert(tipoTarefaDomain.obterMapper() != null, 'A mapper deveria estar diferente de null');
        System.assert(tipoTarefaDomain.obterRegistro() != null, 'O registro deveria estar diferente de null');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoListSObject()
    {
        //WHEN
        List<ITipoTarefaDomain> listaTipoTarefaDomain = (List<ITipoTarefaDomain>) new TipoTarefaDomain().newInstance(new List<SObject>{Schema.getGlobalDescribe().get(
        	'TipoTarefa__c'
        ).newSObject()});
        
        //THEN
        System.assert(listaTipoTarefaDomain.size() > 0, 'A lista de dominios deveria vir pelo menos um ');
    }
    
    @isTest
    public static void testeNewInstanceEnviandoNull()
    {
        //WHEN
        Object TipoTarefaDomain = new TipoTarefaDomain().newInstance('');
        
        //THEN
        System.assert(TipoTarefaDomain == null, 'Se receber nada ou vazio o método newInstance deve retornar null');
    }
}