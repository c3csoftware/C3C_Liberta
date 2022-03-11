public without sharing class PerguntaSelector extends fflib_SObjectSelector implements IPerguntaSelector
{
    //Exception
    public class PerguntaSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return Pergunta__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Pergunta__c.Id,
			Pergunta__c.Pergunta__c,
            Pergunta__c.Obrigatorio__c,
            Pergunta__c.Ordem__c,
            Pergunta__c.Status__c,
            Pergunta__c.Tipo__c,
            Pergunta__c.TipoTarefa__c,
            Pergunta__c.AtualizarCampoSObject__c,
            Pergunta__c.NomeAPICampoAtualizacaoCampo__c,
            Pergunta__c.NomeAPIObjetoAtualizacaoCampo__c,
            Pergunta__c.PerguntaRelacionada__c,
            Pergunta__c.RespostaRelacionada__c,
            Pergunta__c.PerguntaRelacionadaPergunta__c
        };
    }

    //Responsável por buscar uma lista de preguntas por tipo de tarefa
    public List<SObject> obterPerguntasPorTipoTarefa(String tipoTarefa)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.selectField('TipoTarefa__r.Tipo__c');
        query.addCondition('', 'TipoTarefa__c', '=', tipoTarefa);
        query.addCondition('AND', 'Status__c', '=', 'Ativo');

        query.setOrdering('Ordem__c', fflib_QueryFactory.SortOrder.ASCENDING);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    //Responsável por buscas uma lista de perguntas com lista de ids informada
    public List<SObject> buscarPerguntasComListaIds(Set<String> listaIdPerguntas)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Id', 'IN', listaIdPerguntas);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}