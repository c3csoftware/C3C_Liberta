public with sharing virtual class AccountSelector extends fflib_SObjectSelector implements IAccountSelector
{
     
    public Schema.SObjectType getSObjectType()
    {
        return Account.sObjectType;    
    }

    public List<Schema.SObjectField> getSObjectFieldList()
    {
        return new List<Schema.SObjectField>
        {
            Account.Id,
			Account.Name,
            Account.IdChaveExterna__c,
            Account.CPF__c,
            Account.CNPJ__c,
            Account.OwnerId,
            Account.DataAbertura__c,
            Account.Codigo__c
        };
    }

    // Responsável por trazer uma lista de contas por Id (Sendo que sempre retornará 1)
    public List<SObject> buscarContaPorId(String contaId)
    {
        fflib_QueryFactory query = newQueryFactory();
        
        query.addCondition('', 'Id', '=', contaId);

        query.setLimit(1);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    // O nome do método está diferente do proposto, não está buscando contas por Ids, está buscando somente uma conta com um id específico.
    public List<SObject> buscarContasPorIds(Set<String> contaIds)
    {
        fflib_QueryFactory query = newQueryFactory();
        query.addCondition('', 'Id', '=', '0018G00000Af3q4QAB');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }

    public List<SObject> buscarContasComPesquisaParaHoje()
    {
        fflib_QueryFactory query = newQueryFactory();
        // query.addCondition('', 'Id', '=', '0018G00000Af3q4QAB');

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }


    public List<SObject> buscarContasPorDadosLead(List<LeadMapper> listaLeadMapper)
    {
        List<String> emails = new List<String>();
        List<String> telefones = new List<String>();
        List<String> cpfs = new List<String>();
        List<String> cnpjs = new List<String>();

        for (LeadMapper leadMapper : listaLeadMapper)
        {
            emails.add(leadMapper.email);
            telefones.add(leadMapper.telefone);
            cpfs.add(leadMapper.cpf);
            cnpjs.add(leadMapper.cnpj);
        }

        fflib_QueryFactory query = newQueryFactory();
        // if (emails.toString() != '(null)')
            query.addCondition('', 'Email__c', 'IN', emails);
        
        // if (telefones.toString() != '(null)')
            query.addCondition('OR', 'Phone', 'IN', telefones);
        
        // if (cpfs.toString() != '(null)')
            query.addCondition('OR', 'CPF__c', 'IN', cpfs);
        
        // if (cnpjs.toString() != '(null)')
            query.addCondition('OR', 'CNPJ__c', 'IN', cnpjs);

        return (List<SObject>) this.libDatabase.queryExecute(query.toSOQL());
    }
}