public without sharing class TaskCallSelector extends fflib_SObjectSelector implements ITaskCallSelector 
{
    public Schema.SObjectType getSObjectType()
    {
        return Task.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Task.Id,
			Task.Subject,
            Task.OwnerId,
            Task.Priority,
            Task.CallObject,
            Task.CallType,
            Task.Type,
            Task.Status,
            Task.WhoId,
            Task.ActivityDate,
            Task.DataInicioChamada__c,
            Task.DataTerminoChamada__c,
            Task.LinkAcessarGravacaoChamada__c,
            Task.RamalUtilizadoChamada__c,
            Task.DuracaoSegundo__c,
            Task.StatusLigacao__c,
            Task.RamalTransferencia__c,
            Task.CreatedDate
        };
    }

    //Responsável por buscar as tarefas do tipo "Chamada" com id do proprietário
    public List<SObject> buscarTarefasChamadasComIdProprietario(String idProprietario)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'OwnerId', '=', idProprietario);
        query.addCondition('AND', 'TaskSubtype', '=', 'Call');
        query.addCondition('AND', 'CallObject', '!=', null);

        query.setLimit(200);

        query.setOrdering('CreatedDate', fflib_QueryFactory.SortOrder.DESCENDING);
        
        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}