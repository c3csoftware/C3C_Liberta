public without sharing class FilaDomain implements IFilaDomain, C3C_DI_IProvider
{
    //Exception
    public class FilaDomainException extends Exception {}

    //Atributos
    private FilaMapper FilaMapper {get; set;}

    //Contrutores
    public FilaDomain() 
    {}
    
    private FilaDomain(SObject filaSObject)
    {
        this.construirDomainComSObject(filaSObject);
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
            
        if(params instanceOf SObject)
            return new FilaDomain((SObject) params);

        return null;
    }

    //Responsável por retornar a mapper
    public FilaMapper obterMapper()
    {
        return this.filaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.filaMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject filaSObject)
    {
        this.filaMapper = (FilaMapper) C3C_DIContainer_Injector.newInstance('FilaMapper', filaSObject);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<FilaDomain> construirListaDomainComListaSObject(List<SObject> listaFilasSObject)
    {
        List<FilaDomain> listaDeFilasDomain = new List<FilaDomain>();

        for(SObject filaSObject : listaFilasSObject)
            listaDeFilasDomain.add(new FilaDomain(filaSObject));

        return listaDeFilasDomain;
    }
}