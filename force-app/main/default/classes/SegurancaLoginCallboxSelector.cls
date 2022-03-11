public without sharing class SegurancaLoginCallboxSelector extends fflib_SObjectSelector implements ISegurancaLoginCallboxSelector
{
    //Exception
    public class SegurancaLoginCallboxSelectorException extends Exception{}
    
    //Métodos
    public Schema.SObjectType getSObjectType()
    {
        return SegurancaLoginCallBox__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            SegurancaLoginCallBox__c.Id,
			SegurancaLoginCallBox__c.SenhaCallboxUsuario__c,
            SegurancaLoginCallBox__c.Usuario__c
        };
    }

    //Responsável por buscar informações de login do callbox com o id do usuário
    public SObject buscarInformacoesDoLoginCallBoxComId(String idRegistro)
    {
        fflib_QueryFactory query = newQueryFactory(); 
        query.addCondition('', 'Id', '=', idRegistro);
        query.selectField('Usuario__r.Ramal__c');

        for(SObject segurancaLoginCallbox : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
        	return segurancaLoginCallbox;
        
        return null; 
    }
}