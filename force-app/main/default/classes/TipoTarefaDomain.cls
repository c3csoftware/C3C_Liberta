public without sharing class TipoTarefaDomain implements ITipoTarefaDomain, C3C_DI_IProvider
{
    //Exception
    public class TipoTarefaDomainException extends Exception {}

    //Atributos
    private TipoTarefaMapper tipoTarefaMapper 
    {
        get
        {
            if(this.tipoTarefaMapper == null)
                this.tipoTarefaMapper = (TipoTarefaMapper) C3C_DIContainer_Injector.newInstance('TipoTarefaMapper');

            return this.tipoTarefaMapper;
        }
        set;
    }

    //Contrutores
    public TipoTarefaDomain() 
    {}
    
    private TipoTarefaDomain(SObject tipoTarefaSObject)
    {
        this.construirDomainComSObject(tipoTarefaSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);

        if(params instanceOf SObject)
            return new TipoTarefaDomain((SObject) params);

        return null;
    }

    //Responsável por retornar a mapper
    public TipoTarefaMapper obterMapper()
    {
        return this.tipoTarefaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.tipoTarefaMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject tipoTarefaSObject)
    {
        this.tipoTarefaMapper = (TipoTarefaMapper) C3C_DIContainer_Injector.newInstance('TipoTarefaMapper', tipoTarefaSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<TipoTarefaDomain> construirListaDomainComListaSObject(List<SObject> listaUsuariosSObject)
    {
        List<TipoTarefaDomain> listaDeUsuariosDomain = new List<TipoTarefaDomain>();

        for(SObject tipoTarefaSObject : listaUsuariosSObject)
            listaDeUsuariosDomain.add(new TipoTarefaDomain(tipoTarefaSObject));

        return listaDeUsuariosDomain;
    }
}