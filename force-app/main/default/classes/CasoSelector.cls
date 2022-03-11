public without sharing virtual class CasoSelector extends fflib_SObjectSelector implements ICasoSelector
{
    //
    //Métodos
    //

    public Schema.SObjectType getSObjectType()
    {
        return Case.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Case.Id,
            Case.AssessorQueRequisitouCaso__c,
            Case.OwnerId,
			Case.Origin,
            Case.CaseNumber,
            Case.Status,
            Case.CategoriaAtendimento__c
        };
    }

    //Responsável por retornar os casos com origem assessor
    public List<SObject> buscarCasosDeOrigemAssessor(String origem)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Origin', '=', origem);

        System.debug(query.toSOQL());
        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    public List<SObject> obterCasoComStatusResolvidoPorIdsDoCaso(List<String> idsCaso)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'Id', 'IN', idsCaso);
        query.addCondition('AND', 'Status', '=', 'Resolvido');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}