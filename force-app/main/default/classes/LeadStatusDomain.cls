public without sharing class LeadStatusDomain implements ILeadStatusDomain, C3C_DI_IProvider
{
    //Exception
    public class LeadStatusDomainException extends Exception {}

    //Atributos
    private LeadStatusMapper LeadStatusMapper {get; set;}

    //Contrutores
    public LeadStatusDomain() 
    {}
    
    private LeadStatusDomain(SObject filaSObject)
    {
        this.construirDomainComSObject(filaSObject);
    }
    
    private LeadStatusDomain(String idRegistro)
    {
        this.construirDomainComIdRegistro(idRegistro);
    }
    

    private LeadStatusDomain(LeadStatusMapper LeadStatusMpp)
    {
        this.LeadStatusMapper = LeadStatusMpp;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
            
        if(params instanceOf SObject)
            return new LeadStatusDomain((SObject) params);

        if(params instanceOf LeadStatusMapper)
            return new LeadStatusDomain((LeadStatusMapper) params);

        return null;
    }
    
    public void atribuirNovoIdDoRegistro()
    {
        this.LeadStatusMapper.idRegistro = this.LeadStatusMapper.record.Id;
    }

    //Responsável por retornar a mapper
    public LeadStatusMapper obterMapper()
    {
        return this.LeadStatusMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.LeadStatusMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject LeadStatusSObject)
    {
        this.LeadStatusMapper = (LeadStatusMapper) C3C_DIContainer_Injector.newInstance('LeadStatusMapper', LeadStatusSObject);
    }
    
    //Responsável por construir a domain com idRegistro
    private void construirDomainComIdRegistro(String idRegistro)
    {
        this.LeadStatusMapper = (LeadStatusMapper) C3C_DIContainer_Injector.newInstance('LeadStatusMapper', new Map<String,Object>{
            'idRegistro' => idRegistro
        });
    }
    

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<LeadStatusDomain> construirListaDomainComListaSObject(List<SObject> listaLeadStatussSObject)
    {
        List<LeadStatusDomain> listaDeLeadStatussDomain = new List<LeadStatusDomain>();

        for(SObject LeadStatusSObject : listaLeadStatussSObject)
            listaDeLeadStatussDomain.add(new LeadStatusDomain(LeadStatusSObject));

        return listaDeLeadStatussDomain;
    }

    public String pegarMasterLabel()
    {
        return this.obterMapper().masterLabel;
    }
}