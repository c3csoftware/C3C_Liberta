public without sharing class ContactDomain implements IContactDomain, C3C_DI_IProvider
{
    //
    //Atributos
    //

    private ContactMapper instanciaContactMapper
    {
        get
        {
            if(this.instanciaContactMapper == null)
                this.instanciaContactMapper = (ContactMapper) C3C_DIContainer_Injector.newInstance('ContactMapper');

            return this.instanciaContactMapper;
        }
        set;
    }
    
    //
    //Construtores
    //

    public ContactDomain()
    {}

    private ContactDomain(SObject contatoObj)
    {
        this.instanciaContactMapper = (ContactMapper) C3C_DIContainer_Injector.newInstance('ContactMapper', contatoObj);
    }

    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new ContactDomain((SObject) params);

        return null;
    }

    //Responsável por retornar a mapper
    public ContactMapper obterMapper()
    {
        return this.instanciaContactMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.instanciaContactMapper.record;
    }

    //Responsável por preencher o id do contato
    public void preencherNovoId()
    {
        this.instanciaContactMapper.idRegistro = this.instanciaContactMapper.record.Id;
    }
}