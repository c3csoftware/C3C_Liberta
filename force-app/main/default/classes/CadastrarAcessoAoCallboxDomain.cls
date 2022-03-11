public without sharing class CadastrarAcessoAoCallboxDomain implements ICadastrarAcessoAoCallboxDomain, C3C_DI_IProvider
{
    //Exception
    public class CadastrarAcessoAoCallboxDomainException extends Exception {}

    //
    //Atributos
    //

    //Atributo que armazena a Mapper
    private CadastrarAcessoAoCallboxMapper cadAcessoCallboxMapper 
    {
        get
        {
            if(this.cadAcessoCallboxMapper == null)
                this.cadAcessoCallboxMapper = (CadastrarAcessoAoCallboxMapper) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxMapper');

            return this.cadAcessoCallboxMapper;
        } 
        set;
    }

    //
    //Contrutores
    //

    public CadastrarAcessoAoCallboxDomain() 
    {}
    
    private CadastrarAcessoAoCallboxDomain(SObject cadAcessoCallboxSobj)
    {
        this.construirDomainComSObject(cadAcessoCallboxSobj);
    }

    private CadastrarAcessoAoCallboxDomain(Map<String, Object> mapaParametro)
    {
        this.cadAcessoCallboxMapper = (CadastrarAcessoAoCallboxMapper) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxMapper', mapaParametro);
    }

    //
    //Métodos
    //

    //Responsável por retornar a instância(s) da domain de acordo com os paramêtros
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
        
        if(params instanceOf SObject)
            return new CadastrarAcessoAoCallboxDomain((SObject) params);

        if(params instanceOf Map<String, Object>)
            return new CadastrarAcessoAoCallboxDomain((Map<String, Object>) params);
            
        return null;
    }

    //Responsável por retornar a mapper
    public CadastrarAcessoAoCallboxMapper obterMapper()
    {
        return this.cadAcessoCallboxMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.cadAcessoCallboxMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject cadAcessoCallboxSobj)
    {
        this.cadAcessoCallboxMapper = (CadastrarAcessoAoCallboxMapper) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxMapper', cadAcessoCallboxSobj);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<ICadastrarAcessoAoCallboxDomain> construirListaDomainComListaSObject(List<SObject> listaCadastrosAcessoCallBoxSObject)
    {
        List<ICadastrarAcessoAoCallboxDomain> listaDeCadastrosAcessoCallBoxDomain = new List<ICadastrarAcessoAoCallboxDomain>();

        for(SObject cadAcessoCallboxSobj : listaCadastrosAcessoCallBoxSObject)
            listaDeCadastrosAcessoCallBoxDomain.add(new CadastrarAcessoAoCallboxDomain(cadAcessoCallboxSobj));

        return listaDeCadastrosAcessoCallBoxDomain;
    }
}