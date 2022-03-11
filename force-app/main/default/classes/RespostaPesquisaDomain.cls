public without sharing class RespostaPesquisaDomain implements IRespostaPesquisaDomain, C3C_DI_IProvider
{
    //Exception
    public class RespostaPesquisaDomainException extends Exception {}
    
    //Atributos
    private RespostaPesquisaMapper respostaPesquisaMapper {get; set;}
    
    //Contrutores
    public RespostaPesquisaDomain()
    {}
    
    private RespostaPesquisaDomain(SObject respostaPesquisaSObject)
    {
        this.construirDomainComSObject(respostaPesquisaSObject);
    }
    
    private RespostaPesquisaDomain(String codigoCliente, String nota, String entidadePesquisa, String nomeCliente)
    {
        this.construirDomainParaBot(codigoCliente, nota, entidadePesquisa, nomeCliente);
    }
    
    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
    
        if(params instanceOf SObject)
            return new RespostaPesquisaDomain((SObject) params);
        
        if(params instanceOf Map<String, Object>)
        {
            Map<String, Object> mapaParams = (Map<String, Object>) params;
            return new RespostaPesquisaDomain((String) mapaParams.get('codigoCliente'), (String) mapaParams.get('nota'), (String) mapaParams.get('entidadePesquisa'), (String) mapaParams.get('nomeCliente'));
        }
    
        return null;
    }
    
    //Responsável por retornar a mapper
    public RespostaPesquisaMapper obterMapper()
    {
        return this.respostaPesquisaMapper;
    }
    
    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.respostaPesquisaMapper.record;
    }
    
    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject respostaPesquisaSObject)
    {
        this.respostaPesquisaMapper = (RespostaPesquisaMapper) C3C_DIContainer_Injector.newInstance('RespostaPesquisaMapper', respostaPesquisaSObject);
    }
    
    //Responsável por construir a domain com sobject
    private void construirDomainParaBot(String codigoCliente, String notaPesquisa, String entidadePesquisa, String nomeCliente)
    {
        this.respostaPesquisaMapper = (RespostaPesquisaMapper) C3C_DIContainer_Injector.newInstance('RespostaPesquisaMapper', new Map<String, Object>{
            'codigoCliente' =>  codigoCliente, 
            'nota' => notaPesquisa, 
            'entidadePesquisa' => entidadePesquisa,
            'nomeCliente' => nomeCliente
        });
    }
    
    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<RespostaPesquisaDomain> construirListaDomainComListaSObject(List<SObject> listaRespostaPesquisaSObject)
    {
        List<RespostaPesquisaDomain> listaDeRespostaPesquisaDomain = new List<RespostaPesquisaDomain>();
    
        for(SObject respostaPesquisaSObject : listaRespostaPesquisaSObject) 
            listaDeRespostaPesquisaDomain.add(new RespostaPesquisaDomain(respostaPesquisaSObject));
    
        return listaDeRespostaPesquisaDomain;
    }

}