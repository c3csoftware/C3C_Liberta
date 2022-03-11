public without sharing class PerguntaDomain implements IPerguntaDomain, C3C_DI_IProvider
{
    //Exception
    public class PerguntaDomainException extends Exception {}

    //Atributos
    private PerguntaMapper perguntaMapper {get; set;}

    //Contrutores
    public PerguntaDomain() 
    {}
    
    private PerguntaDomain(SObject perguntaSObject)
    {
        this.construirDomainComSObject(perguntaSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);

        if(params instanceOf SObject)
            return new PerguntaDomain((SObject) params);

        return null;
    }

    //Responsável por retornar a mapper
    public PerguntaMapper obterMapper()
    {
        return this.perguntaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.perguntaMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject perguntaSObject)
    {
        this.perguntaMapper = (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper', perguntaSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<PerguntaDomain> construirListaDomainComListaSObject(List<SObject> listaUsuariosSObject)
    {
        List<PerguntaDomain> listaDeUsuariosDomain = new List<PerguntaDomain>();

        for(SObject perguntaSObject : listaUsuariosSObject)
            listaDeUsuariosDomain.add(new PerguntaDomain(perguntaSObject));

        return listaDeUsuariosDomain;
    }
}