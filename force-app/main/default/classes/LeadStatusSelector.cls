public with sharing class LeadStatusSelector extends fflib_SObjectSelector implements ILeadStatusSelector
{
     
    public Schema.SObjectType getSObjectType()
    {
        return LeadStatus.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            LeadStatus.Id,
			LeadStatus.MasterLabel,
			LeadStatus.IsConverted
        };
    }

    //Responsável por trazer os eventos de roletagem relacionados que acabaram de ser aceitos
    public List<SObject> buscarLeadStatusDeStatusConvertido()
    {
        fflib_QueryFactory query = newQueryFactory();
        
        query.addCondition('', 'IsConverted', '=', true);

        query.setLimit(1);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
    
}