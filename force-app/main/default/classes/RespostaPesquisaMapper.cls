public without sharing class RespostaPesquisaMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
	public override String getObjectName()
    {
        return 'RespostaPesquisa__c';
    }
    
    //Atributos
    @AuraEnabled public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String nota
    {
        get;
        set
        {
            this.nota = value;
            this.setValueInRecord('Nota__c', value);
        }
    }
    
    @AuraEnabled public String entidadePesquisa
    {
        get;
        set
        {
            this.entidadePesquisa = value;
            this.setValueInRecord('EntidadePesquisa__c', value);
        }
    }
    
    @AuraEnabled public String codigoCliente
    {
        get;
        set
        {
            this.codigoCliente = value;
            this.setValueInRecord('CodigoCliente__c', value);
        }
    }
    
    @AuraEnabled public String nomeCliente
    {
        get;
        set
        {
            this.nomeCliente = value;
            this.setValueInRecord('NomeCliente__c', value);
        }
    }
    
    public RespostaPesquisaMapper()
    {}
    
    private RespostaPesquisaMapper(SObject objRespostaPesquisa)
    {
        this.initBuild();
        this.construirDomainComSObject(objRespostaPesquisa);
        this.finishBuild();
    }
    
    private RespostaPesquisaMapper(String codigoCliente, String nota, String entidadePesquisa, String nomeCliente)
    {
        this.codigoCliente = codigoCliente;
        this.nota = nota;
        this.entidadePesquisa = entidadePesquisa;
        this.nomeCliente = nomeCliente;
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new RespostaPesquisaMapper((SObject) params);
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParams = (Map<String, Object>) params;
            return new RespostaPesquisaMapper((String) mapaParams.get('codigoCliente'), (String) mapaParams.get('nota'), (String) mapaParams.get('entidadePesquisa'), (String) mapaParams.get('nomeCliente'));
        }            

        return null;
    }
    
    public void construirDomainComSObject(SObject objRespostaPesquisa)
    {
        this.record = objRespostaPesquisa;
        
        this.idRegistro = (String) objRespostaPesquisa.get('Id');
        this.nota = (String) objRespostaPesquisa.get('Nota__c');
        this.entidadePesquisa = (String) objRespostaPesquisa.get('EntidadePesquisa__c');
        this.codigoCliente = (String) objRespostaPesquisa.get('CodigoCliente__c');
        this.nomeCliente = (String) objRespostaPesquisa.get('NomeCliente__c');
    }
}