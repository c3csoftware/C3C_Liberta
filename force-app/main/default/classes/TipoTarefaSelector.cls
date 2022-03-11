public without sharing class TipoTarefaSelector extends fflib_SObjectSelector implements ITipoTarefaSelector
{
    //Exception
    public class TipoTarefaSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return TipoTarefa__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            TipoTarefa__c.Id,
            TipoTarefa__c.Name,
            TipoTarefa__c.PapelEquipe__c,
            TipoTarefa__c.PerfilCliente__c,
            TipoTarefa__c.Tipo__c,
            TipoTarefa__c.NecessitaMonitorarAgendamento__c
        };
    }

    //Responsável por buscar uma lista de respostas por id da pergunta
    public SObject obterTipoTarefasPorTipoIgualQualificacaoLead()
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Tipo__c', '=', 'Qualificacao de Lead');
        query.setLimit(1);

        for(SObject obj : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
            return obj;

        return null;
    }

    //Responsável por buscar o tipo tarefa pelo nome
    public SObject buscarTipoTarefaComNome(String nomeTipoTarefa)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Name', '=', nomeTipoTarefa);
        query.setLimit(1);

        for(SObject obj : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
            return obj;

        return null;
    }

    public SObject obterTipoTarefasPorTipoIgualQualificacaoOportunidade()
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Tipo__c', '=', 'Qualificacao de Oportunidade');
        query.setLimit(1);

        for(SObject obj : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
            return obj;

        return null;
    }

    //Responsável por buscar os tipos de tarefa que participam do monitoramento
    public List<SObject> buscarTiposTarefaQueNecessitamDeMonitoramento(String perfilCliente, String idUsuario)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Tipo__c', 'IN', new List<String>{'NPS', 'Onboarding', 'Relacionamento'});
        query.addCondition('AND', 'PerfilCliente__c', '=', perfilCliente);
        query.addCondition('AND', 'PapelEquipe__C', 'IN', '(SELECT PapelEquipe__c FROM MembroEquipe__c WHERE Usuario__c = \''+idUsuario+'\')', false);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}