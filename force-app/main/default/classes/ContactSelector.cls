public without sharing class ContactSelector extends fflib_SObjectSelector implements IContactSelector
{
    public Schema.SObjectType getSObjectType()
    {
        return Contact.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Contact.Id,
			Contact.MobilePhone
        };
    }

    //Responsável por buscar um contato com o número do celular informado
    public SObject buscarContatoComNumeroCelular(String numeroCelular)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'MobilePhone', '=', numeroCelular);
        query.addCondition('OR', 'Phone', '=', numeroCelular);
        query.setLimit(1);

        for(SObject contato : (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()))
        	return contato;
        
        return null; 
    }
}