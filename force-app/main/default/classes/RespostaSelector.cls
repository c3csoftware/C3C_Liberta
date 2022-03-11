public without sharing class RespostaSelector extends fflib_SObjectSelector implements IRespostaSelector
{
    //Exception
    public class RespostaSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return Resposta__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Resposta__c.Id,
            Resposta__c.Resposta__c,
            Resposta__c.HabilitarColetaInformacoes__c,
            Resposta__c.Ordem__c,
            Resposta__c.Status__c,
            Resposta__c.Pergunta__c
        };
    }

    //Responsável por buscar uma lista de respostas por id da pergunta
    public List<SObject> obterRespostasPorListaIdPergunta(Set<String> idsPergunta)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Pergunta__c', 'IN', idsPergunta);
        query.addCondition('AND', 'Status__c', '=', 'Ativo');

        query.setOrdering('Ordem__c', fflib_QueryFactory.SortOrder.ASCENDING);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}