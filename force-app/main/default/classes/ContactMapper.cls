public without sharing class ContactMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Responsável por definir o SObject
    public override String getObjectName()
    {
        return 'Contact';
    }

    //
    //Atributos
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

    @AuraEnabled public String celular 
    {
        get;
        set
        {
            this.celular = value;
            this.setValueInRecord('MobilePhone', value);
        }
    }

    @AuraEnabled public String sobrenome
    {
        get;
        set
        {
            this.sobrenome = value;
            this.setValueInRecord('LastName', value);
        }
    }

    //
    //Contrutores
    //

    public ContactMapper()
    {}

    private ContactMapper(SObject contatoObj)
    {
        initBuild();
        this.construirMapperComSObject(contatoObj);
        finishBuild();
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new ContactMapper((SObject) params);

        return null;
    }

    private void construirMapperComSObject(SObject contatoObj)
    {
        this.record = contatoObj;

        this.idRegistro = contatoObj.Id;
        this.celular = (String) contatoObj.get('MobilePhone');
        this.sobrenome = (String) contatoObj.get('LastName');
    }
}