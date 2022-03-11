public without sharing class EventRelationSelector extends fflib_SObjectSelector implements IEventRelationSelector
{    
    public Schema.SObjectType getSObjectType()
    {
        return EventRelation.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            EventRelation.Id,
			EventRelation.EventId,
			EventRelation.RelationId,
            EventRelation.Status
        };
    }

    //Responsável por trazer os eventos de roletagem relacionados que acabaram de ser aceitos
    public List<SObject> buscarEventosDeRoletagemRelacionadoQueForamRespondidos()
    {
        fflib_QueryFactory query = newQueryFactory();
        
        query.addCondition('', 'Event.EventoGeradoPorRoletagem__c', '=', true);
        query.addCondition('AND', 'Event.EventoAceito__c', '=', false);
        query.addCondition('AND', 'Event.EventoNegado__c', '=', false);
        query.addCondition('AND', 'Status', 'IN', new List<String>{'Accepted', 'Declined'});

        query.selectField('Event.Lead__c');
        query.selectField('Event.OwnerId');

        query.setOrdering(EventRelation.LastModifiedDate, fflib_QueryFactory.SortOrder.ASCENDING);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}