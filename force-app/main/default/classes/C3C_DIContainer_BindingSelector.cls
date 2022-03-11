public class C3C_DIContainer_BindingSelector extends fflib_SObjectSelector implements C3C_DIContainer_IBindingSelector
{
    public Schema.SObjectType getSObjectType()
    {
        return C3C_DI_binding__mdt.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField> 
        {
            C3C_DI_binding__mdt.Id,
            C3C_DI_binding__mdt.DeveloperName,
            C3C_DI_binding__mdt.ClasseApex__c,
            C3C_DI_binding__mdt.Estatico__c
        };
    }

    public List<SObject> getBindingByKey(String key)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'DeveloperName','=', key);

        return (List<SObject> ) this.libDatabase.queryExecute(query.toSOQL());
    }
}