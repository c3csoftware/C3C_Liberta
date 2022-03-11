public without sharing class CadastrarAcessoAoCallboxMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
    public override String getObjectName()
    {
        return 'CadastrarAcessoAoCallbox__e';
    }

    //
    //Atributos
    //

    @AuraEnabled 
    public String idUsuario 
    {
        get;
        set
        {
            this.idUsuario = value;
            this.setValueInRecord('IdUsuario__c', value);
        }
    }
    
    @AuraEnabled 
    public String ramalUsuario 
    {
        get;
        set
        {
            this.ramalUsuario = value;
            this.setValueInRecord('RamalUsuario__c', value);
        }
    }

    @AuraEnabled 
    public String senhaCallbox
    {
        get;
        set
        {
            this.senhaCallbox = value;
            this.setValueInRecord('SenhaCallbox__c', value);
        }
    }

    //
    //Construtores
    //
    public CadastrarAcessoAoCallboxMapper()
    {}

    private CadastrarAcessoAoCallboxMapper(SObject cadAcessoCallboxSobj)
    {
        this.initBuild();
        this.construirMapperComSObject(cadAcessoCallboxSobj);
        this.finishBuild();
    }

    private CadastrarAcessoAoCallboxMapper(
        String idUsuario,
        String ramalUsuario,
        String senhaCallbox
    )
    {
        this.idUsuario = idUsuario;
        this.ramalUsuario = ramalUsuario;
        this.senhaCallbox = senhaCallbox;
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new CadastrarAcessoAoCallboxMapper((SObject) params);

        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParametro = (Map<String, Object>) params;

            return new CadastrarAcessoAoCallboxMapper(
                (String) mapaParametro.get('idUsuario'),
                (String) mapaParametro.get('ramalUsuario'),
                (String) mapaParametro.get('senhaCallbox')
            );
        }

        return null;
    }
    
    //Resposável por construir a instância da Mapper a partir de um SObject
    public void construirMapperComSObject(SObject cadAcessoCallboxSobj)
    {
        this.record = cadAcessoCallboxSobj;
        
        this.idUsuario = (String) cadAcessoCallboxSobj.get('IdUsuario__c');
        this.ramalUsuario = (String) cadAcessoCallboxSobj.get('RamalUsuario__c');
        this.senhaCallbox = (String) cadAcessoCallboxSobj.get('SenhaCallbox__c');
    }
}