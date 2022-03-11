public without sharing class InstanciaRespostaSelector extends fflib_SObjectSelector implements IInstanciaRespostaSelector
{
    //Exception
    public class InstanciaRespostaSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return InstanciaResposta__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            InstanciaResposta__c.Id,
			InstanciaResposta__c.idTarefa__c,
            InstanciaResposta__c.Pergunta__c,
            InstanciaResposta__c.RespostaDissertativa__c,
            InstanciaResposta__c.RespostaAlternativa__c,
            InstanciaResposta__c.Lead__c,
            InstanciaResposta__c.RespostaAlternativaValor__c
        };
    }

    //Responsável por buscar usuário com o id do usuário
    public List<SObject> obterInstanciaRespostaPorIdTarefa(String idTarefa)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'idTarefa__c', '=', idTarefa);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
       
    }

    //Responsável por buscar usuário com o id do usuário
    public List<SObject> obterInstanciaRespostaLeadConvertidoPorIdTarefa(String idTarefa)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'idTarefa__c', '=', idTarefa);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
       
    }

    public List<SObject> buscarInstanciaRespostasLead(Set<String> idLead)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.selectField('Pergunta__r.Ordem__c');
        query.selectField('Pergunta__r.RespostaRelacionada__c');
        query.selectField('Pergunta__r.Pergunta__c');
        query.addCondition('', 'Lead__c', 'IN', idLead);
        query.addCondition('AND', 'Lead__c', '!=', null);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    public List<SObject> buscarInstanciaRespostasPerguntaLeadConvertido(Set<String> idLead)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.selectField('Pergunta__r.Ordem__c');
        query.selectField('Pergunta__r.RespostaRelacionada__c');
        query.selectField('Pergunta__r.Pergunta__c');
        query.addCondition('', 'Lead__c', 'IN', idLead);
        query.addCondition('AND', 'Lead__c', '!=', null);
        query.addCondition('AND', 'Texto_Pergunta__c', '=', 'Lead convertido?');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}