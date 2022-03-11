public without sharing class EventMapper extends C3C_AbstractMapper implements C3C_DI_IProvider
{
    //Método que define o objeto no qual a Mapper é relacionado
	public override String getObjectName()
    {
        return 'Event';
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
    public Datetime activityDataHora
    {
        get;
        set
        {
            this.activityDataHora = value;
            this.setValueInRecord('ActivityDateTime', value);
        }
    }

    @AuraEnabled 
    public Boolean conjuntoDeLembretes
    {
        get;
        set
        {
            this.conjuntoDeLembretes = value;
            this.setValueInRecord('IsReminderSet', value);
        }
    }

    @AuraEnabled 
    public Datetime remiderData
    {
        get;
        set
        {
            this.remiderData = value;
            this.setValueInRecord('ReminderDateTime', value);
        }
    }

    @AuraEnabled 
    public String assunto
    {
        get;
        set
        {
            this.assunto = value;
            this.setValueInRecord('Subject', value);
        }
    }

    @AuraEnabled 
    public String descricao
    {
        get;
        set
        {
            this.descricao = value;
            this.setValueInRecord('Description', value);
        }
    }

    @AuraEnabled 
    public String proprietario
    {
        get;
        set
        {
            this.proprietario = value;
            this.setValueInRecord('OwnerId', value);
        }
    }

    @AuraEnabled 
    public String criadoPorId{get;set;}
    
    @AuraEnabled 
    public Datetime dataDeInicio
    {
        get;
        set
        {
            this.dataDeInicio = value;
            this.setValueInRecord('StartDateTime', value);
        }
    }

    @AuraEnabled 
    public Datetime dataDeTermino
    {
        get;
        set
        {
            this.dataDeTermino = value;
            this.setValueInRecord('EndDateTime', value);
        }
    }
    
    @AuraEnabled 
    public Integer duracaoEmMinutos
    {
        get;
        set
        {
            this.duracaoEmMinutos = value;
            this.setValueInRecord('DurationInMinutes', value);
        }
    }
    
    @AuraEnabled 
    public Boolean eventoGeradoPorRoletagem
    {
        get;
        set
        {
            this.eventoGeradoPorRoletagem = value;
            this.setValueInRecord('EventoGeradoPorRoletagem__c', value);
        }
    }
    
    @AuraEnabled 
    public String whatId
    {
        get;
        set
        {
            this.whatId = value;
            this.setValueInRecord('WhatId', value);
        }
    }
    
    @AuraEnabled 
    public String whoId
    {
        get;
        set
        {
            this.whoId = value;
            this.setValueInRecord('WhoId', value);
        }
    }
    
    @AuraEnabled 
    public String oportunidade
    {
        get;
        set
        {
            this.oportunidade = value;
            this.setValueInRecord('Oportunidade__c', value);
        }
    }
    
    @AuraEnabled 
    public String lead
    {
        get;
        set
        {
            this.lead = value;
            this.setValueInRecord('Lead__c', value);
        }
    }

    @AuraEnabled 
    public Boolean eventoAceito
    {
        get;
        set
        {
            this.eventoAceito = value;
            this.setValueInRecord('EventoAceito__c', value);
        }
    }

    @AuraEnabled 
    public Boolean eventoNegado
    {
        get;
        set
        {
            this.eventoNegado = value;
            this.setValueInRecord('EventoNegado__c', value);
        }
    }

    @AuraEnabled 
    public Boolean analisadoBatch
    {
        get;
        set
        {
            this.analisadoBatch = value;
            this.setValueInRecord('AnalisadoBatch__c', value);
        }
    }
    
    @AuraEnabled 
    public String nomeProprietario {get;set;}

    @AuraEnabled 
    public String filaRoletagem 
    {
        get;
        set
        {
            this.filaRoletagem = value;
            this.setValueInRecord('FilaRoletagem__c', value);
        }
    }

    //Construtores

    public EventMapper()
    {}
    
    public EventMapper(Id idRegistro, Boolean analisadoBatch)
    {
        this.idRegistro = idRegistro;
        this.analisadoBatch = analisadoBatch;
    }
    
    public EventMapper(String oportunidade, Datetime dataDeInicio, Datetime dataDeTermino, String assunto, String descricao, String proprietario, Integer duracaoEmMinutos, Boolean eventoGeradoPorRoletagem, Boolean eventoAceito)
    {
        this.oportunidade = oportunidade;
        this.dataDeInicio = dataDeInicio;
        this.dataDeTermino = dataDeTermino;
        this.assunto = assunto;
        this.descricao = descricao;
        this.proprietario = proprietario;
        this.duracaoEmMinutos = duracaoEmMinutos;
        this.eventoGeradoPorRoletagem = eventoGeradoPorRoletagem;
        this.eventoAceito = eventoAceito;
    }
    
    public EventMapper(Datetime dataDeInicio, Datetime dataDeTermino, String assunto, String descricao, String proprietario, Integer duracaoEmMinutos, Boolean eventoGeradoPorRoletagem, String lead, Boolean eventoAceito)
    {
        this.lead = lead;
        this.dataDeInicio = dataDeInicio;
        this.dataDeTermino = dataDeTermino;
        this.assunto = assunto;
        this.descricao = descricao;
        this.proprietario = proprietario;
        this.duracaoEmMinutos = duracaoEmMinutos;
        this.eventoGeradoPorRoletagem = eventoGeradoPorRoletagem;
        this.eventoAceito = eventoAceito;
    }

    private EventMapper(SObject eventSObject)
    {
        this.construirEventMapperComEventSObject(eventSObject);
    }

    //Métodos
    
    //Método responsável por retornar a instância da classe caso passe parâmetros
    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new EventMapper((Sobject) params);

        if(params instanceOf Map<String,Object>)
        {
            Map<String,Object> mapaParams = (Map<String,Object>) params;
            Datetime dataDeInicio = (Datetime) mapaParams.get('dataDeInicio');
            Datetime dataDeTermino = (Datetime) mapaParams.get('dataDeTermino');
            String assunto = (String) mapaParams.get('assunto');
            String descricao = (String) mapaParams.get('descricao');
            String proprietario = (String) mapaParams.get('proprietario');
            Integer duracaoEmMinutos = (Integer) mapaParams.get('duracaoEmMinutos');
            Boolean eventoGeradoPorRoletagem = (Boolean) mapaParams.get('eventoGeradoPorRoletagem');
            Boolean eventoAceito = (Boolean) mapaParams.get('eventoAceito');

            if(mapaParams.containsKey('oportunidade'))
            {
                return new EventMapper(
                    (String) mapaParams.get('oportunidade'), 
                    dataDeInicio, 
                    dataDeTermino, 
                    assunto, 
                    descricao, 
                    proprietario, 
                    duracaoEmMinutos, 
                    eventoGeradoPorRoletagem,
                    eventoAceito
                );
            }
            else if(mapaParams.containsKey('analisadoBatch'))
            {
                return new EventMapper(
                    (Id) mapaParams.get('idRegistro'),
                    (Boolean) mapaParams.get('analisadoBatch')
                );
            }
            else 
            {
                return new EventMapper(
                    dataDeInicio, 
                    dataDeTermino, 
                    assunto, 
                    descricao, 
                    proprietario, 
                    duracaoEmMinutos, 
                    eventoGeradoPorRoletagem, 
                    (String) mapaParams.get('lead'),
                    eventoAceito
                );  
            }
        }
        
        return null;
    }

    //Método responsável por construir o evento Mapper caso receba um sObject de evento
    private void construirEventMapperComEventSObject(SObject eventSObject)
    {
        this.record = eventSObject;

        this.idRegistro = (String) eventSObject.get('Id');
        this.activityDataHora = (Datetime) eventSObject.get('ActivityDateTime');
        this.conjuntoDeLembretes = (Boolean) eventSObject.get('IsReminderSet');
        this.remiderData = (Datetime) eventSObject.get('ReminderDateTime');
        this.whatId = (String) eventSObject.get('WhatId');
        this.whoId = (String) eventSObject.get('WhoId');
        this.oportunidade = (String) eventSObject.get('Oportunidade__c');
        this.lead = (String) eventSObject.get('Lead__c');
        this.assunto = (String) eventSObject.get('Subject');
        this.descricao = (String) eventSObject.get('Description');
        this.proprietario = (String) eventSObject.get('OwnerId');
        this.criadoPorId = (String) eventSObject.get('CreatedById');
        this.dataDeInicio = (Datetime) eventSObject.get('StartDateTime');
        this.dataDeTermino = (Datetime) eventSObject.get('EndDateTime');
        this.duracaoEmMinutos = (Integer) eventSObject.get('DurationInMinutes');
        this.eventoGeradoPorRoletagem = (Boolean) eventSObject.get('EventoGeradoPorRoletagem__c');
        this.eventoAceito = (Boolean) eventSObject.get('EventoAceito__c');
        this.eventoNegado = (Boolean) eventSObject.get('EventoNegado__c');
        this.analisadoBatch = (Boolean) eventSObject.get('AnalisadoBatch__c');
        this.filaRoletagem = (String) eventSObject.get('FilaRoletagem__c');

        if(eventSObject.getSObject('Owner') != null)
            this.nomeProprietario = (String) eventSObject.getSObject('Owner').get('Name');
    }
}