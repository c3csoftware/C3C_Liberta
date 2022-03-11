@RestResource(urlMapping='/listaActiveCampaign/registrar')
global class ActiveListCreatedService 
{
    @HttpPost
    global static String doPost()
	{
        ListaActiveCampaign__c lista = new ListaActiveCampaign__c();
        
        RestRequest req = RestContext.request;
        
        lista.IdLista__c = (String) req.params.get('list[id]');
        lista.NomeLista__c = (String) req.params.get('list[name]');
        
        //upsert lista ListaActiveCampaign__c.IdLista__c;
        
        return 'Inserido no objeto ListaActiveCampaign';
    }
}