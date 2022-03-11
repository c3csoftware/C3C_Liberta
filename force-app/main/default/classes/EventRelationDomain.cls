public without sharing class EventRelationDomain implements IEventRelationDomain, C3C_DI_IProvider
{
    //Exception
    public class EventRelationDomainException extends Exception {}

    //Atributos
    private EventRelationMapper eventRelationMapper {get; set;}

    //Contrutores
    public EventRelationDomain() 
    {}
    
    private EventRelationDomain(SObject filaSObject)
    {
        this.construirDomainComSObject(filaSObject);
    }
    
    private EventRelationDomain(String idRegistro)
    {
        this.construirDomainComIdRegistro(idRegistro);
    }
    
    private EventRelationDomain(String idEvento, String idRelacao)
    {
        this.construirDomainComIdEventoEIdRelacao(idEvento, idRelacao);
    }

    private EventRelationDomain(EventRelationMapper eventRelationMpp)
    {
        this.eventRelationMapper = eventRelationMpp;
    }

    //Métodos
    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
            
        if(params instanceOf SObject)
            return new EventRelationDomain((SObject) params);

        if(params instanceOf EventRelationMapper)
            return new EventRelationDomain((EventRelationMapper) params);

        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;
            if(mapaParams.containsKey('idEvento'))
                return new EventRelationDomain((String) mapaParams.get('idEvento'),(String) mapaParams.get('idRelacao'));

            return new EventRelationDomain((String) mapaParams.get('idRegistro'));
        }

        return null;
    }
    
    public void atribuirNovoIdDoRegistro()
    {
        this.eventRelationMapper.idRegistro = this.eventRelationMapper.record.Id;
    }

    //Responsável por retornar a mapper
    public EventRelationMapper obterMapper()
    {
        return this.eventRelationMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.eventRelationMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject eventRelationSObject)
    {
        this.eventRelationMapper = (EventRelationMapper) C3C_DIContainer_Injector.newInstance('EventRelationMapper', eventRelationSObject);
    }
    
    //Responsável por construir a domain com idRegistro
    private void construirDomainComIdRegistro(String idRegistro)
    {
        this.eventRelationMapper = (EventRelationMapper) C3C_DIContainer_Injector.newInstance('EventRelationMapper', new Map<String,Object>{
            'idRegistro' => idRegistro
        });
    }
    
    //Responsável por construir a domain com idEvento e idRelacao
    private void construirDomainComIdEventoEIdRelacao(String idEvento, String idRelacao)
    {
        this.eventRelationMapper = (EventRelationMapper) C3C_DIContainer_Injector.newInstance('EventRelationMapper', new Map<String,Object>{
            'idEvento' => idEvento,
            'idRelacao' => idRelacao
        });
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<EventRelationDomain> construirListaDomainComListaSObject(List<SObject> listaEventRelationsSObject)
    {
        List<EventRelationDomain> listaDeEventRelationsDomain = new List<EventRelationDomain>();

        for(SObject eventRelationSObject : listaEventRelationsSObject)
            listaDeEventRelationsDomain.add(new EventRelationDomain(eventRelationSObject));

        return listaDeEventRelationsDomain;
    }
}