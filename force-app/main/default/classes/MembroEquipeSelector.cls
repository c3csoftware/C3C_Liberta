public without sharing virtual class MembroEquipeSelector extends fflib_SObjectSelector implements IMembroEquipeSelector
{
    public class AccountTeamMemberSelectorException extends Exception{}
    
    public Schema.SObjectType getSObjectType()
    {
        return MembroEquipe__c.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            MembroEquipe__c.Id,
			MembroEquipe__c.Equipe__c,
			MembroEquipe__c.PapelEquipe__c,
			MembroEquipe__c.Usuario__c
        };
    }

    public List<SObject> obterMembroEquipePorEquipes(List<String> listaEquipes)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.selectField('PapelEquipe__r.Name');
        query.selectField('Equipe__r.Name');
        query.addCondition('', 'Equipe__r.Name', 'IN', listaEquipes);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()); 
    }
    
    public List<SObject> obterMembroEquipePorListaIdEquipe(List<String> listaIdEquipe)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.selectField('PapelEquipe__r.Name');
        query.selectField('Equipe__r.Name');
        query.addCondition('', 'Equipe__c', 'IN', listaIdEquipe);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()); 
    }

    public List<SObject> obterMembroEquipePorUsuarioId(String idUsuario)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.selectField('Equipe__r.Name');
        query.addCondition('', 'Usuario__c', '=', idUsuario);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL()); 
    }
    
}