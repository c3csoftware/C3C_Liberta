public without sharing class SegurancaLoginCallboxMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
    public override String getObjectName()
    {
        return 'SegurancaLoginCallBox__c';
    }

    //
    //Atributos (Com referência ao campo do objeto)
    //

    @AuraEnabled public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled public String usuario
    {
        get;
        set
        {
            this.usuario = value;
            this.setValueInRecord('Usuario__c', value);
        }
    }

    @AuraEnabled public String ramalUsuario {get;set;}

    @AuraEnabled public String senhaCallboxUsuario
    {
        get;
        set
        {
            this.senhaCallboxUsuario = value;
            this.setValueInRecord('SenhaCallboxUsuario__c', value);
        }
    }

    //
    //Construtores
    //

    public SegurancaLoginCallboxMapper()
    {}
    
    private SegurancaLoginCallboxMapper(SObject segurancaLoginCallboxSobj)
    {
        this.initBuild();
        this.construirMapperComSObject(segurancaLoginCallboxSobj);
        this.finishBuild();
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new SegurancaLoginCallboxMapper((SObject) params);

        return null;
    }
    
    //Resposável por construir a instância da Mapper a partir de um SObject
    public void construirMapperComSObject(SObject segurancaLoginCallboxSobj)
    {
        this.record = segurancaLoginCallboxSobj;
        
        this.idRegistro = (String) segurancaLoginCallboxSobj.get('Id');
        this.usuario = (String) segurancaLoginCallboxSobj.get('Usuario__c');
        this.senhaCallboxUsuario = (String) segurancaLoginCallboxSobj.get('SenhaCallboxUsuario__c');

        if(segurancaLoginCallboxSobj.getSObject('Usuario__r') != null)
            this.ramalUsuario = (String) segurancaLoginCallboxSobj.getSObject('Usuario__r').get('Ramal__c');
    }
}