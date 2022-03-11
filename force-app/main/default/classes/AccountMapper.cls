public without sharing class AccountMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
	public override String getObjectName()
    {
        return 'Account';
    }

    //Atributos (Com referência ao campo do objeto)
    

    @AuraEnabled 
    public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled 
    public String nomeDaConta
    {
        get;
        set
        {
            this.nomeDaConta = value;
            this.setValueInRecord('Name', value);
        }
    }

    @AuraEnabled 
    public String idChaveExterna
    {
        get;
        set
        {
            this.idChaveExterna = value;
            this.setValueInRecord('IdChaveExterna__c', value);
        }
    }

    @AuraEnabled 
    public String cpfDaConta
    {
        get;
        set
        {
            this.cpfDaConta = value;
            this.setValueInRecord('CPF__c', value);
        }
    }

    @AuraEnabled 
    public String cnpjDaConta
    {
        get;
        set
        {
            this.cnpjDaConta = value;
            this.setValueInRecord('CNPJ__c', value);
        }
    }

    @AuraEnabled 
    public String codigoAssessor
    {
        get;
        set
        {
            this.codigoAssessor = value;
            this.setValueInRecord('CodigoAssessor__c', value);
        }
    }

    @AuraEnabled 
    public String proprietarioConta
    {
        get;
        set
        {
            this.proprietarioConta = value;
            this.setValueInRecord('OwnerId', value);
        }
    }

    //Construtores
    public AccountMapper()
    {}
    
    public AccountMapper(String idRegistro)
    {
        this.idRegistro = idRegistro;
    }

    public AccountMapper(String idRegistro, String nomeDaConta)
    {
        this.idRegistro = idRegistro;
        this.nomeDaConta = nomeDaConta;
    }

    public AccountMapper(String idRegistro, String nomeDaConta, String idChaveExterna)
    {
        this.idRegistro = idRegistro;
        this.nomeDaConta = nomeDaConta;
        this.idChaveExterna = idChaveExterna;
    }


    private AccountMapper(SObject eventSObject)
    {
        this.initBuild();
        this.construirAccountMapperComAccountSObject(eventSObject);
        this.finishBuild();
    }

    //Métodos
    
    //Método responsável por retornar a instância da classe caso passe parâmetros
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new AccountMapper((Sobject) params);
        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;
            return new AccountMapper((String) mapaParams.get('idRegistro'), (String) mapaParams.get('nomeConta'), (String) mapaParams.get('idChaveExterna'));
        }
    
        return null;
    }

    //Método responsável por construir a account Mapper caso receba um sObject de account
    private void construirAccountMapperComAccountSObject(SObject accountSObject)
    {
        accountSObject = (SObject) JSON.deserialize(JSON.serialize(accountSObject), SObject.class);
        this.record = accountSObject;

        this.idRegistro = (String) accountSObject.get('Id');
        this.nomeDaConta = (String) accountSObject.get('Name');
        this.idChaveExterna = (String) accountSObject.get('IdChaveExterna__c');
        this.cpfDaConta = (String) accountSObject.get('CPF__c');
        this.cnpjDaConta = (String) accountSObject.get('CNPJ__c');
        this.codigoAssessor = (String) accountSObject.get('CodigoAssessor__c');
        this.proprietarioConta = (String) accountSObject.get('OwnerId');

    }
}