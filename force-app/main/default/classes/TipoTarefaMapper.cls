public without sharing class TipoTarefaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	public override String getObjectName()
    {
        return 'TipoTarefa__c';
    }
    
    //Atributos
    @AuraEnabled public String recordId
    {
        get;
        set
        {
            this.recordId = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String nome
    {
        get;
        set
        {
            this.nome = value;
            this.setValueInRecord('Name', value);
        }
    }

    @AuraEnabled public String papelEquipe
    {
        get;
        set
        {
            this.papelEquipe = value;
            this.setValueInRecord('PapelEquipe__c', value);
        }
    }

    @AuraEnabled public String perfilCliente
    {
        get;
        set
        {
            this.perfilCliente = value;
            this.setValueInRecord('PerfilCliente__c', value);
        }
    }

    @AuraEnabled public String tipo
    {
        get;
        set
        {
            this.tipo = value;
            this.setValueInRecord('Tipo__c', value);
        }
    }
    
    public TipoTarefaMapper()
    {}
    
    private TipoTarefaMapper(SObject objTipoTarefa)
    {
        this.initBuild();
        this.construirDomainComSObject(objTipoTarefa);
        this.finishBuild();
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new TipoTarefaMapper((SObject) params);

        return null;
    }
    
    public void construirDomainComSObject(SObject objTipoTarefa)
    {
        this.record = objTipoTarefa;
        
        this.recordId = (String) objTipoTarefa.get('Id');
        this.nome = (String) objTipoTarefa.get('Name');
        this.papelEquipe = (String) objTipoTarefa.get('PapelEquipe__c');
        this.perfilCliente = (String) objTipoTarefa.get('PerfilCliente__c');
        this.tipo = (String) objTipoTarefa.get('Tipo__c');
    }
}