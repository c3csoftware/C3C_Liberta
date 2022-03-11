public without sharing class UserMapper extends C3C_AbstractMapper implements C3C_DI_IProvider 
{
    //Método que define o objeto no qual a Mapper é relacionado
    public override String getObjectName()
    {
        return 'User';
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
    
    @AuraEnabled public String nome
    {
        get;
        set
        {
            this.nome = value;
            this.setValueInRecord('Name', value);
        }
    }
    
    @AuraEnabled public String ramal
    {
        get;
        set
        {
            this.ramal = value;
            this.setValueInRecord('Ramal__c', value);
        }
    }

    @AuraEnabled public String senhaCallbox
    {
        get;
        set
        {
            this.senhaCallbox = value;
            this.setValueInRecord('SenhaCallbox__c', value);
        }
    }

    @AuraEnabled public String serverCallbox
    {
        get;
        set
        {
            this.serverCallbox = value;
            this.setValueInRecord('ServerCallbox__c', value);
        }
    }

    @AuraEnabled public Datetime ultimoLoginCallbox
    {
        get;
        set
        {
            this.ultimoLoginCallbox = value;
            this.setValueInRecord('UltimoLoginCallbox__c', value);
        }
    }

    @AuraEnabled public Decimal codigoAssessor
    {
        get;
        set
        {
            this.codigoAssessor = value;
            this.setValueInRecord('CodigoAssessor__c', value);
        }
    }

    @AuraEnabled public String idActiveCampaign
    {
        get;
        set
        {
            this.idActiveCampaign = value;
            this.setValueInRecord('IdActive__c', value);
        }
    }

    @AuraEnabled public String papel {get;set;}
    @AuraEnabled public String nomePerfil {get;set;}

    //Construtores
    public UserMapper()
    {}
    
    private UserMapper(SObject usuarioSObject)
    {
        //Sinalizando que iniciou a construção da instância para não preencher o record pelo "setValueInRecord"
        this.initBuild();
        this.construirDomainComSObject(usuarioSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new UserMapper((SObject) params);

        return null;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject usuarioSObject)
    {
        this.record = usuarioSObject;

        this.idRegistro = (String) usuarioSObject.get('Id');
        this.nome = (String) usuarioSObject.get('Name');
        this.ramal = (String) usuarioSObject.get('Ramal__c');
        this.senhaCallbox = (String) usuarioSObject.get('SenhaCallbox__c');
        this.ultimoLoginCallbox = (Datetime) usuarioSObject.get('UltimoLoginCallbox__c');
        this.codigoAssessor = (Decimal) usuarioSObject.get('CodigoAssessor__c');
        this.idActiveCampaign = (String) usuarioSObject.get('IdActive__c');
        this.serverCallbox = (String) usuarioSObject.get('ServerCallbox__c');
        this.nomePerfil = (String) usuarioSObject.get('PerfilUsuario__c');

        if(usuarioSObject.getSObject('UserRole') != null)
        {
            SObject userRole = usuarioSObject.getSObject('UserRole');

            this.papel = (String) userRole.get('Name');
        }

        // if(usuarioSObject.getSObject('Profile') != null)
        // {
        //     this.nomePerfil = (String) usuarioSObject.getSObject('Profile').get('Name');
        // }
    }
}