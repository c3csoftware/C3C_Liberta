public without sharing class EventDomain implements IEventDomain, C3C_DI_IProvider
{
    //Exception
    public class EventDomainException extends Exception {}

    //Atributos
    private EventMapper eventMapper 
    {
        get
        {
            if(this.eventMapper == null)
                this.eventMapper = (EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper');

            return this.eventMapper;
        }
        set;
    }

    //Contrutores
    public EventDomain() 
    {}
    
    private EventDomain(SObject filaSObject)
    {
        this.construirDomainComSObject(filaSObject);
    }
    
    private EventDomain(Id idRegistro, Datetime dataDeInicio, Datetime dataDeTermino, Time duracao, String assunto, String descricao, String proprietario, Boolean eventoAceito)
    {
        this.construirDomainParaUsuarioComMenosEventoNoMes(idRegistro, dataDeInicio, dataDeTermino, duracao, assunto, descricao, proprietario, eventoAceito);
    }
    
    private EventDomain(Id idRegistro, Boolean analisadoBatch)
    {
        this.construirDomainComIdRegistroEAnalisadoBatch(idRegistro, analisadoBatch);
    }

    private EventDomain(EventMapper eventMpp)
    {
        this.eventMapper = eventMpp;
    }

    //Métodos

    public void atribuirNovoIdDoRegistro()
    {
        this.eventMapper.idRegistro = this.eventMapper.record.Id;
    }
    
    public void atribuirNovoNomeProprietario(String nomeProprietario)
    {
        this.eventMapper.nomeProprietario = nomeProprietario;
    }

    public Object newInstance(Object params)
    {
        if(params instanceOf List<SObject>)
            return this.construirListaDomainComListaSObject((List<SObject>) params);
            
        if(params instanceOf SObject)
            return new EventDomain((SObject) params);

        if(params instanceOf EventMapper)
            return new EventDomain((EventMapper) params);

        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;

            if(mapaParams.containsKey('analisadoBatch'))
                return new EventDomain((Id) mapaParams.get('idRegistro'), (Boolean) mapaParams.get('analisadoBatch'));

            return new EventDomain(
                (Id) mapaParams.get('idRegistro'),
                (Datetime) mapaParams.get('dataDeInicio'), 
                (Datetime) mapaParams.get('dataDeTermino'), 
                (Time) mapaParams.get('duracao'),
                (String) mapaParams.get('assunto'), 
                (String) mapaParams.get('descricao') , 
                (String) mapaParams.get('proprietario'),
                (Boolean) mapaParams.get('eventoAceito')
            );
        }

        return null;
    }

    //Responsável por retornar a mapper
    public EventMapper obterMapper()
    {
        return this.eventMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.eventMapper.record;
    }

    //Responsável por construir a domain com sobject
    private void construirDomainComSObject(SObject eventSObject)
    {
        this.eventMapper = (EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper', eventSObject);
    }

    private void construirDomainComIdRegistroEAnalisadoBatch(Id idRegistro, Boolean analisadoBatch)
    {
        this.eventMapper = (EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper', new Map<String,Object>{
            'idRegistro' => idRegistro,
            'analisadoBatch' => analisadoBatch
        });
    }
    
    //Responsável por construir a domain com sobject
    private void construirDomainParaUsuarioComMenosEventoNoMes(Id idRegistro, Datetime dataDeInicio, Datetime dataDeTermino, Time duracao, String assunto, String descricao, String proprietario, Boolean eventoAceito)
    {
        Integer duracaoEmMinutos = duracao.minute() + (duracao.hour() * 60);
        String sobjectType = idRegistro.getSObjectType().getDescribe().getName();

        Map<String, Object> parametros = new Map<String,Object>{
            'dataDeInicio' => dataDeInicio,
            'dataDeTermino' => dataDeTermino,
            'assunto' => assunto,
            'descricao' => descricao,
            'proprietario' => proprietario,
            'duracaoEmMinutos' => duracaoEmMinutos,
            'eventoGeradoPorRoletagem' => true,
            'eventoAceito' => eventoAceito
        };

        if(sobjectType == 'Lead')
        {
            parametros.put('lead', idRegistro);
        }
        else 
        {
            parametros.put('oportunidade', idRegistro);
        }
        
        this.eventMapper = (EventMapper) C3C_DIContainer_Injector.newInstance('EventMapper', parametros);
    }

    //Responsável por construir uma lista de domain com uma lista de sobject
    private List<EventDomain> construirListaDomainComListaSObject(List<SObject> listaEventsSObject)
    {
        List<EventDomain> listaDeEventsDomain = new List<EventDomain>();

        for(SObject eventSObject : listaEventsSObject)
            listaDeEventsDomain.add(new EventDomain(eventSObject));

        return listaDeEventsDomain;
    }
}