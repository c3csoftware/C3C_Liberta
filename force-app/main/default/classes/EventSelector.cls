public without sharing class EventSelector extends fflib_SObjectSelector implements IEventSelector
{
    //Exception
    public class EventSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return Event.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Event.Id,
            Event.Subject,
			Event.OwnerId,
			Event.StartDateTime,
            Event.EndDateTime,
            Event.EventoAceito__c
        };
    }

    //Responsável por retornar os evento dos usuários da fila informada, a partir da data de inicio e termino informada.
    public List<SObject> buscarEventosDeUsuariosDaFilaComDataDeInicioETermino(String idFila, Datetime dataDeInicio, Datetime dataDeTermino)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'OwnerId', 'IN', '(SELECT UsuarioFila__c FROM MembroFila__c WHERE Fila__c = \''+idFila+'\')', false);
        query.addCondition('AND', 'StartDateTime', '>=', dataDeInicio);
        query.addCondition('AND', 'EndDateTime', '<=', dataDeTermino);

        System.debug(query.toSOQL());
        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    //Responsável por retornar todos os evento dos usuários a partir da data de inicio e termino informada.
    public List<SObject> buscarTodosEventosComDataDeInicioETermino(Datetime activityDataHora, Boolean conjuntoDeLembretes)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('AND', 'ActivityDateTime', '>=', activityDataHora);
        query.addCondition('AND', 'IsReminderSet', '<=', conjuntoDeLembretes);

        System.debug(query.toSOQL());
        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    //Responsável por retornar os eventos sem usuários informados, a partir da data de inicio e termino informada.
    public List<SObject> buscarEventosDeUsuariosDaFilaSemUsuariosInformadosComDataDeInicioETermino(String idFila, Set<String> idsUsuario, Datetime dataDeInicio, Datetime dataDeTermino)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'OwnerId', 'NOT IN', idsUsuario);
        query.addCondition('AND', 'FilaRoletagem__c', '=', idFila);
        query.addCondition('AND', 'OwnerId', 'IN', '(SELECT UsuarioFila__c FROM MembroFila__c WHERE Fila__c = \''+idFila+'\')', false);
        query.addCondition('AND', 'CreatedDate', '>=', dataDeInicio);
        query.addCondition('AND', 'CreatedDate', '<=', dataDeTermino);

        System.debug(query.toSOQL());
        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    public List<SObject> buscarEventosDeUsuariosDaFilaDoMesAtual(String idFila)
    {
        fflib_QueryFactory query = newQueryFactory();

        query.addCondition('', 'OwnerId', 'IN', '(SELECT UsuarioFila__c FROM MembroFila__c WHERE Fila__c = \''+idFila+'\')', false);
        // Fazer uma condição para o mês atual, pegando por StartDateTime
        query.addCondition('AND', 'StartDateTime', '=', 'THIS_MONTH', false);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    public List<SObject> buscarEventosDoMesComIdRelativoIdProprietario(String idRelativo, String idProprietario)
    {
        fflib_QueryFactory query = newQueryFactory();

        query.addCondition('', 'OwnerId', '=', idProprietario);
        query.addCondition('', 'WhatId', '=', idRelativo);
        query.addCondition('', 'StartDateTime', '=', 'THIS_MONTH', false);

        query.setLogic('{0} AND {1} AND {2}');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}