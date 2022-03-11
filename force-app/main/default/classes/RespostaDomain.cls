public without sharing class RespostaDomain implements IRespostaDomain, C3C_DI_IProvider
{
    //Exception
    public class RespostaDomainException extends Exception {}

    //Atributos
    private RespostaMapper respostaMapper {get; set;}

    //Contrutores
    public RespostaDomain() 
    {}
    
    private RespostaDomain(SObject respostaSObject)
    {
        this.construirDomainComSObject(respostaSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);

        if(params instanceOf SObject)
            return new RespostaDomain((SObject) params);

        return null;
    }

    //Responsável por retornar a mapper
    public RespostaMapper obterMapper()
    {
        return this.respostaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.respostaMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject respostaSObject)
    {
        this.respostaMapper = (RespostaMapper) C3C_DIContainer_Injector.newInstance('RespostaMapper', respostaSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<RespostaDomain> construirListaDomainComListaSObject(List<SObject> listaUsuariosSObject)
    {
        List<RespostaDomain> listaDeUsuariosDomain = new List<RespostaDomain>();

        for(SObject respostaSObject : listaUsuariosSObject)
            listaDeUsuariosDomain.add(new RespostaDomain(respostaSObject));

        return listaDeUsuariosDomain;
    }
}