public without sharing class SegurancaLoginCallboxDomain implements ISegurancaLoginCallboxDomain, C3C_DI_IProvider
{
    //Exception
    public class SegurancaLoginCallboxDomainException extends Exception {}

    //Atributos
    private SegurancaLoginCallboxMapper segurancaLoginCallboxMapper 
    {
        get
        {
            if(this.segurancaLoginCallboxMapper == null)
                this.segurancaLoginCallboxMapper = (SegurancaLoginCallboxMapper) C3C_DIContainer_Injector.newInstance('SegurancaLoginCallboxMapper');

            return this.segurancaLoginCallboxMapper;
        }
        set;
    }

    //Contrutores
    public SegurancaLoginCallboxDomain() 
    {}
    
    private SegurancaLoginCallboxDomain(SObject segurancaLoginCallboxSObject)
    {
        this.construirDomainComSObject(segurancaLoginCallboxSObject);
    }

    private SegurancaLoginCallboxDomain(String idUsuario)
    {
        this.segurancaLoginCallboxMapper.usuario = idUsuario;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf String)
            return new SegurancaLoginCallboxDomain((String) params);

        if(params instanceOf SObject)
            return new SegurancaLoginCallboxDomain((SObject) params);

        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);

        return null;
    }

    //Responsável por retornar a mapper
    public SegurancaLoginCallboxMapper obterMapper()
    {
        return this.segurancaLoginCallboxMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.segurancaLoginCallboxMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject segurancaLoginCallboxSObject)
    {
        this.segurancaLoginCallboxMapper = (SegurancaLoginCallboxMapper) C3C_DIContainer_Injector.newInstance('SegurancaLoginCallboxMapper', segurancaLoginCallboxSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<SegurancaLoginCallboxDomain> construirListaDomainComListaSObject(List<SObject> listaSegurancaLoginCallboxSObject)
    {
        List<SegurancaLoginCallboxDomain> listaDeSegurancaLoginCallboxDomain = new List<SegurancaLoginCallboxDomain>();

        for(SObject segurancaLoginCallboxSObject : listaSegurancaLoginCallboxSObject)
            listaDeSegurancaLoginCallboxDomain.add(new SegurancaLoginCallboxDomain(segurancaLoginCallboxSObject));

        return listaDeSegurancaLoginCallboxDomain;
    }
}