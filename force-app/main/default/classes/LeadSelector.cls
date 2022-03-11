public without sharing class LeadSelector extends fflib_SObjectSelector implements ILeadSelector
{
    public class LeadSelectorException extends Exception{}
    
    public Schema.SObjectType getSObjectType()
    {
        return Lead.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Lead.Id,
			Lead.FirstName,
			Lead.LastName,
            Lead.Email,
            Lead.Company,
            Lead.ActiveCamp__Active_Campaign_Id__c,
            Lead.OwnerId,
            Lead.IsConverted,
            Lead.ConvertedAccountId,
            Lead.CPF__c,
            Lead.CNPJ__c,
            Lead.CodigoXP__c,
            Lead.CpfOuCnpj__c,
            Lead.AssessorIndicado__c,
            Lead.CreatedById
        };
    }

    public SObject obterLeadPorActiveCampaignId(String activeCampaignId)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'ActiveCamp__Active_Campaign_Id__c', '=', activeCampaignId);

        for(SObject lead : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
        	return lead;
        
        return null; 
    }

    //Responsável por buscar lead com o número de celular informado
    public SObject buscarLeadComNumeroCelular(String numeroCelular)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'MobilePhone', '=', numeroCelular);
        query.addCondition('OR', 'Phone', '=', numeroCelular);
        query.setLimit(1);

        for(SObject lead : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
        	return lead;
        
        return null; 
    }
    
    //Responsável por buscar leads por lista de ids de lead
    public List<SObject> obterLeadPorIdsDoLead(List<String> idsLead)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'Id', 'IN', idsLead);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()); 
    }

    public SObject obterLeadPorIdDoLead(String idLead) 
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'id', '=', idLead);
        query.setLimit(1);

        for(SObject lead : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
        	return lead;
        
        return null; 
    }

    public List<SObject> obterLeadComStatusNovoPorIdsDoLead(List<String> idsLead)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'Id', 'IN', idsLead);
        query.addCondition('AND', 'Status__c', '=', 'Novo');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}