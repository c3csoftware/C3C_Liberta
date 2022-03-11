public without sharing class EventRelationMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
	public override String getObjectName()
    {
        return 'EventRelation';
    }

    //Atributos (Com referência ao campo do objeto)

    @AuraEnabled 
    public String idRegistro
    {
        get;
        set
        {
            this.idRegistro = value;
            this.setValueInRecord('Id', value);
        }
    }

    @AuraEnabled 
    public String idEvento
    {
        get;
        set
        {
            this.idEvento = value;
            this.setValueInRecord('EventId', value);
        }
    }

    @AuraEnabled 
    public String idRelacao
    {
        get;
        set
        {
            this.idRelacao = value;
            this.setValueInRecord('RelationId', value);
        }
    }

    @AuraEnabled
    public String status
    {
        get;
        set
        {
            this.status = value;
            this.setValueInRecord('Status', value);
        }
    }	

    @AuraEnabled public String leadRelacionadoEvento {get;set;}
    @AuraEnabled public String nomeLeadRelacionadoEvento {get;set;}
    @AuraEnabled public String sobrenomeLeadRelacionadoEvento {get;set;}
    @AuraEnabled public String proprietarioRelacionadoEvento {get;set;}
    @AuraEnabled public Datetime dataCriacao {get;set;}

    //Construtores
    public EventRelationMapper()
    {}
    
    public EventRelationMapper(String idRegistro)
    {
        this.idRegistro = idRegistro;
    }
    
    public EventRelationMapper(String idEvento, String idRelacao)
    {
        this.idEvento = idEvento;
        this.idRelacao = idRelacao;
    }

    private EventRelationMapper(SObject eventSObject)
    {
        this.initBuild();
        this.construirEventRelationMapperComEventRelationSObject(eventSObject);
        this.finishBuild();
    }

    //Métodos
    
    //Método responsável por retornar a instância da classe caso passe parâmetros
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new EventRelationMapper((Sobject) params);

        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;
            if(mapaParams.containsKey('idEvento'))
                return new EventRelationMapper((String) mapaParams.get('idEvento'),(String) mapaParams.get('idRelacao'));

            return new EventRelationMapper((String) mapaParams.get('idRegistro'));
        }
        
        return null;
    }

    //Método responsável por construir o evento Mapper caso receba um sObject de evento
    private void construirEventRelationMapperComEventRelationSObject(SObject eventSObject)
    {
        eventSObject = (SObject) JSON.deserialize(JSON.serialize(eventSObject), SObject.class);
        this.record = eventSObject;

        this.idRegistro = (String) eventSObject.get('Id');
        this.idEvento = (String) eventSObject.get('EventId');
        this.idRelacao = (String) eventSObject.get('RelationId');
        // quem recebeu o convite do evento ^
        this.status = (String) eventSObject.get('Status');
        this.dataCriacao = (Datetime) eventSObject.get('CreatedDate');

        if(eventSObject.getSObject('Event') != null)
        {
            this.leadRelacionadoEvento = (String) eventSObject.getSObject('Event').get('Lead__c');
            
            this.proprietarioRelacionadoEvento = (String) eventSObject.getSObject('Event').get('OwnerId'); 
            // quem disparo o evento ^

            if(eventSObject.getSObject('Event').getSObject('Lead__r') != null)
            {
                this.nomeLeadRelacionadoEvento = (String) eventSObject.getSObject('Event').getSObject('Lead__r').get('FirstName');
                this.sobrenomeLeadRelacionadoEvento = (String) eventSObject.getSObject('Event').getSObject('Lead__r').get('LastName');
            }
        }
    }
}